unit uConsultaPedCompra;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, ComCtrls, fCtrls, TFlatButtonUnit,
  adLabelEdit, DB, ADODB, adLabelNumericEdit, adLabelSpinEdit, ExtCtrls;

type
  TfmConsultaPedCompra = class(TForm)
    grBoxDatas: TGroupBox;
    Label1: TLabel;
    di: TfsDateTimePicker;
    df: TfsDateTimePicker;
    cbLojas: TadLabelComboBox;
    cbPessoa: TadLabelComboBox;
    edEmitDest: TadLabelEdit;
    btEmisDest: TFlatButton;
    btOk: TFlatButton;
    tbPedidos: TADOTable;
    lbCdpes: TLabel;
    tbParcelas: TADOTable;
    tbPedidosPedido: TIntegerField;
    tbPedidosdt_emis: TDateTimeField;
    tbPedidosnm_usu: TStringField;
    tbPedidoscd_pes: TIntegerField;
    tbPedidosnm_razsoc: TStringField;
    tbPedidosvl_merc: TBCDField;
    tbPedidosvl_total: TBCDField;
    tbPedidosVlPendente: TBCDField;
    tbPedidosds_prazo: TStringField;
    tbParcCons: TADOTable;
    tbParcConsseq: TAutoIncField;
    tbParcConsmes_ano: TStringField;
    tbParcConsano_mes: TStringField;
    tbParcConsvalor: TBCDField;
    tbPedRes: TADOTable;
    tbPedResseq: TAutoIncField;
    tbPedResnm_usu: TStringField;
    tbPedResvl_merc: TBCDField;
    tbPedResvl_total: TBCDField;
    tbPedResVlPendente: TBCDField;
    tbParcConsvlFornADM: TBCDField;
    cbPendentes: TfsCheckBox;
    tbParcConsvalor2: TBCDField;
    gbAlteraDatas: TGroupBox;
    edNumDias: TadLabelSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    FlatButton1: TFlatButton;
    pnCategoria: TPanel;
    lbNivel: TLabel;
    lbVlCat: TLabel;
    lbClasse1: TLabel;
    lbClasse2: TLabel;
    lbClasse3: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    FlatButton7: TFlatButton;
    Bevel2: TBevel;
    procedure btEmisDestClick(Sender: TObject);
    procedure i(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure calculaValorespedCompra();
    procedure edEmitDestDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure FlatButton7Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmConsultaPedCompra: TfmConsultaPedCompra;
  isAcessoRestrito:boolean;
implementation

uses uMain, cf, ucf, f, uPedFornecedor, msg, uLj, fdt;

{$R *.dfm}

procedure TfmConsultaPedCompra.btEmisDestClick(Sender: TObject);
var
   cd_pes, ds_pes, ds_end:String;
begin
   fmMain.getDadosFornecedor(cd_pes, ds_pes, ds_end);
   if (cd_pes <> '') then
   begin
      edEmitDest.Text := ds_pes;
      lbCdpes.caption := cd_pes;
   end
   else
   begin
      edEmitDest.Text := '';
      lbCdpes.caption := '';
   end
end;

procedure TfmConsultaPedCompra.calculaValorespedCompra;
var
   params:TStringList;
begin
   f.gravaLog('------------------------- calculaValorespedCompra()');

   uPedfornecedor.getDadosPedidosFornecedor(
      tbPedidos, di.Date, df.Date, f.getCodUO(cbLojas),
      f.getCodUO(cbPessoa), lbCdpes.Caption,
      cbPendentes.Checked, lbNivel.Caption, lbVlCat.Caption, ''
   );

   // obter os dados das parcelas dos pedidos
   uPedFornecedor.getTotaisParcPedforn(tbPedidos, tbParcelas, tbParcCons);

   uPedFornecedor.getTotaisPedidosFornecedor(tbPedidos, tbPedRes);

 //calcular os totais dos pedidos
   cf.getValoresFornADM(tbParcCons);

   fmMain.msgStatus('');

   if ( tbPedidos.IsEmpty = false ) then
   begin
      params := TStringList.Create();

      params.Add(dateToStr(di.Date));
      params.Add(dateToStr(df.Date));
      params.Add(fmMain.getNomeUsuario());
      params.Add(edEmitDest.Text);
      params.Add(uLj.getNomeUO(cbPessoa) );
      params.Add(lbClasse1.Caption);
      params.Add(lbClasse2.Caption);
      params.Add(lbClasse3.Caption);

      fmMain.imprimeRave(tbPedidos, tbParcCons, tbPedRes, nil, nil, 'rpResPedForn', params);

      tbPedidos.Close();
      tbParcelas.Close();
      tbParcCons.Close();
      tbPedRes.Close();
      params.Free();
   end
   else
      msg.msgErro('Não existem pedidos para essa consulta');
end;

procedure TfmConsultaPedCompra.i(Sender: TObject);
begin
   if (fdt.isIntervDataValido( di, df, true, 3600) = true) then
     calculaValorespedCompra();
end;

procedure TfmConsultaPedCompra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
   fmConsultaPedCompra := nil;
end;

procedure TfmConsultaPedCompra.edEmitDestDblClick(Sender: TObject);
begin
   btEmisDestClick(nil);
end;

procedure TfmConsultaPedCompra.FormCreate(Sender: TObject);
begin
   uLj.getListaLojas( cbLojas, true, false, fmMain.getCdPesLogado(), fmMain.getUoLogada() );
   ucf.getCompradores(cbPessoa);
   lbCdpes.Caption := '';

   di.Date := strToDate('01/' + copy(dateToStr(now), 04, 07));
   df.Date := now;

   isAcessoRestrito :=  fmMain.isGrupoRestrito(fmMain.Listapedidosdecompra1.Tag);

   fmConsultaPedCompra.Caption := fmMain.getCaptionNivelAcesso(fmConsultaPedCompra.Caption, isAcessoRestrito);

   gbAlteraDatas.Visible := not(isAcessoRestrito);
end;

procedure TfmConsultaPedCompra.FlatButton1Click(Sender: TObject);
begin
   if (fdt.isIntervDataValido( di, df, true, 3600) = true) then
      uPedfornecedor.mudaDataPedidoDeCompra( tbPedidos, edNumDias.value, f.getCodUO(cbPessoa), lbCdpes.Caption );
end;

procedure TfmConsultaPedCompra.FlatButton7Click(Sender: TObject);
begin
   fmMain.ajustaValoresCategorias(lbClasse1, lbClasse2, lbClasse3, lbNivel, lbVlCat);
end;

end.
