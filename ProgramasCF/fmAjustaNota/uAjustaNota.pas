unit uAjustaNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, TFlatButtonUnit, ExtCtrls, adodb, db,
  adLabelEdit, adLabelNumericEdit, ComCtrls, fCtrls, Buttons, Grids,
  DBGrids, SoftDBGrid, Menus, msg;

type
  TfmAjustaNota = class(TForm)
    Panel1: TPanel;
    edEmitDest: TadLabelEdit;
    edCFO: TadLabelEdit;
    dtEmiss: TfsDateTimePicker;
    edVlDEspExtra: TadLabelNumericEdit;
    btEmisDest: TFlatButton;
    btOk: TfsBitBtn;
    btCancela: TfsBitBtn;
    tbICM: TADOTable;
    dsICM: TDataSource;
    edSerie: TadLabelEdit;
    edNumero: TadLabelEdit;
    Label1: TLabel;
    lbIsEstoque: TLabel;
    RadioGroup1: TRadioGroup;
    gdICMS: TSoftDBGrid;
    cbOperIntegrada: TadLabelComboBox;
    cbCancelada: TfsCheckBox;
    edObservacao: TadLabelEdit;
    Label3: TLabel;
    lbTipo: TLabel;
    Label4: TLabel;
    lbLoja: TLabel;
    edIsNota: TadLabelEdit;
    edCodNFE: TadLabelEdit;
    lbCodPes: TLabel;
    Label2: TLabel;
    lbCriador: TLabel;
    dtEntSai: TfsDateTimePicker;
    Label5: TLabel;
    Label6: TLabel;
    lbPedido: TLabel;
    lbNotasRelacionadas: TLabel;
    gbItens: TGroupBox;
    gridItens: TSoftDBGrid;
    tbItens: TADOTable;
    dsItens: TDataSource;
    btCarregaNf: TFlatButton;
    edTotItens: TadLabelNumericEdit;
    edTotBase: TadLabelNumericEdit;
    edICMS: TadLabelNumericEdit;
    btPesquisa: TfsBitBtn;
    lbCodTrans: TLabel;
    RadioGroup2: TRadioGroup;
    gdIcmItem: TSoftDBGrid;
    dsIcmItens: TDataSource;
    edVlNf: TadLabelNumericEdit;
    edVlItens: TadLabelNumericEdit;
    Label7: TLabel;
    edIsOper: TadLabelEdit;
    edDescNf: TadLabelNumericEdit;
    edPercDesc: TadLabelNumericEdit;
    edVlDescRatIt: TadLabelNumericEdit;
    edVlIpi: TadLabelNumericEdit;
    edVlDesp: TadLabelNumericEdit;
    Label8: TLabel;
    PopupMenu1: TPopupMenu;
    Setavalorunitrioparaduascasas1: TMenuItem;
    SetaValordodescontoparaduascasas1: TMenuItem;
    lbIsDoc: TLabel;
    Label9: TLabel;
    Exportaritens1: TMenuItem;

    function  isGrupoRestrito():boolean;
    procedure btCancelaClick(Sender: TObject);
    procedure btEmisDestClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure carregaDadosICMS(is_nota:String);
    procedure FlatButton1Click(Sender: TObject);
    procedure btCarregaNfClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure gdICMSColExit(Sender: TObject);
    procedure gdICMSDblClick(Sender: TObject);
    procedure getItensNota();
    procedure gridItensColExit(Sender: TObject);
    procedure lbNotasRelacionadasClick(Sender: TObject);
    procedure lbNotasRelacionadasMouseLeave(Sender: TObject);
    procedure lbNotasRelacionadasMouseMove(Sender: TObject;  Shift: TShiftState; X, Y: Integer);
    procedure pesquisaNota(is_nota:String);
    procedure tbItensBeforePost(DataSet: TDataSet);
    procedure tbItensAfterScroll(DataSet: TDataSet);
    procedure calcTotalItensNf();
    procedure Label7Click(Sender: TObject);
    procedure gridItensTitleClick(Column: TColumn);
    procedure edCFODblClick(Sender: TObject);
    procedure recalculaValoresNf();
    procedure salvaValoresNf(mostraMsg:boolean);
    procedure Label8Click(Sender: TObject);
    procedure SetaValordodescontoparaduascasas1Click(Sender: TObject);
    procedure Setavalorunitrioparaduascasas1Click(Sender: TObject);
    procedure recalculaICMSDaNota(is_nota:String);
    procedure mudaCorDoLabel(var meulabel:Tlabel; cor:Tcolor);
    procedure Label7MouseLeave(Sender: TObject);
    procedure Label7MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label8MouseLeave(Sender: TObject);
    procedure Label8MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label9MouseLeave(Sender: TObject);
    procedure Label9MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Label9Click(Sender: TObject);
    procedure Exportaritens1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAjustaNota: TfmAjustaNota;
  IS_GRUPO_RESTRITO:boolean;
  NOTA_EM_EDICAO:boolean;
