unit UAlteraForPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, TFlatButtonUnit, DB, ADODB, Grids,
  DBGrids, SoftDBGrid, adLabelComboBox;

type
  TfmAlteraPedForn = class(TForm)
    Query1: TADOQuery;
    btConsPedForn: TFlatButton;
    Edit1: TadLabelEdit;
    DBGrid: TSoftDBGrid;
    DataSource1: TDataSource;
    cb2: TadLabelComboBox;
    FlatButton2: TFlatButton;
    cbComprador: TadLabelComboBox;
    gridParcelas: TSoftDBGrid;
    tbParc: TADOTable;
    DataSource2: TDataSource;
    gridItens: TSoftDBGrid;
    dsItens: TDataSource;
    procedure btConsPedFornClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure carregaParcelasPedido();
    procedure alteraDatasVencimento();
    procedure carregaItensPedido(numPed:String);
    procedure gridItensDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  fmAlteraPedForn: TfmAlteraPedForn;

implementation

uses uMain, funcsql, f, {cf,} ucf, fdt, uDm, msg, uLj, uPedFornecedor;

{$R *.dfm}

procedure TfmAlteraPedForn.btConsPedFornClick(Sender: TObject);
var
  Str:string;
begin
   str:= ' select zcf_tbuo.ds_uo as Loja, dspes.nm_pes as Fornecedor, dspdf.vl_total as [VL Pedido],' +
        ' dspdf.is_uoCompra, dspdf.cd_usu, dspdf.is_pedf from dspdf'+
        ' inner join zcf_tbuo  on dspdf.is_uoCompra = zcf_tbuo.is_uo ' +
        ' inner join dspes on dspdf.cd_pes = dspes.cd_pes where dspdf.is_pedf = ' + Edit1.text ;

   query1.SQL.Clear;
   query1.SQL.add(str);
   query1.Open;
   FormShow(Sender);
   if (query1.IsEmpty = false)  then
   begin
      dbgrid.Columns[0].Width := 150;
      dbgrid.Columns[1].Width := 250;
      dbgrid.Columns[2].Width := 80;

      dbgrid.Columns[query1.FieldByName('cd_usu').Index].Visible := false;
      dbgrid.Columns[query1.FieldByName('is_pedf').Index].Visible := false;
      dbgrid.Columns[query1.FieldByName('is_uoCompra').Index].Visible := false;

      uLj.getListaLojas(cb2, false, false, fmMain.getCdPesLogado(), fmMain.getUoLogada() );

      ucf.getCompradores(cbComprador);

      f.setUoNacomboBox(cb2, query1.fieldByName('is_uoCompra').AsString);

// ajusta o nome do comprador
     f.setUoNacomboBox(cbComprador, query1.fieldByName('cd_usu').AsString);


     cb2.Enabled := true;
     cbComprador.Enabled := true;
     dbgrid.Enabled := true;
     cb2.Setfocus;
     carregaParcelasPedido();
     carregaItensPedido(Edit1.Text);
  end
  else
     msg.msgErro(' - Pedido não cadastrado.');
end;

procedure TfmAlteraPedForn.FormShow(Sender: TObject);
begin
  dbgrid.Enabled := false;
end;

procedure TfmAlteraPedForn.FlatButton2Click(Sender: TObject);
begin
   if ( msg.msgQuestion( dm.getMsg('fmAltPedforn.msqQuestion') ) = mrYes) then
   begin
      uPedFornecedor.setUoPedForn(
                          query1.FieldByName('is_pedf').AsString,
                          f.getCodUO(cb2),
                          f.getCodUO(cbComprador)
                          );
      alteraDatasVencimento();

      FormShow(Sender);
      btConsPedFornClick(Sender);
      edit1.SetFocus;
   end;
end;

procedure TfmAlteraPedForn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
   fmAlteraPedForn := nil;
end;

procedure TfmAlteraPedForn.carregaParcelasPedido;
var
   cmd:String;
   ds:TdataSet;
begin
   cmd := ' numdoc integer, Parcela int, Vencimento smalldateTime';
   dm.getTable(tbParc, cmd);
   tbParc.Open();

   ds:= uPedFornecedor.getVlParcPedCompra(Edit1.Text);

   ds.First();
   while (ds.Eof= false) do
   begin
      tbParc.AppendRecord([
         edit1.Text,
         ds.fieldByName('numpar').AsString,
         copy( ds.fieldByName('datVen').AsString, 07, 02) +'/'+ copy( ds.fieldByName('datVen').AsString, 05, 02) +'/'+ copy( ds.fieldByName('datVen').AsString, 01, 04)
      ]);
      ds.Next();
   end;
   ds.Free();
   f.ajGridCol(gridParcelas, tbParc, 'numDoc', 0, '');

   gridParcelas.Columns[ tbParc.FieldByName('Parcela').Index ].ReadOnly := true;

   gridParcelas.Enabled := true;
end;

procedure TfmAlteraPedForn.alteraDatasVencimento;
var
   cmd:String;
begin
   tbParc.First();
   while (tbParc.Eof = false) do
   begin
     cmd := ' update dsppe set datVen = ' +
            fdt.dataToSqlInt(tbParc.fieldByName('Vencimento').AsDateTime) +
            ' where ' +
            ' numDoc= ' + tbParc.fieldByName('numDoc').AsString +
            ' and numpar= '  + tbParc.fieldByName('Parcela').AsString;

     dm.execSQL(cmd);
     tbParc.Next();
   end;
end;

procedure TfmAlteraPedForn.carregaItensPedido(numPed:String);
begin
   dsItens.DataSet := uPedFornecedor.getItPedFornecedor(numPed);
   f.ajGridCol(gridItens, dsItens.DataSet, 'Pedido', 0, '');
   f.ajGridCol(gridItens, dsItens.DataSet, 'is_ref', 0, '');
   f.ajGridCol(gridItens, dsItens.DataSet, 'tp_origem', 60, 'Origem');
   f.ajGridCol(gridItens, dsItens.DataSet, 'Codigo', 72, 'Código');
   f.ajGridCol(gridItens, dsItens.DataSet, 'Descricao', 304, 'Descrição');
   f.ajGridCol(gridItens, dsItens.DataSet, 'qt_emb', 44, 'Emb');
   f.ajGridCol(gridItens, dsItens.DataSet, 'QUANT', 64, 'Qt');
   f.ajGridCol(gridItens, dsItens.DataSet, 'UND', 46, 'UND');
   f.ajGridCol(gridItens, dsItens.DataSet, 'vl_ped', 66, 'Vl Ped');
   f.ajGridCol(gridItens, dsItens.DataSet, 'IPI', 34, 'IPI');
   f.ajGridCol(gridItens, dsItens.DataSet, 'Qt Caixa', 44, 'Qt Caixa');
   f.ajGridCol(gridItens, dsItens.DataSet, 'Cod Barras und', 77, 'Cod Barras und');
   f.ajGridCol(gridItens, dsItens.DataSet, 'Dados Caixa', 64, 'Dados Caixa');


   gridItens.Enabled := true;
end;

procedure TfmAlteraPedForn.gridItensDblClick(Sender: TObject);
begin
  f.salvaColunasDbGrid(gridItens, dsItens.DataSet );
end;

end.
