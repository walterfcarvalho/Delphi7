unit uClassificaProd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, TFlatButtonUnit, StdCtrls, adLabelEdit, adLabelNumericEdit,
  ADODB, Grids, DBGrids, Mask, adLabelMaskEdit, DBCtrls,
  adLabelDBLookupListBox, adLabelDBLookupComboBox, SoftDBGrid, mxExport,
  CheckLst, adLabelCheckListBox, fCtrls,  TFlatCheckBoxUnit, uDm, Menus,
  ComCtrls;

type
  TfmClassificaProd = class(TForm)
    btConsulta: TFlatButton;
    edit1: TadLabelEdit;
    DataSource2: TDataSource;
    qrCatAtual: TADOQuery;
    Label2: TLabel;
    qrNvCa1: TADOQuery;
    DataSource3: TDataSource;
    gridCat1: TSoftDBGrid;
    gridCat2: TSoftDBGrid;
    gridCat3: TSoftDBGrid;
    DataSource4: TDataSource;
    qrNvCa2: TADOQuery;
    DataSource5: TDataSource;
    qrNvCa3: TADOQuery;
    btReclass: TFlatButton;
    cbListaClassificado: TfsComboBox;
    Label1: TLabel;
    cbDtExpPreco: TFlatCheckBox;
    btManterClass: TFlatButton;
    gridItens: TSoftDBGrid;
    dsItens: TDataSource;
    tb: TADOTable;
    gridCatAtual: TSoftDBGrid;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edDesc: TadLabelEdit;
    PopupMenu1: TPopupMenu;
    NovoItem1: TMenuItem;
    RemoveItem1: TMenuItem;
    N1: TMenuItem;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    PopupMenu3: TPopupMenu;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    di: TfsDateTimePicker;
    Label6: TLabel;
    cbTpConsulta: TfsComboBox;
    Label7: TLabel;
    procedure btConsultaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridCat2CellClick(Column: TColumn);
    procedure clb1Click(Sender: TObject);
    procedure btReclassClick(Sender: TObject);
    procedure Classifica(sender:tobject);
    procedure edit1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure btManterClassClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure listaItensAClassificar();
    procedure cbDtExpPrecoClick(Sender: TObject);
    procedure setSelecao(char:String);
    procedure gridItensCellClick(Column: TColumn);
    function exiteSelecionado():boolean;
    procedure getCategoria(grid:TsoftDbGrid; qr:TADOquery; nivel, pai:String);
    procedure gridCat1CellClick(Column: TColumn);
    procedure marcaDesmarcaItem();
    procedure gridCat1TitleClick(Column: TColumn);
    procedure gridCat2TitleClick(Column: TColumn);
    procedure gridCat3TitleClick(Column: TColumn);
    procedure chamaCadastroTvcom(qrPai, qr:TADOQuery);
    procedure NovoItem1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure RemoveItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure gridItensTitleClick(Column: TColumn);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmClassificaProd: TfmClassificaProd;

implementation

uses uMain, f, uEstoque, uCategoria, msg;

{$R *.dfm}

procedure TfmClassificaProd.getCategoria(grid: TsoftDbGrid; qr: TADOquery; nivel, pai:String);
begin
   qr.Close();
   uCategoria.getSubCategorias(qr, nivel, pai);

   f.ajGridCol(grid, qr, 'cd_vcampo', 0, '');
   f.ajGridCol(grid, qr, 'Descrição', 150, 'Descrição');
   f.ajGridCol(grid, qr, 'cd_campo', 0, '');
end;


function TfmClassificaProd.exiteSelecionado():boolean;
var
   res:boolean;
begin
   res:= false;
   tb.first();
   while ( tb.Eof = false) do
   begin
      if tb.fieldByName('S').AsString = 'X' then
      begin
         res := true;
         break;
      end;
      tb.Next();
   end;

   if (res = false) then
      msg.msgErro( dm.getMsg('MSG_ERRO_TIT') +  dm.getMsg('MSG_err_it') );

   result := res;
end;

procedure TfmClassificaProd.setSelecao(char: String);
begin
   tb.fieldByName('S').ReadOnly := false;
   tb.Edit;
   tb.fieldByName('S').AsString := char;
   tb.Post();
   tb.fieldByName('S').ReadOnly := true;
end;

procedure TfmClassificaProd.clb1Click(Sender: TObject);
begin
   uCategoria.getCatProduto(qrCatAtual, tb.fieldByName('is_ref').AsString);
end;

