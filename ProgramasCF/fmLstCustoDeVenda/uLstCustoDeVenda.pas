unit uLstCustoDeVenda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, fCtrls, adLabelComboBox, TFlatButtonUnit;

type
  TfmLstCustoDeVenda = class(TForm)
    cbLojas: TadLabelComboBox;
    datai: TfsDateTimePicker;
    dataf: TfsDateTimePicker;
    Label2: TLabel;
    btOk: TFlatButton;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLstCustoDeVenda: TfmLstCustoDeVenda;

implementation
uses ulj, uMain, f, msg, uProd, uDm;

{$R *.dfm}

procedure TfmLstCustoDeVenda.FormCreate(Sender: TObject);
begin
   uLj.getListaLojas(cbLojas, false, false, '', '', '');
   datai.Date := now;
   dataf.Date := now;

   self.Width := 550;
   self.Height:= 130;
end;

procedure TfmLstCustoDeVenda.btOkClick(Sender: TObject);
begin
   if (cbLojas.ItemIndex >=0) and (dataf.Date >= datai.Date) then
      uProd.listaCustoDeVendidos(f.getCodUO(cbLojas), datai.Date, dataf.date)
   else
      msg.msgErro( dm.getMsg('MSG_ERR_LJ') );
end;

procedure TfmLstCustoDeVenda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   Action := caFree;
   fmLstCustoDeVenda := nil;
end;

end.
