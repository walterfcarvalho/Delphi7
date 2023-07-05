unit uCargaVendas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, adLabelNumericEdit, adLabelSpinEdit, StdCtrls, adLabelEdit,
  adLabelMemo, Mask, adLabelMaskEdit, ExtCtrls, Buttons;

type
  TfmCargaVendas = class(TForm)
    Panel1: TPanel;
    memo: TadLabelMemo;
    Timer1: TTimer;
    Panel2: TPanel;
    edDtUltCarga: TadLabelEdit;
    edHoraCarga: TadLabelMaskEdit;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure efetuaCargaDeVenda();
    procedure log(msg:String);
    procedure getDadosUltimaCarga();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure startCargaDeVendas();
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCargaVendas: TfmCargaVendas;
  msg:String;
  i:smallint;
implementation

uses uMain, cf, f, uDm;

{$R *.dfm}

procedure TfmCargaVendas.getDadosUltimaCarga;
begin
   edHoraCarga.Text := dm.getParamBD('comum.horaCargaVendas', '');
   edDtUltCarga.Text := cf.getDataUltCargaVendas();
end;

procedure TfmCargaVendas.log(msg:String);
begin
   memo.Lines.add(msg);
   f.gravaLog(msg);
end;

procedure TfmCargaVendas.FormActivate(Sender: TObject);
begin
   msg := '-\|/';
   i:= 0;
   getDadosUltimaCarga();
end;

procedure TfmCargaVendas.Timer1Timer(Sender: TObject);

begin
   inc(i);
   fmMain.StatusBar1.Panels[3].Text := msg[i];

   if ( i = Length(msg)) then
      i:= 0 ;

   if (copy(timeToStr(now), 01, 05) = edHoraCarga.text) then
      startCargaDeVendas();
end;

procedure TfmCargaVendas.efetuaCargaDeVenda;
var
  dti, dtf:Tdate;
  insereDadosNoBd:boolean;
begin
   insereDadosNoBd:= true;

   getDadosUltimaCarga();

   dti :=  strToDate(edDtUltCarga.Text);
   dtf :=  strToDate(edDtUltCarga.Text);

//   while (dti < dtf-1) do
   begin
      log('');
      log('');
      log('Carga de dados do dia: '+ dateToStr(dti) );
      log('----------------------------------------------------');

      cf.cargaVendas_Entradas_remove('cpr', true, dti);
      log('Obtendo entradas de fornecedor('+ dateToStr(dti) +')');
      cf.cargaVendas_entradas('cpr', insereDadosNoBd, dti);

      cf.cargaVendas_Entradas_remove('Transferencias', true, dti);
      log('Obtendo entradas de por transferencia('+ dateToStr(dti) +')');
      cf.cargaVendas_entradas('Transferencia', insereDadosNoBd, dti);

      cf.cargaVendas_Saidas_remove(insereDadosNoBd, dti);

      log('Obtendo devolucoes de cliente(' + dateToStr(dti) +')');
      cf.cargaVendas_saidas('Devolucoes', insereDadosNoBd, dti);

      log('Obtendo vendas para cliente('+ dateToStr(dti) +')');
      cf.cargaVendas_saidas('Vendas', insereDadosNoBd, dti);

      log('----------------------------------------------------');
      log('');

      dti := dti +1;
   end;
end;

procedure TfmCargaVendas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   fmCargaVendas:= nil;
end;


procedure TfmCargaVendas.startCargaDeVendas;
begin
    Timer1.Enabled := false;
    efetuaCargaDeVenda();
    Timer1.Enabled := true;
end;

procedure TfmCargaVendas.BitBtn1Click(Sender: TObject);
begin
   startCargaDeVendas();
end;

end.
