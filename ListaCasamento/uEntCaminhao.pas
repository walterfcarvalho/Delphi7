unit uEntCaminhao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, ExtCtrls, StdCtrls,
  fCtrls, TFlatButtonUnit, adLabelEdit;

type
  TfmEntCaminhao = class(TForm)
    Panel1: TPanel;
    tb: TADOTable;
    DataSource1: TDataSource;
    grid: TSoftDBGrid;
    tbDestImpr: TADOTable;
    Panel2: TPanel;
    cbIsEntrega: TfsCheckBox;
    edMotorista: TadLabelEdit;
    btComprador: TFlatButton;
    FlatButton1: TFlatButton;
    procedure FormCreate(Sender: TObject);
    procedure gridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure gridCellClick(Column: TColumn);
    procedure ajColEntrega(marcacao:String);
    procedure cbIsEntregaClick(Sender: TObject);
    procedure btCompradorClick(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEntCaminhao: TfmEntCaminhao;
  isImpresso:boolean;
implementation

   uses unit1, uDm, uProduto, funcoes, msg;

{$R *.dfm}

procedure TfmEntCaminhao.FormCreate(Sender: TObject);
begin
   isImpresso := false;

   uProduto.listaPrdPendEntrega(tb, fmMain.RParReg('Loja') );

   funcoes.ajGridCol(grid, tb, 'entregar', 40, 'Entregar');
   funcoes.ajGridCol(grid, tb, 'SeqProduto', 60, 'Protocolo');
   funcoes.ajGridCol(grid, tb, 'Codigo', 60, 'Codigo');
   funcoes.ajGridCol(grid, tb, 'NomeProduto', 220, 'Produto');
   funcoes.ajGridCol(grid, tb, 'Noiva', 200, 'Noiva');
   funcoes.ajGridCol(grid, tb, 'seq', 0, '');
   tb.FieldByName('entregar').Alignment :=  taCenter;
end;

procedure TfmEntCaminhao.gridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
   if Column.Field.FieldName = 'entregar' then
   begin
      column.Font.Style := [fsbold];
      column.font.Color :=  clRed;
   end;
end;

procedure TfmEntCaminhao.ajColEntrega(marcacao: String);
begin
   tb.Edit();
   tb.FieldByName('Entregar').asString := marcacao;
   tb.Post();
end;


procedure TfmEntCaminhao.gridCellClick(Column: TColumn);
begin
   if (tb.FieldByName('Entregar').asString = 'X') then
      ajColEntrega('')
   else
      ajColEntrega('X');
end;


procedure TfmEntCaminhao.cbIsEntregaClick(Sender: TObject);
var
  marca:String;
begin
   if (  cbIsEntrega.Checked = true) then
      marca:= 'X'
   else
      marca := '';

   tb.First();
   while ( tb.Eof = false) do
   begin
      ajColEntrega(marca);
      tb.Next;
   end;
   tb.First();
end;

procedure TfmEntCaminhao.btCompradorClick(Sender: TObject);
var
   params:TStringlist;
   erro:String;
begin
   params := TStringList.Create();

   params.Add( DateToStr(dm.getDateBd) );
   params.Add( edMotorista.Text );

   uProduto.getTbItensEntrega(tbDestImpr);

   getTbItensEntImpr( tb, tbDestImpr);

   if ( tbDestImpr.RecordCount = 0 ) then
      erro := dm.getMsg('err.semIt');

   if ( Length(edMotorista.Text) < 4) then
      erro := erro + dm.getMsg('err.semMot');

   if (erro <> '' )then
      msg.msgErro(erro)
   else
      fmMain.imprimeRave(tbDestImpr, nil, nil, 'rpEntregaCaminhao', params )
end;

procedure TfmEntCaminhao.FlatButton1Click(Sender: TObject);
begin
   if (tbDestImpr.RecordCount > 0) and (Length(edMotorista.Text) > 3) then
     if (  msg.msgQuestion(dm.getMsg('entCam.saida')) = mrYes  ) then
     begin
        uProduto.gravaDadosSaidaCam(tbDestImpr, edMotorista.Text);

        msg.msgExclamation(dm.getMsg('entCam.confOk'));
        fmEntCaminhao.Close();
     end;
end;

procedure TfmEntCaminhao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   fmEntCaminhao := nil;
end;

end.