implementation

uses uMain, uListaFornecedores, cf, uCF, uNotasAgregadas, uAcbr, uDm, uFiscal, f,
     fdt, uLj, uPessoa;

{$R *.dfm}
procedure TfmAjustaNota.mudaCorDoLabel(var meulabel: Tlabel;cor:Tcolor);
begin
   meulabel.Font.Color := cor;
   meulabel.Refresh();
end;


procedure TfmAjustaNota.carregaDadosICMS(is_nota:String);
begin
   uFiscal.getTbDadosIcmNf(tbICM, is_nota);

   dsICM.DataSet := tbICM;

   f.ajGridCol( gdICMS, tbICM, 'tp_icm', 50, 'Tp ICM');
   f.ajGridCol( gdICMS, tbICM, '%ICMS', 40, '');
   f.ajGridCol( gdICMS, tbICM, 'Base', 70, '');
   f.ajGridCol( gdICMS, tbICM, 'Valor ICMS', 70, '');
   f.ajGridCol( gdICMS, tbICM, 'nr_item', 0, '');
   f.ajGridCol( gdICMS, tbICM, 'is_nota', 0, '');
   f.ajGridCol( gdICMS, tbICM, 'isCriado', 0, '');
   f.ajGridCol( gdICMS, tbICM, 'Seq', 0, '');
   f.ajGridCol( gdICMS, tbICM, 'is_estoque', 0, '');


// carregando os dados de ICMS dos itens locais
   dsIcmItens.DataSet:=  uFiscal.getDadosIcmsItTmp(tbItens.TableName);

   f.ajGridCol( gdIcmItem, dsIcmItens.DataSet, 'tp_icm', 50, 'Tp ICM');
   f.ajGridCol( gdIcmItem, dsIcmItens.DataSet, '%ICMS', 40, '');
   f.ajGridCol( gdIcmItem, dsIcmItens.DataSet, 'Base', 70, '');
   f.ajGridCol( gdIcmItem, dsIcmItens.DataSet, 'Valor ICMS', 70, '');
   f.ajGridCol( gdIcmItem, dsIcmItens.DataSet, 'seq', 0, '');
   f.ajGridCol( gdIcmItem, dsIcmItens.DataSet, 'is_estoque', 0, '');
end;

procedure TfmAjustaNota.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmAjustaNota := nil;
   action := cafree;
end;

procedure TfmAjustaNota.pesquisaNota(is_nota:String);
var
  ds:TADOQuery;
