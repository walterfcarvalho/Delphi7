unit uInput2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unMsgTela2, StdCtrls, adLabelEdit, Buttons, fCtrls;

type
  TfmInput2 = class(TfmMsgTela2)

    edInput: TadLabelEdit;

    procedure ajustaCampos(msg, vlDefault:String; showBtOk, showBtCancel:boolean);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmInput2: TfmInput2;

implementation

{$R *.dfm}

procedure TfmInput2.ajustaCampos(msg, vlDefault:String; showBtOk, showBtCancel:boolean);
begin
   preparaParaExibir(msg, showBtOk, showBtCancel);
   lbMsg.Visible := false;
   lbMsg2.Visible := false;

   with edInput do
   begin
     Text := vlDefault;
     LabelDefs.Caption := msg;
     Left := 10;
     Width := fmInput2.Width - 20;
   end;
end;

procedure TfmInput2.FormActivate(Sender: TObject);
begin
   inherited;
   edInput.SetFocus();
end;

procedure TfmInput2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   inherited;
end;

end.
