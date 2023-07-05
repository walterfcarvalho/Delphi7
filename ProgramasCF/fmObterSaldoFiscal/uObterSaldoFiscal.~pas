unit uObterSaldoFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, Spin, StdCtrls, Mask, adLabelComboBox, DB,
  ADODB, Grids, DBGrids, SoftDBGrid;

type
  TfmObterSaldoFiscal = class(TForm)
    cbLoja: TadLabelComboBox;
    GroupBox2: TGroupBox;
    edMesAno: TMaskEdit;
    SpinButton1: TSpinButton;
    FlatButton1: TFlatButton;
    tb: TADOTable;
    DataSource1: TDataSource;
    SoftDBGrid1: TSoftDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure criarTabela();
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmObterSaldoFiscal: TfmObterSaldoFiscal;

implementation

uses uMain, uCF, funcSQL, f, fdt, uDm, uLj;

{$R *.dfm}

procedure TfmObterSaldoFiscal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   f.salvaCampos(fmObterSaldoFiscal);
   fmObterSaldoFiscal := nil;
   action := caFree;
end;

procedure TfmObterSaldoFiscal.criarTabela();
var
   cmd:String;
begin
   fmMain.MsgStatus('Selecionando produtos no cadastro de produtos...');
   cmd := ' is_ref int, entradas int, saidas int, saldoFim int, custo money ';

   if (tb.TableName <> '' )then
      tb.close;

   dm.getTable(tb, cmd);

   tb.close();


   cmd :=  'insert ' + tb.TableName +
           ' select is_ref, 0, 0, 0, 0 from crefe order by is_ref';
   dm.execSQL(cmd);
   
   tb.Open();
end;

procedure TfmObterSaldoFiscal.SpinButton1DownClick(Sender: TObject);
begin
   edMesAno.Text:= fdt.ajustaDataMes(edMesAno.Text, '-');
end;

procedure TfmObterSaldoFiscal.SpinButton1UpClick(Sender: TObject);
begin
   edMesAno.Text:= fdt.ajustaDataMes(edMesAno.text, '+');
end;

procedure TfmObterSaldoFiscal.FormCreate(Sender: TObject);
begin
   fmMain.getParametrosForm(fmObterSaldoFiscal);
   uLj.getListaLojas(cbLoja, false, false, fmMain.getCdPesLogado(), fmMain.getUoLogada() );
end;

procedure TfmObterSaldoFiscal.FlatButton1Click(Sender: TObject);
var
   ds:TdataSet;
   uo, mes, cmd:String;

begin
   mes := fdt.getDatePart('a',strTodate('01/'+ edMesAno.text )) + fdt.getDatePart('m', strTodate('01/'+ edMesAno.text ) );
   uo := f.getCodUO(cbLoja);

   criarTabela();
   tb.First();

   while (tb.Eof = false) do
   begin
      fmMain.MsgStatus('Obtendo saldo do produto: ' + intToStr(tb.RecNo) +' de '+ intToStr(tb.RecordCount) );
      cmd := ' Select top 01 * from zcf_saldoFiscal (nolock) where is_uo = ' +
             f.getCodUO(cbLoja)  + ' and ' +
             ' is_ref= ' + tb.fieldByName('is_ref').AsString  + ' and mes  <= ' + mes  +' order by mes desc';
      ds:= dm.getDataSetQ(cmd);

      if (ds.IsEmpty = false) then
      begin
         tb.Edit();
         tb.FieldByName('entradas').AsInteger := ds.fieldByName('entradas').asinteger;
         tb.FieldByName('saidas').AsInteger := ds.fieldByName('saidas').asinteger;
         tb.FieldByName('saldoFim').AsInteger := ds.fieldByName('saldoFim').asinteger;
         tb.FieldByName('custo').AsFloat := ds.fieldByName('custo').AsFloat;
         tb.Post();
      end;
      ds.free();
      tb.next();
      sleep(10);
   end;
   tb.Close();

   cmd :=
   ' delete from '  + tb.TableName + ' where saidas = 0 and entradas = 0 and saldoFim = 0 ';
   dm.execSQL(cmd);

   tb.Open();
   funcsql.exportaTable(tb);
   fmMain.MsgStatus('');
end;

end.
