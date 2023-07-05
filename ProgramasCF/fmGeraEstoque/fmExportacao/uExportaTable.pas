unit uExportaTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Forms,
  StdCtrls, Controls, ExtCtrls;

type
  TfmExportaTable = class(TForm)
    rgDestino: TRadioGroup;
    Button1: TButton;
    rgFormato: TRadioGroup;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmExportaTable: TfmExportaTable;

implementation

{$R *.dfm}

procedure TfmExportaTable.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    action := caFree;
end;

end.