begin
     ds:= uFiscal.getDadosNota(is_nota,'','','');

     edIsNota.text := ds.fieldByname('is_nota').asString;
     edSerie.Text := ds.fieldByname('serie').asString;
     edNumero.Text := ds.fieldByname('num').asString;
     lbCodPes.caption := ds.fieldByname('cd_pes').asString;
     edEmitDest.Text := trim(ds.fieldByname('Emissor/Destino').asString) + ' - ' + ds.fieldByname('Endereco').asString;
     edCFO.text := ds.fieldByname('cd_cfo').asString;
     edVlDEspExtra.Value := ds.fieldByname('VL_DSPEXTRA').AsFloat;
     dtEmiss.Date := ds.fieldByname('dt_emis').AsDateTime;
     dtEntSai.date := ds.fieldByname('dt_entsai').AsDateTime;
     lbIsEstoque.caption := ds.fieldByname('is_estoque').AsString;
     cbCancelada.Checked := ( ds.fieldByname('st_nf').AsString = 'C');
     edObservacao.Text := ds.fieldByname('observacao').AsString;
     lbTipo.Caption := ds.fieldByname('Tipo').AsString;
     lbLoja.Caption := ds.fieldByname('Loja').AsString;
     lbCriador.caption := ds.fieldByname('nm_usu').AsString;
     lbPedido.Caption := ds.fieldByname('NR_PED').AsString;
     lbCodTrans.Caption := ds.fieldByname('codTransacao').AsString;
     edVlItens.Text := ds.fieldByname('vl_Tot').AsString;
     edVlNf.Text := ds.fieldByname('Valor').AsString;
     edIsOper.Text := ds.fieldByname('is_oper').AsString;
     edDescNf.text := ds.fieldByname('vl_desc').AsString;
     edPercDesc.text := ds.fieldByname('pc_desc').AsString;
     edVlDesp.Text := ds.fieldByname('VL_DSPACES').AsString;
     lbIsdoc.Caption := ds.fieldByname('is_doc').AsString;

     edVlDescRatIt.Text := ds.fieldByname('ValorDescontoItens').AsString;
     edvlIpi.Text := ds.fieldByname('vl_ipi').AsString;

     if (ds.fieldByname('cd_modnf').AsString = '6') then
     begin
        edCodNFE.Text   := ds.fieldByName('codigo_nfe').AsString;
        edCodNFE.enabled := true;
     end
     else
     begin
        edCodNFE.Text := '';
        edCodNFE.enabled := false;
     end;

// carregar os itens
     getItensNota();

//preenche os edits dos totais dos itens
   calcTotalItensNf();

// carrega ICMS da nota e dos itens
     carregaDadosICMS(is_nota);

//use a funcao de formatacao para escolher a operacao integrada
     f.setUoNacomboBox(cbOperIntegrada, ds.fieldByName('sq_opf').AsString );

     ds.Free;
     edIsNota.text := is_nota;
     Panel1.Visible := true;

     NOTA_EM_EDICAO := true;
     tbItens.First();
end;

procedure TfmAjustaNota.btEmisDestClick(Sender: TObject);
var
  cd_pes, ds_pes, ds_end:String;
begin
   if ( isGrupoRestrito() = false ) then
   begin
      if (lbTipo.Caption = 'Entrada') then
         fmMain.getDadosFornecedor(cd_pes, ds_pes, ds_end)
      else
         fmMain.getDadosCliente(cd_pes, ds_pes, ds_end);

      if (cd_pes <> '') then
      begin
         lbCodPes.caption := cd_pes;
         edEmitDest.text := ds_pes +' - '+ ds_end;
      end;
   end;
end;


procedure TfmAjustaNota.btCancelaClick(Sender: TObject);
begin
   NOTA_EM_EDICAO := false;
   f.limparCampoform('fmAjustaNota');
   panel1.Visible := false;
end;

procedure TfmAjustaNota.FlatButton1Click(Sender: TObject);
var
   cmd:String;
begin
   btCancelaClick(nil);
   cmd := '';
   cmd := uFiscal.getIsNota();

   if cmd <> '' then
      pesquisaNota(cmd)
   else
      panel1.Visible := false;
end;

procedure TfmAjustaNota.FormCreate(Sender: TObject);
begin
  cbOperIntegrada.Items := uFiscal.getOperIntegradasFiscais();
  IS_GRUPO_RESTRITO := fmMain.isGrupoRestrito( fmMain.Ajustedenotas1.Tag );
  fmMain.getParametrosForm(fmAjustaNota);

  if (IS_GRUPO_RESTRITO = false) then
  begin
     edIsNota.ReadOnly := false;
  end;
end;

procedure TfmAjustaNota.recalculaValoresNf();
begin
   f.gravaLog('-----------------------------------------------');
   f.gravaLog('Ajuste de NF' + edIsNota.Text);

   uFiscal.recalculaTotalItensNota(tbItens);

   carregaDadosICMS(edIsNota.Text);

   // insere os valores de icms da nota
   uFiscal.sicVlIcmItensComNf(dsIcmItens.DataSet, tbICM, lbIsEstoque.Caption);

   // soma os valores dos campos da tb de itens
   calcTotalItensNf();

end;

