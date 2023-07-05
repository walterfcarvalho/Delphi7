unit fmMsg;

interface

uses
  Windows, f, msg, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, jpeg, Buttons, fCtrls;

type
  TForm1 = class(TForm)
    Timer: TTimer;
    Panel1: TPanel;
    imgQuestion: TImage;
    imgWarning: TImage;
    imgError: TImage;
    fsBitBtn1: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure montaMsg(Tipo:String; TimeOut:integer);
    procedure mostraIcon(tipo:String);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
procedure TForm1.mostraIcon(tipo: String);
begin
   if( tipo = 'question') then
   begin
   	imgQuestion.Visible := true;
      imgQuestion.Top := 15;
      imgQuestion.Top := 25;
   end
   if( tipo = 'warning') then
	begin
   	imgError.Visible := true;
      imgError.Top := 15;
      imgError.Top := 25;
   end
   else
	begin
   	imgWarning.Visible := true;
      imgWarning.Top := 15;
      imgWarning.Top := 25;
   end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
	self.Icon := application.Icon;
end;

procedure TForm1.montaMsg(tipo: String; timeOut: integer);
begin
   Timer.Enabled := (TimeOut > 0);
   Timer.Interval := TimeOut;

	mostraIcon(tipo);



end;

end.
