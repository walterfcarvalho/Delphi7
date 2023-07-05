unit uReqEmSeparacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRelGeral, Grids, DBGrids, SoftDBGrid, ADODB, DB, StdCtrls,
  fCtrls, ComCtrls, TFlatButtonUnit, adLabelComboBox, ExtCtrls, adLabelEdit;

type
  TfmReqEmSeparacao = class(TfmRelGeral)
    DS: TDataSource;
    edCodigo: TadLabelEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure listaItensEmSeparacao();
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmReqEmSeparacao: TfmReqEmSeparacao;
  isAcessoRestrito:boolean;
implementation

uses uMain, f, cf, ucf, uDm, uEstoque, uLj, msg, uReq, fdt;

{$R *.dfm}

procedure TfmReqEmSeparacao.listaItensEmSeparacao;
var
   params: TstringList;
begin
   DS.DataSet := uReq.getReqPorItem('', f.getCodUO(cbLojas), di.Date, df.Date, true, edCodigo.Text, f.getCodUO(cbCaixas), '');

   if  (DS.DataSet.IsEmpty = false) then
   begin
      params := TStringList.create();
      params.Add( dateToStr(di.date));
      params.Add( dateToStr(df.date));
      params.add( dm.getDataHoraBD());
      params.Add( fmMain.getNomeUsuario());
      fmMain.imprimeRave(DS.DataSet, nil, nil, nil, nil, 'rpItensEmSeparacao', params);
  end
  else
     msg.msgErro(dm.getMsg('wms_SemItensPendentes'));
end;

procedure TfmReqEmSeparacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
   fmReqEmSeparacao := nil;
end;

procedure TfmReqEmSeparacao.btOkClick(Sender: TObject);
var
  podeExecutar:boolean;
begin
   podeExecutar := true;

   if ( fdt.isIntervDataValido(di , df, true) = false ) and ( isAcessoRestrito = true) then
      podeExecutar := false;

   if ( podeExecutar = true) then
      listaItensEmSeparacao();
end;

procedure TfmReqEmSeparacao.FormCreate(Sender: TObject);
begin
   qr.Destroy();
   tbPreviaDeCaixa.Destroy();
   tbSangrias.Destroy();
   tbTotRec.Destroy();
   tbValoresAvarias.Destroy();
   tbValoresAvarias_Total.Destroy();
   tbVendasCartao.Destroy();
   cbDetAvaForn.Destroy();


   isAcessoRestrito:= fmMain.isGrupoRestrito(fmMain.ListaItensemseparaonoCD1.Tag);
   fmReqEmSeparacao.Caption := fmMain.getCaptionNivelAcesso(fmReqEmSeparacao.Caption, isAcessoRestrito);

   cbLojas.Items.Clear();

   uLj.getListaLojas( cbLojas, true, false, fmMain.getCdPesLogado(), fmMain.getUoLogada() );
   ulj.getComboBoxLjMapa(cbCaixas);

   if (fmMain.isAcessoTotal(fmMain.ListaItensemseparaonoCD1.Tag) = true) then
		QT_DIAS_INTERV_DATA := 99999
   else
		QT_DIAS_INTERV_DATA := 31;

end;

procedure TfmReqEmSeparacao.FormShow(Sender: TObject);
begin
  inherited;
   uLj.getListaLojas( cbLojas, true, false, fmMain.getCdPesLogado(), fmMain.getUoLogada() );
end;

end.
