unit uImpFichas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCompFornecedor, DB, ADODB, StdCtrls, adLabelEdit, ComCtrls,
  fCtrls, adLabelComboBox, Grids, DBGrids, TFlatButtonUnit;

type
  TfmLstFichaCatCont = class(TfmCompFornecedor)
    procedure FlatButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edCodFornDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLstFichaCatCont: TfmLstFichaCatCont;

implementation

uses uContabil, uMain, fdt;

{$R *.dfm}

procedure TfmLstFichaCatCont.FlatButton1Click(Sender: TObject);
begin
   if (fdt.isIntervDataValido( dti, dtf, true, 31)= true ) then
      fmMain.exportaDataSet(
         uContabil.getFichasCatContabil(cbEmpresa.Items[cbEmpresa.itemIndex], edCodForn.Text, dti.date, dtf.Date),
         nil
      );
end;

procedure TfmLstFichaCatCont.FormCreate(Sender: TObject);
begin
  inherited;
  edCodForn.LabelDefs.Caption := 'Categoria contábil:';
  edCodForn.ReadOnly := false;
end;

procedure TfmLstFichaCatCont.edCodFornDblClick(Sender: TObject);
begin
//  inherited;
end;

end.
