unit unMsgTela2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls;

type
  TfmMsgTela2 = class(TForm)
    btCancel: TfsBitBtn;
    btOk: TfsBitBtn;
    lbMsg: TLabel;
    lbMsg2: TLabel;
    lbSim: TLabel;
    lbNao: TLabel;
    procedure preparaParaExibir(msg:String;  showBtOk, showBtCancel:boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMsgTela2: TfmMsgTela2;

implementation

{$R *.dfm}

procedure TfmMsgTela2.preparaParaExibir(msg: String; showBtOk, showBtCancel:boolean);
begin
   with self do
   begin
      Top := Application.MainForm.Top + 10;
      Left := Application.MainForm.Left;
      Width := Application.MainForm.Width - 30;
      Position := poMainFormCenter;
      BorderStyle := bsDialog;
      Caption := Application.Name;
      lbMsg.caption := copy(msg, 01, 300);
   end;

   btOk.Visible := showBtOk;
   lbSim.Visible := showBtOk;

   btCancel.Visible := showBtCancel;
   lbNao.Visible := showBtCancel;


   if (showBtCancel = false) then
      btOk.Left := btCancel.Left;
end;

procedure TfmMsgTela2.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = VK_ESCAPE) then
     ModalResult := mrCancel;

   if (key = VK_RETURN) then
     ModalResult := mrOk;
end;

end.
