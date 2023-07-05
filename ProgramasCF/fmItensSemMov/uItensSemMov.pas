unit uItensSemMov;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRelGeral, DB, ADODB, StdCtrls, fCtrls, ComCtrls,
  TFlatButtonUnit, adLabelComboBox, adLabelEdit, adLabelNumericEdit,
  adLabelSpinEdit, Grids, DBGrids, SoftDBGrid, ExtCtrls, Buttons;

type
  TfmItensSemMov = class(TfmRelGeral)
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    edCodigo: TadLabelEdit;
    spedit: TadLabelSpinEdit;
    btExport: TFlatButton;
    cbRemSemMov: TfsCheckBox;
    Label3: TLabel;
    procedure geraDiasSemOperacao();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure pegarDiasSemMovimentoDositens();
    procedure gridTitleClick(Column: TColumn);
    procedure getDadosUltEntradaCompra();
    procedure FormActivate(Sender: TObject);
    procedure FlatButton7Click(Sender: TObject);
    procedure btExportarClick(Sender: TObject);
    procedure removeItensSemDados();
    procedure popularTabelaItens();
    procedure FormShow(Sender: TObject);
    procedure btExportClick(Sender: TObject);
    procedure cbRemSemMovClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmItensSemMov: TfmItensSemMov;

implementation

uses f, uMain, cf, ucf, uDm, uEstoque, uLj, msg, fdt, uProd, uDadosGeraEst;

{$R *.dfm}

procedure TfmItensSemMov.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
   fmItensSemMov := nil;
end;

procedure TfmItensSemMov.pegarDiasSemMovimentoDosItens;
var
  tp_mov:String;
  qtDias:integer;
begin
   f.gravaLog('');
   f.gravaLog('pegarDiasSemMovimentoDosItens()');
   f.gravaLog('');


   case cbCaixas.ItemIndex of
      0:tp_mov := '2';
      1:tp_mov := '09, 23, 24, 25, 26, 43, 44 , 46';
   end;

   tbOperadores.First();
   while (tbOperadores.Eof = false ) do
   begin
      fmMain.msgStatusProgresso(tbOperadores.recNo, tbOperadores.RecordCount, 'Obtendo último movimento...');

      qtDias :=  uEstoque.getDiasSemMov( f.getCodUO(cbLojas),
                                   tbOperadores.fieldByName('is_ref').asString,
                                   tp_mov
                                 );
      tbOperadores.Edit;
      tbOperadores.FieldByName('qtDias').AsInteger := qtDias;
      tbOperadores.post;
      tbOperadores.next;
   end;

   tbOperadores.First();
   while ( tbOperadores.Eof = false ) do
   begin
      fmMain.msgStatusProgresso(tbOperadores.RecNo, tbOperadores.RecordCount, 'Filtrando valores...');

      if( tbOperadores.FieldByName('qtDias').AsInteger < spedit.Value) then
         tbOperadores.Delete()
      else
         tbOperadores.Next;
   end;
end;

procedure TfmItensSemMov.gridTitleClick(Column: TColumn);
begin
   dm.organizarTabela(tbOperadores, grid, column);
end;

procedure TfmItensSemMov.getDadosUltEntradaCompra;
var
   ds:TdataSet;
begin
   f.gravaLog('');
   f.gravaLog('getDadosUltEntradaCompra()');
   f.gravaLog('');

   tbOperadores.First();
   while ( tbOperadores.Eof = false) do
   begin
      fmMain.msgStatusProgresso(tbOperadores.recNo, tbOperadores.RecordCount, 'Obtendo data da ultima entrada...');

      ds:= uProd.getDadosUltEntItem(tbOperadores.fieldByName('is_ref').AsString, f.getCodUO(cbLojas), '1, 3' );

      if (ds.IsEmpty = false) then
      begin
          tbOperadores.Edit;
          tbOperadores.FieldByName('Data Ult Entrada').AsString := ds.fieldByName('dt_Mov').asString;
          tbOperadores.post;
      end;
          tbOperadores.Next();

      ds.free();
    end;
end;

