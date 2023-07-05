unit uRecibo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPropostaLoja, DB, ADODB, adLabelNumericEdit, adLabelSpinEdit,
  ComCtrls, fCtrls, ExtCtrls, TFlatButtonUnit, StdCtrls, adLabelEdit,
  Grids, DBGrids, SoftDBGrid;

type
  TfmRecibo = class(TfmProposta)
    gb2: TGroupBox;
    edNota: TadLabelEdit;
    edValor: TadLabelNumericEdit;
    date: TfsDateTimePicker;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure edNovaClick(Sender: TObject);

    procedure carregaDadosVenda(isNota:String);
    procedure btImpClick(Sender: TObject);
    function getParams():Tstringlist;
    procedure FlatButton3Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRecibo: TfmRecibo;

implementation

{$R *.dfm}

uses fdt, f, uMain, uDm, uFiscal, extenso, msg;

procedure TfmRecibo.FormCreate(Sender: TObject);
begin
//  inherited;
  gb1.Enabled := true;
  gb2.Enabled := true;

  grid.Free();
  panel1.Free();
  label1.free();
  table.Free();
  edMsg.Visible := false;
end;

procedure TfmRecibo.carregaDadosVenda(isNota: String);
var
  ds:TdataSet;
begin
   ds:= uFiscal.getDadosNota(isNota);

   edValor.Value := ds.fieldByName('valor').AsFloat;
   edNota.Text := 'Nota de compra:'+trim(ds.fieldByName('serie').AsString) +  '/'+ ds.fieldByName('num').AsString;

   date.Date := ds.fieldByName('dt_emis').AsDateTime;

   carregaDadosCliente(ds.fieldByName('cd_pes').asString);
end;

procedure TfmRecibo.edNovaClick(Sender: TObject);
var
   isNota:String;
begin
   f.limparCampoform('fmRecibo');

  if (msg.msgQuestion( dm.getMsg('fmNovoRecibo')) = mrYes) then
     isNota := uFiscal.getIsNota();

   if (isNota <> '') then
      if (uFiscal.isNotaDeVenda(isNota, '', true) = true) then
         carregaDadosVenda(isNota);
end;

function TfmRecibo.getParams(): Tstringlist;
var
   params: TStringList;
begin
   params := montaRelatorio();

   params.Add(edValor.Text); {18}
   params.Add(extenso.getExtenso( edValor.Value));{19}
   params.Add(edNota.Text); {20}
   params.add(fdt.dataPorExtenso(date.Date)); {21}

   result := params;
end;

procedure TfmRecibo.btImpClick(Sender: TObject);
begin
   fmMain.imprimeRave(nil, nil, nil, nil, nil, 'rpRecibo', getParams());
end;


procedure TfmRecibo.FlatButton3Click(Sender: TObject);
var
   arq:String;
begin
   arq := f.getDirLogs + 'rpRecibo.pdf';
   fmMain.impressaoRavePDF(nil, nil, 'rpRecibo', getParams(), arq );
   fmMain.enviarEmail('', 'Envio de recibo' + arq , arq, nil, 'Enviando e-mail para cliente...' );
end;

end.