procedure TfmAjustaNota.salvaValoresNf(mostraMsg:boolean);
begin
   f.gravaLog('---------------------------------------------------------');
   f.gravaLog('Atualiza nota');
   uFiscal.upDadosNF(
      edIsNota.Text,
      lbCodTrans.Caption,
      lbCodPes.Caption,
      f.getCodUO(cbOperIntegrada),
      edCFO.Text,
      edObservacao.Text,
      cbCancelada.Checked,
      edVlDEspExtra.Value,
      dtEmiss.Date,
      dtEntSai.Date,
      edVlNf.Text,
      edVlItens.Text,
      edPercDesc.Text,
      edDescNf.Text,
      edVlDescRatIt.Text,
      edVlIpi.Text,
      edVlDesp.Text
   );

// ajustar o itens na dnotc
   uFiscal.ajustaDadosICM(
      tbICM,
      edIsNota.Text,
      copy(lbTipo.Caption, 01, 01)
   );

   NOTA_EM_EDICAO := false;

// ajustar os valores de icms dos itens
   uFiscal.ajDadosICMSItensNF(
      tbItens,
      f.getCodUO(cbOperIntegrada),
      lbCodPes.Caption,
      lbIsEstoque.Caption
   );

   f.gravaLog('---------------------------------------------------------');
   f.gravaLog('Atualiza nota - fim ');


   if (mostraMsg = true) then
      msg.msgExclamation('A nota foi Alterada...');
end;


procedure TfmAjustaNota.btOkClick(Sender: TObject);
var
   isAltera:boolean;
begin
   isAltera := true;

   if (edCodNFE.text <> '') then
      if (isGrupoRestrito() = false) then
         if (msg.msgQuestion(dm.getMsg('fiscal.MsgAjNota'))= mrNo) then
            isAltera := false;

   if (isAltera = true) then
      if msg.msgQuestion(dm.getMsg('fiscal.msgAltNF')) = mrYes then
         salvaValoresNf(true);
end;

procedure TfmAjustaNota.gdICMSColExit(Sender: TObject);
begin
   if ( tbICM.fieldByName('base').Index = gdICMS.SelectedIndex) and ( tbICM.fieldByName('%icms').AsString <> '' ) then
   begin
      tbICM.edit();
      tbICM.fieldByName('valor ICMS').AsFloat := tbICM.fieldByName('base').asFloat * (tbICM.fieldByName('%icms').asFloat / 100);
      tbICM.fieldByName('is_estoque').AsString := lbIsEstoque.caption;

      tbICM.post();
   end
end;

function TfmAjustaNota.isGrupoRestrito:boolean;
begin
    if (IS_GRUPO_RESTRITO = true) then
       msg.msgErro('Você não tem acesso a essa função');

    result := IS_GRUPO_RESTRITO;
end;

procedure TfmAjustaNota.lbNotasRelacionadasMouseLeave(Sender: TObject);
begin
//   lbNotasRelacionadas.font.Color := clRed;
   mudaCorDoLabel(lbNotasRelacionadas, clBlack);
end;

procedure TfmAjustaNota.lbNotasRelacionadasMouseMove(Sender: TObject;Shift: TShiftState; X, Y: Integer);
begin
   mudaCorDoLabel(lbNotasRelacionadas, clBlue);
end;

procedure TfmAjustaNota.lbNotasRelacionadasClick(Sender: TObject);
begin
	if (fmNotasAgregadas = nil) then
   begin
   	Application.CreateForm(TfmNotasAgregadas, fmNotasAgregadas);
		fmNotasAgregadas.ShowModal;
	   fmNotasAgregadas := nil;
   end;
end;

procedure TfmAjustaNota.Label7Click(Sender: TObject);
begin
	if msg.msgQuestion( dm.getMsg('fiscal.msgAltItNF') ) = mrYes then
   begin
      recalculaValoresNf();
   end;
end;


procedure TfmAjustaNota.gdICMSDblClick(Sender: TObject);
begin
   if ( msg.msgQuestion('Deseja mesmo remover esse ICM?')= mrYes ) then
      tbICM.Delete();
end;

