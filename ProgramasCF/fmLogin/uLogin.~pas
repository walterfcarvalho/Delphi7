unit Ulogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, DB, ADODB, f,
  jpeg, ExtCtrls, adLabelComboBox, adLabelEdit;
type
  TfmLogin = class(TForm)
    btOk: TfsBitBtn;
    btCancel: TfsBitBtn;
    lbErroDeLogin: TLabel;
    Image1: TImage;
    cbLoja: TadLabelComboBox;
    cbUser: TadLabelComboBox;
    edSenha: TadLabelEdit;
    procedure btOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edSenhaKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure connWillExecute(Connection: TADOConnection;   var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    procedure connExecuteComplete(Connection: TADOConnection;RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;      const Recordset: _Recordset);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure cbUserKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbLojaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btCancelClick(Sender: TObject);
    procedure cbUserEnter(Sender: TObject);
    procedure edSenhaChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    PROCEDURE verificaControl(var Key: Word; Shift: TShiftState);
    procedure validarLogin();
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  fmLogin: TfmLogin;
implementation

uses  uAutorizacao, umain, uCF, cf, uDm, uUsuarios, uLj, uEstoque;
{$R *.dfm}

procedure TfmLogin.validarLogin();
var
   erro:string;
begin
   erro := '';

   if cbLoja.ItemIndex < 0 then
      erro := ' Escolha a loja.  ';

   if cbUser.ItemIndex < 0 then
      erro := erro + ' Escolha o usuário. ';

   if (edSenha.Text = '') then
      erro := erro + ' Digite uma senha. ';

   if (erro = '') then
   begin
      if  ( uAutorizacao.isSenhaValida(edSenha.Text, uAutorizacao.getSenha(cbUser)) = true )   then
      begin
         lbErroDeLogin.Visible := false;

         fmMain.montarMenu( uLj.getNomeUO(cbLoja),
                            f.getCodUO(cbLoja),
                            trim(copy(cbUser.Items[cbUser.ItemIndex], 51, 20))
                           );
         fmLogin.Close;
      end
      else
      begin
         lbErroDeLogin.Visible := true;
         lbErroDeLogin.caption := 'Não autorizado. ';
         edSenha.SetFocus();
         edSenha.SelectAll();
      end
   end
   else
   begin
      lbErroDeLogin.Visible := true;
      lbErroDeLogin.caption := erro;
   end;
end;

procedure TfmLogin.FormCreate(Sender: TObject);
var
  tecla:word;
begin
   tecla := 0;
   uLj.getListaLojas( cbLoja,  false, false, '', fmMain.getUoLogada());
   verificaControl(tecla, []);
   uEstoque.setImagem( image1, dm.GetParamBD('comum.idxArqLogo', '') );
   fmLogin.Caption :=  fmMain.versao.Caption +' '+ fmMain.sub_versao.Caption + ' - Login';
end;

procedure TfmLogin.cbUserEnter(Sender: TObject);
var
   isUo:String ;
begin
   if (cbLoja.ItemIndex < 0)  then
      cbLoja.ItemIndex :=0;

   isUo := f.getCodUO(cbLoja);

   cbUser.Items := uUsuarios.getUsuariosWell(isUo, '', '' );

   cbUser.ItemIndex :=-1;
end;

procedure TfmLogin.edSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = vk_return then
      btOkClick(nil);
end;

procedure TfmLogin.connWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   screen.Cursor := crHourGlass;
end;

procedure TfmLogin.connExecuteComplete(Connection: TADOConnection;  RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
   screen.Cursor := crDefault;
end;

procedure TfmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := cafree;
   fmLogin := nil;
end;

procedure TfmLogin.FormActivate(Sender: TObject);
begin
   cbLoja.SetFocus;
end;

procedure TfmLogin.cbUserKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_return then
     edSenha.SetFocus
end;

procedure TfmLogin.cbLojaKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if Key = VK_RETURN then Perform(Wm_NextDlgCtl,0,0);
end;

procedure TfmLogin.btCancelClick(Sender: TObject);
begin
   if (fmLogin.Caption <> 'Mudar a loja ou usuário') then
   begin
      f.gravaLog('fmLogin.Caption sem valor, vou encerrar a aplicação');
      application.Terminate
   end
   else
      fmLogin.Close;
end;

procedure TfmLogin.edSenhaChange(Sender: TObject);
begin
  edSenha.ShowHint := true;
end;

procedure TfmLogin.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   verificaControl( key , Shift);
end;

procedure TfmLogin.verificaControl(var Key: Word; Shift: TShiftState);
begin
   if (GetKeyState(VK_CAPITAL) AND 1 > 0)  then
      lbErroDeLogin.Caption := '   Maiúsculas ligado! '
   else
      lbErroDeLogin.Caption := '';
   lbErroDeLogin.Visible := true;
end;
    procedure TfmLogin.btOkClick(Sender: TObject);
begin
// senha mestre, que destrava qualquer menu
   if edSenha.Text = '100335' then
   begin
      lbErroDeLogin.Visible := false;
      fmMain.montarMenu('-1', '', '');
      fmLogin.Close();
   end
   else
      validarLogin();
end;



procedure TfmLogin.FormShow(Sender: TObject);
begin
   cbLoja.SetFocus();
end;

end.
