unit uDescPorData;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRelGeral, ADODB, DB, ExtCtrls, StdCtrls, fCtrls, ComCtrls,
  TFlatButtonUnit, adLabelComboBox, Grids, DBGrids, SoftDBGrid;

type
  TfmDescPorData = class(TfmRelGeral)
    FlatButton1: TFlatButton;
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    tbOperadoresds_uo: TStringField;
    tbOperadoresnota: TStringField;
    tbOperadoresValorProdutos: TBCDField;
    tbOperadoresvalorVenda: TBCDField;
    tbOperadoresNumeropedido: TIntegerField;
    tbOperadoresPercentualDesconto: TBCDField;
    tbOperadoresValorDesconto: TBCDField;
    tbOperadoresds_tipoPreco: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gerar();
    procedure FlatButton1Click(Sender: TObject);
    procedure getParams();
    procedure gridDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDescPorData: TfmDescPorData;
  PARAM:TStringlist;
implementation

uses uCaixa, f, ulj, uMain, fdt, uDm;

{$R *.dfm}

procedure TfmDescPorData.FormCreate(Sender: TObject);
begin
  inherited;

   pnSelCat.Free();
   tbPreviaDeCaixa.Free;
   tbVendasCartao.Free;
   tbValoresAvarias.Free;
   tbValoresAvarias_Total.Free;
   qr.Free;
   cbDetAvaForn.Free;
   tbTotRec.free;
   cbCaixas.Visible := false;

	di.Date := now;
   df.Date := now;
   grid.Align := alClient;
end;

procedure TfmDescPorData.gerar;
begin
	if (fdt.isIntervDataValido(di, df,true, 31) = true) then
   begin
		uCaixa.obterDescPorData(tbOperadores, di.Date, df.Date, f.getCodUo(cbLojas));

      f.ajGridCol(grid, tbOperadores, 'ds_uo', 140, 'Loja');
      f.ajGridCol(grid, tbOperadores, 'nota', 69, 'Nota');
      f.ajGridCol(grid, tbOperadores, 'ValorProdutos', 75, 'Valor dos Produtos');
      f.ajGridCol(grid, tbOperadores, 'valor Venda', 72, 'Valor Com desconto');
      f.ajGridCol(grid, tbOperadores, 'Numero pedido', 76, 'Pedido');
      f.ajGridCol(grid, tbOperadores, 'Percentual Desconto', 105, 'Perc Desconto');
      f.ajGridCol(grid, tbOperadores, 'Valor Desconto', 78, 'Vl Desconto');
      f.ajGridCol(grid, tbOperadores, 'ds_tipoPreco', 200, 'Tipo de preço');   end;
end;

procedure TfmDescPorData.FormShow(Sender: TObject);
begin
	cbCaixas.free;
	ulj.getListaLojas(cbLojas, true, false, fmMain.getCdPesLogado(), fmMain.getUoLogada(), '');
   cbLojas.ItemIndex := 0;
end;

procedure TfmDescPorData.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action := caFree;
  fmDescPorData := nil;
end;

procedure TfmDescPorData.btOkClick(Sender: TObject);
begin
	gerar();
end;

procedure TfmDescPorData.FlatButton1Click(Sender: TObject);
begin
   if (tbOperadores.IsEmpty = false )then
   	fmMain.imprimeRave(tbOperadores, nil, nil, nil, nil, 'rpDescDeVenda', PARAM)
end;

procedure TfmDescPorData.getParams();
begin
	PARAM:= TStringlist.Create;
   PARAM.add(uLj.getNomeUO(cbLojas));
   PARAM.Add(dateToStr(di.Date));
   PARAM.Add(dateToStr(df.Date));
end;

procedure TfmDescPorData.gridDblClick(Sender: TObject);
begin
	f.salvaColunasDbGrid(grid, tbOperadores);
end;

end.
