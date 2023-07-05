unit urequisicao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls, Buttons, fCtrls,
  adLabelEdit, adLabelComboBox, Mask, adLabelMaskEdit, TFlatButtonUnit,
  mxOneInstance, ExtCtrls;

type
  TfmReqLojas = class(TForm)
    DataSource1: TDataSource;
    Table: TADOTable;
    dbGrid: TSoftDBGrid;
    fsGroupBox1: TfsGroupBox;
    edCodigo: TadLabelEdit;
    edDescricao: TadLabelEdit;
    edSaldo: TadLabelEdit;
    fsLabel3: TfsLabel;
    cbOrigem: TadLabelComboBox;
    edQuant: TadLabelMaskEdit;
    btImprime: TFlatButton;
    FlatButton1: TFlatButton;
    Panel1: TPanel;
    edObs: TadLabelEdit;
    procedure FormCreate(Sender: TObject);
    procedure cbOrigemChange(Sender: TObject);
    procedure edDescricaoEnter(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BuscarDadosProduto(Sender:TObject);
    procedure iniciarRequisicao(Sender: TObject);
    procedure edQuantKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    function MontarRelatorioImpressao(Sender:tobject;EhImpressao:boolean):String;
    procedure btImprimeClick(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure LimparEdits(Sender:Tobject);
    procedure dbGridDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmReqLojas: TfmReqLojas;
  FinalizarPrograma:Boolean;
implementation

uses umain, cf, uDm, uEstoque, f, msg, uLj, uProd;

{$R *.dfm}

procedure TfmReqLojas.iniciarRequisicao(Sender: TObject);
begin
   dm.getTable( table,'cod varchar(08), descricao varchar(50), quant int');

   dbGrid.Columns[0].Title.caption := 'Codigo';
   dbGrid.Columns[1].Title.caption := 'Descricao';
   dbGrid.Columns[2].Title.caption := 'Quantidade';
   dbGrid.Columns[0].Title.Font.Style := [fsbold];
   dbGrid.Columns[1].Title.Font.Style := [fsbold];
   dbGrid.Columns[2].Title.Font.Style := [fsbold];
   edCodigo.Enabled := true;
   edQuant.Enabled := true;
   edcodigo.SetFocus;
end;

procedure TfmReqLojas.FormCreate(Sender: TObject);
begin
   uLj.getListaLojas( cbOrigem, false, false, '', '' );
end;

procedure TfmReqLojas.edDescricaoEnter(Sender: TObject);
begin
   if edCodigo.Enabled = true then
      edCodigo.SetFocus;
end;

procedure TfmReqLojas.BuscarDadosProduto(Sender: TObject);
var
  ds: TdataSet;
begin
   ds :=  uProd.getDadosProd(f.getCodUO(cbOrigem),  edCodigo.Text, '', '101', true );

   if (ds.IsEmpty = false) then
   begin
      edDescricao.text := ds.fieldByName('DESCRICAO').AsString;
      edSaldo.Text := ds.fieldByName('estoque').AsString;
      edQuant.SetFocus
   end
   else
      edCodigo.SetFocus;
   ds.free();
end;

procedure TfmReqLojas.cbOrigemChange(Sender: TObject);
begin
   if (cbOrigem.itemindex > -1) then
      iniciarRequisicao(sender);
end;


procedure TfmReqLojas.edQuantKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = vk_return) and (f.SohNumeros(edQuant.Text) <> '' ) then
   begin
      table.AppendRecord([edCodigo.Text, edDescricao.Text, f.SohNumeros(edQuant.Text)]);
      LimparEdits(Sender);
   end;
end;

procedure TfmReqLojas.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if table.IsEmpty = false then
     if msg.msgQuestion(' Abandona a requisi��o ?  ') = mrYes then
        Canclose := true
      else
        Canclose :=false;
end;

function TfmReqLojas.MontarRelatorioImpressao(Sender:tobject;EhImpressao:boolean):String;
var
   dest:TstringList;
   nArquivo,linha:string;
   i,l,Fl:integer;
begin
   screen.Cursor := crHourGlass;
   nArquivo :=  f.TempDir() +  'Req_' + trim( copy(cbOrigem.Items[cbOrigem.itemIndex],01,30) ) +' '+
               copy(dateToStr(now),01,02) +'-'+ copy(dateToStr(now),04,02) +'-'+ copy(dateToStr(now),07,04)+ '_'+
               copy(dateTimeToStr(now),12,02) +'-'+ copy(dateTimeToStr(now),15,02) +
               '.rtf' ;

   dest:=  TStringList.create();
   Fl := 0; l := 0;

   table.First;
   while table.Eof = false do
   begin
      inc(fl);
      Dest.Add('');
      Dest.Add('');
      Dest.Add('                          *** REQUISICAO DE PRODUTOS  ***                                     FL:' + f.preencheCampo(03,'0','e',intToStr(fl)));
      Dest.Add('');
      Dest.Add('Data: ' + DateTimeToStr(now)  );
      Dest.Add('Loja Requisitada: ' + copy(cbOrigem.Items[cbOrigem.itemindex],01,30) ) ;
      Dest.Add('Loja Requisitante : ' + FmMain.StatusBar1.Panels[0].Text ) ;
      Dest.Add('');
      Dest.Add('------------------------------------------------------------------------------');
      Dest.Add('CODIGO    DESCRICAO                                                QUANTIDADE ');
      Dest.Add('------------------------------------------------------------------------------');
      Dest.Add('');

      while ( l < 15 ) and ( table.eof = false ) do
      begin
         inc(l);
         linha :=
            f.preencheCampo(10,' ', 'd', table.fieldByname('cod').Asstring) +
            f.preencheCampo(60,' ', 'd', copy(table.fieldByname('descricao').Asstring,01,45 )) +
            f.preencheCampo(04,'0', 'e', table.fieldByname('quant').Asstring);
         dest.Add(linha);
         table.next;
      end;
      if ( table.eof = false ) then
      begin
         Dest.Add('Observa��o: ' + edObs.Text);
         Dest.Add( '');
         Dest.Add('------------------------------------------------------------------------------');
         Dest.Add('');
         l:=0
      end
      else
      begin
         for i:=0 to 8 do
         begin
            inc(l);
            Dest.Add('');
         end;
         Dest.Add('                           -----------------------------------  ');
         Dest.Add('                                         Visto                  ');

         while ( l < 40 ) do
         begin
            Dest.Add('');
            inc(l);
        end;
      end;
   end;
   Dest.SaveToFile( nArquivo);
   table.First;
   screen.Cursor := crDefault;

   result := nArquivo;
end;

procedure TfmReqLojas.FlatButton1Click(Sender: TObject);
begin
   if table.IsEmpty = false then
   begin
      cbOrigem.ItemIndex := -1;
      table.Close;
      IniciarRequisicao(Sender);
      LimparEdits(Sender);
   end;
end;

procedure TfmReqLojas.LimparEdits(Sender: Tobject);
begin
   edCodigo.Text := '';
   edQuant.Text := '';
   edDescricao.Text := '';
   edSaldo.Text := '';
   edCodigo.setfocus;
end;

procedure TfmReqLojas.dbGridDblClick(Sender: TObject);
begin
   table.Delete();
end;

procedure TfmReqLojas.edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = vk_return) then
      BuscarDadosProduto(Sender);
