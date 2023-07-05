unit uAutorizacao;

interface

uses Db, classes, controls, forms, f, ufmAutorizacao, adLabelComboBox, sysUtils, uUsuarios;

function getUserAutorizador(lstUsuarios:TStringlist):String;
function encriptSenha(senha: String): String;
function getSenha(cbUser:TadLabelComboBox):String;
function isSenhaValida(senhaDig, senha:String):boolean;

implementation

uses StdCtrls;

//function getUserAutorizador(dsUsuarios:TdataSet):String;
function getUserAutorizador(lstUsuarios:TStringlist):String;
begin
   application.CreateForm(TfmAutorizacao, fmAutorizacao);
   fmAutorizacao.cbUser.Items := lstUsuarios;
   fmAutorizacao.cbUser.Sorted := true;

   fmAutorizacao.ShowModal;

   if (fmAutorizacao.ModalResult = mrOk) then
   begin
      result := uUsuarios.getCodUsuario(fmAutorizacao.cbUser)
   end
   else
      result := '';

   f.gravaLog('getUserAutorizador():<'+ Result+'>');

   fmAutorizacao := nil;
end;

function encriptSenha(senha: String): String;
var
 pT, wStr    : String;
 wReturn : String;
 wLB : Integer;
 wS  : Integer;
 wB  : Integer;
 i   : Integer;
begin
  // Retornará o pTexto Encrypt ou decrypt
  // ptexto - String a ser (E)criptografada ou (D)descriptografada
  // pT     - Letra (E ou D) que identifica a função a ser usada em pTexto.
  pT      := 'E';
  wStr    := '0A1b2C3d4E5f6G7h8I9j10L11m12N13o14P15q16R17s18T19u20V21x22Z23';
  wLB     := Length(wStr);
  wReturn := '';
  wS      := 0;
  wB      := 0;

  For i := 1 To Length(senha)do
  begin
    wB := wB Mod wLB + 1;
    wS := wS + Ord(wStr[wB]);
    If pT = 'E' Then
      wReturn := wReturn + Chr(Ord((senha[i])) + (ord(wStr[wB]) + wS) Mod 128)
    Else If pT = 'D' Then
      wReturn := wReturn + Chr(Ord((senha[i])) - (ord(wStr[wB]) + wS) Mod 128);
   result := wReturn;
  end;
end;

function getSenha(cbUser:TadLabelComboBox):String;
begin
   result := trim(copy(cbUser.Items[cbUser.itemIndex], 90, 50));
   f.gravaLog(result);
end;

function isSenhaValida(senhaDig, senha:String):boolean;
begin
    f.gravaLog('senhaDig: ' + encriptSenha(senhaDig) + '  senha: '+senha);

    result := (encriptSenha(senhaDig) = senha);
end;

end.

