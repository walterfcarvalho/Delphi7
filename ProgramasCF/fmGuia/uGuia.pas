unit uGuia;

interface

uses
  Windows,  db, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, ExtCtrls, Grids, DBGrids, SoftDBGrid,
  ADODB, adLabelEdit;

type
  TfmGuia = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    lbLoja: TLabel;
    Label5: TLabel;
    lbNota: TLabel;
    lbIsNota: TLabel;
    lbUo: TLabel;
    lbSrAnt: TLabel;
    Label2: TLabel;
    cbTpNovaSerie: TFlatButton;
    btImp: TFlatButton;
    edMsg: TadLabelEdit;
    procedure cbTpNovaSerieClick(Sender: TObject);
    procedure carregaDadosNota(isNota:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btImpClick(Sender: TObject);
    procedure imprimeGuia();
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmGuia: TfmGuia;

implementation

{$R *.dfm}
uses uFiscal, uDm, uMain, f, uUsuarios;

procedure TfmGuia.carregaDadosNota(isNota: String);
var
   ds:TdataSet;
begin
   ds:= uFiscal.getDadosNota(isNota, '', '', '');
   lbLoja.Caption :=   ds.fieldByName('loja').asString;
   lbLoja.Visible:= true;
   lbNota.caption := trim(ds.fieldByName('serie').asString) +'/'+ ds.fieldByName('num').asString;
   lbNota.Visible := true;

   edMsg.Text := ds.fieldByName('observacao').asString;
   edMsg.Visible := true;

   lbIsNota.Caption := ds.fieldByName('is_nota').asString;
   lbIsNota.Visible := true;
end;

procedure TfmGuia.cbTpNovaSerieClick(Sender: TObject);
var
  isNota:String;
begin
   isNota := uFiscal.getIsNota();
   if (isNota <> '') then
      if (uFiscal.isNotaDeVenda(isNota, '', true) = true) then
        carregaDadosNota(isnota)
end;

procedure TfmGuia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := cafree;
  if (fmGuia <> nil) then
     fmGuia := nil;
end;

procedure TfmGuia.imprimeGuia();
var
  dsPessoa, dsNota:TdataSet;
  params:TStringlist;
begin
   if (edMsg.Text <> '') then
      uFiscal.setObsNota(edMsg.Text, lbIsNota.caption);

   dsNota :=  uFiscal.getDadosNota(lbIsNota.caption);
   dsPessoa := uUsuarios.getDadosPessoa(dsNota.fieldByName('cd_pes').AsString);

   params := TStringList.Create();
   params.add(uFiscal.getVendedorDaNota(lbIsNota.caption));
   params.add(  fmMain.getStrLogoEmpresa() );

   f.gravaLog(dsNota, 'DataSet DadosNota');
   f.gravaLog(dsPessoa, 'DataSet Pessoa');

   fmMain.imprimeRave(dsNota, dsPessoa, nil, nil, nil, 'rpGuiaEntrega', params);

end;

procedure TfmGuia.btImpClick(Sender: TObject);
begin
   if (lbNota.Caption <> '') then
      imprimeGuia();
end;


procedure TfmGuia.FormCreate(Sender: TObject);
begin
  lbIsNota.Caption := '';
end;

end.

