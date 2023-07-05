unit uFtp;


interface
  uses Forms, idFTP, IdComponent;

  function conectarFTP(server:String):boolean;
  function existeArqXML(is_nota:String):String;
  function getFile(server, remoteFile: String): boolean;
  function getStrBuscaXML(uo, sr_docf, nr_docf:String):String;
  function isArquivoExiste(server, remoteFile:String):String;
  function putFile(servidor, dirRemoto, arqLocal:String):boolean;

  procedure ftpStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);


implementation

uses uFmFtp, DB, cf, classes, uMain, f, SysUtils, uDm, uFiscal, msg, uAcbr;

function getStrBuscaXML(uo, sr_docf, nr_docf:String):String;
begin
   result:=
      dm.getParamBD('ServerNFE.dirLogs', uo ) +
      '*'+
      f.preencheCampo(03, '0', 'E', trim(sr_docf) ) +
      f.preencheCampo(09, '0', 'E', trim(nr_docf) ) +
      '*' ;
end;


function isArquivoExiste(server, remoteFile:String):String;
begin
   conectarFTP(server);
   result := fmFTp.isArquivoExiste(remoteFile);
   fmFTP.disconnect();
end;

procedure criaFormFtp();
begin
    Application.CreateForm(TfmFTP, fmFTP);
    fmFtp.Show();
end;

function conectarFTP(server:String):boolean;
begin
   result := true;
   try
      criaFormFTP();
      fmFtp.connect(server);
      result := true;
    except
       on e:Exception do
       begin
          msg.showAndWriteErr(dm.getCMD1('msg', 'ftp.err', e.Message));
          result := false;
       end;
    end;
end;

procedure ftpStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
begin
   f.gravaLog('resposta FTP'+ AStatusText);
   f.gravaLinhaEmUmArquivo('c:\respostaFTP.txt', AStatusText);
end;

function existeArqXML(is_nota:String):String;
var
  arq, aux:String;
  ds:TdataSet;
begin
   ds:= uFiscal.getDadosNota(is_nota, '', '', '');

   arq :=  uFtp.getStrBuscaXML( ds.fieldByName('is_estoque').AsString, ds.fieldByName('serie').AsString, ds.fieldByName('num').AsString);


   aux := isArquivoExiste( uAcbr.getIPServer(ds.fieldByName('is_estoque').AsString) , arq);
   aux := ExtractFileName(aux);
   aux := f.sohNumerosPositivos(aux);

   ds.free();
   f.gravaLog('resultado:' +   aux);
   result := aux;
end;

function putFile(servidor, dirRemoto, arqLocal:String):boolean;
begin
   conectarFTP(servidor);
   result := fmFTP.putFile(servidor, arqLocal, dirRemoto);
   fmFTP.Close();
end;


function getFile(server, remoteFile: String): boolean;
begin
	f.gravaLog('uFTp.getFile() server:'+ server + ' RemoteFile:' + remoteFile);
   conectarFTP(server);
   result := fmFTp.getFile(remoteFile);
   fmFTP.disconnect();
end;


end.
