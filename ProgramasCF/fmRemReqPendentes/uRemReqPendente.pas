unit uRemReqPendente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRRANA, ADODB, DB, ExtCtrls, StdCtrls, fCtrls, ComCtrls,
  TFlatButtonUnit, adLabelComboBox, adLabelEdit;

type
  TfmRemItensSep = class(TfmRelGeral1)
    procedure btOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRemItensSep: TfmRemItensSep;

implementation

uses uDm, uReq, f, msg, uMain, uLj, uRelGeral, DateUtils;

{$R *.dfm}

procedure TfmRemItensSep.btOkClick(Sender: TObject);
var
   ds:Tdataset;
begin
//   ds := uReq.getReqPendPorDataOS(f.getCodUO(cbLojas), di.Date, df.Date);

   DS := uReq.getReqPorItem('', f.getCodUO(cbLojas), di.Date, df.Date, true, edCodigo.Text, fmMain.getUOCD(), '');

   if (ds.IsEmpty = true) then
     msg.msgErro(dm.getMsg('wms_SemItensPendentes'))
   else
      if ( msg.msgQuestion(dm.getMsg('wms_RemReqPend')) = mrYes) then
      begin
         ureq.removeReqPendentes(ds);
         msg.msgExclamation(dm.getMsg('MSG_FIM'));
      end;
   ds.free();
end;

procedure TfmRemItensSep.FormShow(Sender: TObject);
begin
	inherited;
   uLj.getListaLojas(cbLojas, true, false, '', fmMain.getUoLogada(), fmMain.getUOCD());
   edCodigo.Free();
end;

procedure TfmRemItensSep.FormCreate(Sender: TObject);
begin
  inherited;

	if (fmMain.isAcessoTotal(fmMain.Cancelarrequisiespendentes1.Tag) = true) then
		QT_DIAS_INTERV_DATA := 99999
	else
		QT_DIAS_INTERV_DATA := 31;
end;

procedure TfmRemItensSep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  inherited;
	action := caFree;
   fmRemItensSep := nil;
end;

end.
