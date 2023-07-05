unit uResumoECF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, ComCtrls, adLabelComboBox, Grids,
  DBGrids, SoftDBGrid, DB;

type
  TfmResumoECF = class(TForm)
    cbLojas: TadLabelComboBox;
    datai: TfsDateTimePicker;
    cbECF: TadLabelComboBox;
    fsBitBtn3: TfsBitBtn;
    DataSource1: TDataSource;
    SoftDBGrid1: TSoftDBGrid;
    fsBitBtn1: TfsBitBtn;
    procedure fsBitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure getCodEcfReducoesDia();
    procedure cbLojasClick(Sender: TObject);
    procedure dataiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmResumoECF: TfmResumoECF;
  ds:TdataSet;
implementation
{$R *.dfm}
uses uMain, uCF, f, fdt, uDm, uLj;

procedure TfmResumoECF.fsBitBtn3Click(Sender: TObject);
begin
//   ds:= uCF.listaCuponsPorLojaData( f.getCodUO(cbLojas), f.getCodUO(cbECF), datai.Date, datai.Date);

   DataSource1.DataSet := ds;
end;

procedure TfmResumoECF.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    Action := CaFree;
    fmResumoECF := nil;
end;

procedure TfmResumoECF.FormActivate(Sender: TObject);
begin
   uLj.getListaLojas( cbLojas, false, false, fmMain.getCdPesLogado(), fmMain.getUoLogada() );
   datai.Date := now;
   getCodEcfReducoesDia();   
end;

procedure TfmResumoECF.fsBitBtn1Click(Sender: TObject);
begin
   fmMain.imprimeRave(ds, nil, nil, nil, nil, 'rpProCuponsDia', nil);
end;

procedure TfmResumoECF.getCodEcfReducoesDia;
var
   ds: TdataSet;
   cmd:String;
begin
   cbECF.Items.clear();
   cmd :=  'Select nr_ecf, ser_fab from reducaoz where ' +
           'is_uo= '+ f.getCodUO(cbLojas) +
           ' and dt_mov= ' + fdt.dateToSqlDate(datai.Date);
   ds:= dm.getDataSetQ(cmd);

   ds.First();
   while ( ds.Eof = false ) do
   begin
      cbECF.Items.Add(
         f.preencheCampo(50,' ', 'D', ds.fieldByName('nr_ecf').asString) +
         ds.fieldByName('ser_fab').asString
      );
      ds.Next();
   end;
//   cbEcf.Items.SaveToFile('c:\teste.txt');
   ds.free();
end;

procedure TfmResumoECF.cbLojasClick(Sender: TObject);
begin
   getCodEcfReducoesDia();
end;

procedure TfmResumoECF.dataiClick(Sender: TObject);
begin
   getCodEcfReducoesDia();
end;

end.