procedure TfmClassificaProd.formActivate(Sender: TObject);
begin
   edit1.setfocus;
   getCategoria(gridCat1, qrNvCa1, '1', '');

   if (fmMain.isAcessoTotal(fmMain.Classificaodepro1.Tag) = false) then
   begin
      gridCat2.PopupMenu := nil;
      gridCat3.PopupMenu := nil;
      gridCat1.PopupMenu := nil;
   end;
   di.Date := dm.getDateBd() -720;
end;


procedure TfmClassificaProd.formCreate(Sender: TObject);
begin
   tb.Connection := dm.con;
   qrCatAtual.Connection :=dm.con;
   qrNvCa1.Connection :=dm.con;
   qrNvCa2.Connection :=dm.con;
   qrNvCa3.Connection :=dm.con;
end;

procedure TfmClassificaProd.listaItensAClassificar;
begin
   uEstoque.getItensclassificacaoCategoria(tb, edit1.Text, edDesc.text, cbListaClassificado.ItemIndex, di.Date, cbTpConsulta.itemIndex);

  (tb.fieldByName('isClassificado') as TBooleanfield).DisplayValues := 'Sim;não';

   f.ajGridCol(gridItens, tb, 'S', 50, 'Sel');
   f.ajGridCol(gridItens, tb, 'is_ref', 0, '');
   f.ajGridCol(gridItens, tb, 'isClassificado', 70, 'Classificado');
   f.ajGridCol(gridItens, tb, 'cd_ref', 80, 'Código');
   f.ajGridCol(gridItens, tb, 'ds_ref', 300, 'Descrição');
   f.ajGridCol(gridItens, tb, 'dtClassificacao', 250, 'Classificado em');
   gridItens.fields[0].Alignment := taCenter;
end;

procedure TfmClassificaProd.btConsultaClick(Sender: TObject);
begin
   if (length(edit1.text) >=3) then
      listaItensAClassificar();
end;

procedure TfmClassificaProd.Classifica(sender:tobject);
begin
   tb.first();
   while ( tb.Eof = false) do
   begin
      if (tb.fieldByName('S').asString = 'X') then
      begin
         uCategoria.removeClassificacao(tb.fieldByName('is_ref').AsString);

         uCategoria.gravaCat(tb.fieldByName('is_ref').AsString, '1', gridCat1.fields[0].asString);
         uCategoria.gravaCat(tb.fieldByName('is_ref').AsString, '2', gridCat2.fields[0].asString);
         uCategoria.gravaCat(tb.fieldByName('is_ref').AsString, '3', gridCat3.fields[0].asString);

         uCategoria.marcaItemComoClassificado(tb.fieldByName('is_ref').AsString);
      end;
      tb.Next();
   end;
   qrCatAtual.Close;
   qrNvCa2.Close;
   qrNvCa3.Close;
end;

procedure TfmClassificaProd.edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
     btConsultaClick(Sender);
end;

procedure TfmClassificaProd.btManterClassClick(Sender: TObject);
begin
   if (exiteSelecionado() = true) then
      if  msg.msgQuestion( dm.getMsg('catItem.manter') ) = mrYes then
      begin
         tb.first();
         while ( tb.Eof = false ) do
         begin
            if ( tb.fieldByName('S').AsString = 'X') then
               uCategoria.marcaItemComoClassificado( tb.fieldByName('is_ref').AsString );
            tb.Next();
         end;
      end;
end;

procedure TfmClassificaProd.btReclassClick(Sender: TObject);
var
   erro:string;
