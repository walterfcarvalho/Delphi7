unit uResumoEstoque;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, SoftDBGrid, DB, ADODB,
  TFlatButtonUnit;

type
  TfmResEstoque = class(TForm)
    SoftDBGrid1: TSoftDBGrid;
    Panel1: TPanel;
    lbCod: TLabel;
    lbDesc: TLabel;
    dataSource: TDataSource;
    chsoPositivo: TCheckBox;
    Label1: TLabel;
    lbTotal: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure obterestoques(is_ref,EhDisponivel:string);
    procedure Obtertotal(Sender:Tobject);
    procedure chsoPositivoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmResEstoque: TfmResEstoque;

implementation

uses umain, uDm, funcsql, f, uEstoque;
{$R *.dfm}

procedure TfmResEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action:= caFree;
   fmResEstoque := nil;
end;

procedure TfmResEstoque.obterEstoques(is_ref, EhDisponivel:string);
var
   lst:Tstrings;
begin
   lst := dm.GetValoresSQL(lst, ' Select cd_ref, ds_ref from crefe (nolock) where is_ref = ' + is_ref);
   lbCod.Caption := lst[0];
   lbDesc.Caption := lst[1];

   dataSource.DataSet := uEstoque.getEstoqueLojas(is_ref, EhDisponivel);
end;

procedure TfmResEstoque.Obtertotal(Sender: Tobject);
var
  total:real;
begin
   total := 0;
   dataSource.DataSet.First;
   while dataSource.DataSet.Eof = false do
   begin
      if chsoPositivo.Checked = true then
      begin
         if dataSource.DataSet.fieldByName('Estoque').asfloat > 0 then
            total := Total + dataSource.DataSet.fieldByName('Estoque').asfloat;
      end
      else
         total := Total + dataSource.DataSet.fieldByName('Estoque').asfloat;
         dataSource.DataSet.Next;
   end;
   lbtotal.caption := floatToStr(Total);
   dataSource.DataSet.First;
end;

procedure TfmResEstoque.chsoPositivoClick(Sender: TObject);
begin
   Obtertotal(nil);
end;

end.
