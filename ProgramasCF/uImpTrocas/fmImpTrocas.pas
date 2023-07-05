unit ufmImpTrocas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uImpPedForn, StdCtrls, Buttons, fCtrls, adLabelEdit;

type
  TfmImpTroca = class(TfmImpPedForn)
    procedure FormCreate(Sender: TObject);
    procedure btImprimeClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmImpTroca: TfmImpTroca;

implementation

{$R *.dfm}

procedure TfmImpTroca.FormCreate(Sender: TObject);
begin
//  inherited;
	btExportar.Free;
   btEmail.Free;
end;

procedure TfmImpTroca.btImprimeClick(Sender: TObject);
var
	ds:TDataSet;
begin
	ds :=

end;

end.