begin
   erro :='';

   if (exiteSelecionado() = false) then
      erro := ' ';

   if (qrNvCa3.IsEmpty = true) then
   begin
      erro:= erro + ' - Selecione as classes ';
      msg.msgErro(erro);
   end;

   if (erro <> '') then
   else
      if ( msg.msgQuestion('Confirma a classificação para:'+#13+#13+ ' - '+gridCat1.fields[1].AsString+#13+ ' - '+gridCat2.fields[1].AsString+#13+ ' - '+gridCat3.fields[1].AsString ) = mrYes) then
         Classifica(sender);

   getCategoria(gridCat1, qrNvCa1, '1', '');
end;

procedure TfmClassificaProd.formClose(Sender: TObject; var Action: TCloseAction);
begin
   action := cafree;
   self := nil;
end;

procedure TfmClassificaProd.marcaDesmarcaItem();
var
  cmd:String;
begin
   if gridItens.SelectedIndex = tb.fieldByName('S').Index then
   begin
      cmd := tb.fieldByName('S').AsString;

      if (cmd = 'X') then
         cmd := ''
      else
         cmd := 'X';

      setSelecao(cmd);
   end;
end;

procedure TfmClassificaProd.cbDtExpPrecoClick(Sender: TObject);
var
   check:String;
begin
   if (cbDtExpPreco.Checked = true) then
      check := 'X'
   else
      check := '';

   tb.first();
   while (tb.Eof = false) do
   begin
      self.setSelecao(check);
      tb.Next();
   end;
end;


procedure TfmClassificaProd.gridItensCellClick(Column: TColumn);
begin
   if gridItens.SelectedIndex = 0 then
      marcaDesmarcaItem()
   else
   begin
      uCategoria.getCatProduto(qrCatAtual, tb.fieldByName('is_ref').AsString);

      f.ajGridCol(gridCatAtual, qrCatAtual, 'nivel', 20, 'Nivel' );
      f.ajGridCol(gridCatAtual, qrCatAtual, 'Descrição', 120, 'Descrição' );
   end;
end;


procedure TfmClassificaProd.gridCat1CellClick(Column: TColumn);
begin
   qrNvCa2.Close();
   getCategoria(gridCat2, qrNvCa2, '2', qrNvCa1.fieldByName('cd_vcampo').AsString);
   qrNvCa3.Close();
end;

procedure TfmClassificaProd.gridCat1TitleClick(Column: TColumn);
begin
   dm.ordernaQuery(qrNvCa1, gridCat1, Column);
end;

procedure TfmClassificaProd.gridCat2CellClick(Column: TColumn);
begin
   if (qrNvCa2.IsEmpty = false) then
      getCategoria(gridCat3, qrNvCa3, '3', qrNvCa2.fieldByName('cd_vcampo').AsString);
end;


procedure TfmClassificaProd.gridCat2TitleClick(Column: TColumn);
begin
   dm.ordernaQuery(qrNvCa2, gridCat2, Column);
end;

procedure TfmClassificaProd.gridCat3TitleClick(Column: TColumn);
begin
   dm.ordernaQuery(qrNvCa3, gridCat3, Column);
end;

procedure TfmClassificaProd.chamaCadastroTvcom(qrPai, qr: TADOQuery);
var
   nmCat:String;
   cd_campoPai, cd_vCampoPai:String;
begin
   nmCat :=  msg.msgInput(dm.getMsg('catNova'), '');

   if length(nmCat) > 3 then
   begin
      if (qrPai = nil) then
      begin
         cd_campoPai := '0';
         cd_vCampoPai := '';
      end
      else
      begin
         cd_campoPai:=  qrPai.FieldByName('cd_campo').AsString;
         cd_vCampoPai:= qrPai.FieldByName('cd_Vcampo').AsString;
      end;
      uEstoque.cadastraCategoria(cd_campoPai, cd_vCampoPai, nmCat);
   end;
end;

procedure TfmClassificaProd.NovoItem1Click(Sender: TObject);
begin
   chamaCadastroTvcom(nil, qrNvCa1);
   getCategoria(gridCat1, qrNvCa1, '1', '');
end;

procedure TfmClassificaProd.MenuItem1Click(Sender: TObject);
begin
   chamaCadastroTvcom(qrNvCa1, qrNvCa2);
   gridCat1CellClick(nil);
end;

procedure TfmClassificaProd.MenuItem4Click(Sender: TObject);
begin
   chamaCadastroTvcom(qrNvCa2, qrNvCa3);
   gridCat2CellClick(nil);
end;

procedure TfmClassificaProd.RemoveItem1Click(Sender: TObject);
begin
   uEstoque.removeItemCategoria(qrNvCa1.fieldByName('cd_Campo').AsString, qrNvCa1.fieldByName('cd_VCampo').AsString);
   getCategoria(gridCat1, qrNvCa1, '1', '');
end;

procedure TfmClassificaProd.MenuItem3Click(Sender: TObject);
begin
   uEstoque.removeItemCategoria(qrNvCa2.fieldByName('cd_Campo').AsString, qrNvCa2.fieldByName('cd_VCampo').AsString);
   gridCat1CellClick(nil);
end;

procedure TfmClassificaProd.MenuItem6Click(Sender: TObject);
begin
   uEstoque.removeItemCategoria(qrNvCa3.fieldByName('cd_Campo').AsString, qrNvCa3.fieldByName('cd_VCampo').AsString);
   gridCat2CellClick(nil);
end;

procedure TfmClassificaProd.gridItensTitleClick(Column: TColumn);
begin
   dm.organizarTabela(tb, gridItens, Column);
end;

end.
