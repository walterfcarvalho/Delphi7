unit uCriaReqFromPed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, DB, ADODB,
  uExportaPedido, StdCtrls, adLabelEdit, adLabelComboBox, Dialogs;


type
  TfmCriaReqFromPed = class(TfmExportaPedido)
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCriaReqFromPed: TfmCriaReqFromPed;

implementation

uses uLj, uPedCliente, uDm, uReq, f, uMain;

{$R *.dfm}

procedure TfmCriaReqFromPed.FormShow(Sender: TObject);
begin
   Self.Width := 500;
   self.Height:= 200;
   self.Caption := 'Gerar requisição a partir de pedido de cliente';
   cbPreco02.Visible := false;
   cbPreco02.LabelDefs.Caption := 'Depósito';
   uLj.getComboBoxLjMapa(cbPreco01);
end;

procedure TfmCriaReqFromPed.Button1Click(Sender: TObject);
begin
//  inherited;
   uReq.reqFromPedCliente(f.getCodUO(cbPreco01), edCodigo.Text, fmMain.getUserLogado());
end;

procedure TfmCriaReqFromPed.FormCreate(Sender: TObject);
begin
  inherited;
  self.Caption := dm.getMsg('fmCriaReqFromPed.caption');
end;

procedure TfmCriaReqFromPed.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   fmCriaReqFromPed := nil;
end;

end.
