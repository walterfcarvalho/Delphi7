unit ufmTelnet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, OleCtrls, StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdTelnet;

type
  TfmTelnet = class(TForm)
    Memo: TMemo;
    tn: TIdTelnet;

    procedure FormCreate(Sender: TObject);
    procedure tnDataAvailable(Sender: TIdTelnet; const Buffer: String);

//    function chamaExecutarTelnet(uo, comando:String):boolean;
    procedure MemoChange(Sender: TObject);

    function execCmd(uo, comando:String):boolean;

    function geraArqPDF(uo, comando:String):String;


  private
    function executeTelnetCmd(uo, comando: String): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTelnet: TfmTelnet;
implementation

{$R *.dfm}

uses f, uMain, uDm;

procedure TfmTelnet.FormCreate(Sender: TObject);
begin
  fmTelnet.Left := Application.MainForm.Left + 30;
  fmTelnet.Width := application.MainForm.Width -60;
end;

procedure TfmTelnet.tnDataAvailable(Sender: TIdTelnet; const Buffer: String);
begin
   f.gravaLog('Retorno do ACBR:' + Buffer);
end;

{
function TfmTelnet.executeTelnetCmd(uo, comando:String):boolean;
var
   CR_PONTO_LF :String;
//   tn:TidTelnet;
begin

   f.gravaLog('executeTelnetCmd()' + comando);

    screen.Cursor := crHourglass;
    RESP_TELNET := '';
    CR_PONTO_LF := char(13)+ char(10)+'.'+ char(13)+char(10);
    try
       CR_PONTO_LF := char(13)+ char(10)+'.'+ char(13)+char(10);

       tn.Host := dm.GetParamBD('ServerNFE.ip', uo );
       tn.Port := 3436;

       memo.Lines.Add('Conectando ao servidor ACBR...');
       tn.Connect(3000);

       memo.Lines.Add('Comando ACBR: '+ comando);
       tn.write( comando + CR_PONTO_LF);

       edit1.Text := tn.ReadLn();

       memo.Lines.Add('Solicitando ação...');

       memo.Lines.Add('Fechando conexão...');
       tn.write('bye' + CR_PONTO_LF );
       fmTelnet.Refresh();

       f.gravaLog('Respostas do servidor:' + RESP_TELNET);
       screen.Cursor := crDefault;



//       tn.Disconnect();

       Result := (pos('ERRO:', RESP_TELNET) = 0);
     except
     begin
        screen.Cursor := crDefault;
        gravaLog('');
        result := False;
     end;
    end;
end;
}

function TfmTelnet.executeTelnetCmd(uo, comando:String):String;
var
   CR_PONTO_LF :String;
   retorno:String;
begin
   screen.Cursor := crHourglass;

   f.gravaLog('executeTelnetCmd()' + comando);

   CR_PONTO_LF := char(13)+ char(10)+'.'+ char(13)+char(10);
   try
      tn.Host := dm.GetParamBD('ServerNFE.ip', uo );
      tn.Port := 3436;

      memo.Lines.Add('Conectando ao servidor ACBR...');
      tn.Connect(3000);


      memo.Lines.Add('Solicitando ação...');
      memo.Lines.Add('Comando ACBR: '+ comando);
      tn.write(comando + CR_PONTO_LF);

      retorno:= tn.ReadLn();

      memo.Lines.Add('Fechando conexão...');
      tn.write('bye' + CR_PONTO_LF );
      fmTelnet.Refresh();

      Result :=  retorno;
      screen.Cursor := crDefault;

   except
      begin
         gravaLog('');
         result := 'ERRO:';
      end;
   end;
   screen.Cursor := crDefault;
end;


function TfmTelnet.execCmd(uo, comando:String):boolean;
var
   retorno:String;
begin
   fmTelnet.Refresh();
   retorno := executeTelnetCmd(uo, comando);
   result := (pos('ERRO:', retorno) = 0);
end;

function TfmTelnet.geraArqPDF(uo, comando:String):String;
var
   p,a, retorno:String;
begin
   fmTelnet.Refresh();
   retorno := executeTelnetCmd(uo, comando);
   a := ExtractFileName(retorno);
   result := a;
end;

procedure TfmTelnet.MemoChange(Sender: TObject);
begin
   self.Refresh();
   sleep(300);
end;

end.
