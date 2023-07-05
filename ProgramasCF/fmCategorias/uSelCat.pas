unit uSelCat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, DB, StdCtrls, Buttons, fCtrls, Grids, DBGrids, SoftDBGrid,
  ComCtrls;

type
  TfmSelCat = class(TForm)
    lbnivel: TLabel;
    grClasse1: TSoftDBGrid;
    grClasse2: TSoftDBGrid;
    grClasse3: TSoftDBGrid;
    fsBitBtn1: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
    qrClasse1: TADOQuery;
    qrClasse2: TADOQuery;
    qrClasse3: TADOQuery;
    DsClasse1: TDataSource;
    dsClasse2: TDataSource;
    dsClasse3: TDataSource;
    lbValorNivel: TLabel;
    Label1: TLabel;
    Label2: TLabel;

//
//  procedure AbreCategoria01(Sender:Tobject;Conexao:TADOConnection);
    procedure FormCreate(Sender: TObject);
    procedure grClasse1CellClick(Column: TColumn);
    procedure grClasse2CellClick(Column: TColumn);
    procedure grClasse3CellClick(Column: TColumn);
    procedure qrClasse2BeforeClose(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grClasse1TitleClick(Column: TColumn);
    procedure grClasse2TitleClick(Column: TColumn);
    procedure grClasse3TitleClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  fmSelCat: TfmSelCat;

implementation
uses uMain, funcSQL, uDm;

{$R *.dfm}


procedure listaCategoria(qr:TADOQuery; cd_campo, cd_campoPai, cd_vcampoPai:String);
var
pai,    cmd:String;
begin
    if ( qr.IsEmpty = true) then
       qr.Close();


    if (cd_campoPai <> '') then
       pai := dm.getQtCMD2('cat', 'getCat.pai', cd_campoPai, cd_vcampoPai)
    else
      pai := '/* */';

    cmd := dm.getCMD2('cat', 'getCat', QuotedStr(cd_campo), pai);

//    cmd := cmd + ' order by ds_vcampo';

    dm.getQuery(qr, cmd);
end;


procedure TfmSelCat.FormCreate(Sender: TObject);
begin
   listaCategoria(qrClasse1, '1', '', '');
   lbnivel.Caption := '0';
   lbValorNivel.Caption := '0000';
end;

procedure TfmSelCat.grClasse1CellClick(Column: TColumn);
begin
   if (qrClasse1.IsEmpty = false) then
      listaCategoria( qrClasse2,
                     '2',
                     '1',
                     qrClasse1.fieldByName('cd_vcampo').asString
                      );
   lbnivel.Caption := '1';
   lbValorNivel.Caption := qrClasse1.fieldByName('cd_vcampo').asString;
end;

procedure TfmSelCat.grClasse2CellClick(Column: TColumn);
begin
   if (qrClasse2.IsEmpty = false) then
      listaCategoria( qrClasse3,
                     '3',
                     '2',
                     qrClasse2.fieldByName('cd_vcampo').asString
                      );
   lbnivel.Caption := '2';
   lbValorNivel.Caption := qrClasse2.fieldByName('cd_vcampo').asString;
end;

procedure TfmSelCat.grClasse3CellClick(Column: TColumn);
begin
   lbnivel.Caption := '3';
   lbValorNivel.Caption := qrClasse3.fieldByName('cd_vcampo').asString;
end;

procedure TfmSelCat.qrClasse2BeforeClose(DataSet: TDataSet);
begin
   qrClasse3.Close();
end;

procedure TfmSelCat.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  Action := CaFree;
//  fmSelCat:= nil;
end;

procedure TfmSelCat.grClasse1TitleClick(Column: TColumn);
begin
   dm.ordernaQuery(qrClasse1, grClasse1, Column);
end;

procedure TfmSelCat.grClasse2TitleClick(Column: TColumn);
begin
   dm.ordernaQuery(qrClasse2, grClasse2, Column);
end;

procedure TfmSelCat.grClasse3TitleClick(Column: TColumn);
begin
   dm.ordernaQuery(qrClasse3, grClasse3, Column);
end;

end.
