unit uRemLancContabil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, adLabelComboBox, TFlatButtonUnit,
  ExtCtrls;

type
  TfmRemLancContabil = class(TForm)
    cbEmpresa: TadLabelComboBox;
    edPrefSeq: TadLabelEdit;
    GroupBox1: TGroupBox;
    edSeqF: TadLabelEdit;
    edSeqI: TadLabelEdit;
    FlatButton1: TFlatButton;
    cbTipoLancamento: TadLabelComboBox;
    rgTpRemocao: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);

    function validaCampos():boolean;
    procedure edSeqIKeyPress(Sender: TObject; var Key: Char) ;
    procedure rgTpRemocaoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRemLancContabil: TfmRemLancContabil;

implementation
    uses uMain, cf, f, uContabil, uDm, msg, uLj;

{$R *.dfm}
function TfmRemLancContabil.validaCampos():boolean;
var
   erro:String;
begin
   if  (cbEmpresa.ItemIndex < 0) then
      erro := erro + dm.getMsg('contab.errEmp');

   if (rgTpRemocao.ItemIndex = 0) then
      if (edSeqI.Text = '') or (edSeqF.Text = '') or (edPrefSeq.Text = '') then
         erro := erro +  dm.getMsg('contab.errSeq');

   if (f.SohLetras(edSeqI.Text) <> '') or
      (f.SohLetras(edSeqF.Text) <> '') or
      (f.SohLetras(edPrefSeq.Text)<> '') then
      erro := erro + ' - Os sequenciais devem ser numéricos. '+#13;

   if ( f.SohNumeros(edSeqF.Text) < f.SohNumeros(edSeqI.Text) ) then
      erro := erro + ' - O sequencial final não pode ser menor que o inicial. '+#13;

   if (erro <> '') then
      msg.msgErro( dm.getMsg('MSG_ERRO_TIT') +erro);

   result := (erro = '');
end;


procedure TfmRemLancContabil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   f.salvaCampos(fmRemLancContabil);
   action := cafree;
   fmRemLancContabil := nil;
end;

procedure TfmRemLancContabil.FormCreate(Sender: TObject);
begin
   uLj.getListaEmpresas(cbEmpresa);
//   fmMain.getParametrosForm(fmRemLancContabil);
end;

procedure TfmRemLancContabil.FlatButton1Click(Sender: TObject);
begin
   if (validaCampos() = true ) then
   begin
      if rgTpRemocao.ItemIndex = 0 then
      begin
         if ( ucontabil.removeLancContabil( cbEmpresa.Items[cbEmpresa.itemIndex], edPrefSeq.Text, edSeqI.Text,edSeqF.Text,(cbTipoLancamento.ItemIndex = 0)) >= 1 ) then
              msg.msgExclamation(dm.getMsg('contab.seqRemov'))
         else
             msg.msgErro( dm.getMsg('MSG_SEM_DADOS'));
      end
      else
      begin
         if (ucontabil.removeLotes(cbEmpresa.Items[cbEmpresa.itemIndex], edSeqI.Text, edSeqF.Text) > 0) then
              msg.msgExclamation(dm.getMsg('contab.LotRemov'))
         else
             msg.msgErro( dm.getMsg('MSG_SEM_DADOS'));
      end;
   end;
end;

procedure TfmRemLancContabil.edSeqIKeyPress(Sender: TObject; var Key: Char);
begin
   if (f.isLetra(Key)= true) then
      key := #0;
end;

procedure TfmRemLancContabil.rgTpRemocaoClick(Sender: TObject);
begin
   edPrefSeq.Visible := not(rgTpRemocao.ItemIndex = 1);
   cbTipoLancamento.Visible := not(rgTpRemocao.ItemIndex = 1);
end;

procedure TfmRemLancContabil.FormShow(Sender: TObject);
begin
   self.Width := 700;
   self.Height := 200;
end;

end.
