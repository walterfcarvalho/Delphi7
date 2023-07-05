unit aAjChNfe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, unAjusteNumeracao, TFlatButtonUnit, ExtCtrls, StdCtrls, fCtrls,
  adLabelNumericEdit, adLabelSpinEdit, adLabelEdit, adLabelComboBox, Mask,
  adLabelMaskEdit, DB, Buttons;

type
  TfmAjChaveNFe = class(TfmAjustaNumNF)
    edChNfe: TadLabelEdit;
    btObterChave: TfsBitBtn;
    procedure cbTpNovaSerieClick(Sender: TObject);

    procedure carregaChaveNota(is_nota:String);
    procedure FormCreate(Sender: TObject);
    procedure ajustaItensNaTela();
    procedure btOkClick(Sender: TObject);
    procedure btObterChaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure atualizaChaveNFE();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAjChaveNFe: TfmAjChaveNFe;

implementation

uses cf, ucf, uFiscal, uAcbr, f, uMain, msg;

{$R *.dfm}

procedure TfmAjChaveNFe.ajustaItensNaTela;
begin
   cbLoja.Visible := false;
   cbNumNovaSerie.Visible := false;
   edSerie.Visible := false;
   edNumNovo.Visible := false;
   edContNovo.Visible := false;
   edContNovo.LabelDefs.Caption := '';
   cbAlteraNumAntigo.Visible := false;
   gbNotaAnt.Visible := false;
   btOk.Visible := false;
   btCancel.Visible := false;
   cbAlteraContNovo.Visible := false;

   btOk.Top := gbNotaAnt.Top;
   btCancel.Top := gbNotaAnt.Top;

   fmAjChaveNFe.ClientHeight := btOk.Top + btOk.Width + 30;
   fmAjChaveNFe.ClientWidth:= btCancel.Left + btCancel.Width + 30;
end;

procedure TfmAjChaveNFe.carregaChaveNota(is_nota:String);
var
   ds:TdataSet;
begin
   ds:= uFiscal.getDadosNota(lbIsNota.Caption, '', '', '');

   edChNfe.Text :=  ds.fieldByName('chave_acesso_nfe').AsString;
   lbSrAnt.Caption :=  ds.fieldByName('chave_acesso_nfe').AsString;

   lbIsNota.caption := ds.fieldByName('is_nota').AsString;
   lbUo.Caption :=  ds.fieldByName('is_estoque').AsString;

   btObterChave.Enabled := ((ds.fieldByName('tipo').AsString = 'Saida') or (ds.fieldByName('tp_emis').AsString = '0') );
   btOk.Visible := true;
   btCancel.Visible := true;
   ds.free();
end;

procedure TfmAjChaveNFe.cbTpNovaSerieClick(Sender: TObject);
begin
  inherited;

  if( lbIsNota.Caption <> '') then
  begin
     ajustaItensNaTela();
     carregaChaveNota(lbIsNota.caption);
     edChNfe.SetFocus();
  end;
end;

procedure TfmAjChaveNFe.FormCreate(Sender: TObject);
begin
   lbIsNota.Caption := '';
   lbSrAnt.Caption := '';
   ajustaItensNaTela();
end;

procedure TfmAjChaveNFe.atualizaChaveNFE;
begin
   if uFiscal.salvaChaveNFe( lbIsNota.Caption, edChNfe.Text)= true then
     msg.msgExclamation('Chave Salva com Sucesso!')
   else
      msgErro('Problemas ao salvar a chave');
end;

procedure TfmAjChaveNFe.btOkClick(Sender: TObject);
begin
   if (uFiscal.isChNFeValida(edChNfe.Text) = false)  and (fmMain.isAcessoTotal(fmMain.AjustachaveNFe1.Tag) = false ) then
      msg.msgErro('A chave digitada é inválida.')
   else
   begin
      if (edChNfe.Text <> lbSrAnt.Caption) and (lbSrAnt.Caption <> '') then
      begin
         if (msg.msgQuestion('Tem certeza que deseja alterar essa chave?') = mrYes) then
            atualizaChaveNFE();
      end
      else
         atualizaChaveNFE();
   end;
end;

procedure TfmAjChaveNFe.btObterChaveClick(Sender: TObject);
var
   chNfe:String;
begin
   chNfe := uAcbr.getChaveNFeSaida( lbUo.Caption, lbIsNota.Caption);
   if ( chNfe <> '' ) then
      edChNfe.Text := chNfe;
end;

procedure TfmAjChaveNFe.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
  fmAjChaveNFe := nil;
end;


end.
