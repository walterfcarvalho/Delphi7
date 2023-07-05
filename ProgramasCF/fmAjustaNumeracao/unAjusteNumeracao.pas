unit unAjusteNumeracao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, adLabelComboBox, TFlatButtonUnit,
  ExtCtrls, fCtrls, adLabelNumericEdit, adLabelSpinEdit, db;

type
  TfmAjustaNumNF = class(TForm)
    gbNotaNovo: TGroupBox;
    cbLoja: TadLabelComboBox;
    cbNumNovaSerie: TadLabelComboBox;
    edSerie: TadLabelEdit;
    edNumNovo: TadLabelSpinEdit;
    edContNovo: TadLabelSpinEdit;
    gbNotaAnt: TGroupBox;
    edContSrAntiga: TadLabelSpinEdit;
    cbAlteraNumAntigo: TfsCheckBox;
    Panel1: TPanel;
    cbTpNovaSerie: TFlatButton;
    Label1: TLabel;
    lbLoja: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lbNota: TLabel;
    lbIsNota: TLabel;
    lbUo: TLabel;
    btCancel: TFlatButton;
    btOk: TFlatButton;
    lbSrAnt: TLabel;
    cbAlteraContNovo: TfsCheckBox;
    Label2: TLabel;
    procedure cbTpNovaSerieClick(Sender: TObject);
    procedure carregaDadosNota(isNota:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbNumNovaSerieChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbAlteraNumAntigoClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure alteraNumeracao();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAjustaNumNF: TfmAjustaNumNF;

implementation

uses cf, umain, f, uDm, uFiscal, msg;

{$R *.dfm}

procedure TfmAjustaNumNF.carregaDadosNota(isNota:String);
var
   ds:TdataSet;
begin
   ds := uFiscal.getDadosNota(isNota, '', '', '');
   lbLoja.Caption := ds.fieldByName('loja').asString;
   lbNota.Caption := trim(ds.fieldByName('serie').asString) +'/'+ ds.fieldByName('num').asString ;
   lbIsNota.caption := isNota;
   lbUo.caption := ds.fieldByName('is_estoque').asString;

   lbLoja.Visible := true;
   lbNota.Visible := true;

   gbNotaAnt.Visible := true;
   gbNotaNovo.Visible := true;
   cbTpNovaSerie.Visible := true;
   cbLoja.Visible := true;
   cbNumNovaSerie.Visible := true;
   lbSrAnt.Caption := trim(ds.fieldByName('serie').asString);

   ds.free;

   btOk.Visible := true;
   btCancel.Visible := true;
end;

procedure TfmAjustaNumNF.cbTpNovaSerieClick(Sender: TObject);
var
   cmd:String;
begin
   btCancelClick(nil);
   cmd := uFiscal.getIsNota();
   if (cmd <> '') then
      carregaDadosNota(cmd);
end;

procedure TfmAjustaNumNF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
   fmAjustaNumNF := nil;
end;

procedure TfmAjustaNumNF.cbNumNovaSerieChange(Sender: TObject);
var
  srNova:String;
begin
   srNova := dm.getParamBD( trim(copy(cbLoja.Items[cbLoja.ItemIndex],50,30)), lbUo.Caption);

   if (cbNumNovaSerie.ItemIndex = 0) then
   begin
      edNumNovo.Text := uFiscal.getProximoNumNF(lbUo.Caption, srNova);
      edSerie.text := srNova;
   end
   else
   begin
      edNumNovo.Text := '0';
      edContNovo.Text :=  '0';
   end;
   edSerie.Visible := true;
   edNumNovo.Visible := true;
   edContNovo.Visible := true;
   edContNovo.Value := edNumNovo.Value;
   edContSrAntiga.Visible := true;
end;

procedure TfmAjustaNumNF.FormCreate(Sender: TObject);
begin
   cbLoja.Items.clear();
   cbLoja.Items.add('- Gerencial                                      ServerNFE.SrNfGerencial');
   cbLoja.Items.add('- Fiscal                                         ServerNFE.SrNfe');
   cbLoja.Items.add('- Contingência                                   ServerNFE.SrNfeCont');
   cbLoja.ItemIndex := 0;
   cbNumNovaSerie.ItemIndex := -1;
   lbIsNota.caption := '';
   btCancelClick(nil);
end;

procedure TfmAjustaNumNF.cbAlteraNumAntigoClick(Sender: TObject);
begin
   edContSrAntiga.Enabled :=   (cbAlteraNumAntigo.Enabled = true);
end;

procedure TfmAjustaNumNF.btCancelClick(Sender: TObject);
begin
   btOk.Visible := false;
   btCancel.Visible := false;
   gbNotaNovo.Visible := false;
   gbNotaAnt.Visible:= false;
   cbAlteraNumAntigo.Checked := false;
   cbLoja.ItemIndex := -1;
   cbNumNovaSerie.ItemIndex := -1;
   edSerie.text := '';
   edNumNovo.text := '';
   edContNovo.Text :='';
   edContSrAntiga.Text := '';
   lbLoja.Caption := '';
   lbNota.Caption := '';
   lbIsNota.caption := '';
   lbUo.Caption := '';
end;

procedure TfmAjustaNumNF.alteraNumeracao();
var
   cmd:String;
begin
   cmd :=
   dm.getCMD3('fiscal', 'updSrNrNf',
   	quotedstr(edSerie.Text),
		quotedStr(f.SohNumeros(edNumNovo.Text)),
		lbIsNota.Caption
	);
   dm.execSQL(cmd);

   if edSerie.Text = 'GE' then
   begin
	   dm.getCMD1('fiscal', 'setcfo9999', lbIsNota.Caption);
	   dm.execSQL(cmd);
   end;

   if (cbAlteraContNovo.Checked = true ) then
   begin
      f.gravaLog('Atualizar contador da serie nova');
      uFiscal.ajustaContador(lbUo.Caption, edSerie.text, edContNovo.Text);
   end;
   if ( cbAlteraNumAntigo.Checked = true) then
   begin
      f.gravaLog('Atualizar contador da serie nova');
      uFiscal.ajustaContador(lbUo.Caption, lbSrAnt.Caption, edContSrAntiga.Text);
   end;
end;


procedure TfmAjustaNumNF.btOkClick(Sender: TObject);
var
   erro, cmd:String;
begin
   if ( cbLoja.ItemIndex = -1) then
     erro := erro + 'Informe a Serie nova. ' + #13;

   if ( cbNumNovaSerie.ItemIndex = -1) then
     erro := erro + 'Informe como vai pegar a numeração. ' + #13;

   if ( edSerie.Text = '') then
     erro := erro + 'Informe a série.' + #13;

   if ( edNumNovo.Text = '') then
     erro := erro + 'Informe o novo número.' + #13;

   if ( cbAlteraNumAntigo.Checked = true)  and (edContSrAntiga.Text = ''  )then
     erro := erro + 'Informe o contador da série antiga.' + #13;

   if ( edContNovo.Text = '') then
     erro := erro + 'Informe o valor do contador novo.' + #13;

   cmd := ' Confirma alteração da numeração: ' + #13+
          ' De  :' + lbNota.Caption + #13 +
          ' Para:' + trim(edSerie.Text) + '/'+ edNumNovo.Text;

   if (erro <> '') then
   begin
      erro := 'Corrija esses erros antes: ' + #13 + erro;
      msg.msgErro(erro);
   end
   else
   if (msg.msgQuestion(cmd) = mrYes) then
   begin
      alteraNumeracao();
      msg.msgExclamation('Dados alterados...');
   end;
end;


end.
