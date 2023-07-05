unit uRelPedForn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRelGeral, ADODB, DB, StdCtrls, fCtrls, ComCtrls,
  TFlatButtonUnit, adLabelComboBox, ExtCtrls;

type
  TfmRelPedForn = class(TfmRelGeral)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRelPedForn: TfmRelPedForn;

implementation

uses uReqEmSeparacao;

{$R *.dfm}

procedure TfmRelPedForn.FormCreate(Sender: TObject);
begin
//  inherited;
   cbDetAvaForn.Destroy();
   tbPreviaDeCaixa.Destroy();
   tbOperadores.Destroy();
   tbTotRec.Destroy();
   tbSangrias.Destroy();
   tbVendasCartao.Destroy();
   tbValoresAvarias.Destroy();
   qr.Destroy();
//   tbValoresAvarias.Destroy();
end;

procedure TfmRelPedForn.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//  inherited;
   action := caFree;
   fmReqEmSeparacao := nil;
end;

end.
