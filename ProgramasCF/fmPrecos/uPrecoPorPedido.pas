unit uPrecoPorPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, Grids, Buttons,Clipbrd, funcSQL,
  adLabelNumericEdit, mxExport, DB, ADODB, TFlatButtonUnit, DBGrids, uDm,
  SoftDBGrid, fCtrls;

type
  TfmPcporPedido = class(TForm)
    edNumPedido: TadLabelEdit;
    edPercNota: TadLabelNumericEdit;
    edMargem1: TadLabelNumericEdit;
    edFrete: TadLabelNumericEdit;
    edIPI: TadLabelNumericEdit;
    btCalcula: TFlatButton;
    FlatButton3: TFlatButton;
    FlatButton4: TFlatButton;
    edMargem2: TadLabelNumericEdit;
    tbp: TADOTable;
    DataSource1: TDataSource;
    gdPedido: TSoftDBGrid;
    CheckBox1: TfsCheckBox;
    btCancela: TFlatButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCalculaClick(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure edNumPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LimpaTabela(Sender:Tobject);
    procedure FlatButton4Click(Sender: TObject);
    procedure btCancelaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPcporPedido: TfmPcporPedido;

implementation

uses Uprecoswell, uMain, uCF, f, uEstoque, uPreco;

{$R *.dfm}
function FloatSqlToStr(str:string):string;
begin
   if pos(',',str) = 0 then str := str +',00';
   if pos(',',str) = length(str)-1 then str:= str + '0';
   if pos(',',str) = 0 then str:= str + ',00';
   FloatSqlToStr := str;

end;
procedure TfmPcporPedido.FormCreate(Sender: TObject);
var
  i:smallint;
begin
   screen.Cursor := crHourglass;

   dm.getTable(tbP,  dm.getCMD('preco', 'getTbPcPorPed'));

   gdPedido.Columns[0].Visible := false;
   gdPedido.Columns[1].Width := 50;
   gdPedido.Columns[2].Width := 200;
   gdPedido.Columns[3].Width := 50;
   gdPedido.Columns[4].Width := 80;
   gdPedido.Columns[5].Width := 50;


   for i:=0 to tbP.FieldCount -1 do
     gdPedido.Columns[i].Title.Font.Style := [fsBold];

   screen.Cursor := crDefault;
end;

procedure TfmPcporPedido.FlatButton3Click(Sender: TObject);
var
  ds:TDataSet;
begin
   ds := uEstoque.getDadosPedidoDeCompra(edNumPedido.text);

   LimpaTabela(sender);
   while ds.Eof = false do
   begin
      tbP.AppendRecord([
         ds.FieldByName('is_ref').AsString,
         ds.FieldByName('CODIGO').AsString,
         ds.FieldByName('DESCRICAO').AsString,
         ds.FieldByName('QUANT').AsString,
         FloatToStr(ds.FieldByName('UND').AsFloat) ,
        ds.FieldByName('IPI').AsString
      ]);
      ds.Next;
   end;
   ds.Free();
end;

procedure TfmPcporPedido.btCalculaClick(Sender: TObject);
var
  i:integer;
  vlVenda, ipi, frete, margem01, margem02:real;
  arq:TstringList;
begin
   arq := tStringList.Create();
   i:=0;
   margem01 := 0;
   margem02 := 0;
   tbP.First;

   arq.add('Pedido número:' + edNumPedido.Text );
   arq.add('');

   while (tbP.Eof = false) do
   begin
      ipi := (( ( tbP.FieldByName('IPI').asFloat ) *( tbP.fieldByName('PRECO UND').asFloat  ) ) / 100) * (edPercNota.Value/100);

      frete :=    edFrete.Value * ( tbP.fieldByName('PRECO UND').asFloat  )  / 100 ;

      if (edMargem1.value <> 0) then
         margem01 :=  ((tbP.fieldByName('PRECO UND').asFloat + frete + ipi) * edMargem1.value) / 100;

      vlVenda := ( tbP.fieldByName('PRECO UND').asFloat ) + frete + ipi + margem01;

      if (edMargem2.value <> 0) then
         margem02 :=  (vlVenda * edMargem2.Value) / 100;

      vlVenda := vlVenda + margem02;

      inc(i);
      arq.add( IntToStr(i)+ '- '+ tbP.fieldByName('codigo').AsString+' '+tbP.fieldByName('descricao').AsString );
      arq.add( '     PC Ped: ' + FloatToStrF( tbP.fieldByName('PRECO UND').asFloat, ffFixed, 18, 02)  );
      arq.add( '     IPI '+ tbP.FieldByName('IPI').asString +'%: '+ floatToStr(ipi) + '     %nota: ' + edPercNota.Text );
      arq.add( '     Frete: '+ floatToStr(frete) );
      arq.add( '     Margem01: '+ floatToStr(margem01) );
      arq.add( '     Margem02: '+ floatToStr(margem02) );
      arq.add( '     PC Gerado: '+FloatToStrF(vlvenda,ffFixed, 18, 02));
      arq.add( '');

// CODIGO varchar(08), DESCRICAO varchar(50), [PRECO ATUAL] money, [PRECO 01] money, [PRECO 02] money, [PRECO 03] money, IS_REF int primary key, CUSTO money

      fmLancaPc.addItemReajuste(
           tbP.fieldByName('codigo').AsString
         , tbP.fieldByName('Descricao').AsString
         , uPreco.getPcProd(f.getNumUO(fmLancaPc.cbLoja), '', tbP.FieldByname('is_ref').AsString, f.getCodPc(fmLancaPc.cbPc01))
         , vlVenda
         , tbp.fieldByName('is_ref').AsString
         , tbP.fieldByName('PRECO UND').AsString
      );
      tbP.Next;
   end;

   if checkBox1.Checked = true then
   begin
      arq.SaveToFile(getDirLogs()+'memDeCaculo.txt');
      Winexec(pchar('notepad.exe '+getDirLogs()+ 'memDeCaculo.txt'),sw_normal);
   end;
   fmPcporPedido.Close;

end;

procedure TfmPcporPedido.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := cafree;
end;

procedure TfmPcporPedido.edNumPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = VK_return) then
      FlatButton3Click(Sender);
end;


procedure TfmPcporPedido.LimpaTabela(Sender: Tobject);
begin
   while tbP.IsEmpty = false do
      tbP.Delete;
end;

procedure TfmPcporPedido.FlatButton4Click(Sender: TObject);
begin
   tbP.First;
   while tbP.Eof = false do
   begin
     tbP.Edit;
     tbP.FieldByName('ipi').asFloat := strToFloat(edIPI.text);
     tbP.Post;
     tbP.Next;
   end;
end;

procedure TfmPcporPedido.btCancelaClick(Sender: TObject);
begin
   fmPcporPedido.Close;
end;






end.
