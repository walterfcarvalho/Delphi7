unit ufmTelnet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, OleCtrls, ShockwaveFlashObjects_TLB, StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdTelnet;

type
  TfmTelnet = class(TForm)
    flash: TShockwaveFlash;
    telnet: TIdTelnet;
    lbMsg: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure telnetDataAvailable(Sender: TIdTelnet; const Buffer: String);

    function chamaExecutarTelnet(uo, comando:String):boolean;

  private
    function executeTelnetCmd(uo, comando: String): boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTelnet: TfmTelnet;

implementation

{$R *.dfm}

uses funcoes, uMain, uDm;

procedure TfmTelnet.FormCreate(Sender: TObject);
var
   resource: TResourceStream;
begin
   if (FileExists(funcoes.TempDir()+'ani.swf' ) = false) then
   begin
      resource := TResourceStream.Create( Hinstance, 'sample_bmp', 'FLASH');
      resource.SaveToFile(funcoes.TempDir()+'ani.swf');
      resource.Free();
  end;
      flash.Movie :=  funcoes.TempDir()+'ani.swf' ;
      flash.BGColor := 'C0B0AC';
      flash.Rewind;
end;


procedure TfmTelnet.telnetDataAvailable(Sender: TIdTelnet;
  const Buffer: String);
begin
   FUNCOES.gravaLog(Buffer);
   RESP_TELNET := RESP_TELNET + Buffer;
end;

function TfmTelnet.executeTelnetCmd(uo, comando:String):boolean;
var
   CR_PONTO_LF :String;
   tn:TidTelnet;
begin

   funcoes.gravaLog('executeTelnetCmd()' + comando);

    screen.Cursor := crHourglass;
    RESP_TELNET := '';
    CR_PONTO_LF := char(13)+ char(10)+'.'+ char(13)+char(10);
    try
       CR_PONTO_LF := char(13)+ char(10)+'.'+ char(13)+char(10);
       tn := TIdTelnet.Create(nil);
//       tn.OnDataAvailable :=  tnDataAvailable();
       tn.Host := dm.GetParamBD('ServerNFE.ip', uo );
       tn.Port := 3436;
       lbMsg.Caption := 'Conectando ao servidor ACBR...';
       tn.Connect(1000);
       sleep(1000);
       lbMsg.Caption := 'Comando ACBR: '+ comando;
       tn.write( comando + CR_PONTO_LF);
       lbMsg.Caption  := 'Solicitando ação...';
       sleep(2000);
       lbMsg.Caption := 'Fechando conexão...';
       tn.write('bye' + CR_PONTO_LF );
       sleep(4000);

       gravaLog('Respostas do servidor:' + RESP_TELNET);
       fmMain.msgStatus('');
       result := (pos('ERRO: ', RESP_TELNET) = 0)
     except
     begin
        screen.Cursor := crDefault;
        gravaLog('');
        result :=false;
     end;
    end;
end;



function TfmTelnet.chamaExecutarTelnet(uo, comando:String):boolean;
var
   res:boolean;
begin
   try
      executeTelnetCmd(uo, comando);
      res := true;
   except
      on e:exception do
         funcoes.gravaLog('Erro ao processar o comando telnet..'+ e.Message);
   end;

end;

end.
