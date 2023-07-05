unit uFmCriaNf;

interface

uses
  ADODB, DB, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, ExtCtrls, adLabelComboBox,
  adLabelEdit, Buttons, fCtrls;

type
  TfmCriaNf = class(TForm)
    Panel1: TPanel;
    gbNfOrigem: TGroupBox;
    Label1: TLabel;
    lbLoja: TLabel;
    lbNota: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    lbDtEmis: TLabel;
    lbStatus: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    lbValor: TLabel;
    lbDest: TLabel;
    lbIsNota: TLabel;
    Label2: TLabel;
    btNovo: TFlatButton;
    gbNfDest: TGroupBox;
    cbOperIntegrada: TadLabelComboBox;
    Label6: TLabel;
    lbOperacao: TLabel;
    rgTpDest: TRadioGroup;
    pnTpDestEmis: TPanel;
    cbLoja: TadLabelComboBox;
    edMailDest: TadLabelEdit;
    btEmisDest: TFlatButton;
    btOk: TfsBitBtn;
    btCancela: TfsBitBtn;
    lbUo: TLabel;
    edObs: TadLabelEdit;
    cbUsaFatPreco: TfsCheckBox;

    function camposOk():boolean;
    procedure btCancelaClick(Sender: TObject);
    procedure btEmisDestClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure carregaDadosNota(is_nota:String);
    procedure cbOperIntegradaChange(Sender: TObject);
    procedure edMailDestClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure preparaNovaConsulta();
    procedure rgTpDestClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCriaNf: TfmCriaNf;

implementation

uses ufiscal, uLj, uMain, f, uDm, msg;

{$R *.dfm}

procedure TfmCriaNf.carregaDadosNota(is_nota:String);
var
  ds:TDataset;
begin
	ds:= uFiscal.getDadosNota(is_nota,'','','');

	lbNota.Caption := trim(ds.fieldByName('serie').AsString) +'/'+ trim(ds.fieldByName('num').AsString);
   lbLoja.Caption := ds.fieldByName('Loja').AsString;
   lbStatus.Caption:=ds.fieldByName('Situacao').AsString;
   lbValor.Caption := ds.fieldByName('Valor').AsString;
   lbIsNota.Caption :=  ds.fieldByName('is_nota').AsString;
   lbUo.Caption := ds.fieldByName('is_estoque').AsString;
	lbDtEmis.Caption := ds.fieldByName('Entrada/Saida').AsString;
	lbOperacao.Caption := ds.fieldByName('ds_res').AsString;

   gbNfDest.Visible := true;

   btNovo.Visible := false;
   btOk.Visible := true;
   btCancela.Visible := true;
   cbOperIntegradaChange(nil);

end;


procedure TfmCriaNf.btNovoClick(Sender: TObject);
var
   cmd:String;
begin
	preparaNovaConsulta();
   cmd := '';
   cmd := uFiscal.getIsNota();

   if cmd <> '' then
      carregaDadosNota(cmd)
   else
   	preparaNovaConsulta();
end;

procedure TfmCriaNf.preparaNovaConsulta;
begin
	lbNota.Caption := '';
   lbLoja.Caption := '';
   lbStatus.Caption:='';
   lbStatus.Caption := '';
   lbValor.Caption := '';
   lbIsNota.Caption := '';
   lbUo.Caption := '';
   lbDest.Caption := '';
	lbOperacao.Caption := '';
   lbDtEmis.Caption := '';

	edObs.Text := '';
   edMailDest.Text := '';
   lbIsNota.caption := '';

   btOk.Visible := false;
   btCancela.Visible := false;

   btNovo.Visible := true;
   gbNfDest.Visible := false;

   cbOperIntegrada.ItemIndex := -1;
end;

procedure TfmCriaNf.FormCreate(Sender: TObject);
begin
	cbOperIntegrada.Items := ufiscal.getOperIntOS();

   pnTpDestEmis.BevelOuter := bvNone;
   gbNfDest.Visible := false;
	uLj.getListaLojas(cbLoja, false, false, '', '');

   edMailDest.Visible := false;

   fmCriaNf.Height := 450;
   fmCriaNf.Width := 690;

	preparaNovaConsulta();

end;

procedure TfmCriaNf.rgTpDestClick(Sender: TObject);
begin
   if(rgTpDest.ItemIndex = 0)then
   begin
      cbLoja.Visible := true;

      edMailDest.Visible := false;
      btEmisDest.Visible := false;
      edMailDest.Text := '';
      lbDest.Caption := '';
   end
   else
   begin
      cbLoja.Visible := false;
      cbLoja.ItemIndex := -1;
      edMailDest.Visible := true;
      btEmisDest.Visible := true;
   end;
end;

procedure TfmCriaNf.btCancelaClick(Sender: TObject);
begin
	preparaNovaConsulta();
end;

procedure TfmCriaNf.btEmisDestClick(Sender: TObject);
var
	cd_pes, ds_pes, ds_end:String;
begin
	cd_pes := '';
	fmMain.getDadosPessoa(cd_pes, ds_pes, ds_end, '');
   edMailDest.Text := ds_pes + ' ' + ds_end;
	lbDest.Caption := cd_pes;
end;

procedure TfmCriaNf.btOkClick(Sender: TObject);
var
	nf, cd_pes:String;
begin
   if (camposOk() = true) then
   begin
      if (rgTpDest.ItemIndex = 0) then
         cd_pes := f.getCodUO(cbLoja)
      else
         cd_pes := lbDest.Caption;

      nf :=
      uFiscal.geraNotaApartirDeOutra(
      	fmMain.getUoLogada(),
			fmMain.getUserLogado(),
         cd_pes,
         '',
         f.getCp(2, cbOperIntegrada),
         lbIsNota.Caption,
         edObs.Text,
         cbUsaFatPreco.Checked
      );

      if (nf <> '')then
      begin
	      msg.msgExclamation(dm.getCMD1('MSG', 'fiscal.nfGerada', nf));
         btCancelaClick(nil);
      end;
	end;
end;

procedure TfmCriaNf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	Action := caFree;
   fmCriaNf := nil;
end;

function TfmCriaNf.camposOk: boolean;
var
	err:String;
begin
	err:= '';

   if (cbOperIntegrada.ItemIndex < 0) then
	 	err:= err + dm.getMsg('criaNferrOpr');

   if (rgTpDest.ItemIndex = 0) and (cbLoja.ItemIndex < 0) and (rgTpDest.Enabled = true) then
   	err:= err + dm.getMsg('MSG_ERR_LJ');

   if (rgTpDest.ItemIndex = 1) and (lbDest.Caption = '') then
		err:= err + dm.getMsg('criaNfErrCli');

   if (err <> '') then
		msg.msgErro(  dm.getMsg('MSG_ERRO_TIT') + err);

   result := (err = '');
end;

procedure TfmCriaNf.edMailDestClick(Sender: TObject);
begin
	if edMailDest.Text = '' then
   	btEmisDestClick(nil);
end;

procedure TfmCriaNf.cbOperIntegradaChange(Sender: TObject);
begin
   rgTpDest.Enabled := (f.getCp(3, cbOperIntegrada) <> '12');
   cbLoja.Enabled := rgTpDest.Enabled;

   cbUsaFatPreco.Visible := (f.getCp(4, cbOperIntegrada) ='True');
   cbUsaFatPreco.Enabled := cbUsaFatPreco.Visible;
end;

end.
