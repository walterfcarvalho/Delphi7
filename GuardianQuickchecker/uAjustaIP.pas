unit uAjustaIP;   // Æ

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, winSock, f, IniFiles, adLabelComboBox, clipbrd, shellapi,
  TFlatSpeedButtonUnit, ExtCtrls, IdBaseComponent, IdComponent, IdRawBase,
  IdRawClient, IdIcmpClient, AppEvnts, DBCtrls, fDBCtrls, adLabelEdit,
  Buttons, fCtrls, IdTCPConnection, IdTCPClient, IdTelnet, CoolTrayIcon,
  Menus, ComCtrls, IdIntercept, IdLogBase, IdLogFile;

type
  TfmAjustaIP = class(TForm)
    Timer1: TTimer;
    ApplicationEvents1: TApplicationEvents;
    fsBitBtn1: TfsBitBtn;
    CoolTrayIcon1: TCoolTrayIcon;
    PopupMenu1: TPopupMenu;
    Restaurar1: TMenuItem;
    Sair1: TMenuItem;
    lbServer: TLabel;
    lbPorta: TLabel;
    Timer2: TTimer;
    sb: TStatusBar;
    Memo1: TMemo;
    procedure executaScript(comandos:TstringList);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure addLinhas(str:String);
    procedure acaoDeFalha();
    procedure Sair1Click(Sender: TObject);
    procedure Restaurar1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    function lerParamSL(valor:String):String;
    function getTamLog():String;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAjustaIP: TfmAjustaIP;
  TIME:INTEGER;
  H:TStringlist;
  tamLog:String;
implementation

uses msg, Math;

{$R *.dfm}

function TfmAjustaIP.lerParamSL(valor: String): String;
var
   aux:String;
begin
   aux := H.Values[valor];
   result := aux;
end;


procedure TfmAjustaIP.addLinhas(str:String);
begin
   sb.Panels[0].Text:= str;
end;

function ExecAndWait(const FileName, Params: string;  const WindowState: Word): boolean;
var
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  CmdLine: string;
begin
  { Coloca o nome do arquivo entre aspas. Isto é necessário devido aos espaços contidos em nomes longos }
  CmdLine := '"' + Filename + '"' + Params;
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  with SUInfo do begin
  cb := SizeOf(SUInfo);
  dwFlags := STARTF_USESHOWWINDOW;
  wShowWindow := WindowState;
  end;
  Result := CreateProcess(nil, PChar(CmdLine), nil, nil, false,
  CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
  PChar(ExtractFilePath(Filename)), SUInfo, ProcInfo);
  { Aguarda até ser finalizado }
  if Result then begin
  WaitForSingleObject(ProcInfo.hProcess, INFINITE);
  { Libera os Handles }
  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
  end;
end;

procedure TfmAjustaIP.executaScript(comandos:TstringList);
var
  WindowState: Word;
  bat : string;
  i:integer;
  arq:TStringList;
begin
   screen.Cursor := crHourGlass;

   f.gravaLog('executaScript()');
   f.gravaLog(comandos);

// encapsular o comando em um arquivo.bat
   arq := TStringlist.Create();

   for i:= 0 to comandos.Count -1 do
      arq.Add(comandos[i]);


   if ( lerParamSL('showScript') = '1') then
   begin
      WindowState := sw_normal;
      arq.Add('Pause');
   end
   else
      WindowState := sw_hide;

   bat := f.getDirExe()+'execAndWait.bat';

   arq.SaveToFile(bat);
   arq.Free();

   if f.getIdxParam('-t') <= 0 then
      ExecAndWait(bat, '', WindowState);

   sleep(2000);
   screen.Cursor := crDefault;
end;

procedure TfmAjustaIP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   deleteFile(f.getDirExe()+'execAndWait.bat');
end;

procedure TfmAjustaIP.FormCreate(Sender: TObject);
var
  janela:String;
begin
   f.limparLog();

   H := f.getParamsArIni(f.getDirExe() + getNomeDoExecutavel() + '.ini');
   f.gravaLog(H);

  fmAjustaIP.lbServer.caption := lerParamSL( 'ipSrvQuickChecker');
  fmAjustaIP.lbPorta.caption := lerParamSL('porta');

   if f.getIdxParam('-t') <=0 then
   begin
      timer1.Interval := strToInt(lerParamSL('intervaloConsulta')+ '000');
      timer1.Enabled := true;

      TIME := Timer1.Interval;
      timer2.Enabled := true;
   end;
   CoolTrayIcon1.IconVisible := true;

   fmAjustaIP.Top := screen.Height - (fmAjustaIP.Height + 30);
   fmAjustaIP.Left := screen.Width - (fmAjustaIP.Width + 30);
/////////////
end;

procedure TfmAjustaIP.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
   f.gravaLog(e.MethodName(sender));
   f.gravaLog(e.Message);
end;

procedure TfmAjustaIP.acaoDeFalha;
var
   cmd: String;
   i:integer;
   comandos:TSTringlist;
begin
   memo1.Lines.Add(DateTimeToStr(now));

   Timer1.Enabled := false;
   f.gravaLog('             ');
   f.gravaLog('Tentando restaurar....');
   f.gravaLog('------------------------------------------');

   comandos := TStringlist.Create();
   for i:=1 to 10 do
   begin
      cmd := lerParamSL('acao'+intToStr(i));
      if (Length(cmd) > 5) then
      begin
         comandos.Clear();
         comandos.Add(cmd);
         executaScript(comandos);
      end;
   end;
   comandos.Free();
   Timer1.Enabled := true;
end;

procedure TfmAjustaIP.Sair1Click(Sender: TObject);
begin
   application.Terminate();
end;

procedure TfmAjustaIP.Restaurar1Click(Sender: TObject);
begin
   Application.Restore();
   Application.BringToFront();
end;

procedure TfmAjustaIP.Timer1Timer(Sender: TObject);
begin
   fsBitBtn1Click(nil);
end;

procedure TfmAjustaIP.Timer2Timer(Sender: TObject);
var
   val:integer;
begin
   TIME := (TIME - 1000);

   val := TIME div 1000;

   sb.Panels[1].Text := intToStr(val);

   if TIME <= 0 then
      TIME := Timer1.Interval;
end;

procedure TfmAjustaIP.fsBitBtn1Click(Sender: TObject);
var
   slCmd:TStringlist;
   tamAtual, strStatus:String;
begin
   f.gravaLog('Teste feito em-> ' + dateTimeToStr(now));

   tamAtual := getTamLog();

   if (tamLog = tamAtual) and (tamLog <> '') then
   begin
      acaoDeFalha();

      tamLog :=  tamAtual;
   end
   else
   begin
      tamLog :=  tamAtual;
   end;
end;

function TfmAjustaIP.getTamLog(): String;
var
   i:integer;
   dirQw, tam, aux:String;
   cmd:TStringList;
   arqLog:String;
begin
   dirQw := lerParamSL('dirQw');
   arqlog :=  f.getDirLogs()+ '\LogQuickWay.txt';

   cmd := Tstringlist.Create();
   cmd.add('dir "' + dirQw +   '*.log" /-c >'+ arqLog);
   cmd.SaveToFile(  f.getDirLogs() + 'comando.bat');

   f.execAndWait(f.getDirLogs() + 'comando.bat', '', sw_hide);
   cmd.Clear();

   cmd.LoadFromFile(arqLog);

   tam :=  trim(copy(cmd[cmd.count-2], 29, 15));

   cmd.Free();

   deleteFile( f.getDirLogs() + 'comando.bat');

   result := tam;
end;

end.
