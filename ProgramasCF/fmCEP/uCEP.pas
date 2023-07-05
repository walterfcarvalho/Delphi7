unit uCEP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, Buttons, fCtrls, adLabelComboBox,
  TFlatButtonUnit, ExtCtrls, Db;

type
  TfmCep = class(TForm)
    GroupBox1: TGroupBox;
    pnItens: TPanel;
    edUF: TadLabelEdit;
    btUF: TfsBitBtn;
    edCidade: TadLabelEdit;
    lbCd_cid: TLabel;
    btCidade: TfsBitBtn;
    edBairro: TadLabelEdit;
    lbCd_bai: TLabel;
    btBairro: TfsBitBtn;
    edCEP: TadLabelEdit;
    pnOperacao: TPanel;
    btIncluir: TFlatButton;
    btAltera: TFlatButton;
    btExclui: TFlatButton;
    pnOkCancel: TPanel;
    btOk: TfsBitBtn;
    btCancela: TfsBitBtn;
    btConsulta: TFlatButton;
    edLog: TadLabelEdit;
    cbTpLog: TadLabelComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCidadeClick(Sender: TObject);
    procedure edCidadeDblClick(Sender: TObject);
    procedure btUFClick(Sender: TObject);
//    function  pegarDadosCampo(codPerfil, campoCodigo, campoNome, campoDiparador, filtro:String ; var codRetorno, nmRetorno:String):boolean;
    procedure btBairroClick(Sender: TObject);
    procedure edUFClick(Sender: TObject);
    procedure edCidadeClick(Sender: TObject);
    procedure edBairroClick(Sender: TObject);
    procedure edUFEnter(Sender: TObject);
    procedure edCidadeEnter(Sender: TObject);
    procedure edBairroEnter(Sender: TObject);
    procedure limpaUF();
    procedure limpaBairro();
    procedure limpaCidade();
    procedure btIncluirClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    function validaCampos():boolean;
    function incluirCEP():boolean;
    procedure btCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
    procedure consultaCEP();
    procedure setaTipoLogradouro(tpLog:String);
    function getTipoLogradouro(item:String):String;
    procedure btExcluiClick(Sender: TObject);
    function excluirCEP():boolean;
    function alteraCEP():boolean;
    procedure btAlteraClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCep: TfmCep;
  OPERACAO:String;
implementation

{$R *.dfm}
uses uCF, uBuscaCidade, f, msg, uBuscasDiversas;

function TfmCep.getTipoLogradouro(item: String): String;
begin
   result := trim(copy(item, 51,10));
end;

function TfmCep.validaCampos: boolean;
var
   erro:String;
begin
   erro := '';

   if ( edCEP.Text= '' ) or
      ( length(f.SohNumeros(edCEP.text)) <> Length(edCEP.Text) ) or
      ( Length(edCEP.Text) <> 8)  then
      erro := erro + ' - Preencha corretamente o CEP.'+#13;
   if (edUF.Text = '') then
      erro := erro + ' - Preencha o cadastro da UF.'+#13;
   if ( edCidade.Text= '' ) then
      erro := erro + ' - Preencha o cadastro da cidade.'+#13;
   if ( edBairro.Text= '' ) then
      erro := erro + ' - Preencha o cadastro do bairro.'+#13;

   if (erro <> '') then
   begin
      erro := ' Corrija antes esses erros: '+#13 +#13 + erro;
      msg.msgErro(erro);
   end;

   result :=  (erro = '');
end;

procedure TfmCep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
   fmCep := nil;
end;

procedure TfmCep.edCidadeDblClick(Sender: TObject);
begin
   btCidadeClick(nil);
end;
{
function TfmCep.pegarDadosCampo(codPerfil, campoCodigo, campoNome, campoDiparador, filtro:String ; var codRetorno, nmRetorno:String):boolean;
var
  res:boolean;
begin
   res:= false;
   if (campoDiparador <> '') then
   begin
      Application.CreateForm(TfmBuscaDiversas, fmBuscaDiversas);
      fmBuscaDiversas.setPerfil(codPerfil);
      fmBuscaDiversas.edFiltro.Text := filtro;

      fmBuscaDiversas.showModal();

      if (fmBuscaDiversas.ModalResult = mrOk) then
      begin
         codRetorno := fmBuscaDiversas.dsPes.DataSet.fieldByName(campoCodigo).asString;
         nmRetorno := fmBuscaDiversas.dsPes.DataSet.fieldByName(campoNome).asString;
         res:= true;
      end;
      fmBuscaDiversas.Close();
      fmBuscaDiversas := nil;
   end;
   result := res;

end;
 }
procedure TfmCep.btCidadeClick(Sender: TObject);
var
  cod, desc:String;
begin
   if (uBuscasDiversas.pegarDadosCampo('cidade', 'cd_cid', 'nm_cid', edUF.Text, edUF.Text, cod, desc ) = true) then
   begin
      edCidade.Text := desc;
      lbCd_cid.Caption := cod;
      limpaBairro();
   end;
end;

procedure TfmCep.btBairroClick(Sender: TObject);
var
  cod, desc:String;
begin
   pegarDadosCampo('bairro', 'cd_bai', 'nm_bai', edCidade.Text, lbCd_cid.Caption, cod, desc );
   edBairro.Text := desc;
   lbCd_bai.Caption := cod;
end;

procedure TfmCep.edUFClick(Sender: TObject);
begin
   btUFClick(nil);
end;

procedure TfmCep.edCidadeClick(Sender: TObject);
begin
   btCidadeClick(nil);
