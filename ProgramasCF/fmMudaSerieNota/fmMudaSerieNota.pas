unit fmMudaSerieNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, adLabelComboBox, TFlatButtonUnit, DB, fCtrls;

type
  TfmAjustaSerie = class(TForm)
    cbLoja: TadLabelComboBox;
    Panel1: TPanel;
    cbTipoSerie: TadLabelComboBox;
    btOk: TFlatButton;
    FlatButton1: TFlatButton;
    ckTAlteraTodas: TfsCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure consultaTipoEmissaoNota();
    procedure cbLojaChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FlatButton1Click(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure direcionaUmaLoja();
    procedure direcionaTodasLojas();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAjustaSerie: TfmAjustaSerie;

implementation

uses uMain, uAcbr, f, funcSQL, uCF, uDm, uLj, msg;

{$R *.dfm}

procedure TfmAjustaSerie.FormActivate(Sender: TObject);
begin
   uLj.getListaLojas(cbLoja, false, false, '', fmMain.getUoLogada());
   cbLoja.ItemIndex := -1;
end;


procedure TfmAjustaSerie.cbLojaChange(Sender: TObject);
begin
   consultaTipoEmissaoNota();
end;

procedure TfmAjustaSerie.consultaTipoEmissaoNota;
var
   srNormal, srCont, cmd:String;
   ds:TDataSet;
begin
   srNormal := dm.getParamBD('ServerNFE.SrNfe', f.getCodUO(cbLoja));
   srCont := dm.getParamBD('ServerNFE.SrNfeCont', f.getCodUO(cbLoja));
   cmd :=
   ' select sr_nf from topsef  where  sq_opf in( select sq_opf  from topi where ds_res like ''nf%'') '+
   ' and  is_loja= ' + f.getCodUO(cbLoja) ;
   ds:= dm.getDataSetQ(cmd);

   ds.First();
   if (ds.FieldByName('sr_nf').AsString = srNormal) then
     cbTipoSerie.ItemIndex := 0
   else    if (ds.FieldByName('sr_nf').AsString = srCont) then
     cbTipoSerie.ItemIndex := 1
   else
     cbTipoSerie.ItemIndex := -1;
   panel1.Visible:= true;
end;



procedure TfmAjustaSerie.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   fmAjustaSerie := nil;
end;

procedure TfmAjustaSerie.btOkClick(Sender: TObject);
begin
   panel1.Visible := false;
   cbTipoSerie.ItemIndex := -1;
   cbLoja.ItemIndex := -1;
end;

procedure TfmAjustaSerie.direcionaUmaLoja();
begin
   fmMain.msgStatus('Enviando comando para o ACBR da loja:' + uLj.getNomeUO(cbLoja));
   uAcbr.redirectAutorizadorNFE( f.getCodUO(cbLoja), (cbTipoSerie.ItemIndex = 1) );
end;

procedure TfmAjustaSerie.direcionaTodasLojas;
var
   i:integer;
begin
   for i:=0 to cbLoja.Items.Count -1 do
   begin
      cbLoja.ItemIndex := i;
      direcionaUmaLoja();
   end;
end;

procedure TfmAjustaSerie.FlatButton1Click(Sender: TObject);
begin
   msg.msgWarning('Essa alteração só vai funcionar depois da estação na loja '+ 'na próxima vez que a estação que emite a nota entrar no well');
   screen.Cursor := crHourGlass;
   if (ckTAlteraTodas.Checked = true) then
      direcionaTodasLojas()
   else
      direcionaUmaLoja();

   btOkClick(nil);

   screen.Cursor := crDefault;
end;


end.
