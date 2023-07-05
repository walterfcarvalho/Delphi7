unit uFmFtp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdFTP, StdCtrls;


type
  TfmFTP = class(TForm)
    Memo1: TMemo;
    ftp: TIdFTP;


    function isArquivoExiste(arquivo:String):String;
    function putFile(servidor, arqLocal, dirRemoto: String):boolean;
    function getFile(remoteFile:String):boolean;

    procedure connect(servidor:String);
    procedure disconnect();
    procedure formClose(Sender: TObject; var Action: TCloseAction);
    procedure ftpStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
    procedure ftpConnected(Sender: TObject);
    procedure ftpDisconnected(Sender: TObject);
    procedure processaErro(mensagem:String);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmFTP: TfmFTP;

implementation

uses f, msg, uDm;

{$R *.dfm}

{ TForm1 }

procedure TfmFTP.processaErro(mensagem:String);
begin
   memo1.Lines.add(mensagem);
   ftp.Disconnect();

   memo1.Lines.add('Erro: ' + mensagem);
   sleep(2000);
end;


procedure TfmFTP.connect(servidor: String);
begin
  try
   with ftp do
   begin
      Port := 21;
      Host := servidor;
      Connect(true, 3000);
      ChangeDir('');
   end;
  except
     on e:exception do
        processaErro(e.Message);
  end;
end;

procedure TfmFTP.disconnect;
begin
   ftp.Disconnect();
   ftp.Destroy();
   fmFTP.Close();
end;

function TfmFTP.getFile(remoteFile: String): boolean;
var
   fileName:String;
begin
   try
      fileName:= Sysutils.ExtractFileName(remoteFile);
      Memo1.lines.add('arqRemoto:' + remoteFile);
      Memo1.lines.add('arqLocal: ' + f.getDirLogs() + fileName );

      ftp.Get(remoteFile, (f.getDirLogs() + fileName), true, false);
      result := true;
   except
      on e:Exception do
      begin
          processaErro(e.Message);
          result := false;
      end;
   end;
end;

function TfmFTP.putFile(servidor, arqLocal, dirRemoto:String):boolean;
var
   stream : TStream;
begin
    f.gravaLog('TfmFTP.Putfile: ' + servidor + ' arqLocal: ' + arqLocal + ' dirRemoto: '+ dirRemoto );
    try
       stream := TFileStream.Create(arqLocal, fmOpenRead);
       ftp.ChangeDir(dirRemoto);
       ftp.Put( stream, SysUtils.ExtractFileName(arqLocal));
       stream.Free();
       result := true;
    except
       on e:exception do
       begin
          processaErro(e.Message);
          result := false;
       end;
    end;
end;

procedure TfmFTP.ftpStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
begin
   f.gravaLog('Ftp: ' + AStatusText);
   memo1.Lines.add('Ftp: ' + AStatusText);
   sleep(300);
end;

procedure TfmFTP.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := cafree;
   fmFtp := nil;
end;

function TfmFTP.isArquivoExiste(arquivo:String):String;
var
   saida:TStrings;
   arq:String;
begin
   try
      arq := '';
      saida:= TStringList.create();

      memo1.Lines.add('Arq buscado: '+ arquivo);

      f.gravaLog('Arq buscado: '+ arquivo);      

      ftp.List(saida, arquivo, false);

//      saida.SaveToFile('c:\saida.txt');

      f.gravaLog('arquivos encontrados: ' + intToStr(saida.count)  );

      if (saida.Count > 0) then
      begin
        if (saida[0] <> '') then
            arq := saida[0];
      end;
        saida.Free();

   except
      on e:exception do
      begin
         processaErro(e.Message);
         arq := '';
      end;
   end;
   f.gravaLog('uFtp.isArquivoExiste()' + arquivo + ' Result:' + arq);
   result := arq;
end;


procedure TfmFTP.ftpConnected(Sender: TObject);
begin
  f.gravaLog('Ftp conectado:' + ftp.Host);
end;

procedure TfmFTP.ftpDisconnected(Sender: TObject);
begin
  f.gravaLog('Ftp desconectado:' + ftp.Host);
end;

end.
