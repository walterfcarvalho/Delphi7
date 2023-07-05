unit uLsdDrvgWellWms;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRRANA, ADODB, DB, StdCtrls, fCtrls, ComCtrls, TFlatButtonUnit,
  adLabelComboBox, ExtCtrls, adLabelEdit;

type
  TfmLsdDrvgWellWms = class(TfmRelGeral1)
    edCod: TadLabelEdit;
    btExport: TFlatButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure geraRelDrvgWellWms();
    procedure FormCanResize(Sender: TObject; var NewWidth,NewHeight: Integer; var Resize: Boolean);
    function podeGerar():boolean;
    procedure btExportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLsdDrvgWellWms: TfmLsdDrvgWellWms;

implementation

uses uRelGeral, uEstoque, uWms, uMain, udm, msg, f;

{$R *.dfm}

procedure TfmLsdDrvgWellWms.FormCreate(Sender: TObject);
begin
   inherited;
   GroupBox1.Free();
   cbCaixas.Free();
   qr.free();
   tbValoresAvarias.Free();
   tbValoresAvarias_Total.free();
   tbPreviaDeCaixa.Free();
   tbTotRec.Free();
   tbSangrias.Free();
   tbVendasCartao.Free();
   cbDetAvaForn.Free();
   cbCaixas.Free();
   cbLojas.Width := 200;

   cbLojas.Items.Add('Todos os divergentes');
   cbLojas.Items.Add('Negativos no Well');
   cbLojas.Items.Add('Negativos no WMS');
   cbLojas.ItemIndex := 0;
   edCod.LabelDefs.Caption := 'Faixa de código';
end;

procedure TfmLsdDrvgWellWms.FormShow(Sender: TObject);
begin
//	cbDetAvaForn.Visible := true;
//  inherited;
end;

procedure TfmLsdDrvgWellWms.geraRelDrvgWellWms;
var
   param:Tstringlist;
   gera:boolean;
begin
//   f.gravaLog(tbOperadores, 'tb divergencia');

   if (tbOperadores.IsEmpty = false )then
   begin
      param := TStringlist.Create();
      param.Add(cbLojas.Items[cblojas.itemIndex]);
      param.Add(fmMain.getNomeUsuario());
      param.Add(dm.getDataHoraBD() );

      fmMain.imprimeRave(tbOperadores, nil, nil, nil, nil, 'rpDirvgWellWms', param);
      param.Free();

   end
   else
      msg.msgExclamation(dm.getMsg('SEM_ITEM'));

   tbOperadores.close;
end;

function TfmLsdDrvgWellWms.podeGerar: boolean;
var
   gera:boolean;
begin
   gera := true;
   if (edCodigo.Text = '') and (cbLojas.ItemIndex = 0) then
		if ( msg.msgQuestion(dm.getMsg('MSG_DEMORA')) = mrNo) then
			gera := false;
	result := gera;         
end;

procedure TfmLsdDrvgWellWms.btOkClick(Sender: TObject);
begin
   if (podeGerar() = true) then
   begin
	   uWms.listaDrvWellWms(tbOperadores, edCod.Text, cbLojas.Itemindex);
      geraRelDrvgWellWms();
   end;
end;

procedure TfmLsdDrvgWellWms.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := Cafree;
  fmLsdDrvgWellWms := nil;
end;

procedure TfmLsdDrvgWellWms.FormActivate(Sender: TObject);
begin
//  inherited;
   self.WindowState := wsNormal;
   self.Refresh();
   self.Width := 755;
   self.Height := 300;
end;


procedure TfmLsdDrvgWellWms.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
//  inherited;

end;


procedure TfmLsdDrvgWellWms.btExportClick(Sender: TObject);
begin
   if (podeGerar() = true) then
   begin
	   uWms.listaDrvWellWms(tbOperadores, edCod.Text, cbLojas.Itemindex);
      fmMain.exportaDataSet(tbOperadores, nil);
	end;
end;

end.
