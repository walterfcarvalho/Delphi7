unit ufmLstDrvEntSaiCD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRelGeral, ADODB, DB, StdCtrls, fCtrls, ComCtrls,
  TFlatButtonUnit, adLabelComboBox, ExtCtrls, adLabelEdit;

type
  TfmLstDrvEntSaiCD = class(TfmRelGeral)
    edCodigo: TadLabelEdit;
    btExport: TFlatButton;
    cbDrivgNaoAutoriz: TfsCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btExportClick(Sender: TObject);
    procedure geraRelatorio();
    procedure cbDetAvaFornClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLstDrvEntSaiCD: TfmLstDrvEntSaiCD;

implementation

uses uEstoque, uMain, f, uDm;

{$R *.dfm}

procedure TfmLstDrvEntSaiCD.geraRelatorio;
begin
   if (cbLojas.ItemIndex = 1) then
      // expedicao
      uEstoque.listaItTransfComWMS(tbOperadores, fmMain.getUOCD(), di.Date, df.Date, cbDetAvaForn.Checked, cbDrivgNaoAutoriz.Checked, trim(edCodigo.Text) )
   else
      // internacao
      uEstoque.listaItRecComWMS(tbOperadores, fmMain.getUOCD(),di.Date, df.Date, cbDetAvaForn.Checked, cbDrivgNaoAutoriz.Checked, trim(edCodigo.Text) );
end;


procedure TfmLstDrvEntSaiCD.FormShow(Sender: TObject);
begin
   inherited;
   cbLojas.Items.Clear();
   cbLojas.Items.Add('Internação');
   cbLojas.Items.Add('Expedição');
   cbLojas.LabelDefs.Caption := 'Tipo de operação:';
   cbLojas.ItemIndex := 0;

   cbCaixas.Free();
   tbPreviaDeCaixa.Free();
   tbSangrias.free();
   tbValoresAvarias.Free();
   tbValoresAvarias_Total.Free();

   di.Date := dm.getDateBd() -1;
   df.Date := dm.getDateBd() -1;

   edCodigo.Visible := fmMain.isAcessoTotal(fmMain.ListaitensmovimentadoswellxWms1.Tag);
   cbDrivgNaoAutoriz.Visible := cbDetAvaForn.Checked;
   
   pnParam.Height := 145;

end;

procedure TfmLstDrvEntSaiCD.btOkClick(Sender: TObject);
var
   params:TStringlist;
begin
	geraRelatorio();

   if (tbOperadores.IsEmpty = false) then
   begin
      params := TStringlist.Create();

      params.Add(dateToStr(di.Date));
      params.Add(dateToStr(df.Date));
      params.Add(dm.getDataHoraBD());
      params.Add(fmMain.getNomeUsuario());
      params.Add(cbLojas.Items[cbLojas.itemIndex]);


      if (cbLojas.ItemIndex = 1) then
         params.Add('Destino')
      else
         params.Add('Nota fiscal');

      fmMain.imprimeRave(tbOperadores, nil, nil, nil, nil, 'rpItMovCD', params);
   end;
end;

procedure TfmLstDrvEntSaiCD.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  action := caFree;
  fmLstDrvEntSaiCD := nil;
end;

procedure TfmLstDrvEntSaiCD.btExportClick(Sender: TObject);
begin
	geraRelatorio();
	if (tbOperadores.IsEmpty = false) then
   	fmMain.exportaDataSetNome(tbOperadores, nil, 'conf_rastreio_WellWms.xls')
end;


procedure TfmLstDrvEntSaiCD.cbDetAvaFornClick(Sender: TObject);
begin
//  inherited;
    cbDrivgNaoAutoriz.Visible := cbDetAvaForn.Checked;
end;

end.
