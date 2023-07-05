unit uLstPcAlt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, ComCtrls, fCtrls, adLabelComboBox, DB,
  Grids, DBGrids, SoftDBGrid, TFlatButtonUnit, ExtCtrls, ADODB;

type
  TfmLstPcAlt = class(TForm)
    Panel1: TPanel;
    cbLojas: TadLabelComboBox;
    dti: TfsDateTimePicker;
    dtf: TfsDateTimePicker;
    cbPreco: TadLabelComboBox;
    Label1: TLabel;
    Label2: TLabel;
    edCodigo: TadLabelEdit;
    edDesc: TadLabelEdit;
    btConsultar: TFlatButton;
    Panel2: TPanel;
    grid: TSoftDBGrid;
    dsPcs: TDataSource;
    qr: TADOQuery;
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    procedure getDadosItem(cod:String);
    procedure btConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridTitleClick(Column: TColumn);
    procedure gridDblClick(Sender: TObject);

  private
     is_ref:String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLstPcAlt: TfmLstPcAlt;

implementation

{$R *.dfm}

uses uEstoque, f, uDm, uMain, uPreco, uLj, msg, uProd;

procedure TfmLstPcAlt.getDadosItem(cod:String);
var
  ds:TdataSet;
begin
   ds:= uProd.getDadosProd( f.getCodUO(cbLojas), cod, '', f.getCodPc(cbPreco), true);
   if ( ds.IsEmpty = false ) then
   begin
      is_ref := ds.fieldByName('is_ref').AsString;
      edDesc.Text := ds.fieldByName('descricao').AsString;
      edCodigo.Text := ds.fieldByName('codigo').AsString;
   end
   else
      is_ref := '';

   ds.Free();
end;

procedure TfmLstPcAlt.edCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key = VK_return) then
     getDadosItem(edCodigo.Text);
end;

procedure TfmLstPcAlt.btConsultarClick(Sender: TObject);
begin
   getDadosItem(edCodigo.Text);

   if (is_ref <> '') then
   begin
      uPreco.getAlteracoesPrecoItem(qr, is_ref, f.getCodUO(cbLojas), f.getCodPc(cbPreco), dti.Date, dtf.date);
      f.ajGridCol(grid, qr, 'ds_uo', 150, 'Loja');
      f.ajGridCol(grid, qr, 'ds_tipopreco', 100, 'Tp Preço');
      f.ajGridCol(grid, qr, 'dt_altpv', 100, 'Data alteração');
      f.ajGridCol(grid, qr, 'vl_preco', 100, 'Preço');
      f.ajGridCol(grid, qr, 'cd_usu', 0, '');
      f.ajGridCol(grid, qr, 'dt_dig', 150, 'Digitado em');
      f.ajGridCol(grid, qr, 'nm_pes', 150, 'Lançado por');
      f.ajGridCol(grid, qr, 'is_alp', 0, '');
      f.ajGridCol(grid, qr, 'is_oap', 0, '');
   end
end;

procedure TfmLstPcAlt.FormCreate(Sender: TObject);
begin
   uLj.getListaLojas(cbLojas, true, false, fmMain.getCdPesLogado(), '');
   cbPreco.Items := uPreco.getListaPrecos(false, false, false, fmMain.getGrupoLogado());
   cbPreco.ItemIndex := 0;

   dti.Date := dm.getDateBd();
   dtf.Date := dti.Date;

   self.Left := application.MainForm.Left;
   self.Width := application.MainForm.Width;

   cbLojas.ItemIndex := 0;
end;

procedure TfmLstPcAlt.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
   fmLstPcAlt := nil;
end;

procedure TfmLstPcAlt.gridTitleClick(Column: TColumn);
begin
   dm.organizarQuery(qr, grid, Column);
end;

procedure TfmLstPcAlt.gridDblClick(Sender: TObject);
begin
   if (msg.msgQuestion(dm.getMsg('pedcliente.pedAprov')) = mrYes) then
   begin
      uPreco.removePreco( qr.fieldByName('is_alp').AsString, qr.fieldByName('is_oap').AsString  );
      btConsultarClick(nil);
   end;
end;

end.
