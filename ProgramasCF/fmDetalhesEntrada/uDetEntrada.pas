unit uDetEntrada;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, funcsql,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls, ComCtrls,
  ExtCtrls, Menus;

type
  TfmDetEntrada = class(TForm)
    SoftDBGrid1: TSoftDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    itens1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure consultaDetalhesEntrada(is_ref:String);
    procedure Veressanota1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure itens1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDetEntrada: TfmDetEntrada;

implementation

uses uMain, uCF, uDm, uEstoque, f, msg;

{$R *.dfm}
procedure TfmDetEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
   fmDetEntrada := nil;
end;

procedure TfmDetEntrada.consultaDetalhesEntrada(is_ref:String);
var
  lst:Tstrings;
begin
   lst := dm.GetValoresSQL(lst, ' Select cd_ref, ds_ref from crefe (nolock) where is_ref = ' + is_ref);
   label2.Caption := lst[0] + '   ' + lst[1];

   DataSource1.DataSet := uEstoque.getEntradasPorItem(is_ref, '', strToDate('01/01/2000'), now);
   if (SoftDBGrid1.Columns.Count -1 > 2) then
   begin
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'numNota', 50, 'Nota');
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'srNota', 30, 'Serie');
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'ds_uo', 120, 'Loja');
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'VL_DSPEXTRA', 0, '');
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'valorRateio', 0, '');
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'ValorIcms', 0, '');
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'ValorIPI', 0, '');
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'totalNota', 0, '');
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'totalItem', 0, '');
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'is_nota', 0, '');
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'vlItensNota', 0, '');
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'freteRateado', 0, '');
      f.ajGridCol(SoftDBGrid1, DataSource1.DataSet, 'is_oper', 50, 'Operação');
   end;
   lst.Free();
end;

procedure TfmDetEntrada.Veressanota1Click(Sender: TObject);
begin
   fmMain.mostraDetalhesNota(DataSource1.DataSet.fieldByName('is_nota').AsString);
end;

procedure TfmDetEntrada.PopupMenu1Popup(Sender: TObject);
begin
   fmMain.mostraDetalhesNota(DataSource1.DataSet.fieldByName('is_nota').AsString);
end;

procedure TfmDetEntrada.itens1Click(Sender: TObject);
begin
   fmMain.mostraDetalhesNota(DataSource1.DataSet.fieldByName('is_nota').AsString);
end;

end.
