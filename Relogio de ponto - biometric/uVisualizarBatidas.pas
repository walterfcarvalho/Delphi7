unit uVisualizarBatidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, fCtrls, fdt, uUtil;

type
  TfmVisbatidas = class(TForm)
    GroupBox3: TGroupBox;
    dti: TfsDateTimePicker;
    BitBtn7: TBitBtn;
    ListBox: TListBox;
    Label1: TLabel;
    procedure BitBtn7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmVisbatidas: TfmVisbatidas;
implementation

uses RelogioPonto, uConsultarBatidas, uBatida;

{$R *.dfm}

procedure TfmVisbatidas.BitBtn7Click(Sender: TObject);
var
  bat:TstringList;
  i:integer;
begin
   ListBox.Items.Clear;
   ListBox.Items.Add('Batidas do dia: ' + dateToStr(dti.date) +'  '+fdt.getDescricaoDia(dti.Date,true));
   ListBox.Items.Add('------------------------------');
   screen.Cursor := crHourGlass;
   bat := TStringList.Create;
   bat :=  uBatida.getBatidas( dateToStr(dti.Date), dateToStr(dti.Date), label1.Caption );

   for i:=0 to bat.Count -1 do
      ListBox.Items.Add(copy(bat[i],12,05) + '  -  Loja: ' + copy(bat[i],30,05)  );

   screen.Cursor := crDefault;
end;

procedure TfmVisbatidas.FormCreate(Sender: TObject);
begin
   fmVisbatidas.top := fmBatidas.top;
end;

procedure TfmVisbatidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
   fmVisbatidas := nil;
end;

end.
