unit uCustoPorPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls, Buttons,
  fCtrls, adLabelEdit, f, funcsql, fdt;

type
  TfmCustoPorPedido = class(TForm)
    edNumPedido: TadLabelEdit;
    btCalc: TfsBitBtn;
    tb: TADOTable;
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    procedure criaTabela();
    procedure btImp(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure preencheDadosPedido();
    procedure getDadosCRUC();
    procedure ajustaVisualizacao();
    procedure gridTitleClick(Column: TColumn);
    procedure Impressao();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCustoPorPedido: TfmCustoPorPedido;

implementation

uses uMain, uCF, uDm, uEstoque;

{$R *.dfm}

procedure TfmCustoPorPedido.criaTabela();
var
  cmd:String;
begin
    grid.Visible := false;
    if (tb.TableName <> '') then
       tb.Close;
    cmd := 'is_ref int, cd_Ref varchar(08), ds_ref varchar(50), pc_01 money, pc_02 money';
    dm.getTable(tb, cmd);
end;


procedure TfmCustoPorPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   fmCustoPorPedido := nil;
   action := caFree;
end;

procedure TfmCustoPorPedido.preencheDadosPedido;
var
   ds:TDataSet;
begin
   ds := uEstoque.getDadosPedidoDeCompra(edNumPedido.Text );
   ds.First;
   while (ds.Eof = false) do
   begin
      tb.AppendRecord([
                        ds.FieldByName('is_ref').asString,
                        ds.FieldByName('codigo').asString,
                        ds.FieldByName('descricao').asString,
                        '0,00',
                        '0,00'
                     ]);
      ds.Next();
   end;
  ds.Free();
end;

procedure TfmCustoPorPedido.getDadosCRUC();
var
   qr:TADOQuery;
begin //
   tb.First();
   while (tb.Eof = false) do
   begin
      qr := TADOQuery.Create(nil);
      uEstoque.getCRUCBaseNota( qr, tb.fieldByname('is_ref').asString);

      if (qr.IsEmpty = false ) then
      begin
         tb.Edit;
         tb.FieldByName('pc_01').AsFloat := qr.fieldByName('Custo +IPI').asFloat;
         tb.FieldByName('pc_02').AsFloat := qr.fieldByName('Custo +IPI -ICMS').asFloat;
         tb.Post();
      end;
      qr.Free();
      tb.Next();
   end;
end;

procedure TfmCustoPorPedido.ajustaVisualizacao;
begin
   grid.Columns[ tb.FieldByName('is_ref').Index ].Visible := false;
   grid.Columns[ tb.FieldByName('cd_ref').Index ].Title.Caption := 'C�digo';
   grid.Columns[ tb.FieldByName('ds_ref').Index ].Title.Caption := 'Descri��o';
   grid.Columns[ tb.FieldByName('pc_01').Index ].Title.Caption := 'Custo +IPI';
   grid.Columns[ tb.FieldByName('pc_02').Index ].Title.Caption := 'Custo +IPI -ICMS';
   tb.First();
end;

procedure TfmCustoPorPedido.btImp(Sender: TObject);
begin
   screen.cursor := crHourGlass;
   criaTabela();
   preencheDadosPedido();
   getDadosCRUC();
   ajustaVisualizacao();
   grid.Visible := true;
   screen.cursor := crDefault;
   Impressao;
end;


procedure TfmCustoPorPedido.gridTitleClick(Column: TColumn);
begin
   funcsql.organizarTabela(tb, Column);
end;

procedure TfmCustoPorPedido.Impressao();
var
   param:TSTringlist;
begin
  param := TStringlist.create();
  param.Add('Pedido: ' + edNumPedido.Text);
  param.Add('Gerado por: ' +  fmMain.getNomeUsuario());
  fmMain.imprimeRave(tb, nil, nil, nil, nil, 'rpCRUCNPorPedido', param );
end;

end.
