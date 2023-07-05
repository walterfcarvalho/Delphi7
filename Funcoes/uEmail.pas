unit uEmail;

interface
  uses dialogs, forms, Classes, SysUtils, IdBaseComponent, IdComponent, messages,ADODB,
  IdTCPConnection, IdTCPClient, IdMessageClient, IdSMTP,
  IdMessage, IdIOHandler, IdIOHandlerSocket, IdSSLOpenSSL, uHash;

  function enviarEmail(dadosConexao:THash; para, assunto, anexo:String; corpoMsg:Tstringlist; titulo:String):boolean;
  function  getMailDestino():String;
  function isEmailValido(email:String):boolean;

implementation
uses uMain, uDestinoEmail, funcoes, {uCF,} uDm, uEnviaEmail, uLj, msg;

function enviarEmail(dadosConexao:THash;  para, assunto, anexo:String; corpoMsg:Tstringlist; titulo:String):boolean;
begin
   funcoes.gravaLog('uEmail.enviarEmail()');

   Application.CreateForm(TfmEnviaEmail, fmEnviaEmail);
   fmEnviaEmail.Show;
   result := fmEnviaEmail.enviarEmailGmail (dadosConexao, 'uo', para, assunto, anexo, corpoMsg, titulo, '' );
   fmEnviaEmail.Close();
   fmEnviaEmail := nil;
end;

function  getMailDestino():String;
var
   str:String;
begin
   application.CreateForm(TfmDestEmail, fmDestEmail);

   uLj.getListaLojas(fmDestEmail.cbLoja, false, false, '', '' );

   fmDestEmail.cbLoja.ItemIndex := 0;
   fmDestEmail.ShowModal;

   if fmDestEmail.ModalResult  <> 0 then
   begin
      str := fmDestEmail.edMailDest.Text;
      if str = '' then str := '0';
      if pos('@',str) = 0 then
         str := dm.openSQL('Select email from zcf_tbuo (NOLOCK) where is_uo= ' + str , 'email');
      result := str;
   end
   else
      msg.msgWarning('Cancelado pelo usuário');
end;

function isEmailValido(email:String):boolean;
var
  aux:String;
  res:boolean;
begin
   res := true;
   if (funcoes.RemAcentos(email) <> email)then
   begin
      msg.msgErro(dm.getMsg('mail.caracteres') );
      res := false;
   end;

   if (pos('@', email) < 1) and (pos('.', email) < 3) then
   begin
      msg.msgErro( dm.getMsg('mail.formato'));
      res := false;
   end;
   result := res;
end;





end.
