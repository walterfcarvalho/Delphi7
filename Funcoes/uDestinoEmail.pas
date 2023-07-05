unit uDestinoEmail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, adLabelComboBox, ExtCtrls,
  TFlatButtonUnit, adLabelMemo, fCtrls, TFlatGroupBoxUnit;

type
  TfmDestEmail = class(TForm)
    pnConfirma: TPanel;
    btOk: TFlatButton;
    FlatButton1: TFlatButton;
    lbEmail: TLabel;
    mmCorpoEmail: TadLabelMemo;
    FlatGroupBox1: TFlatGroupBox;
    edConta: TadLabelEdit;
    edSenha: TadLabelEdit;
    cbSalvaSenha: TfsCheckBox;
    FlatGroupBox2: TFlatGroupBox;
    cbLoja: TadLabelComboBox;
    rgEmailDest: TRadioGroup;
    Label1: TLabel;
    rgTpSender: TRadioGroup;
    edMailDest: TadLabelEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure btOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbSistemaClick(Sender: TObject);
    procedure salvaDadosLoginEmail();
    procedure FlatButton1Click(Sender: TObject);
    procedure fsCbEmailLojaClick(Sender: TObject);
    procedure rgEmailDestClick(Sender: TObject);
    procedure rgTpSenderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDestEmail: TfmDestEmail;

implementation

uses uMain, f, {uCF,} udm, uLj, uEmail, uEnviaEmail;

{$R *.dfm}

procedure TfmDestEmail.btOkClick(Sender: TObject);
begin
   lbEmail.Caption := '';

   if ( rgEmailDest.ItemIndex = 0 ) then
      lbEmail.Caption := dm.getEmail(f.getCodUO(cbLoja))
   else
   begin
      if (uEmail.isEmailValido(edMailDest.Text) = true) then
         lbEmail.Caption := trim(edMailDest.Text)
   end;

   if (lbEmail.Caption <> '') then
   begin
      salvaDadosLoginEmail();


	   f.WParReg(f.getNomeDoExecutavel(), 'ultimoDestEmail', edMailDest.Text );
      ModalResult := mrOk;
   end
   else
      edMailDest.SetFocus();
end;

procedure TfmDestEmail.FormShow(Sender: TObject);
begin
   uLj.getListaLojas(cbLoja, false, false, '', '' );
   fsCbEmailLojaClick(nil);

	edMailDest.LabelDefs.Caption := '';
   edMailDest.Text :=  f.rParReg(f.getNomeDoExecutavel(), 'ultimoDestEmail');
end;

procedure TfmDestEmail.cbSistemaClick(Sender: TObject);
begin
   if (rgTpSender.ItemIndex = 0) then
   begin
      edConta.Visible := false;
      edConta.Text := '';
      edSenha.Visible := false;
      edSenha.Text := '';
      cbSalvaSenha.Visible := false;
   end
   else
   begin
      edConta.Visible := true;
      edConta.Text := '';
      edSenha.Visible := true;
      edSenha.Text := '';
      cbSalvaSenha.Visible := true;

      cbSalvaSenha.Checked := f.rParRegBool(application.Name +'_'+ uEnviaEmail.DADOS_EMAIL.getValor('cd_pes'){ fmMain.getCdPesLogado()}, 'salvaSenha');

      if (cbSalvaSenha.Checked = true) then
      begin
         edConta.Text :=  f.rParReg(application.Name +'_'+ uEnviaEmail.DADOS_EMAIL.getValor('cd_pes') {fmMain.getCdPesLogado()}, 'userEmail');
         edSenha.Text :=  f.rParReg(application.Name +'_'+ uEnviaEmail.DADOS_EMAIL.getValor('cd_pes'){fmMain.getCdPesLogado()}, 'userSenha');
      end;
   end;
end;

procedure TfmDestEmail.salvaDadosLoginEmail();
var
   usu, pass:String;
begin
   if (cbSalvaSenha.Checked = true) then
   begin
      usu := edConta.Text;
      pass := edSenha.Text;
   end;

   f.wParReg(application.Name +'_'+ uEnviaEmail.DADOS_EMAIL.getValor('cd_pes'){fmMain.getCdPesLogado()}, 'userEmail', usu);
   f.wParReg(application.Name +'_'+uEnviaEmail.DADOS_EMAIL.getValor('cd_pes'){fmMain.getCdPesLogado()}, 'userSenha', pass);
   f.wParRegBolean(application.Name +'_'+ uEnviaEmail.DADOS_EMAIL.getValor('cd_pes'){fmMain.getCdPesLogado()}, 'salvaSenha', cbSalvaSenha.Checked );
end;

procedure TfmDestEmail.FlatButton1Click(Sender: TObject);
begin
   ModalResult := mrCancel;
end;

procedure TfmDestEmail.fsCbEmailLojaClick(Sender: TObject);
begin
   if ( rgEmailDest.ItemIndex = 0 ) then
   begin
      Label2.Visible := false;
      Label3.Visible := true;
      edMailDest.Visible := false;
      edMailDest.Text := '';
      cbLoja.Visible := true;
      cbLoja.SetFocus();
      cbLoja.ItemIndex := 0;
   end
   else
   begin
      Label2.Visible := true;
      Label3.Visible := false;
      cbLoja.ItemIndex := -1;
      cbLoja.Visible := false;
      edMailDest.Visible := true;
      edMailDest.SetFocus();
   end;

end;

procedure TfmDestEmail.rgEmailDestClick(Sender: TObject);
begin
   fsCbEmailLojaClick(nil);
end;

procedure TfmDestEmail.rgTpSenderClick(Sender: TObject);
begin
   cbSistemaClick(nil);
end;

end.
