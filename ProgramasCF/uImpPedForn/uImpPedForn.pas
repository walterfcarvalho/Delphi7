unit uImpPedForn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, Buttons, fCtrls;

type
  TfmImpPedForn = class(TForm)
    edNumPed: TadLabelEdit;
    btImprime: TfsBitBtn;
    btExportar: TfsBitBtn;
    btEmail: TfsBitBtn;
    procedure edNumPedKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btImprimeClick(Sender: TObject);
    procedure chamaImprPedForn(destino:char);
    procedure btExportarClick(Sender: TObject);
    procedure btEmailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmImpPedForn: TfmImpPedForn;

implementation

   uses f, uPedFornecedor;


{$R *.dfm}

procedure TfmImpPedForn.edNumPedKeyPress(Sender: TObject; var Key: Char);
begin
   if (f.isLetra(key) = true) then
      key := #0;
end;

procedure TfmImpPedForn.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   fmImpPedForn := nil;
end;

procedure TfmImpPedForn.chamaImprPedForn(destino:char);
begin
   if (edNumPed.Text <> '') then
      uPedFornecedor.impPedFornecedor(edNumPed.Text, destino);
end;

procedure TfmImpPedForn.btImprimeClick(Sender: TObject);
begin
   chamaImprPedForn('P');
end;

procedure TfmImpPedForn.btExportarClick(Sender: TObject);
begin
   chamaImprPedForn('E');
end;

procedure TfmImpPedForn.btEmailClick(Sender: TObject);
begin
   chamaImprPedForn('M');
end;

end.
