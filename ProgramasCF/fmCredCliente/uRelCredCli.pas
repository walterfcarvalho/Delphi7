unit uRelCredCli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, adLabelNumericEdit, Grids, DBGrids,
  SoftDBGrid, ExtCtrls, ComCtrls, fCtrls, TFlatButtonUnit, adLabelComboBox, uDm,
  DB, ADODB;

type
  TfmRelCredCli = class(TForm)
    pnParam: TPanel;
    cbLojas: TadLabelComboBox;
    btOk: TFlatButton;
    GroupBox1: TGroupBox;
    di: TfsDateTimePicker;
    Panel1: TPanel;
    rg1: TRadioGroup;
    SoftDBGrid1: TSoftDBGrid;
    edValor: TadLabelNumericEdit;
    DataSource1: TDataSource;
    tb: TADOTable;
    FlatButton1: TFlatButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure SoftDBGrid1DblClick(Sender: TObject);
    procedure ajustaGrid();
    procedure SoftDBGrid1TitleClick(Column: TColumn);
    procedure FlatButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRelCredCli: TfmRelCredCli;

implementation

uses uPessoa, ulj, f, uMain;

{$R *.dfm}

procedure TfmRelCredCli.FormCreate(Sender: TObject);
begin
	if fmMain.isAcessoTotal(fmMain.mnRelCredCli.tag) = true then
		ulj.getListaLojas(cbLojas, true, false, fmMain.getCdPesLogado(), fmMain.getUoLogada())
   else
		ulj.getListaLojas(cbLojas, false, false, fmMain.getCdPesLogado(), fmMain.getUoLogada());

   di.Date := dm.getDateBd();
   Panel1.Align := alclient;


end;

procedure TfmRelCredCli.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
	action := caFree;
   fmRelCredCli := nil;
end;

procedure TfmRelCredCli.btOkClick(Sender: TObject);
begin
	uPessoa.listaCreditos(tb, f.getCodUO(cbLojas), di.Date, edValor.Text);
   ajustaGrid();
end;

procedure TfmRelCredCli.SoftDBGrid1DblClick(Sender: TObject);
begin
	f.salvaColunasDbGrid(SoftDBGrid1, tb);
end;

procedure TfmRelCredCli.ajustaGrid;
var
	i:integer;
begin
	for i:=0 to SoftDBGrid1.Columns.Count - 1 do
   	SoftDBGrid1.Columns[i].Title.Font.Style := [fsBold];

   f.ajGridCol(SoftDBGrid1, tb, 'ds_uo', 153, 'Loja ');
   f.ajGridCol(SoftDBGrid1, tb, 'num_cli', 74, 'Cod cliente');
   f.ajGridCol(SoftDBGrid1, tb, 'nm_pes', 304, 'Nome do cliente');
   f.ajGridCol(SoftDBGrid1, tb, 'saldo', 91, 'Crédito atual');
   f.ajGridCol(SoftDBGrid1, tb, 'credMaisantigo', 114, 'Credito Mais Antigo');
   f.ajGridCol(SoftDBGrid1, tb, 'seq', 0, '');
end;

procedure TfmRelCredCli.SoftDBGrid1TitleClick(Column: TColumn);
begin
	dm.organizarTabela(tb, SoftDBGrid1, Column);
end;

procedure TfmRelCredCli.FlatButton1Click(Sender: TObject);
var
	param:Tstringlist;
begin
	if tb.IsEmpty = false then
   begin
   	param := TStringList.Create();
      param.Add(uLj.getNomeUO(cbLojas));
      param.Add(dateToStr(di.Date));
      param.Add(edValor.Text);
      param.Add(dateTimeToStr(now));

		fmMain.imprimeRave(tb, nil, nil, nil, nil, 'rpAdiAbertos', param);
   end;
end;

end.