procedure TfmAjustaNota.getItensNota();
begin
   uFiscal.getTbajNotas(tbItens, edIsNota.Text);

   dsItens.DataSet := tbItens;

   f.ajGridCol( gridItens, tbItens, 'is_movi', 0, '');
   f.ajGridCol( gridItens, tbItens, 'is_ref', 0, '');
   f.ajGridCol( gridItens, tbItens, 'vl_descRat', 50, 'Desc Rat');
   f.ajGridCol( gridItens, tbItens, 'tp_origem', 30, 'Origem');
   f.ajGridCol( gridItens, tbItens, 'tp_icm', 30, 'Tp Icm');
   f.ajGridCol( gridItens, tbItens, 'pc_icm', 30, '% Icm');
   f.ajGridCol( gridItens, tbItens, 'cd_ref', 50, 'Código');
   f.ajGridCol( gridItens, tbItens, 'ds_ref', 250, 'Descrição');
   f.ajGridCol( gridItens, tbItens, 'qt_mov', 50, 'Quant');
   f.ajGridCol( gridItens, tbItens, 'PrecoUnitarioLiquido', 50, 'Und');
   f.ajGridCol( gridItens, tbItens, 'total_Item', 50, 'Vl Item');
   f.ajGridCol( gridItens, tbItens, 'codCfo', 40, 'Cfop');
   f.ajGridCol( gridItens, tbItens, 'tp_icm', 50, 'Tp icms');
   f.ajGridCol( gridItens, tbItens, 'valorBaseIcms', 70, 'Base icms');
   f.ajGridCol( gridItens, tbItens, 'valorIcms', 70, 'Valor icms');
   f.ajGridCol( gridItens, tbItens, 'st_mov', 30, 'Situação');
   f.ajGridCol( gridItens, tbItens, 'nr_item', 30, 'Item');
   f.ajGridCol( gridItens, tbItens, 'seq', 0, '');
   f.ajGridCol( gridItens, tbItens, 'codRegra', 0, '');
   f.ajGridCol( gridItens, tbItens, 'descRegra', 50, 'Regra ICM');

   gbItens.Visible := true;
   gbItens.Top := btOk.Top + btOk.Height + 20;
end;

procedure TfmAjustaNota.btCarregaNfClick(Sender: TObject);
begin
   NOTA_EM_EDICAO := false;
   if (edIsNota.Text <> '') then
      pesquisaNota(edIsNota.Text);
end;

procedure TfmAjustaNota.gridItensColExit(Sender: TObject);
begin
   uFiscal.ajustaIcmdItem(tbItens);
end;

procedure TfmAjustaNota.tbItensBeforePost(DataSet: TDataSet);
begin
//   f.gravaLog('tbItensBeforePost');
   if gridItens.SelectedIndex = tbItens.FieldByName('st_mov').Index then
      if (tbItens.FieldByName('st_mov').AsString <> 'C') and (tbItens.FieldByName('st_mov').IsNull = false ) then
      begin
         tbItens.FieldByName('st_mov').AsString := '';
         msg.msgErro( dm.getMsg('MSG_VL_ERR'));
      end;
end;

procedure TfmAjustaNota.tbItensAfterScroll(DataSet: TDataSet);
begin
//   f.gravaLog('tbItensAfterScroll()');
   if ( NOTA_EM_EDICAO = true) then
      gridItensColExit(nil);
end;

procedure TfmAjustaNota.calcTotalItensNf();
var
   it, icms, base, desc:real;
   i:integer;

begin
	f.gravaLog('calcTotaIitensNf() inicio, qt Linhas: '+ intToStr(tbItens.RecordCount));

   tbItens.First();
   for i:=1 to tbItens.RecordCount do
   begin
      it := it +  tbItens.fieldByName('total_Item').AsFloat;
      base := base + tbItens.fieldByName('valorBaseIcms').AsFloat;
      icms := icms + tbItens.fieldByName('valorIcms').AsFloat;
      desc := desc + tbItens.fieldByName('vl_descRat').AsFloat;

      tbItens.Next();
   end;
   tbItens.First();

   edTotItens.Value := it; //  dm.somaColunaTable(tbItens, 'total_Item');
   edTotBase.Value := base; //dm.somaColunaTable(tbItens, 'valorBaseIcms');
   edICMS.Value :=  icms; //.somaColunaTable(tbItens, 'valorIcms');

   edDescNf.Value := desc;
   edVlNf.Value := edTotItens.Value - edDescNf.Value + edVlIpi.Value;
   edVlItens.Value := edTotItens.Value ;
   edVlDescRatIt.Value := desc;

	f.gravaLog('calcTotaIitensNf() fim');
end;

