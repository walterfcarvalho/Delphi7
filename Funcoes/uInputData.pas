unit uInputData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, fCtrls, StdCtrls, Buttons;

type
  TfmInputData = class(TForm)
    dt: TfsDateTimePicker;
    btOk: TfsBitBtn;
    btCancel: TfsBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmInputData: TfmInputData;

implementation

{$R *.dfm}

end.
