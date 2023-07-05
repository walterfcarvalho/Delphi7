unit uConReqProd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, adLabelComboBox, ComCtrls,
  adLabelDBDateTimePicker, DB, ADODB, Grids, DBGrids, SoftDBGrid,
  fCtrls, ExtCtrls, adLabelEdit, Menus;

type
  TfmConReqProduto = class(TForm)
    grid: TSoftDBGrid;
    dataSource: TDataSource;
    Panel1: TPanel;
    edCodigo: TadLabelEdit;
    cbLojas: TadLabelComboBox;
    dti: TfsDateTimePicker;
    dtf: TfsDateTimePicker;
    btConsultar: TFlatButton;
    Label1: TLabel;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    Verrequisiotransferidas1: TMenuItem;
    cbDestReq: TadLabelComboBox;
    remItemDaRequisicao: TMenuItem;
    Removereincluirnoprximoabastecimento1: TMenuItem;
    lbItem: TLabel;
    procedure consultaPedidos(is_ref:String);
    procedure btConsultarClick( sender:Tobject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure consultaExterna(cd_ref, uo:String; dataInicio:Tdate);
    procedure Verrequisiotransferidas1Click(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure remItemDaRequisicaoClick(Sender: TObject);
    procedure Removereincluirnoprximoabastecimento1Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmConReqProduto: TfmConReqProduto;

  UO_CD:String;

  implementation

uses uMain, funcsql, f, cf, fdt, uReqTransferidas, uEstoque, uLj, msg, uDm, uReq, uProd;

{$R *.dfm}

procedure TfmConReqProduto.consultaPedidos(is_ref:String);
var
  i:integer;
begin
   DataSource.DataSet :=  uReq.getReqPorItem(is_ref, f.getCodUO(cbLojas), dti.Date, dtf.Date, false, '', f.getCodUO(cbDestReq), '' );

   for i := 0 to grid.columns.count -1 do
      grid.Columns[i].Title.Font.Style := [fsBold];

   f.ajGridCol(grid, dataSource.DataSet, 'AutOs', 50, 'Usuário aut OS');

   grid.Columns[dataSource.DataSet.FieldByName('data').Index].Width := 70;
   grid.Columns[dataSource.DataSet.FieldByName('Requisição').Index].Width := 65;
   grid.Columns[dataSource.DataSet.FieldByName('Loja').Index].Width := 130;

   grid.Columns[dataSource.DataSet.FieldByName('Pedido').Index].Width := 60;
   grid.Columns[dataSource.DataSet.FieldByName('Pendente').Index].Width := 60;
   grid.Columns[dataSource.DataSet.FieldByName('Em Separação').Index].Width := 60;
   grid.Columns[dataSource.DataSet.FieldByName('Separada').Index].Width := 60;
   grid.Columns[dataSource.DataSet.FieldByName('transferida').Index].Width := 60;
   grid.Columns[dataSource.DataSet.FieldByName('Cancelada').Index].Width := 60;


   grid.Columns[dataSource.DataSet.FieldByName('is_ref').Index].Visible := false;
   grid.Columns[dataSource.DataSet.FieldByName('ds_ref').Index].Visible := false;
   grid.Columns[dataSource.DataSet.FieldByName('cd_ref').Index].Visible := false;

   grid.Columns[dataSource.DataSet.FieldByName('is_uo').Index].Visible := false;

end;

procedure TfmConReqProduto.btConsultarClick( sender:Tobject);
var
   erro:String;
   dsItem:Tdataset;
begin
   if dti.Date > dtf.Date then
      erro :=  dm.getMsg('MSG_DT_1');

   if (erro <> '') then
      msg.msgErro( dm.getMsg('MSG_ERRO_TIT') + erro)
   else
   begin
      // verificar Se o produto é cadastrado, quando for consultar por produto.
      dsItem:= uProd.getDadosProd(fmMain.getUOCD, edCodigo.text, '', '101', true );

      lbItem.Caption := dsItem.fieldByName('codigo').AsString + ' - '+ dsItem.fieldByName('descricao').AsString;

      if (dsItem.IsEmpty = false) then
      begin
         UO_CD := f.getCodUO(cbDestReq);
         consultaPedidos(dsItem.fieldByName('is_ref').AsString  );
      end;

      ds.Free();
   end;
end;

procedure TfmConReqProduto.FormCreate(Sender: TObject);
begin
	grid.Align := alClient;
   uLj.getListaLojas(cbLojas, true, false, fmMain.getCdPesLogado(), fmMain.getUoLogada());
   ulj.getComboBoxLjMapa(cbDestReq);
   cbDestReq.ItemIndex := 0;
   cbLojas.ItemIndex := 0;

   dti.Date := now-5;
   dtf.Date := now;

   // habilita remover o item da requisicao
   remItemDaRequisicao.Enabled := fmMain.isAcessoTotal( fmMain.ConsultaarequisioCDporproduto1.Tag);
   Removereincluirnoprximoabastecimento1.Enabled :=  fmMain.isAcessoTotal( fmMain.ConsultaarequisioCDporproduto1.Tag);
end;

procedure TfmConReqProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if (fmReqTransferidas <> nil) then
      fmReqTransferidas.close();

   action := CaFree;
   fmConReqProduto:= nil;
end;

procedure TfmConReqProduto.consultaExterna(cd_ref, uo: String; dataInicio: Tdate);
begin
   edCodigo.Text := cd_ref;
   edCodigo.Enabled := false;
   f.setUoNacomboBox(cbLojas, uo);

   if (cbLojas.ItemIndex = -1) then
     cbLojas.ItemIndex := 0;

   dti.Date := dataInicio;
   btConsultarClick(nil);
end;

procedure TfmConReqProduto.Verrequisiotransferidas1Click(Sender: TObject);
begin
   if (dataSource.DataSet.IsEmpty = false ) then
       fmMain.getRequisicoesTransferidas( dataSource.DataSet.fieldByname('is_ref').asString,
                                          dataSource.DataSet.fieldByname('is_uo').asString,
                                          dataSource.DataSet.fieldByname('data').AsDateTime,
                                          now
                                        );
end;

procedure TfmConReqProduto.gridCellClick(Column: TColumn);
var
   i:integer;
begin
   for i:= 0 to dataSource.DataSet.FieldCount-1 do
   f.gravaLog(dataSource.DataSet.Fields[i].FieldName + ': '+  intToStr(grid.Columns[i].Width)  );
end;

procedure TfmConReqProduto.remItemDaRequisicaoClick(Sender: TObject);
var
  num:String;
begin
   if ( dataSource.DataSet.IsEmpty = false) then
      if (dataSource.DataSet.FieldByName('transferida').AsInteger <> 0) or
         (dataSource.DataSet.FieldByName('cancelada').AsInteger <> 0) then
            msg.msgErro(dm.getMsg('errRemItemReq'))
      else
      begin
         num := msg.msgInput('Informe a nova quantidade (zero remove o item):', '');

         if (num <> '') then
            if (f.isNumero(num, false) = false) or ( strToint(num) > dataSource.DataSet.FieldByName('pedido').AsInteger ) then
               msg.msgErro(dm.getMsg('osDepErrQtZero'))
             else
                if (msg.msgQuestion( dm.getMsg('msgConfQt') +' '+ num) = mrYes) then
                begin
                   uReq.remItemDaRequisicao(
                      dataSource.DataSet.FieldByName('Requisição').AsString,
                      dataSource.DataSet.FieldByName('os').AsString,
                      dataSource.DataSet.FieldByName('is_ref').AsString,
                      strToInt(num)
                   );
                   btConsultarClick(nil);
                end;
      end;
end;

procedure TfmConReqProduto.Removereincluirnoprximoabastecimento1Click(
  Sender: TObject);
begin
   if ( dataSource.DataSet.IsEmpty = false) then
      if (dataSource.DataSet.FieldByName('transferida').AsInteger <> 0) or
         (dataSource.DataSet.FieldByName('cancelada').AsInteger <> 0) then
            msg.msgErro(dm.getMsg('errRemItemReq'))
      else
         if msg.msgQuestion(dm.getMsg('wms_remove_insere_nova')) = mrYes then
         begin
             uReq.salvaItReqAbast(
                  dataSource.DataSet.FieldByName('is_uo').AsString,
                  dataSource.DataSet.FieldByName('is_ref').AsString,
                  dataSource.DataSet.FieldByName('Pedido').AsString,
                  dataSource.DataSet.FieldByName('Pedido').AsString,
                  UO_CD
               );

               uReq.remItemDaRequisicao(
                  dataSource.DataSet.FieldByName('Requisição').AsString,
                  dataSource.DataSet.FieldByName('os').AsString,
                  dataSource.DataSet.FieldByName('is_ref').AsString,
                  0
               );
               btConsultarClick(nil);
         end;
end;

end.