procedure TfmAjustaNota.gridItensTitleClick(Column: TColumn);
begin
   dm.organizarTabelaGrid(tbItens, gridItens, column);
end;

procedure TfmAjustaNota.edCFODblClick(Sender: TObject);
var
   i:integer;
begin
   tbItens.First();
   for i:=0 to tbItens.RecordCount do
   begin
      tbItens.Edit();
      tbItens.FieldByName('codcfo').AsString := edCFO.Text;
      tbItens.post();
      tbItens.Next();
   end;
end;

procedure TfmAjustaNota.recalculaICMSDaNota(is_nota: String);
var
   i:integer;
   ds, dsEmis, dsDest:TdataSet;
   ufEmissor, campoCFO:String;
   tpIcms, percIcm:String;
begin
   if (edIsNota.Text = '') then
   begin
      edIsNota.Text := is_nota;
      btCarregaNfClick(nil);
   end;

   ds:= uFiscal.getDadosOprInt(f.getCodUO(cbOperIntegrada));

   dsDest :=   uPessoa.getDadosPessoa(lbCodPes.Caption);

   ufEmissor := uLj.getDadosUo(lbIsEstoque.Caption, 'CD_UF');

   tbItens.First();
   for i:=1 to tbItens.RecordCount do
   begin
      tbItens.Edit();
      campoCFO :=
      uFiscal.getCampoCfo(
         ufEmissor,
         dsDest.fieldByName('cd_uf').AsString,
         dsDest.fieldByName('cd_uf').AsString,
         tbItens.fieldByName('codRegra').AsInteger
      );

      tbItens.FieldByName('codCFO').AsString := ds.fieldByName(campoCFO).AsString;

// definir o tipo de icms e o percentual

     tpIcms:= '';
     PercIcm:= '';

     uFiscal.getPercICMItNf(
        tbItens.fieldByName('is_ref').AsString,
        dsDest.fieldByName('cd_sexo').AsString,
        ufEmissor,
        dsDest.fieldByName('cd_uf').AsString,
        ds.fieldByName('FL_ICMS').AsString,
        percIcm,
        tpIcms
      );

      tbItens.FieldByName('pc_Icm').AsString := percIcm;
      tbItens.FieldByName('tp_Icm').AsString := tpIcms;


      tbItens.Post();
      tbItens.Next();
   end;
   tbItens.First();
   edCFO.Text :=  tbItens.FieldByName('codCFO').AsString;
end;


procedure TfmAjustaNota.Label8Click(Sender: TObject);
begin //
   recalculaICMSDaNota(edIsNota.Text);
end;


procedure TfmAjustaNota.SetaValorDoDescontoParaDuasCasas1Click(
  Sender: TObject);
begin
   dm.setaCampoMoneyParaDuasCasas(tbItens, 'vl_DescRat');
end;

procedure TfmAjustaNota.Setavalorunitrioparaduascasas1Click(
  Sender: TObject);
begin
   dm.setaCampoMoneyParaDuasCasas(tbItens, 'precoUnitarioLiquido');
end;



procedure TfmAjustaNota.Label7MouseLeave(Sender: TObject);
begin
   mudaCorDoLabel(label7, clBlack);
end;

procedure TfmAjustaNota.Label7MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   mudaCorDoLabel(label7, clBlue);
end;

procedure TfmAjustaNota.Label8MouseLeave(Sender: TObject);
begin
   mudaCorDoLabel(label8, clBlack);
end;

procedure TfmAjustaNota.Label8MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   mudaCorDoLabel(label8, clBlue);
end;

procedure TfmAjustaNota.Label9MouseLeave(Sender: TObject);
begin
   mudaCorDoLabel(label9, clBlack);
end;

procedure TfmAjustaNota.Label9MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
   mudaCorDoLabel(label9, clBlue);

end;

procedure TfmAjustaNota.Label9Click(Sender: TObject);
begin
   if msg.msgQuestion('Vou recalcular a nota e recarregar de novo, continua ?') =mrYes then
   begin
      dm.execSQL(dm.getCMD1('fiscal', 'recalculaIPI', edIsNota.Text));
      btCarregaNfClick(nil);
   end;
end;

procedure TfmAjustaNota.Exportaritens1Click(Sender: TObject);
begin
   fmmain.exportaDataSet(tbItens, nil);
end;

end.

