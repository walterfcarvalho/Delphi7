unit uReqTransferidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SoftDBGrid;

type
  TfmReqTransferidas = class(TForm)
    grid: TSoftDBGrid;
    DataSource1: TDataSource;

    procedure consultaReqtransferida(isRef, uocd, uo: String; dti, dtf: Tdate);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmReqTransferidas: TfmReqTransferidas;
  ds:TdataSet;
implementation

uses ucf, cf, f, msg, uEstoque;
{$R *.dfm}

{ TfmReqTransferidas }

procedure TfmReqTransferidas.consultaReqtransferida(isRef, uocd, uo: String; dti, dtf: Tdate);
begin
   ds := uEstoque.getRRANAItem(isRef, uocd, '2', uo, dti, dtf);
   DataSource1.DataSet := ds;
   if (ds.IsEmpty = false) then
   begin
      grid.Columns[ds.FieldByName('dt_mov').Index].Title.Caption := 'Data';
      grid.Columns[ds.FieldByName('nm_usu').Index].Title.Caption := 'Usuário';
      grid.Columns[ds.FieldByName('qt_mov').Index].Title.Caption := 'Quantidade';
      grid.Columns[ds.FieldByName('ds_uo').Index].Title.Caption := 'Lj Destino';
      grid.Columns[ds.FieldByName('sr_docf').Index].Title.Caption := 'Sr nota';
      grid.Columns[ds.FieldByName('nr_docf').Index].Title.Caption := 'Nr nota';

      grid.Columns[ds.FieldByName('qt_sldatu').Index].Visible := false;
      grid.Columns[ds.FieldByName('ds_res').Index].Visible := false;
      grid.Columns[ds.FieldByName('TipoMovEstoque').Index].Visible := false;
      grid.Columns[ds.FieldByName('is_filDest').Index].Visible := false;
      grid.Columns[ds.FieldByName('sq_dlest').Index].Visible := false;


      grid.Columns[ds.FieldByName('dt_mov').Index].Width := 110;
      grid.Columns[ds.FieldByName('nm_usu').Index].Width := 113;
      grid.Columns[ds.FieldByName('qt_mov').Index].Width := 70;
      grid.Columns[ds.FieldByName('ds_uo').Index].Width := 110;
      grid.Columns[ds.FieldByName('sr_docf').Index].Width := 30;
      grid.Columns[ds.FieldByName('nr_docf').Index].Width := 60;
   end
   else
   begin
      msg.msgErro('Não há transferencia para essa loja, desse item após essa requisição');
      fmReqTransferidas.Close();
   end;

end;

procedure TfmReqTransferidas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   fmReqTransferidas := nil;
end;

procedure TfmReqTransferidas.gridColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
var
   i:integer;
begin
   for i := 0 to grid.Columns.Count -1 do
    if grid.Columns[i].Visible = true then
       gravaLog(grid.Columns[i].FieldName + ' '+ intToStr(grid.Columns[i].Width));
end;

end.


