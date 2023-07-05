unit uListaJust;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, adLabelComboBox, adLabelEdit;

type
  TfmListaJust = class(TForm)
    cbJust: TadLabelComboBox;
    btOk: TfsBitBtn;
    btCancel: TfsBitBtn;
    edObs: TadLabelEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmListaJust: TfmListaJust;

implementation

uses uUtil;

{$R *.dfm}

procedure TfmListaJust.FormCreate(Sender: TObject);
begin
   cbJust.Items := uUtil.getJustificativas();
   cbJust.ItemIndex := 0;
end;

end.
