unit uConReqDep;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, adLabelComboBox, ComCtrls,
  adLabelDBDateTimePicker, DB, ADODB, Grids, DBGrids, SoftDBGrid,
  fCtrls, ExtCtrls, Buttons, Menus;

type
  TfmConReqDep = class(TForm)
    grid: TSoftDBGrid;
    dsReq: TDataSource;
    pdGrid: TSoftDBGrid;
    Label3: TLabel;
    DataSource2: TDataSource;
    Panel2: TPanel;
    fsBitBtn1: TfsBitBtn;
    dtf: TfsDateTimePicker;
    dti: TfsDateTimePicker;
    cbLojaEstoque: TadLabelComboBox;
    cbLojas: TadLabelComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    qrReq: TADOQuery;
    qrItens: TADOQuery;
    popMenu: TPopupMenu;
    Removerrequisio1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure consultaPedidos();
    procedure ajustaLoja(Sender:TObject; combo:TcomboBox;loja:string);
    procedure FormActivate(Sender: TObject);
    procedure ListaItensRequicao();
    procedure gridDblClick(Sender: TObject);
    procedure ajustaCabecalho(grid:TDbgrid);
    procedure btOkClick(Sender: TObject);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridTitleClick(Column: TColumn);
    procedure Removerrequisio1Click(Sender: TObject); //sender:tobject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmConReqDep: TfmConReqDep;

implementation

uses umain, uCF, f, uDm, uLj, msg, fdt, uReq;

{$R *.dfm}

procedure TfmConReqDep.FormCreate(Sender: TObject);
begin
	cbLojaEstoque.Items :=  uLj.getCdRecebReq();

   cbLojaEstoque.ItemIndex :=0;
end;

procedure TfmConReqDep.consultaPedidos();
begin
   getReqLojasPorData(qrReq, dti.Date, dtf.Date, f.getCodUO(cbLojaEstoque), f.getCodUO(cbLojas));

   grid.Columns[0].Width := 200;
   grid.Columns[1].Width := 150;
   grid.Columns[2].Width := 150;
   f.ajGridCol(grid, qrReq, 'nm_usu', 100, 'Usuário');

   ajustaCabecalho(grid);
end;

procedure TfmConReqDep.ajustaLoja(Sender: TObject; combo: TcomboBox;loja: string);
var
   i:integer;
begin
   combo.itemindex := 0;
   for i:=0 to combo.Items.Count -1 do
   begin
      if f.SohNumeros(copy(combo.Items[i],40,50)) = loja then
         combo.itemindex := i;
   end;
end;
procedure TfmConReqDep.btOkClick(Sender: TObject);

begin
   if dti.Date > dtf.Date then
      msg.msgErro('Data inicial maior que a data final.')
   else if (dtf.Date - dti.Date) > 30 then
      msg.msgErro('Período maior que 30 dias.')
   else
      ConsultaPedidos()
end;

procedure TfmConReqDep.FormActivate(Sender: TObject);
begin
   dtf.Date := now;
   dti.Date := now;

   if fmMain.isAcessoTotal(fmMain.Consultaarequisies2.Tag) then
   begin
    grid.PopupMenu := popMenu;
    uLj.getListaLojas(cbLojas, true, false, '', fmMain.getUoLogada() );
   end
   else
   begin
      grid.PopupMenu := nil;
      uLj.getListaLojas(cbLojas, false, false, fmMain.getCdPesLogado(), fmMain.getUoLogada() );
   end
end;

procedure TfmConReqDep.ListaItensRequicao();
begin
   uReq.getItensReq(qrItens, dsReq.DataSet.FieldByname('Requisição').AsString);

   pdGrid.Columns[0].Width := 50;
   pdGrid.Columns[01].Width := 300;
   pdGrid.Columns[02].Width := 50;
   pdGrid.Columns[03].Width := 50;
   pdGrid.Columns[04].Width := 50;
   pdGrid.Columns[05].Width := 50;
   pdGrid.Columns[06].Width := 50;
   pdGrid.Columns[07].Width := 50;


   ajustaCabecalho(pdGrid);
end;

procedure TfmConReqDep.gridDblClick(Sender: TObject);
begin
  if  (dsReq.DataSet.IsEmpty = false) then
     ListaItensRequicao();
end;

procedure TfmConReqDep.ajustaCabecalho(grid: TDbgrid);
var
  i:integer;
begin
   for i:= 0 to grid.Columns.Count -1 do
      grid.Columns[i].Title.Font.Style := [fsBold];
end;

procedure TfmConReqDep.fsBitBtn1Click(Sender: TObject);
begin
   if (dti.Date > dtf.Date) then
      msg.msgErro('Data inicial menor que a final');
   consultaPedidos();
end;

procedure TfmConReqDep.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   fmConReqDep := nil;
   action := cafree;
end;

procedure TfmConReqDep.gridTitleClick(Column: TColumn);
begin
   dm.organizarQuery(qrReq, grid, Column);
end;

procedure TfmConReqDep.Removerrequisio1Click(Sender: TObject);
begin
   ureq.apagaRequisicao(qrReq.fieldByName('Requisição').AsString);
end;

end.
