unit uCadBairro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uCEP, TFlatButtonUnit, StdCtrls, adLabelComboBox, Buttons,
  fCtrls, adLabelEdit, ExtCtrls, f;

type
  TfmCadBairro = class(TfmCep)
    procedure FormCreate(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    function validarCampos():String;
    procedure incluirBairro();
    procedure btExcluiClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCadBairro: TfmCadBairro;

implementation

uses uMain, cf, ucf, uDm, msg;

{$R *.dfm}

procedure TfmCadBairro.FormCreate(Sender: TObject);
begin
//  inherited;
  edCEP.Visible := false;
  cbTpLog.Visible := false;
  edLog.Visible := false;
  pnOkCancel.Visible := false;
  pnOperacao.Visible := true;
//  btConsulta.Visible := false;
  edBairro.ReadOnly := false;
  btBairro.Visible := false;
  btAltera.Visible := false;
end;

procedure TfmCadBairro.btConsultaClick(Sender: TObject);
var
   cmd:String;
begin
  cmd := validarCampos();
  if ( cmd = '') then
     msg.msgErro(' - Bairro não cadastrado')
  else
    lbCd_bai.caption := cmd;
end;

procedure TfmCadBairro.btIncluirClick(Sender: TObject);
var
  cmd:String;
begin
   cmd :=
   'Confirma a inclusão desse bairro ?' + #13+
   'UF:' + edUF.Text + #13+
   'Cidade: '+ edCidade.Text +#13+
   'Bairro: '+ edBairro.Text;

   if (validarCampos() = '') then
      if (msg.msgQuestion(cmd) = mrYes) then
         incluirBairro();

end;

function TfmCadBairro.validarCampos(): String;
var
   cmd, erro:String;
begin
   if (lbCd_cid.Caption = '') then
      erro := erro + ' - Preencha a cidade.' + #13;

   if (edUF.Text = '') then
      erro := erro + ' - Preencha o estado.' + #13;

   if( edBairro.Text = '') then
      erro := erro + ' - Preencha o bairro.' + #13
   else
   begin
      cmd :=
      'select top 01 cd_bai, nm_bai from tbai '+
      'where cd_uf=' + quotedStr(edUF.Text) +
      ' and cd_cid= ' + lbCd_cid.Caption +
      ' and nm_bai=' + QuotedStr(edBairro.Text);

      cmd := dm.openSQL(cmd, '');
      if ( cmd <> '') then
         erro := erro + ' - Esse bairo já é cadastrado.' + #13;
   end;

   if ( erro <> '') then
      msg.msgErro( 'Corrija antes esses erros:'+ #13 + erro);

   result := cmd;
end;

procedure TfmCadBairro.incluirBairro;
var
   cmd:String;
begin
   cmd :=
   ' insert tbai(cd_bai, CD_CID, CD_UF, MAINT, NM_BAI) values (' +
   quotedStr(dm.getContadorWell('cd_bai')) + ', '+
   quotedStr(lbCd_cid.Caption) +', '+
   quotedStr(edUF.Text)  +', '+
   '''A''' + ', '+
   quotedstr(edBairro.Text) + ')';
   dm.execSQL(cmd);
end;

procedure TfmCadBairro.btExcluiClick(Sender: TObject);
var
  cmd:String;
  i, j, numclientes:integer;
  itens:TStringList;
begin
   msg.msgWarning('Se houver algum cliente cadastrado com esse bairro, não poderei exclui-lo.');

   cmd :=
   ' select cast(cd_pes as varchar(08)) + '' - '' + nm_Pes'+
   ' from dspes where cd_bai=' + lbCd_bai.Caption +
   ' and cd_cid= ' + quotedStr(lbCd_cid.Caption) +
   ' and cd_uf= '+ quotedStr(edUF.Text)  +
   ' order by nm_pes';

   itens := dm.getListagem(cmd, 0);

   numclientes:= itens.Count;

   if (numclientes > 5) then
      j:= 5
   else
      j:= numclientes;

   cmd := '';
   if (numclientes > 0 )  then
   begin

      for i:= 1 to j do
         cmd := cmd + itens[i] + #13;

      cmd := ' Existem clientes com esse bairro, então não posso excluí-lo: '+ #13+ cmd;

     msgErro(cmd);
   end
   else
   begin
      cmd :=
      ' Delete from tbai'+
      ' where cd_bai=' + lbCd_bai.Caption +
      ' and cd_cid= ' + quotedStr(lbCd_cid.Caption) +
      ' and cd_uf= '+ quotedStr(edUF.Text);
      dm.execSQL(cmd);
   end;
end;

procedure TfmCadBairro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := cafree;
   fmCadBairro := nil;
end;

end.
