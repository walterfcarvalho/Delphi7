unit uDetalhesCRUC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid,DB;

type
  TfmDetalhesCRUC = class(TForm)
     grid: TSoftDBGrid;
     DataSource1: TDataSource;

    procedure getDadosCRUC(is_ref:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridDblClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDetalhesCRUC: TfmDetalhesCRUC;

implementation

uses uMain, uEstoque, f, Math;

{$R *.dfm}


procedure TfmDetalhesCRUC.getDadosCRUC(is_ref: String);
var
  ds:TdataSet;
begin
   ds := uEstoque.getDetalhesCRUC(is_ref);
   DataSource1.DataSet := ds;

   if( ds.IsEmpty = false )then
   begin
      f.ajGridCol(grid, ds , 'Loja', 131, 'Loja');
      f.ajGridCol(grid, ds, 'Data entrada', 72, 'Data entrada');
      f.ajGridCol(grid, ds, 'Sr Nota', 43, 'Sr Nota');
      f.ajGridCol(grid, ds, 'Nr Nota', 60, 'Nr Nota');
      f.ajGridCol(grid, ds, 'Vl de Nota', 87, 'Vl de Nota');
      f.ajGridCol(grid, ds, '% IPI', 39, '% IPI');
      f.ajGridCol(grid, ds, '(+) Vl IPI', 60, '(+) Vl IPI');
      f.ajGridCol(grid, ds, '%ICMS', 58, '%ICMS');
      f.ajGridCol(grid, ds, '(-) Vl ICMS', 71, '(-) Vl ICMS');
      f.ajGridCol(grid, ds, 'Ult Pedido', 74, 'Ult Pedido');
      f.ajGridCol(grid, ds, 'Pc Ultima Compra', 126, 'Pc Ultima Compra');
      f.ajGridCol(grid, ds, 'Pc CRUC', 64, 'Pc CRUC');
   end;
end;

procedure TfmDetalhesCRUC.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    action := caFree;
   DataSource1.DataSet.Free();    
    fmDetalhesCRUC:= nil;
end;

procedure TfmDetalhesCRUC.gridDblClick(Sender: TObject);
begin
//   f.salvaColunasDbGrid(grid);
end;

end.
