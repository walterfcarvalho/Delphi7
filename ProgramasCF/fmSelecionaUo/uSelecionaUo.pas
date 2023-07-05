unit uSelecionaUo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, Buttons, fCtrls, DB, ADODB, Grids,
  DBGrids, SoftDBGrid;

type
  TfmSelecionaUo = class(TForm)
    cbLojas: TadLabelComboBox;
    btIncluiXML: TfsBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSelecionaUo: TfmSelecionaUo;

implementation

//uses uCF;

{$R *.dfm}

{ TfmSelecionaUo }

{ TfmSelecionaUo }

procedure TfmSelecionaUo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
end;

end.
