unit uNovaProposta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, ExtCtrls, StdCtrls, adLabelComboBox,
  adLabelEdit;

type
  TfmNovaProposta = class(TForm)
    cbPreco: TadLabelComboBox;
    pnConfirma: TPanel;
    BitBtn1: TFlatButton;
    btCancela: TFlatButton;
    edNumPedido: TadLabelEdit;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btCancelaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmNovaProposta: TfmNovaProposta;
implementation

uses uPropostaLoja, umain, uDm, cf, funcSQL, f, msg, uPreco;
{$R *.dfm}

procedure TfmNovaProposta.FormShow(Sender: TObject);
begin
   cbPreco.Items := uPreco.getListaPrecos(false, false, false, fmMain.getGrupoLogado() );
end;

procedure TfmNovaProposta.BitBtn1Click(Sender: TObject);
begin
   if (cbpreco.ItemIndex > -1 ) then
   begin
      fmProposta.CriarTabelaProposta(Sender);
      preco:= f.SohNumeros(f.getCodUO(cbPreco));

      if edNumPedido.Text <> '' then
         fmProposta.ImportaDadosPedido(sender, edNumPedido.Text);

      fmProposta.gb1.Enabled := true;
      btCancelaClick(Sender);

   end
   else
      msg.msgErro('Escolha o Preço para inciar a proposta. ');
end;

procedure TfmNovaProposta.btCancelaClick(Sender: TObject);
begin
   fmNovaProposta.Close;
end;

procedure TfmNovaProposta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := CaFree;
end;

end.
