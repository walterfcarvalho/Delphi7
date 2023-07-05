unit uMsgMemoInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfmMsgMemoInput = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMsgMemoInput: TfmMsgMemoInput;

implementation

uses f;

{$R *.dfm}

procedure TfmMsgMemoInput.FormActivate(Sender: TObject);
begin
//	f.rParReg('', )
end;

end.