end;

procedure TfmCep.edBairroClick(Sender: TObject);
begin
   btBairroClick(nil);
end;

procedure TfmCep.edUFEnter(Sender: TObject);
begin
   btUF.SetFocus();
end;

procedure TfmCep.edCidadeEnter(Sender: TObject);
begin
   btCidade.SetFocus();
end;

procedure TfmCep.edBairroEnter(Sender: TObject);
begin
   btBairro.SetFocus();
end;

procedure TfmCep.limpaBairro();
begin
   edBairro.Text := '';
   lbCd_bai.Caption := '';
end;


procedure TfmCep.limpaCidade();
begin
   limpaBairro();
   edCidade.Text := '';
   lbCd_cid.Caption := '';
end;

procedure TfmCep.btUFClick(Sender: TObject);
var
  cd_uf, nm_uf:String;
begin
   if (pegarDadosCampo( 'uf', 'cd_uf', 'nm_uf', '*', '*', cd_uf, nm_uf ) = true) then
   begin
      limpaCidade();
      edUF.Text := cd_uf;
   end;
end;

procedure TfmCep.btIncluirClick(Sender: TObject);
begin
   OPERACAO := btIncluir.Caption;
   pnOkCancel.Visible := false;
   edCEP.Visible := true;
   pnItens.Visible:= true;
   pnOkCancel.Visible := true;
   pnOperacao.Visible := false;
   edCEP.SetFocus();
end;



function TfmCep.incluirCEP;
begin
   if (validaCampos = true) then
      result := ucf.incluirCEP( edCEP.Text, edUF.Text, lbCd_cid.Caption,
        lbCd_bai.Caption, getTipoLogradouro(cbTpLog.Items[cbTpLog.ItemIndex]),edLog.text);
end;

procedure TfmCep.limpaUF;
begin
   edUF.Text := '';
   limpaCidade();
end;


procedure TfmCep.btCancelaClick(Sender: TObject);
begin
   OPERACAO := '';
   edCEP.Text := '';
   limpaUF();
   pnOperacao.Visible := true;
   pnOkCancel.Visible := false;
   pnItens.Visible := false;
end;


procedure TfmCep.FormCreate(Sender: TObject);
begin
   cbTpLog.Items := uCF.getTiposLogradouro();
   btCancelaClick(nil);
end;

procedure TfmCep.setaTipoLogradouro(tpLog: String);
var
   i:integer;
begin
   for i:=0 to cbTpLog.Items.Count -1 do
   begin
      if (getTipoLogradouro(cbTpLog.Items[i]) = tpLog) then
      begin
         cbTpLog.ItemIndex := i;
         Break;
      end;
   end;
end;

procedure TfmCep.consultaCEP;
var
   ds:TDataSet;
begin
   ds:= uCF.getCEP(edCEP.Text);
   if (ds.IsEmpty = false) then
   begin
      edUF.Text := ds.fieldByName('cd_uf').asString;
      lbCd_cid.Caption := ds.fieldByName('cd_cid').asString;
      lbCd_bai.Caption := ds.fieldByName('cd_bai').asString;
      edCidade.Text := ds.fieldByName('nm_cid').asString;
      edBairro.Text := ds.fieldByName('nm_bai').asString;
      edLog.Text := ds.fieldByName('nm_log').asString;
      setaTipoLogradouro(ds.fieldByName('tp_lograd').asString);

      pnOperacao.Visible :=  true;
      pnItens.Visible := true;
      pnOkCancel.Visible := false;
   end
   else
      msg.msgErro('CEP n�o cadastrado');
   ds.Free();
end;

procedure TfmCep.btConsultaClick(Sender: TObject);
begin
   consultaCEP();
end;

procedure TfmCep.btOkClick(Sender: TObject);
begin
   if (OPERACAO = btIncluir.Caption) then
      if (uCF.getCEP(edCEP.text).IsEmpty = true) then
      begin
         if incluirCEP() = true then
         begin
            msg.msgExclamation('CEP incluido');
            btCancelaClick(nil);
         end
      end
      else
         if (msg.msgQuestion(' CEP j� cadastrado, deseja consultar?') = mrYes) then
            consultaCEP();
end;


procedure TfmCep.btExcluiClick(Sender: TObject);
begin
   if (msg.msgQuestion('Eu recomento fortemente vc n�o excluir algum CEP, pois isso pode '+
                       ' causar inconsist�ncia.' +#13+ 'Deseja realmente exluir o CEP ?') = mrYes) then
   begin
      if (excluirCEP() = true) then
         msg.msgExclamation('CEP excluido')
      else
         msg.msgErro('Erro ao Excluir CEP');

      btCancelaClick(nil);
   end;
end;

function TfmCep.excluirCEP():boolean;
begin
   if (validaCampos = true) then
      result := uCF.excluirCEP(edCEP.Text);
end;

function TfmCep.alteraCEP():boolean;
begin
   result := (excluirCEP() = true) and ( incluirCEP() = true);
end;

procedure TfmCep.btAlteraClick(Sender: TObject);
begin
   if (msg.msgQuestion('Eu recomento fortemente vc n�o alterar algum CEP, pois isso pode '+
                       ' causar inconsist�ncia.' +#13+ 'Deseja realmente alterar o CEP ?' ) = mrYes) then
      if (alteraCEP() = true) then
         msg.msgExclamation('Altera��o concluida.')
      else
         msg.msgErro('Erro ao tentar excluir.');
end;


end.
