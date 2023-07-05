unit uTotalEntSai;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DB;

type
  TfmTotalEntSai = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    lbPrimEnt: TLabel;
    Label5: TLabel;
    lbTotEnt: TLabel;
    Label6: TLabel;
    lbTotVenda: TLabel;
    Bevel1: TBevel;
    lbDados: TLabel;
    lbEntSaiTotal: TLabel;
    lbMsgEntSai: TLabel;

  procedure calculaTotalEntSai(is_ref, uo, uo_cd:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTotalEntSai: TfmTotalEntSai;

implementation

{$R *.dfm}

uses uMain, uCF, f, uEstoque, uProd;

{ TfmTotalEntSai }


procedure TfmTotalEntSai.calculaTotalEntSai(is_ref, uo, uo_cd: String);
var
   ds:TdataSet;
   dataI:Tdate;
   strTotSaida:String;
   totEnt, totSai:Real;
begin
   if (lbDados.Caption = '') then
   begin
      ds:= uProd.getDadosProd( uo_cd, '', is_ref, '101', false);
      lbDados.Caption := ds.fieldByName('codigo').AsString + '  '+
                         ds.fieldByName('descricao').AsString;
      ds.free();
   end;

// parte das entradas
   ds:= uEstoque.getEntradasPorItem(is_ref, '', strToDate('01/01/2001'), now, false, true);

   if (ds.isEmpty = false) then
   begin
      lbPrimEnt.Caption := uProd.getDataEntrada(ds, 'P');
      lbTotEnt.Caption :=  uEstoque.getTotalDeEntradasProduto(ds, true);

      totEnt :=  strtoFloat(uEstoque.getTotalDeEntradasProduto(ds, false)) ;
   end
   else
   begin
      lbTotEnt.caption := '00000000';
      lbPrimEnt.Caption := 'Não há';
   end;

// saidas
   datai:= strToDate('01/01/2000');
   strTotSaida := uEstoque.getVendaProduto(is_ref, uo, UO_CD, dataI, now);
   lbTotVenda.Caption:= floatTostrf( strToFloat(strTotSaida), ffnumber, 18, 02);

   totSai := strToFloat(strTotSaida);

   lbEntSaiTotal.caption := floatTostrf( (totEnt - totSai), ffnumber, 18, 02);


   if ( (totEnt - totSai) > 0) then
   begin
      lbEntSaiTotal.font.Color := clRed;
      lbMsgEntSai.Caption := 'Saldo de entradas';
   end
   else
   begin
      lbEntSaiTotal.font.Color := clBlue;
      lbMsgEntSai.Caption := 'Saldo de saídas';
   end;


   ds.Free();


end;
procedure TfmTotalEntSai.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    action := caFree;
    fmTotalEntSai:= nil;
end;

end.
