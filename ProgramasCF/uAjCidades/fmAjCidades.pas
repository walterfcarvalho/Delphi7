unit fmAjCidades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, Buttons, fCtrls, adLabelComboBox,
  TFlatButtonUnit, ExtCtrls, Db;

type
  TForm1 = class(TForm)
    edUF: TadLabelEdit;
    btUF: TfsBitBtn;
    edCidade: TadLabelEdit;
    procedure btUFClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses uBuscasDiversas;

procedure TForm1.btUFClick(Sender: TObject);
begin
   uBuscasDiversas.pegarDadosCampo('UF', 

end;

end.
