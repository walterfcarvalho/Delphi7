unit uAcertoEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPrecosCusto, DB, ADODB, ExtCtrls, adLabelSpinEdit, StdCtrls,
  adLabelComboBox, TFlatCheckBoxUnit, TFlatButtonUnit, adLabelNumericEdit,
  Grids, DBGrids, SoftDBGrid, adLabelEdit, Buttons, fCtrls;

type
  TfmAcertoEstoque = class(TfmPrecoCustos)
    tb: TADOTable;
    rgTpAcerto: TRadioGroup;
    Memo1: TMemo;
    fsBitBtn2: TfsBitBtn;

    procedure FormCreate(Sender: TObject);
    procedure btConsultaProdutoClick(Sender: TObject);
    procedure btAjustaPrecoClick(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure getTbAcerto();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


    procedure edPcNovoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    function getTpAcerto():String;
    PROCEDURE AdicionaItemnaGridAcerto();
    procedure iniciaProcessoDeAcerto(mostraMsgSemitem:boolean);
    procedure fsBitBtn2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAcertoEstoque: TfmAcertoEstoque;
  DS:TdataSet;
implementation

uses uMain, f, msg, fdt, uEstoque, uDm, uProd;

{$R *.dfm}

procedure TfmAcertoEstoque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   fmAcertoEstoque := nil;
end;

procedure TfmAcertoEstoque.FormCreate(Sender: TObject);
begin
   cbCustoFiscal.Free();
   cbCustoMedioUnico.Free();
   Button1.Visible := false;
   GroupBox1.Visible := false;
   query.Free();

   getTbAcerto();

   edPcNovo.Decimals := 0;
end;

procedure TfmAcertoEstoque.btConsultaProdutoClick(Sender: TObject);
begin
   DS:= uProd.getDadosProdBasico(f.getCodUO(cbLoja), edCodigo.Text, '101', '0', '');

   if ( DS.IsEmpty = false ) then
   begin
      edNome.text := '';
      edNome.text :=
      DS.fieldByName('codigo').AsString + ' ' + DS.fieldByName('descricao').AsString + ' Saldo:'+ DS.fieldByName('estoque').AsString ;
      if (fmAcertoEstoque.FormStyle = fsMDIChild) then
         edPcNovo.SetFocus();
   end
   else
   begin
      Memo1.Lines.Add('Não encontrado:' + edCodigo.Text)
   end;
end;

procedure TfmAcertoEstoque.iniciaProcessoDeAcerto(
  mostraMsgSemitem: boolean);
begin
   uEstoque.acertaQuantidadeItens( f.getCodUO(cbLoja), fmMain.getCdPesLogado(), tb, mostraMsgSemitem);
   getTbAcerto();
end;

procedure TfmAcertoEstoque.btAjustaPrecoClick(Sender: TObject);
begin
    iniciaProcessoDeAcerto(true);
end;

procedure TfmAcertoEstoque.edCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = VK_Return then
     btConsultaProdutoClick(nil);
end;

procedure TfmAcertoEstoque.getTbAcerto();
begin
   dm.getTable(tb, dm.getCMD('estoque', 'getTbAcertoQt'));
   DataSource1.DataSet := tb;

   f.ajGridCol(Grid, tb, 'is_oper', 0, '');
   f.ajGridCol(Grid, tb, 'is_doc', 0, '');
   f.ajGridCol(Grid, tb, 'vl_mov', 0, '');
   f.ajGridCol(Grid, tb, 'custoFiscal', 0, '');
   f.ajGridCol(Grid, tb, 'cmu', 0, '');
   f.ajGridCol(Grid, tb, 'is_lanc', 0, '');
   f.ajGridCol(Grid, tb, 'is_ref', 0, '');

   edCodigo.Text := '';
   edNome.Text := '';
   edPcNovo.Value := 0;
end;

procedure TfmAcertoEstoque.AdicionaItemnaGridAcerto;
begin
   if Tb.Locate('is_ref', DS.fieldByName('is_ref').asString, []) = false then
   begin
      uEstoque.insItemTbAcerto( getTpAcerto(), edPcNovo.Value, DS, tb);
      if (fmAcertoEstoque.FormStyle = fsMDIChild) then
         edCodigo.SetFocus();
   end
   else
      msg.msgErro(DS.fieldByName('codigo').asString + ' Item ja tem');

   DS.free();
end;


procedure TfmAcertoEstoque.edPcNovoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = vk_return) then
   begin
      AdicionaItemnaGridAcerto();
   end;
end;

procedure TfmAcertoEstoque.fsBitBtn1Click(Sender: TObject);
var
   limitador, i:integer;
   key:word;
   shift:TshiftState;
begin
   key := VK_RETURN;

   for i:=0 to memoItens.Lines.Count - 1 do
   begin
      limitador := pos(' ', memoItens.Lines[i]);
      edCodigo.Text := Trim(copy(memoItens.Lines[i], 01, limitador));
      btConsultaProdutoClick(nil);
      edPcNovo.Text := Trim(copy(memoItens.Lines[i], limitador+1, 10));

      if (edPcNovo.Value <> 0) and (rgTpAcerto.ItemIndex < 2) then
         edPcNovoKeyDown(nil, key, shift );
   end;
end;

procedure TfmAcertoEstoque.FormActivate(Sender: TObject);
begin
  inherited;
  cbLoja.Items.Delete(0);
end;

procedure TfmAcertoEstoque.GridDblClick(Sender: TObject);
begin
   if tb.IsEmpty = false then
     tb.Delete();
end;

function TfmAcertoEstoque.getTpAcerto: String;
begin
   case rgTpAcerto.ItemIndex of
     0:result := 'E';
     1:result := 'S';
     2:result := 'A';
   end;
end;



procedure TfmAcertoEstoque.fsBitBtn2Click(Sender: TObject);
var
  i:integer;
  dsIt:TdataSet;
begin
  for i:=0 to memoItens.Lines.Count-1 do
  begin
    dsIt := uProd.getDadosProd(f.getCodUO(cbLoja), trim(copy(memoItens.Lines[i],01, 08)), '', '101', true);

    if (dsIt.IsEmpty = false) then
      uEstoque.zeraPendenciaEstoque(f.getCodUO(cbLoja), dsIt.fieldByName('is_ref').AsString);
  end;
end;

end.
