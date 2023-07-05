unit uTotalSaidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, TFlatButtonUnit, db,
  StdCtrls, ExtCtrls, adLabelComboBox, Grids, DBGrids, SoftDBGrid, fCtrls,
  ADODB;

type
  TfmTotalSaidas = class(TForm)
    dt01: TDateTimePicker;
    dt02: TDateTimePicker;
    FlatButton1: TFlatButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbTotal: TLabel;
    cbLoja: TadLabelComboBox;
    Bevel1: TBevel;
    Panel1: TPanel;
    Label4: TLabel;
    lbDados: TLabel;
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    cbVarAtac: TfsCheckBox;
    tb: TADOTable;
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure calcularVenda(is_ref, uo:String; inicio, fim: Tdate);

    procedure ajustaDataInicio(data:Tdate);
    procedure calculaVendaAtacVar();
    procedure gridDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTotalSaidas: TfmTotalSaidas;
  fmIS_REF:String;
implementation

uses uMain, f, cf, uEstoque, uLj, uProd, uDm;

{$R *.dfm}
procedure TfmTotalSaidas.FormCreate(Sender: TObject);
begin
   uLj.getListaLojas( cbLoja, true, false, '', fmMain.getUoLogada());
end;

procedure TfmTotalSaidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
   fmTotalSaidas := nil;
end;

procedure TfmTotalSaidas.calcularVenda(is_ref, uo:String; inicio, fim: Tdate);
var
   ds:TdataSet;
   uoParaDados:String;
begin
   if (uo = '') or (uo = '999') then
      uoParaDados := fmMain.getUOCD()
   else
      uoParaDados := uo;

   if (lbDados.Caption = '') then
   begin
      ds:= uProd.getDadosProdBasico(uoParaDados, is_ref, '101', '0');
      lbDados.Caption := ds.fieldByName('codigo').AsString + '  '+
                         ds.fieldByName('descricao').AsString;
      ds.free();
   end;

   fmIS_REF := is_ref;

   ds:= uProd.getVdItemDetPorLojaPeriodo( is_ref, uo, inicio, fim);

   dataSource1.DataSet := ds;
   lbTotal.caption :=  dm.somaColTable(ds, 'qt_mov', true);

   grid.Columns[ ds.FieldByName('qt_mov').Index ].Title.Caption := 'Quantidade';
end;


procedure TfmTotalSaidas.FlatButton1Click(Sender: TObject);
begin
   if (cbVarAtac.Checked = false) then
      calcularVenda( fmIS_REF, f.getCodUO(cbLoja), dt01.Date, dt02.date)
   else
     calculaVendaAtacVar();
end;

procedure TfmTotalSaidas.ajustaDataInicio(data: Tdate);
begin
   dt01.Date := data;
   dt02.Date := now;
end;

procedure TfmTotalSaidas.calculaVendaAtacVar();
begin
   tb.Connection := dm.con;

   if tb.TableName <> '' then
      tb.Close();

   if (DataSource1.DataSet.IsEmpty = false )then
      grid.DataSource.DataSet.Close();

   DataSource1.DataSet := tb;
   tb.TableName :=  uprod.getTbVendaVarejoAtacado( f.getCodUO(cbLoja), fmIS_REF, dt01.Date, dt02.Date);
   tb.Open();

   f.ajGridCol(grid, tb, 'is_uo', 0, 'is_uo');
   f.ajGridCol(grid, tb, 'ds_uo', 195, 'Loja');
   f.ajGridCol(grid, tb, 'qtVarejo', 88, 'Varejo');
   f.ajGridCol(grid, tb, 'qtAtacado', 110, 'Atacado');
   f.ajGridCol(grid, tb, 'seq', 0, 'seq');

   lbTotal.caption :=
   floatToStr(
   dm.somaColunaTable(tb, 'qtVarejo') + dm.somaColunaTable(tb, 'qtAtacado')
   ) ;
end;

procedure TfmTotalSaidas.gridDblClick(Sender: TObject);
begin
//   f.salvaColunasDbGrid(grid, tb);



end;

end.
