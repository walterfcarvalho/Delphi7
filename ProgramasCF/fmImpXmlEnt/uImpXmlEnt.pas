unit uImpXmlEnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uListaItensPorNota, Menus, DB, ADODB, StdCtrls, fCtrls,
  ComCtrls, Buttons, Grids, DBGrids, SoftDBGrid, TFlatButtonUnit,
  adLabelEdit, adLabelComboBox;

type
  TfmImpXmlEnt = class(TfmListaItensNota)
    procedure FormCreate(Sender: TObject);
    procedure btPesqClick(Sender: TObject);
    procedure fsBitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmImpXmlEnt: TfmImpXmlEnt;

implementation

uses uFiscal, f;

{$R *.dfm}

procedure TfmImpXmlEnt.FormCreate(Sender: TObject);
begin
//  inherited;
   cbLoja.Visible := false;
   edSerie.Left := edSerie.Left - cbLoja.Width;
   edNNota.Left := edNNota.Left - cbLoja.Width;
   date.Visible := false;
end;


procedure TfmImpXmlEnt.btPesqClick(Sender: TObject);
begin
//  inherited;
   uFiscal.listaXmlEnt(qrNota, edSerie.Text, edNNota.Text);

   f.ajGridCol(grid, qrNota, 'is_uo', 0, '');
   f.ajGridCol(grid, qrNota, 'serie', 30, 'Série');
   f.ajGridCol(grid, qrNota, 'numero', 60, 'Número');
   f.ajGridCol(grid, qrNota, 'ds_uo', 250, 'Loja recebedora');
   f.ajGridCol(grid, qrNota, 'nmArq', 0, '');
   f.ajGridCol(grid, qrNota, 'data', 150, 'Data Salva');

// select uo.is_uo, nf.serie, nf.numero, uo.ds_uo, nf.nmArq from zcf_chavesXmlEnt nf inner join zcf_tbuo uo on uo.is_uo = nf.ipserver where serie= ?and numero= ? order by serie, numero
end;

procedure TfmImpXmlEnt.fsBitBtn2Click(Sender: TObject);
begin
//  inherited;
   fmImpXmlEnt.Close();
end;

procedure TfmImpXmlEnt.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;
    Action := caFree;
    fmImpXmlEnt := nil;
end;

procedure TfmImpXmlEnt.gridDblClick(Sender: TObject);
begin
//  inherited;
   if (qrNota.IsEmpty = false) then
   begin
      uFiscal.visualizaXmlEnt(
         qrNota.fieldByName('is_uo').asString,
         qrNota.fieldByName('nmArq').asString,
         qrNota.fieldByName('chNfe').asString
      );

   end;

end;

end.
