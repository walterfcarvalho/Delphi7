unit ufmAutorizacaoPonto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ufmAutorizacao, StdCtrls, Buttons, fCtrls, adLabelEdit,
  adLabelComboBox;

type
  TfmAutorizacaoPonto = class(TfmAutorizacao)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAutorizacaoPonto: TfmAutorizacaoPonto;

implementation

{$R *.dfm}

procedure TfmAutorizacaoPonto.FormCreate(Sender: TObject);
begin
  inherited;

  with  cbJust do
  begin
     Visible := true;
     Left := cbUser.Left;
     top := edSenha.Top;
  end;

  with  edSenha do
  begin
     top := cbJust.Top + 40;
  end;


  btOk.Top := edSenha.top + 35;
  btCancel.Top := edSenha.Top + 35;

  fmAutorizacaoPonto.ClientHeight := fmAutorizacaoPonto.ClientHeight + 10;
end;

end.
