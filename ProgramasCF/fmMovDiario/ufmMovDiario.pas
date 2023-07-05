unit ufmMovDiario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, SoftDBGrid, TFlatButtonUnit, ExtCtrls, uDM,
  StdCtrls;

type
  TfmMovDiario = class(TForm)
    Panel1: TPanel;
    btNovo: TFlatButton;
    btAbrir: TFlatButton;
    btRemove: TFlatButton;
    btSalva: TFlatButton;
    gridDesp: TSoftDBGrid;
    Label2: TLabel;
    tbDesp: TADOTable;
    dsDesp: TDataSource;
    tbItens: TADOTable;
    tbItensseqItem: TAutoIncField;
    tbItensseqMov: TIntegerField;
    tbItenstpMov: TIntegerField;
    tbItensdescMov: TStringField;
    tbItensValor: TBCDField;
    dsItens: TDataSource;
    grid: TSoftDBGrid;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbLoja: TLabel;
    lbData: TLabel;
    tbDespseqDesp: TAutoIncField;
    tbDespseqMov: TIntegerField;
    tbDespValor: TBCDField;
    tbDespobs: TStringField;
    Label5: TLabel;
    lbUser: TLabel;
    lbStatus: TLabel;
    Label8: TLabel;
    btConfere: TFlatButton;
    brPrint: TFlatButton;
    btEmail: TFlatButton;

    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btNovoClick(Sender: TObject);
    procedure abreMov(num:String);
    procedure tbItensAfterInsert(DataSet: TDataSet);
    procedure btAbrirClick(Sender: TObject);
    procedure tbItensAfterPost(DataSet: TDataSet);
    procedure habilitaSalva();
    procedure tbDespAfterPost(DataSet: TDataSet);
    procedure btSalvaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure brPrintClick(Sender: TObject);
    procedure btConfereClick(Sender: TObject);
    procedure btEmailClick(Sender: TObject);
    procedure gridDespDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMovDiario: TfmMovDiario;
  fiel: TBCDField  ;
implementation

uses uMovDiario, msg, uMain, f, uAbreMovDiario, uLj;

{$R *.dfm}



procedure TfmMovDiario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
   fmMovDiario := nil;
end;


procedure TfmMovDiario.abreMov(num:String);
var
  ds:TdataSet;
begin
   ds:= uMovDiario.abreMov( num, tbItens, tbDesp );

   if (ds <> nil) then
   begin
      lbLoja.Caption :=  ds.fieldByName('ds_uo').AsString;
      lbData.Caption := ds.fieldByName('data').AsString;
      lbStatus.Caption := ds.fieldByName('status').AsString;
      lbUser.Caption := ds.fieldByName('nm_usu').AsString;

      btEmail.Visible := btSalva.Visible;

      f.ajGridCol(grid, tbItens, 'seqItem', 0, '');
      f.ajGridCol(grid, tbItens, 'seqMov', 0, '');
      f.ajGridCol(grid, tbItens, 'tpMov', 0, '');
      f.ajGridCol(grid, tbItens, 'descMov', 200, 'Itens do caixa');
      f.ajGridCol(grid, tbItens, 'Valor', 100, 'Valor');

      f.ajGridCol(gridDesp, tbDesp, 'seqDesp', 0, '');
      f.ajGridCol(gridDesp, tbDesp, 'seqMov', 0, '');
      f.ajGridCol(gridDesp, tbDesp, 'Valor', 100, 'Valor Sangria');
      f.ajGridCol(gridDesp, tbDesp, 'Obs', 500, 'Finalidade da Sangria');

      ds.Free();
   end;
end;


procedure TfmMovDiario.btNovoClick(Sender: TObject);
var
  uo, ds_uo, num:String;
  data:Tdate;
  cbLj : TcomboBox;
begin
   cbLj := uLj.getComboBoxLojas(false, false, fmMain.getCdPesLogado(), fmMain.getUoLogada());

   data := dm.getDateAntBd(1);

   msg.getUoData(cbLj, fmMain.getCdPesLogado(), uo, ds_uo, data);

   if (uo <> '') and (uo <> '999') then
   begin
      num := uMovdiario.criaMov(uo, fmMain.getCdPesLogado(), data );
      if (num <> '') then
         abreMov(num);
   end;

   cbLj.Free();
end;

procedure TfmMovDiario.tbItensAfterInsert(DataSet: TDataSet);
begin
   tbItens.Cancel();
end;

procedure TfmMovDiario.btAbrirClick(Sender: TObject);
var
  uo, ds_uo:String;
  data:Tdate;
  cbLj: TComboBox;
begin
   cbLj := uLj.getComboBoxLojas(false, false, fmMain.getCdPesLogado(), fmMain.getUoLogada());

   data := dm.getDateBd();

   msg.getUoData(cblj, fmMain.getCdPesLogado(), uo, ds_uo, data);

   if (uo <> '') and (uo <> '999')  then
   begin
      uo := uMovdiario.getSeqMov(uo, data);
      abreMov(uo);
   end;
   cbLj.Free();
end;

procedure TfmMovDiario.tbItensAfterPost(DataSet: TDataSet);
begin
   habilitaSalva();
end;

procedure TfmMovDiario.habilitaSalva;
begin
   btSalva.Enabled := true;
end;

procedure TfmMovDiario.tbDespAfterPost(DataSet: TDataSet);
begin
   habilitaSalva();
end;

procedure TfmMovDiario.btSalvaClick(Sender: TObject);
begin
   uMovDiario.salvaMov(tbItens, tbDesp);
end;

procedure TfmMovDiario.FormCreate(Sender: TObject);
begin
   btConfere.Visible := fmMain.isAcessoTotal(fmMain.mnResDiario.Tag);
end;

procedure TfmMovDiario.brPrintClick(Sender: TObject);
begin
   uMovDiario.imprimeMov(tbItens, tbDesp);
end;

procedure TfmMovDiario.btConfereClick(Sender: TObject);
var
  seqMov:String;
begin
   seqMov := tbDesp.fieldByName('seqMov').AsString;

   if (tbDesp.IsEmpty = false) then
      if  uMovDiario.alteraStatus( seqMov ) = true then
         abreMov(seqMov);
end;

procedure TfmMovDiario.btEmailClick(Sender: TObject);
begin
   if (tbItens.IsEmpty = false) then
      if (uMovDiario.salvaMov(tbItens, tbDesp) = true) then
         uMovDiario.enviaEmail( tbItens.fieldByName('seqMov').AsString);
end;

procedure TfmMovDiario.gridDespDblClick(Sender: TObject);
begin
   if msg.msgQuestion( dm.getMsg('comum.delQuestion') ) = mrYes then
      tbDesp.Delete();
end;

end.
