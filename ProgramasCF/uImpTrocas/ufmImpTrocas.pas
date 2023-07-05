unit ufmImpTrocas;

interface

uses
  DB, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uImpPedForn, StdCtrls, Buttons, fCtrls, adLabelEdit, f;

type
  TfmImpTroca = class(TfmImpPedForn)
    procedure FormCreate(Sender: TObject);
    procedure btImprimeClick(Sender: TObject);
    procedure imprimeTroca(dsTroca:TdataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmImpTroca: TfmImpTroca;

implementation

	uses uTroca, uMain, fdt, uDm, msg;

{$R *.dfm}

procedure TfmImpTroca.FormCreate(Sender: TObject);
begin
//  inherited;
	btExportar.Free;
   btEmail.Free;
end;

procedure TfmImpTroca.imprimeTroca(dsTroca: TdataSet);
var
	dsEnt, dsSai:TdataSet;
begin //
	dsEnt := uTroca.getItensTroca(dsTroca.fieldByName('numTroca').asString, true);
	dsSai := uTroca.getItensTroca(dsTroca.fieldByName('numTroca').asString, false);

   fmMain.imprimeRave(dsTroca, dsEnt, dsSai, nil, nil,'rpEspelhoTroca', nil );
end;



procedure TfmImpTroca.btImprimeClick(Sender: TObject);
var
	ds:TDataSet;
begin
	if (edNumPed.Text <> '' )then
	begin
   	ds := uTroca.getTroca(edNumPed.Text, fmMain.getUoLogada());

      if (ds.IsEmpty = false) then
	      imprimeTroca(ds)
      else
      	msg.msgErro(dm.getMsg('trcErr'));
   end;
end;


procedure TfmImpTroca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  inherited;
	action := caFree;
	fmImpTroca := nil;
end;

end.
