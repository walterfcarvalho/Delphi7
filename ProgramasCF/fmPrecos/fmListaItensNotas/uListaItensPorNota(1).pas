unit uListaItensPorNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, ADODB,
  TFlatButtonUnit, StdCtrls, adLabelEdit, adLabelComboBox,
  Dialogs, Buttons, Grids, DBGrids, SoftDBGrid, DB,
  fCtrls, ScktComp, Menus, ComCtrls;

type
  TfmListaItensNota = class(TForm)
    cbLoja: TadLabelComboBox;
    edSerie: TadLabelEdit;
    edNNota: TadLabelEdit;
    btPesq: TFlatButton;
    grid: TSoftDBGrid;
    qrNota: TADOQuery;
    DataSource1: TDataSource;
    btOk: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
    PopupMenu1: TPopupMenu;
    Veranota1: TMenuItem;
    date: TfsDateTimePicker;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure getIsNota();
    procedure btOkClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Veranota1Click(Sender: TObject);
    procedure gridDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure gridTitleClick(Column: TColumn);
    procedure fsBitBtn2Click(Sender: TObject);
    procedure btPesqClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmListaItensNota: TfmListaItensNota;

implementation

uses cf, f, funcsql, uMain, uFiscal, uDm, ulj, msg, uEstoque;

{$R *.dfm}

procedure TfmListaItensNota.FormCreate(Sender: TObject);
begin
   uLj.getListaLojas(cbLoja, false, false, '', '');
   f.setUoNacomboBox(cbLoja, fmMain.getUoLogada() );
   date.Date :=  dm.getDateBd();
end;

procedure TfmListaItensNota.getIsNota;
var
   i:integer;
begin
   if (trim(edNNota.Text) = '') then
      qrNota := uFiscal.getDadosNota('', f.getCodUO(cbLoja), edSerie.Text, edNNota.Text, date.Date )
   else
      qrNota := uFiscal.getDadosNota('', f.getCodUO(cbLoja), edSerie.Text, edNNota.Text );

   dataSource1.DataSet := qrNota;

   for i:=0 to grid.Columns.Count -1 do
      grid.Columns[i].Visible := false;

   f.ajGridCol(grid, qrNota, 'dt_emis', 70, 'Emissão');
   f.ajGridCol(grid, qrNota, 'Serie', 40, 'Série');
   f.ajGridCol(grid, qrNota, 'Tipo', 60, 'Tipo');
   f.ajGridCol(grid, qrNota, 'Num', 60, 'Número');
   f.ajGridCol(grid, qrNota, 'Emissor/Destino', 150, 'Emissor/Destino');
   f.ajGridCol(grid, qrNota, 'Situacao', 70, 'Situação');
   f.ajGridCol(grid, qrNota, 'Valor', 70, 'Valor');
   f.ajGridCol(grid, qrNota, 'Loja', 150, 'Loja');
   f.ajGridCol(grid, qrNota, 'Xml Arquivado', 50, 'Xml Arquivado');
end;

procedure TfmListaItensNota.btOkClick(Sender: TObject);
begin
  if (qrNota.IsEmpty = false) then
  begin
    fmListaItensNota.Caption := qrNota.FieldByname('is_nota').asString;
    btOk.ModalResult := mrOk;
    fmListaItensNota.ModalResult := mrOk
  end
  else
    fmListaItensNota.ModalResult := mrCancel;
end;

procedure TfmListaItensNota.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
   if (ModalResult = 2 ) then
   begin
      CanClose := false;

      if (edSerie.Text = '') then
        edSerie.setFocus()
      else if (edNNota.Text = '') then
        edNNota.setFocus()
      else
         btPesqClick(nil);
   end;
end;

procedure TfmListaItensNota.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   f.wParReg(f.getNomeDoExecutavel(), 'pesqNf.Serie', edSerie.Text);
   f.wParReg(f.getNomeDoExecutavel(), 'pesqNf.Numero', edNNota.Text);
   f.wParReg(f.getNomeDoExecutavel(), 'pesqNf.UO', f.getCodUO(cbLoja) );


   action := CaFree;
end;

procedure TfmListaItensNota.Veranota1Click(Sender: TObject);
begin
   if (qrNota.IsEmpty = false )then
      fmMain.mostraDetalhesNota(qrNota.fieldByName('is_nota').AsString);
end;

procedure TfmListaItensNota.gridDblClick(Sender: TObject);
begin
   btOkClick(nil);
end;

procedure TfmListaItensNota.FormActivate(Sender: TObject);
var
   uo:String;
begin
   if (edSerie.Visible = true) then
      edSerie.SetFocus;

   uo := f.rParReg(f.getNomeDoExecutavel(), 'pesqNf.uo' );

   if (f.setUoNacomboBox(cbLoja, uo) <> false ) then
   begin
      edSerie.Text := f.rParReg(f.getNomeDoExecutavel(), 'pesqNf.Serie' );
      edNNota.Text := f.rParReg(f.getNomeDoExecutavel(), 'pesqNf.Numero' );
   end;
end;

procedure TfmListaItensNota.gridTitleClick(Column: TColumn);
begin
   dm.organizarQuery(qrNota, grid, column);
end;

procedure TfmListaItensNota.fsBitBtn2Click(Sender: TObject);
begin
   ModalResult := mrNo;
end;

procedure TfmListaItensNota.btPesqClick(Sender: TObject);
begin
   getIsNota();
end;

end.
