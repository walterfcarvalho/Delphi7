unit uEntUsaivdMed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, SoftDBGrid, StdCtrls, adLabelListBox,
  ExtCtrls, adLabelEdit, adLabelComboBox, TFlatButtonUnit, Menus;

type
  	TfmDadosEntSaiMed = class(TForm)
   pnTitulo: TPanel;
   btGeraEstoque: TFlatButton;
   cbLoja: TadLabelComboBox;
   edit1: TadLabelEdit;
   Panel1: TPanel;
   lbNivel: TLabel;
   lbVlCat: TLabel;
   lbClasse1: TLabel;
   lbClasse2: TLabel;
   lbClasse3: TLabel;
   Bevel1: TBevel;
   Label5: TLabel;
   Label6: TLabel;
   Label2: TLabel;
   FlatButton7: TFlatButton;
   pnForn: TPanel;
   btAddForn: TFlatButton;
   btRemoveForn: TFlatButton;
   lbForn: TadLabelListBox;
   grid: TSoftDBGrid;
   tbGE: TADOTable;
    dsGe: TDataSource;
   pbRodape: TPanel;
   btPrint: TFlatButton;
   rgTpBusca: TadLabelComboBox;
   btExport: TFlatButton;
   Label1: TLabel;
    btReq: TFlatButton;
    FlatButton5: TFlatButton;
    FlatButton6: TFlatButton;
    Bt_Saidas: TFlatButton;
    Bt_Entradas: TFlatButton;
	procedure btGeraEstoqueClick(Sender: TObject);
   procedure calcular();
   procedure selectItens(uo:String);
   procedure FormCreate(Sender: TObject);
   procedure rgTpBuscaChange(Sender: TObject);
	procedure  ajAcessoPnCategoria();
	procedure ajustaGrid();
	procedure btExportClick(Sender: TObject);
   procedure FormClose(Sender: TObject; var Action: TCloseAction);
   procedure FlatButton7Click(Sender: TObject);
   procedure btAddFornClick(Sender: TObject);
   procedure gridDblClick(Sender: TObject);
   procedure calculaSugestaocompra();
    procedure Bt_SaidasClick(Sender: TObject);
    procedure btReqClick(Sender: TObject);
    procedure Bt_EntradasClick(Sender: TObject);
    procedure FlatButton5Click(Sender: TObject);
    procedure FlatButton6Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDadosEntSaiMed: TfmDadosEntSaiMed;

implementation

uses uDadosGeraEst, uLj, uMain, f, uDm, uGeraEstoque, msg, uProd;

{$R *.dfm}

procedure TfmDadosEntSaiMed.selectItens(uo:String);
var
  dsIt:TdataSet;
begin
	dsIt := TDataSet.Create(nil);
   if (rgTpBusca.ItemIndex < 3) then
		dsIt := uDadosGeraEst.selectItens(rgTpBusca.ItemIndex, edit1.Text, lbNivel.Caption, lbVlCat.Caption, true, lbForn.Items)
   else
		dsIt := uProd.getItensFromXLS();// getItensFromXLS(tbGe);

	f.gravaLog(dsIt, 'Itens da planilha');

   uDadosGeraEst.getItensGeraEstoque( dsIt, tbGE, uo, '101', false);
end;

procedure TfmDadosEntSaiMed.calcular;
var
  uo:String;
begin
	ajustaGrid();

   uo :=  uDadosGeraEst.lojaAProcessar( (cbLoja.ItemIndex = 0), cbLoja);

	fmDadosEntSaiMed.selectItens(uo);

	uDadosGeraEst.getDadosEntrada(tbGe, uo, false);

   uDadosGeraEst.getDadosUltSaida(tbGe, uo);

   uDadosGeraEst.calculaVendasMedias(tbGE, uo);

	if (rgTpBusca.ItemIndex = 3) then
		calculaSugestaocompra();

   fmMain.msgStatus('');
end;

procedure TfmDadosEntSaiMed.btGeraEstoqueClick(Sender: TObject);
var
  erro:String;
