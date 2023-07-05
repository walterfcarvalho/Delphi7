unit uAbreMovDiario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fCtrls, ComCtrls, Buttons;

type
  TfmDialogMov = class(TForm)
    fsData: TfsDateTimePicker;
    cbLoja: TfsComboBox;
    Label2: TLabel;
    Label1: TLabel;
    btCancel: TfsBitBtn;
    btOk: TfsBitBtn;

    procedure confCampos(dataDefault:Tdate);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDialogMov: TfmDialogMov;

implementation

uses f, uDm;

{$R *.dfm}

{ TfmDialogMov }

procedure TfmDialogMov.confCampos(dataDefault:Tdate);
begin
   fsData.DateTime := dataDefault;
   fsData.MinDate := fsData.Date - 10;
end;

end.
