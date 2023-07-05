unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, winSock, funcoes, IniFiles, adLabelComboBox, clipbrd;

type
  TForm1 = class(TForm)
    lb: TListBox;
    cbPerfil: TadLabelComboBox;

    procedure Button1Click(Sender: TObject);
    procedure addLinhas(str:String);
    procedure listaDadosDoComputador();
    procedure carregaOpcoesIp();
    procedure addIPAlista(tipo, descricao, ip, mascara, gateway:String);
    procedure FormActivate(Sender: TObject);
    procedure cbPerfilClick(Sender: TObject);
    procedure mudarIpDaMaquina(perfil:integer);
    procedure aguardaMudancaNoIp();


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.aguardaMudancaNoIp;
var
   i:integer;
begin
   screen.Cursor := crHourGlass;
   for i:= 20 downTo 0 do
   begin
      lb.Items.clear();
      addLinhas('Mudando o ip, aguarde... ' +  intToStr(i));
      lb.Refresh();
      sleep(1000);
   end;
   screen.Cursor := crDefault;
end;


function execAndWait(const FileName:String): boolean;
var
  WindowState: Word;
  Params: string;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: string;
  arq:TstringList;
  comando:String;
begin
   WindowState := SW_hide;
   Params := '';

   screen.Cursor := crHourGlass;

// encapsular o comando em um arquivo.bat
   comando := FileName;
   arq := TStringlist.Create();
   arq.Add(comando);
   funcoes.gravaLog(comando);
   comando :=  funcoes.getDirExe()+'execAndWait.bat' ;
   arq.SaveToFile(comando);
   arq.Free();

  { Coloca o nome do arquivo entre aspas. Isto é necessário devido aos espaços contidos em nomes longos }
  CmdLine := '"' + comando + '"' + Params;
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do
  begin
     cb := SizeOf(SUInfo);
     dwFlags := STARTF_USESHOWWINDOW;
     wShowWindow := WindowState;
  end;
  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, false, CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,  PChar(ExtractFilePath(comando)), SUInfo, ProcInfo);
  { Aguarda até ser finalizado }
  if Result then
  begin
     WaitForSingleObject(ProcInfo.hProcess, INFINITE);
     { Libera os Handles }
     CloseHandle(ProcInfo.hProcess);
     CloseHandle(ProcInfo.hThread);
  end;
  sleep(300);
  screen.Cursor := crDefault;
end;

procedure TForm1.addLinhas(str:String);
begin
   lb.Items.Add(str);
end;


function GetIP:string;
//--> Declare a Winsock na clausula uses da unit
var
   WSAData: TWSAData;
   HostEnt: PHostEnt;
   Name:string;
begin
   WSAStartup(2, WSAData);
   SetLength(Name, 255);
   winsock.Gethostname(PChar(Name), 255);
   SetLength(Name, StrLen(PChar(Name)));
   HostEnt := gethostbyname(PChar(Name));

   with HostEnt^ do
      Result := Format('%d.%d.%d.%d',[Byte(h_addr^[0]), Byte(h_addr^[1]), Byte(h_addr^[2]),Byte(h_addr^[3])]);

   WSACleanup;
end;


procedure TForm1.addIPAlista(tipo, descricao, ip, mascara, gateway: String);
var
   cmd:String;
begin
   if (tipo = 'DHCP') then
      cmd :=    Descricao + ' - ' + tipo + ' ip automático'
   else
      cmd := Descricao + ' - ' +  tipo + ' IP: '+ip+' '+ ' Mask: ' + mascara +' '+ ' Gw: ' + gateway;
   cbPerfil.Items.Add(cmd);
end;


procedure TForm1.carregaOpcoesIp;
begin
   cbPerfil.Items.Clear();
   addIPAlista
   (
      funcoes.getParamIni('IP1', 'Tipo'),
      funcoes.getParamIni('IP1', 'Descricao'),
      funcoes.getParamIni('IP1', 'ip'),
      funcoes.getParamIni('IP1', 'mascara'),
      funcoes.getParamIni('IP1', 'gateway')
   );

   addIPAlista
   (
      funcoes.getParamIni('IP2', 'Tipo'),
      funcoes.getParamIni('IP2', 'Descricao'),
      funcoes.getParamIni('IP2', 'ip'),
      funcoes.getParamIni('IP2', 'mascara'),
      funcoes.getParamIni('IP2', 'gateway'),
   );
   cbPerfil.ItemIndex := -1;
end;

procedure TForm1.listaDadosDoComputador;
begin
   screen.Cursor := crHourGlass;
   lb.Items.clear();
   addLinhas('Obtendo informações do computador...');
   lb.Refresh();
   sleep(500);
   addLinhas('O nome dessa estação é: '+ funcoes.getNomeDoMicro());
   addLinhas('IP: '+  GetIP   );
   screen.Cursor := crDefault;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   listaDadosDoComputador();
   carregaOpcoesIp();
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
   sleep(500);
   listaDadosDoComputador();
   carregaOpcoesIp();
end;

procedure TForm1.mudarIpDaMaquina(perfil:integer);
var
  cmd, secao:String;
begin
   secao := 'IP'+ intToStr(perfil);

// cria o comando para alterar o endereco ip
   cmd := 'netsh interface ip set address "'+ funcoes.getParamIni('conexao', 'nome') +'" ';
   if (funcoes.getParamIni(secao, 'Tipo') = 'DHCP') then
   begin
      cmd := cmd + 'DHCP'
   end
   else
   begin
      cmd := cmd +
      funcoes.getParamIni(secao, 'Tipo') + ' ' +
      funcoes.getParamIni(secao, 'ip') + ' ' +
      funcoes.getParamIni(secao, 'mascara') + ' ' +
      funcoes.getParamIni(secao, 'gateway') + ' 1';
   end;
   clipboard.AsText := cmd;
   execAndWait(cmd);

// cria o comando para alterar Servidor DHCP
   cmd := 'netsh interface ip set dns "'+ funcoes.getParamIni('conexao', 'nome') +'" ';
   if (funcoes.getParamIni(secao, 'Tipo') = 'DHCP') then
   begin
      cmd := cmd + 'DHCP'
   end
   else
   begin
      cmd := cmd + 'STATIC ' +
      funcoes.getParamIni(secao, 'DNS')
   end;
   execAndWait(cmd);

// mostrar na tela a configuracao do ip
   aguardaMudancaNoIp();
   FormActivate(nil);
end;

procedure TForm1.cbPerfilClick(Sender: TObject);
var
    msg:String;
    perfil:String;
begin
   perfil := 'IP' + IntToStr( cbPerfil.ItemIndex +1);
   msg := 'Deseja mudar o IP para: ' + funcoes.getParamIni(perfil, 'Descricao') + ' ?';

   if( funcoes.msgTela(msg, MB_ICONQUESTION + MB_YESNO) = mrYes) then
   begin
      mudarIpDaMaquina(cbPerfil.ItemIndex +1)
   end
   else
      FormActivate(nil);

end;


end.