begin
   erro := verificaParametros(rgTpBusca.ItemIndex, 0, cbLoja.ItemIndex, edit1.Text, lbForn.Items);
	if (erro =  '') then
		calcular()
   else
      msg.msgErro('Erro:'+#13+ erro);
end;


procedure TfmDadosEntSaiMed.FormCreate(Sender: TObject);
begin
   uLj.getListaLojas( cbLoja, true, false, fmMain.getCdPesLogado(), fmMain.getUoLogada());

	ajustaGrid();

   rgTpBusca.ItemIndex := 0;
   cbLoja.ItemIndex := 0;
   grid.Align := alClient;
end;

procedure TfmDadosEntSaiMed.rgTpBuscaChange(Sender: TObject);
begin
    ajAcessoPnCategoria();
    Case rgTpBusca.ItemIndex of
       0: edit1.LabelDefs.Caption := 'Faixa de código';
       1: edit1.LabelDefs.Caption := 'Número do pedido';
       2: edit1.LabelDefs.Caption := 'Código do fornecedor';
    end;


    if (rgTpBusca.ItemIndex  = 2) then
    begin
       pnForn.Visible := true;
       pnForn.Left := 5;
       pnForn.Top := 40;
    end
    else
       pnForn.Visible := false;
end;

procedure TfmDadosEntSaiMed.ajAcessoPnCategoria();
begin
   lbNivel.Caption := '0';
   lbVlCat.Caption := '0000';
   Panel1.Visible := (rgTpBusca.ItemIndex = 0);
end;

procedure TfmDadosEntSaiMed.ajustaGrid();
var
  i:smallint;
begin
   if (tbGE.TableName <> '') then
   	tbGE.Close;

	dm.getTable(tbGe, dm.getCMD('estoque', 'getTbEntSaiVd'));

   f.ajGridCol(grid, tbGE, 'is_ref', 0, '');
   f.ajGridCol(grid, tbGE, 'codigo', 50, 'Código');
   f.ajGridCol(grid, tbGE, 'descricao', 360, 'Descrição');
   f.ajGridCol(grid, tbGE, 'Data Ultima Ent', 112, 'Data ult ent');
   f.ajGridCol(grid, tbGE, 'Quant Ultima Ent', 84, 'Qt ult ent');
   f.ajGridCol(grid, tbGE, 'dt_ult_vend', 112, 'Data ult venda');
   f.ajGridCol(grid, tbGE, 'qt_ult_vend', 65, 'Qt ult venda');
   f.ajGridCol(grid, tbGE, 'estoque', 65, 'Estoque');
   f.ajGridCol(grid, tbGE, 'qtMaiorVenda', 70, 'Maior venda');
   f.ajGridCol(grid, tbGE, 'vdMed12', 65, 'Med 12 meses');
   f.ajGridCol(grid, tbGE, 'vdMed6', 65, 'Med 06 meses');
   f.ajGridCol(grid, tbGE, 'vdMed3', 65, 'Med 03 meses');
   f.ajGridCol(grid, tbGE, 'vdMed1', 65, 'Med últ mês');
   f.ajGridCol(grid, tbGE, 'estoqueDesejavel', 65, 'Estoque desejavel');
   f.ajGridCol(grid, tbGE, 'sugestaoPedido', 65, 'Sugestão pedido');


   for i:=0 to grid.Columns.Count -1 do
      grid.Columns[i].Title.Font.Style :=[fsbold];
end;

procedure TfmDadosEntSaiMed.btExportClick(Sender: TObject);
begin
	fmMain.exportaDataSet(tbGE, nil);
end;

procedure TfmDadosEntSaiMed.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   tbge.Close();
   f.salvaCampos(fmDadosEntSaiMed);
   Action := caFree;
   fmDadosEntSaiMed := nil;
end;

procedure TfmDadosEntSaiMed.FlatButton7Click(Sender: TObject);
begin
   fmMain.ajustaValoresCategorias(lbClasse1, lbClasse2, lbClasse3, lbNivel, lbVlCat);
end;

procedure TfmDadosEntSaiMed.btAddFornClick(Sender: TObject);
begin
   fmMain.addFornaLista(lbForn);
end;

procedure TfmDadosEntSaiMed.gridDblClick(Sender: TObject);
begin
	f.salvaColunasDbGrid(grid, tbGe);
end;

procedure TfmDadosEntSaiMed.calculaSugestaocompra();
var
   estoque, estAlvo:integer;
begin
	tbGE.First();
   while (tbGE.Eof = false) do
   begin
   	tbGE.Edit();

      estoque := tbGE.FieldByName('estoque').AsInteger;
      estAlvo := tbGE.FieldByName('estoqueDesejavel').AsInteger;

      tbGE.FieldByName('sugestaoPedido').AsInteger := estAlvo - estoque;

   	tbGE.Post();
   	tbGE.Next();
   end;
end;

procedure TfmDadosEntSaiMed.Bt_SaidasClick(Sender: TObject);
begin
	uDAdosGeraEst.listaFormVendas(
   	tbGE,
		uDadosGeraEst.lojaAProcessar((cbLoja.ItemIndex = 0), cbLoja),
	   strToDate('01/01/2000')
   );
end;

procedure TfmDadosEntSaiMed.btReqClick(Sender: TObject);
begin
	uDAdosGeraEst.listaFormRequisicao(
	   tbGe,
		uDadosGeraEst.lojaAProcessar((cbLoja.ItemIndex = 0), cbLoja),
	   (now-30)
   );
end;

procedure TfmDadosEntSaiMed.Bt_EntradasClick(Sender: TObject);
begin
   screen.Cursor := crhourglass;
   if (tbGE.IsEmpty = false) then
      fmMain.obterDetalhesEntrada(tbGE.fieldByName('is_ref').asString );
   screen.Cursor := crdefault;
end;

procedure TfmDadosEntSaiMed.FlatButton5Click(Sender: TObject);
begin
   if not(tbGE.IsEmpty) then
      fmMain.obterResumoEstoque( tbGE.fieldByName('is_ref').AsString, '1');
end;

procedure TfmDadosEntSaiMed.FlatButton6Click(Sender: TObject);
begin
   if not(tbGE.IsEmpty) then
      fmMain.obterResumoEstoque( tbGE.fieldByName('is_ref').AsString, '1');
end;

end.
