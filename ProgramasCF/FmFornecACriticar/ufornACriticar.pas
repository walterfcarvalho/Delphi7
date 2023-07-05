unit ufornACriticar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, StdCtrls,
  Buttons, fCtrls;

type
  TfmFornACriticar = class(TForm)
    tb: TADOTable;
    DataSource1: TDataSource;
    fsBitBtn1: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
    grid: TSoftDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure fsBitBtn2Click(Sender: TObject);
    procedure gridTitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmFornACriticar: TfmFornACriticar;

implementation

uses uMain, uCF, uDm, f, msg;

{$R *.dfm}

procedure TfmFornACriticar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := cafree;
  fmFornACriticar := nil;
end;

procedure TfmFornACriticar.FormActivate(Sender: TObject);
begin
  tb.TableName := 'zcf_FornCritReq';
  tb.Open;
  grid.Columns[0].Width := 100;
  grid.Columns[1].Width := 100;
  grid.Columns[2].Width := 350;
  dm.OrganizarTabela(tb, grid, grid.Columns[2]);
  dm.OrganizarTabela(tb, grid, grid.Columns[2]);

  grid.Columns[0].Title.caption := 'Fornecedor';
  grid.Columns[01].Title.caption := 'Codigo pessoa';
  grid.Columns[02].Title.caption := 'Descricao'     ;
end;

procedure TfmFornACriticar.fsBitBtn1Click(Sender: TObject);
var
  cod:String;
  ds:TdataSet;
begin
{   cod := uCF.get .getFmDadosPessoa('F');
   if ( cod <> '') then
   begin
      ds := uCF.getDadosFornecedor(cod,'');
      tb.AppendRecord([ds.FieldByName('is_cred').asString,
                       ds.FieldByName('codigo').asString,
                       ds.FieldByName('fornecedor').asString
                       ]
                     );
      ds.Destroy();
   end;
{}
end;

procedure TfmFornACriticar.fsBitBtn2Click(Sender: TObject);
begin
   if (msg.msgQuestion('Remove o fornecedor : ' + tb.fieldbyName('descricao').asString + '...') = mryes) then
      tb.Delete;
end;

procedure TfmFornACriticar.gridTitleClick(Column: TColumn);
begin
   dm.OrganizarTabela(tb, grid, column);
end;

end.
