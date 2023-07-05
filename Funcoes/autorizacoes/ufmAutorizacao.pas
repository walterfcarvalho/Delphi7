unit ufmAutorizacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, adLabelEdit, adLabelComboBox;

type
  TfmAutorizacao = class(TForm)
    cbUser: TadLabelComboBox;
    edSenha: TadLabelEdit;
    btOk: TfsBitBtn;
    btCancel: TfsBitBtn;
    lbMsg: TLabel;
    procedure btOkClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure cbUserClick(Sender: TObject);
    procedure edSenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure limpaMsg();
    procedure mostraMsg(msg:String);
    procedure cbUserChange(Sender: TObject);
    procedure edSenhaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAutorizacao: TfmAutorizacao;

implementation
uses f, uAutorizacao;
{$R *.dfm}

procedure TfmAutorizacao.btOkClick(Sender: TObject);
begin
   if (cbUser.ItemIndex >= 0) then
      if ( uAutorizacao.isSenhaValida(edSenha.Text, uAutorizacao.getSenha(cbUser) ) = true) then
         ModalResult := mrOk
      else
         mostraMsg('Senha inválida');
end;

procedure TfmAutorizacao.btCancelClick(Sender: TObject);
begin
   ModalResult := mrNo;
end;


procedure TfmAutorizacao.cbUserClick(Sender: TObject);
begin
//   edSenha.SetFocus()
end;

procedure TfmAutorizacao.edSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if ( key = VK_return) then
     btOkClick(nil);
end;

procedure TfmAutorizacao.FormCreate(Sender: TObject);
begin
   fmAutorizacao.Icon := Application.Icon;
   btCancel.Caption := '';
   fmAutorizacao.Refresh();
end;

procedure TfmAutorizacao.limpaMsg;
begin
    lbMsg.Caption := '';
    lbMsg.Visible:=false;
end;

procedure TfmAutorizacao.cbUserChange(Sender: TObject);
begin
   limpaMsg();
end;

procedure TfmAutorizacao.edSenhaChange(Sender: TObject);
begin
   limpaMsg();
end;

procedure TfmAutorizacao.mostraMsg(msg: String);
begin
    lbMsg.Caption:= msg;
    lbMsg.Visible := true;
    edSenha.SetFocus;
    edSenha.SelectAll();
end;

procedure TfmAutorizacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   self := nil;
end;

procedure TfmAutorizacao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
	  if (Key = VK_return) or (key = vk_Tab) and (Components[fmAutorizacao.ComponentIndex].Name = cbUser.Name ) then
	     edSenha.SetFocus();
end;

end.