procedure TfmItensSemMov.FormActivate(Sender: TObject);
begin
   GroupBox1.Visible := false;
   cbDetAvaForn.Visible := false;

   cbCaixas.LabelDefs.Caption := 'Tipo de movimento:';
   cbCaixas.Items.Clear();
   cbCaixas.items.add('Saída de transferência');
   cbCaixas.items.add('Venda');
   GroupBox1.Visible := false;
   cbCaixas.itemIndex := 0;

   uLj.getListaLojas( cbLojas, false ,false, fmMain.getCdPesLogado(), fmMain.getUoLogada() ) ;

   GroupBox1.Visible := true;
   pnSelCat.Visible := true;
   edCodigo.Visible := true;

   if (fmMain.isAcessoTotal(fmMain.ListaItenssemmovimentao1.Tag)) then
     QT_DIAS_INTERV_DATA := 9999
   else
     QT_DIAS_INTERV_DATA := 31;

   fdt.formataIntervDatas(now, di, df);

//   btExport.Visible := false;
   grid.Align := alClient;
   GroupBox1.Free();
end;

procedure TfmItensSemMov.FlatButton7Click(Sender: TObject);
begin
   fmMain.ajustaValoresCategorias(lbClasse1, lbClasse2, lbClasse3, lbNivel, lbVlCat);
end;

procedure TfmItensSemMov.btExportarClick(Sender: TObject);
begin
  if ( tbOperadores.IsEmpty = false ) then
     fmMain.exportaDataSet(tbOperadores, nil);

end;

procedure TfmItensSemMov.popularTabelaItens();
var
   cmd:String;
	dsItens:TdataSet;
begin
   cmd := 'is_ref int primary key, codigo varchar(10), descricao varchar(60), [Data Ult Entrada] smallDateTime, estoque int, pv money, qtDias int, cd_pes int, dt_imp smallDateTime';
   dm.getTable(tbOperadores, cmd);

   dsItens :=
   uEstoque.getTabelaPrecos( 0, 2, '', edCodigo.Text, f.getCodUO(cbLojas), '101', '-1', lbNivel.Caption, lbVlCat.Caption);

   fmMain.msgStatus('Itens Encontrados: ' + intToStr(dsItens.RecordCount));
   sleep(1000);

   uDadosGeraEst.getItensGeraEstoque( dsItens, tbOperadores, f.getCodUO(cbLojas), '101', false);
end;

procedure TfmItensSemMov.removeItensSemDados;
var
  data:Tdate;
begin
   f.gravaLog('removeItensSemDados()');

   data := dm.getDateBd();

   tbOperadores.First();
   while (tbOperadores.Eof = false) do
   begin
      if (tbOperadores.FieldByName('Data Ult Entrada').AsString <> '' ) then
      begin
         if ( (data - tbOperadores.FieldByName('Data Ult Entrada').AsDateTime) < spedit.Value) then
            tbOperadores.Delete()
         else
            tbOperadores.next();
      end
      else
         tbOperadores.next();
   end;
end;

procedure TfmItensSemMov.geraDiasSemOperacao;
begin
   f.gravaLog('---------- Gerar produtos sem movimento --------');

   // obtem os itens
   popularTabelaItens();

   // calcular os dias sem o movimento
   pegarDiasSemMovimentoDositens();

   // calcular a ultima entrada do item
   getDadosUltEntradaCompra();

   // remover os itens que nao tem entrada sem estoque
   if (cbRemSemMov.Checked = true) then
      removeItensSemDados();

   grid.Columns[ tbOperadores.FieldByName('is_ref').Index].Visible := false;
   grid.Columns[ tbOperadores.FieldByName('pv').Index].title.caption := 'Preco Varejo';

   fmMain.msgStatus('');
end;


procedure TfmItensSemMov.btOkClick(Sender: TObject);
var
   executa:boolean;
begin
   grid.Visible := false;
   executa := true;
//   if (fdt.isIntervDataValido(di, df, true, 99999) = false) then
//      executa := false;

   if (edCodigo.Text = '' ) then
      if (msg.msgQuestion('Se não especificar o código vou gerar para todos os itens,' +
                          'isso pode demorar, continua?' ) = mrNo) then
      executa := false;

   if (executa = true) then
      geraDiasSemOperacao();


   grid.Visible := true;
end;


procedure TfmItensSemMov.FormShow(Sender: TObject);
begin
//  inherited;

end;

procedure TfmItensSemMov.btExportClick(Sender: TObject);
begin
  inherited;
   fmMain.exportaDataSet(tbOperadores, nil);
end;

procedure TfmItensSemMov.cbRemSemMovClick(Sender: TObject);
begin
//  inherited;
   spedit.Enabled := cbRemSemMov.Enabled;

end;

end.
