unit uDetalhesNotas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, SoftDBGrid, f, funcsql,
  DB, ADODB, adLabelEdit;

type
  TfmDetalhesNota = class(TForm)
    grid: TSoftDBGrid;
    Panel1: TPanel;
    Bevel1: TBevel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    GroupBox1: TGroupBox;
    lbDestEmit: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbNota: TLabel;
    lbEmitente: TLabel;
    lbOperacao: TLabel;
    Label4: TLabel;
    lbEmissao: TLabel;
    Label7: TLabel;
    lbEntSai: TLabel;
    Label1: TLabel;
    lbCFO: TLabel;
    Label8: TLabel;
    lbValor: TLabel;
    dsItens: TDataSource;
    Label9: TLabel;
    lbDEspExtra: TLabel;
    edIsNota: TadLabelEdit;
    Button1: TButton;
    procedure carregarDadosNota(is_nota: String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDetalhesNota: TfmDetalhesNota;

implementation

uses uMain, cf, ucf, uFiscal;

{$R *.dfm}

{ TForm1 }

procedure TfmDetalhesNota.carregarDadosNota(is_nota : String);
var
   ds:TdataSet;
begin
   ds:= uFiscal.getDadosNota(is_nota, '', '', '');

// campos do cabeçalho
   if (ds.FieldByName('tipo').AsString = 'Saida') then
      lbDestEmit.Caption := 'Destinatário:'
   else
      lbDestEmit.Caption := 'Emitente:';

   edIsNota.text := ds.FieldByName('is_nota').AsString;
   lbNota.Caption := trim(ds.FieldByName('serie').AsString)+'-'+ds.FieldByName('num').AsString;
   lbEmitente.Caption := ds.FieldByName('Emissor/Destino').AsString;
   lbOperacao.Caption := ds.FieldByName('ds_res').AsString;
   lbEntSai.Caption := ds.FieldByName('tipo').AsString;
   lbEmissao.Caption := ds.FieldByName('Entrada/Saida').AsString;
   lbCFO.Caption := ds.FieldByName('cd_cfo').AsString;
   lbValor.caption := ds.FieldByName('valor').AsString;
   lbDEspExtra.Caption := ds.FieldByName('VL_DSPEXTRA').AsString;

   dsItens.DataSet :=
   uFiscal.getItensNota(ds.FieldByName('is_nota').AsString);

   f.ajGridCol( grid, dsItens.DataSet, 'is_ref', -1, '' );
   f.ajGridCol( grid, dsItens.DataSet, 'cd_ref', 55, 'Codigo' );
   f.ajGridCol( grid, dsItens.DataSet, 'ds_ref', 340, 'Descrição' );
   f.ajGridCol( grid, dsItens.DataSet, 'qt_mov', 50, 'Quant' );
   f.ajGridCol( grid, dsItens.DataSet, 'PrecoUnitarioLiquido', 55, 'Pc Und' );
   f.ajGridCol( grid, dsItens.DataSet, 'total_Item', 55, 'Total item' );

   ds.free();
end;

procedure TfmDetalhesNota.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmDetalhesNota := nil;
   action := caFree;
end;

procedure TfmDetalhesNota.gridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   if (Column.FieldName ='EAN') then
      f.showColGridInvalid( grid, rect, dsItens.dataset.fieldByname('EAN'), Column, state, f.isEAN13(dsItens.dataset.fieldByname('EAN').AsString) );

   f.showColGridInvalid( grid, rect, dsItens.dataset.fieldByname('NCM_SH'), Column, state, (length(dsItens.dataset.fieldByname('NCM_SH').AsString) = 8) );
end;

procedure TfmDetalhesNota.Button1Click(Sender: TObject);
begin
  carregarDadosNota(edIsNota.Text);
end;

end.