end;

procedure TfmReqLojas.btImprimeClick(Sender: TObject);
var
   corpoMsg:Tstringlist;
   arq:string;
begin
   arq := MontarRelatorioImpressao(Sender,false );
   corpoMsg := TStringList.Create();
   corpoMsg.LoadFromFile( arq );
   corpoMsg.Add('Gerada por: ' + fmMain.StatusBar1.Panels[1].text);
   corpoMsg.Add('A partir da loja: ' + fmMain.StatusBar1.Panels[0].text);

// enviar email para a loja requisitada
   fmMain.EnviarEmail ( dm.getEmail(f.getNumUO(cbOrigem)) ,  ' Requisicao de mercadorias da loja '+ fmMain.StatusBar1.Panels[0].Text,'',corpoMsg, 'Enviando email para a loja requisitada...');
   corpoMsg.Add('');

// email para a loja que ta pedindo
   fmMain.EnviarEmail( dm.getEmail(fmMain.getUoLogada()),  'Copia da Requisicao de mercadorias da loja '+ fmMain.StatusBar1.Panels[0].Text,'',corpoMsg, 'Copia da requisi��o para a loja que pediu...');
   FlatButton1Click(nil);
end;

procedure TfmReqLojas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := cafree;
   fmReqLojas := nil;
end;

end.


