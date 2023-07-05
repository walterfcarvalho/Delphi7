unit verificaSenhas;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,funcoes, adLabelEdit, adLabelComboBox,
  DB, ADODB, TFlatButtonUnit, ConsultaSenha ;


function telaAutorizacao(grupos,usuarios,MSG:String):Boolean;
function TelaAutorizacao2(grupos, cd_usu:string):String;
function telaAutPonto(lstJustificativas, lstUsers:TStrings ):string;
function loginWell(lojas: TStringList; var user:String; Conexao:TAdoConnection):String;
function FEncryptDecrypt(senha : String; pT : String) : String;
function telaAutorizacaoSimples(senha,msg:String):String;

implementation

function TelaAutorizacao(grupos,usuarios,MSG:String):Boolean;
begin
   application.CreateForm(TFmSenha,FmSEnha);
   FmSenha.cbUsuarios.Items :=
   FmSenha.ShowModal;

   if FmSEnha.ModalResult = MrOk then
      Result := True
   else
      Result := false;
end;


function loginWell(lojas: TStringList; var user:String; Conexao:TAdoConnection):String;
begin
   application.CreateForm(TFmSenha,FmSEnha);

   fmSenha.cbLoja.items := lojas;
   fmSenha.Conexao.ConnectionString := funcoes.getDadosConexaoUDL('ConexaoAoWell.ini');
   FmSenha.cbJustificativa.Visible := false;
   FmSenha.ShowModal;

   if FmSEnha.ModalResult = MrOk then
      Result := trim(copy(fmSenha.cbUsuarios.Items[fmSenha.cbUsuarios.Itemindex],100,10))
   else
     Result := '';
end;

function TelaAutorizacao2(grupos, cd_usu:string):String;
begin
   funcoes.gravaLog('TelaAutorizacao2()');
   application.CreateForm(TFmSenha,FmSEnha);
   FmSenha.cbUsuarios.Items := uUsuarios.getUsuariosWell(grupos, cd_usu);
   FmSenha.desabilitajustificativa();
   fmSenha.Conexao.ConnectionString :=  funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');
   FmSenha.ShowModal;

   if FmSenha.ModalResult = MrOk then
      Result := trim(copy(fmSenha.cbUsuarios.Items[fmSenha.cbUsuarios.Itemindex],100,10))
   else
     Result := '';
end;

function telaAutPonto(lstJustificativas,lstUsers:TStrings ):string;
begin
   screen.Cursor := crHourGlass;

   application.CreateForm(TFmSenha,FmSEnha);

   FmSenha.cbUsuarios.Items := lstUsers;
   if (lstJustificativas.Count > 0) then
   begin
      fmsenha.habilitaJustificativa(nil);
      fmSenha.cbJustificativa.Items :=  lstJustificativas ;
   end
   else
      fmSenha.desabilitajustificativa();

   FmSenha.Conexao.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini');

   screen.Cursor := crDefault;
   FmSenha.ShowModal;
   if FmSEnha.ModalResult = MrOk then
   begin
      if (lstJustificativas.Count > 0) then
         Result := trim(copy(fmSenha.cbJustificativa.Items[fmSenha.cbJustificativa.Itemindex], 01, 04))
      else
         Result := trim(copy(fmSenha.cbUsuarios.Items[fmSenha.cbUsuarios.Itemindex], 100, 10))
   end
   else
      Result := '';
end;

function FEncryptDecrypt(senha:String; pT : String) : String;
var
 wStr    : String;
 wReturn : String;
 wLB : Integer;
 wS  : Integer;
 wB  : Integer;
 i   : Integer;
begin
  // Retornará o pTexto Encrypt ou decrypt
  // ptexto - String a ser (E)criptografada ou (D)descriptografada
  // pT     - Letra (E ou D) que identifica a função a ser usada em pTexto.
  pT      := UpperCase(pT);
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

function telaAutorizacaoSimples(senha,msg:String):String;
begin
   application.CreateForm(TFmSenha,FmSEnha);
   fmSenha.preparaSenhaSimples(senha);
   FmSenha.Position := poMainFormCenter;
   FmSenha.ShowModal;

   if (fmSenha.ModalResult = mrOk) then
     result := senha
   else
      result := '';
end;


   
end.
