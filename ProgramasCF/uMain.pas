unit uMain;

interface

uses
  ComObj, qforms, Jpeg, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, Menus, DB, ADODB, ComCtrls, StdCtrls, mxOneInstance,
  ExtCtrls, RpCon, RpConDS, RpBase, RpSystem, RpDefine, RpRave, Typinfo, DBCtrls,
  AppEvnts, RpRender, RpRenderPDF, RpRenderCanvas, RpRenderPrinter, OleCtrls,
  mxExport, CoolTrayIcon, ToolWin, ImgList, Buttons, adLinkedButton,
  xmldom, Xmlxform, DBClient, Provider, Grids, DBGrids, uHash, adLabelListBox;
type
  TfmMain = class(TForm)
    menuPrincipal: TMainMenu;
    Estoques1: TMenuItem;
    ConsultaaRequisies1: TMenuItem;
    Preos1: TMenuItem;
    abeladePreos1: TMenuItem;
    Consultaarequisies2: TMenuItem;
    Precosalteradosporperodo1: TMenuItem;
    Fiscal1: TMenuItem;
    Vendas1: TMenuItem;
    Funcoes1: TMenuItem;
    Propostasdaloja1: TMenuItem;
    StatusBar1: TStatusBar;
    Requisicoentreloas1: TMenuItem;
    rocardeUsuario1: TMenuItem;
    Requisicaoparaocd1: TMenuItem;
    Cadastrodeavarias1: TMenuItem;
    Relatorios1: TMenuItem;
    Relacaodenotasdetransferncia1: TMenuItem;
    Mapadeseparao1: TMenuItem;
    abeladePreos2: TMenuItem;
    Precosalteradosporperodo2: TMenuItem;
    Descontodepedido1: TMenuItem;
    AjustedePrecos1: TMenuItem;
    Relatorios2: TMenuItem;
    AnaliseVLC1: TMenuItem;
    RvProject1: TRvProject;
    RvSystem1: TRvSystem;
    RvDSConn: TRvDataSetConnection;
    Etiquetas1: TMenuItem;
    EtiquetasDeClientes1: TMenuItem;
    Geracaopreodecusto1: TMenuItem;
    N1: TMenuItem;
    RelatriodeComisso1: TMenuItem;
    Funcoes2: TMenuItem;
    Comporavendafiscal1: TMenuItem;
    Ajustedenotas1: TMenuItem;
    Analisedeestoque1: TMenuItem;
    Requisiodereposio1: TMenuItem;
    RequisioparaoCDAbastecimento1: TMenuItem;
    ConsultaarequisioCDporproduto1: TMenuItem;
    compras1: TMenuItem;
    Alterafornpedidodecompra1: TMenuItem;
    Classificaodepro1: TMenuItem;
    RvDSConn2: TRvDataSetConnection;
    Cadastrarcodigodebarrasdeproduto1: TMenuItem;
    DeletarRegistrodecartoTEF1: TMenuItem;
    CadastrarNCM1: TMenuItem;
    administrao1: TMenuItem;
    Permisses1: TMenuItem;
    Fornecedoresaignorarnarequisio1: TMenuItem;
    Mudafinanceiradeboleto1: TMenuItem;
    MudaversodoBD1: TMenuItem;
    Fichasdefornecedorpordata1: TMenuItem;
    parmetrosdosistema1: TMenuItem;
    AjustedoarquivoSPED1: TMenuItem;
    Listarcustodeitensporpedido1: TMenuItem;
    EnviarXML1: TMenuItem;
    ImprimirNFe1: TMenuItem;
    RvRenderPDF1: TRvRenderPDF;
    Saldofiscalpormes1: TMenuItem;
    EnviarespelhoPDFdeNFeparaemail1: TMenuItem;
    Pagamentosemcarto1: TMenuItem;
    Cargadedadosparaconciliao1: TMenuItem;
    ImprimirDANFE1: TMenuItem;
    RvDSConn3: TRvDataSetConnection;
    RvDSConn4: TRvDataSetConnection;
    Geraestoque1: TMenuItem;
    Processarinventrio1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Produtostransferidos1: TMenuItem;
    Log1: TMenuItem;
    ListaCuponspordia1: TMenuItem;
    RazoAnalticoRRANA1: TMenuItem;
    CadastrodeCEP1: TMenuItem;
    mxOneInstance1: TmxOneInstance;
    ConfiguraSeriesparacontingencia1: TMenuItem;
    RvDSConn5: TRvDataSetConnection;
    Cadastrodeimagens1: TMenuItem;
    AlteraStatusdoCaixa1: TMenuItem;
    ImpressorasNFE1: TMenuItem;
    ResumoCaixa1: TMenuItem;
    Exportacaodeitesdepedido1: TMenuItem;
    ListaItenssemmovimentao1: TMenuItem;
    RemoverEansinvalidos2: TMenuItem;
    Ajustanumerodenota1: TMenuItem;
    Cargadadosdasvendas1: TMenuItem;
    ListaItensemseparaonoCD1: TMenuItem;
    Funes1: TMenuItem;
    Relatrios1: TMenuItem;
    Listapedidosdecompra1: TMenuItem;
    RotinasDiversas1: TMenuItem;
    CrditodeCliente1: TMenuItem;
    Contbil1: TMenuItem;
    Removerlancamentos1: TMenuItem;
    Sincronizarplanodecontas1: TMenuItem;
    Cadastrodebairros1: TMenuItem;
    AjustachaveNFe1: TMenuItem;
    Etiquetasparatapetes1: TMenuItem;
    emiteGuiaEntrega: TMenuItem;
    Rebibodevenda1: TMenuItem;
    CoolTrayIcon1: TCoolTrayIcon;
    mnResDiario: TMenuItem;
    mnAprovaPedCli: TMenuItem;
    BuscarnosservidoresXMLdeumanota1: TMenuItem;
    Fluxodeclientesporhora1: TMenuItem;
    ImageList1: TImageList;
    SalvarXMLdenfe1: TMenuItem;
    GeraReqvendaapartirdepedido1: TMenuItem;
    FinalizarnotadeentradanoWMS1: TMenuItem;
    FinalizarOSnoWMS1: TMenuItem;
    Impressodepedidodefornecedor1: TMenuItem;
    PesquisaXML1: TMenuItem;
    Acertodeestoque1: TMenuItem;
    WMS1: TMenuItem;
    Cancelarrequisiespendentes1: TMenuItem;
    ListaitensmovimentadoswellxWms1: TMenuItem;
    Formatacomando1: TMenuItem;
    Listafichasporcatcontabil1: TMenuItem;
    ListaestoquedivergenteWellxWms1: TMenuItem;
    Zerarpickingestoquenegativo1: TMenuItem;
    Vendabrutafornecedorvalor1: TMenuItem;
    GeraEANvlidoaleatrio1: TMenuItem;
    DadosEntradasadaevenda1: TMenuItem;
    Gerarumanotacomositensdeoutra1: TMenuItem;
    mnAnMovEstCd: TMenuItem;
    mnRelCredCli: TMenuItem;
    mnRestoreOs: TMenuItem;
    imprim1: TMenuItem;
    Espelhodetrocadeprodutos1: TMenuItem;
    Ajustedecaddecidade1: TMenuItem;
    IncluirItememOramento1: TMenuItem;
    AlterarQuantidadeporcaixa1: TMenuItem;
    CadastradadosparaoProtheus1: TMenuItem;
    ListaVarejoecustodeitensvendidos1: TMenuItem;
    CalcularFatordopedido1: TMenuItem;
    AjustaNFJaboti1: TMenuItem;
    versao: TStaticText;
    sub_versao: TStaticText;
    mnSpedContabil: TMenuItem;
    ReceberNotadeTransfernciaXML1: TMenuItem;
    mxDataSetExport1: TmxDataSetExport;

    function converterJPegParaBmp(Arquivo: string):String;
    function converterBmpParaJPeg(Arquivo: string):String;    
    function ehCampoPermitido(nParam:String): Boolean;
    function ehTelaPermitida(tag:string;  Telas:Tstrings):Boolean;
    function enviarEmail(para, assunto, anexo:String; corpoMsg:Tstringlist; titJanela:String): boolean;
    function getUoEmpresa():String;
    function getCaptionNivelAcesso(captionForm:String; is_restrito:boolean):String;
    function getCD_PES(tipo: String):String;
    function getCdPesLogado():String;
    function getCodPreco(cb:TCustomComboBox): String;
    function getDescPreco(cb:TCustomComboBox):String;
    function getDescUO(cb:TCustomComboBox):String;
    function getGrupoLogado():String;
    function getNomeLojaLogada():String;
    function getNomeUsuario():String;
    function getTpImpressao():integer;
    function getUOCD():String;
    function getUoLogada():String;
    function getUserLogado:String;
    function isAcessoTotal(codTela: integer): boolean;
    function isGrupoRestrito(codTela: integer): boolean;
    function isPermiteAbrirTela( codTela:smallInt ): boolean;
    function getStrArqResource():String;
    function isTelaRequerSenha( codTela:smallInt ):boolean;
    function getDadosConEmail(uo:String):THash;
    function getStrLogoEmpresa():String;

    procedure AppException(Sender: TObject; E: Exception);
    procedure abreFormRequisicao(mostraMsg:Boolean; perfil:integer);
    procedure abreTelaConsultaRequisicao(cd_ref, uo: String; dataInicio: Tdate);
    procedure ajustaValoresCategorias(var descCat01, descCat02, descCat03, numNivel, vlNivel:Tlabel);
    procedure consultaRequisicaoPorProduto(cd_Ref: String);
    procedure exportaDataSet(ds:TdataSet; msgEmail:Tstringlist);
    procedure exportaDataSetNome(ds:TdataSet; msgEmail: Tstringlist; nomeArq:String);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure getDadosFornecedor(var cd_pes, nome, ds_end:String);
    procedure getDadosPessoa(var cd_pes, nome, ds_end: String; tipo:String);
    procedure getParametrosForm(form:Tform);
    procedure getPedidosFornecedor(is_ref, uo:String);
    procedure impressaoRavePDF(qr,qr2:TDataSet; nRelatorio:String; params:Tstrings;nmArquivo:String);
    procedure imprimeRave(qr, qr2, qr3, qr4, qr5:TDataSet; nRelatorio:String; params:Tstrings);
    procedure montarMenu(nomeloja, is_uo, is_usu:string);
    procedure mostraDetalhesNota(is_nota:String);
    procedure verificaPermissao(item:TmenuItem; camposPermitidos:Tstringlist);
    procedure visualizarDANFE(Sender: TObject);
    procedure loginAutomatico();
    procedure msgStatusProgresso(Index, count:integer; msg:String);
    procedure msgStatus(msg:String);
    procedure getDadosCliente(var cd_pes, nome, ds_end: String);
    procedure getDadosCRUC(is_ref:String);
    procedure etiquetasParaTapetes(qt:integer);

    procedure abeladePreos2Click(Sender: TObject);
    procedure Ajustedenotas1Click(Sender: TObject);
    procedure AjustedePrecos1Click(Sender: TObject);
    procedure ajustedoarquivoSPED1Click(Sender: TObject);
    procedure Alterafornpedidodecompra1Click(Sender: TObject);
    procedure AlteraStatusdoCaixa1Click(Sender: TObject);
    procedure Analisedeestoque1Click(Sender: TObject);
    procedure AnaliseVLC1Click(Sender: TObject);
    procedure applicationEvents1Exception(Sender: TObject; E: Exception);
    procedure Cadastrarcodigodebarrasdeproduto1Click(Sender: TObject);
    procedure CadastrarNCM1Click(Sender: TObject);
    procedure Cadastrodeavarias1Click(Sender: TObject);
    procedure CadastrodeCEP1Click(Sender: TObject);
    procedure Cadastrodeimagens1Click(Sender: TObject);
    procedure cargadedadosparaconciliao1Click(Sender: TObject);
    procedure Classificaodepro1Click(Sender: TObject);
    procedure Comporavendafiscal1Click(Sender: TObject);
    procedure compromissosdefornecedorespordata1Click(Sender: TObject);
    procedure ConfiguraSeriesparacontingencia1Click(Sender: TObject);
    procedure Consultaarequisies2Click(Sender: TObject);
    procedure ConsultaarequisioCDporproduto1Click(Sender: TObject);
    procedure CoolTrayIcon1Click(Sender: TObject);
    procedure deletarRegistrodecartoTEF1Click(Sender: TObject);
    procedure Descontodepedido1Click(Sender: TObject);
    procedure enviarespelhoPDFdeNFeparaemail1Click(Sender: TObject);
    procedure enviarXML1Click(Sender: TObject);
    procedure Etiquetas1Click(Sender: TObject);
    procedure EtiquetasDeClientes1Click(Sender: TObject);
    procedure Fornecedoreacriticar1Click(Sender: TObject);
    procedure Geracaopreodecusto1Click(Sender: TObject);
    procedure Geraestoque1Click(Sender: TObject);
    procedure ImpressorasNFE1Click(Sender: TObject);
    procedure imprimirDANFE1Click(Sender:Tobject);
    procedure ListaCuponspordia1Click(Sender: TObject);
    procedure listarcustodeitensporpedido1Click(Sender: TObject);
    procedure Log1Click(Sender: TObject);
    procedure mapadeseparao1Click(Sender: TObject);
    procedure mudarfinanceiradeboleto1Click(Sender: TObject);
    procedure mxOneInstance1InstanceExists(Sender: TObject);
    procedure n1Click(Sender: TObject);
    procedure obterDetalhesEntrada(is_ref:String);
    procedure obterDetalhesSaida(is_ref, uo:String; dtInicio:Tdate);
    procedure obterResumoEntSai(isref, uo: String);
    procedure obterResumoEstoque(is_ref, is_disponivel:String);
    procedure pagamentosEmCartao1Click(Sender: TObject);
    procedure parmetrosDoSistema1Click(Sender: TObject);
    procedure permisses2Click(Sender: TObject);
    procedure precosalteradosporperodo2Click(Sender: TObject);
    procedure Processarinventrio1Click(Sender: TObject);
    procedure Produtostransferidos1Click(Sender: TObject);
    procedure propostasdaloja1Click(Sender: TObject);
    procedure RazoAnalticoRRANA1Click(Sender: TObject);
    procedure relacaodenotasdetransferncia1Click(Sender: TObject);
    procedure relatriodeComisso1Click(Sender: TObject);
    procedure requisicaoparaocd1Click(Sender: TObject);
    procedure requisicoEntreLoas1Click(Sender: TObject);
    procedure requisiodereposio1Click(Sender: TObject);
    procedure requisioParaoCDAbastecimento1Click(Sender: TObject);
    procedure rocardeUsuario1Click(Sender: TObject);
    procedure saldofiscalpormes1Click(Sender: TObject);
    procedure setaAversoNobd1Click(Sender: TObject);
    procedure Exportacaodeitesdepedido1Click(Sender: TObject);
    procedure ListaItenssemmovimentao1Click(Sender: TObject);
    procedure RemoverEansinvalidos2Click(Sender: TObject);
    procedure Ajustanumerodenota1Click(Sender: TObject);
    procedure Cargadadosdasvendas1Click(Sender: TObject);
    procedure getRequisicoesTransferidas(isRef, uo: String; dti, dtf: Tdate);
    procedure ListaItensemseparaonoCD1Click(Sender: TObject);
    procedure Listapedidosdecompra1Click(Sender: TObject);
    procedure RotinasDiversas1Click(Sender: TObject);
    procedure CrditodeCliente1Click(Sender: TObject);
    procedure Removerlancamentos1Click(Sender: TObject);
    procedure Sincronizarplanodecontas1Click(Sender: TObject);
    procedure Cadastrodebairros1Click(Sender: TObject);
    procedure AjustachaveNFe1Click(Sender: TObject);
    procedure Etiquetasparatapetes1Click(Sender: TObject);
    procedure emiteGuiaEntregaClick(Sender: TObject);
    procedure Rebibodevenda1Click(Sender: TObject);
    procedure mnResDiarioClick(Sender: TObject);
    procedure mnAprovaPedCliClick(Sender: TObject);
    procedure Fluxodeclientesporhora1Click(Sender: TObject);
    procedure SalvarXMLdenfe1Click(Sender: TObject);
    procedure GeraReqvendaapartirdepedido1Click(Sender: TObject);
    procedure FinalizarnotadeentradanoWMS1Click(Sender: TObject);
    procedure FinalizarOSnoWMS1Click(Sender: TObject);
    procedure Impressodepedidodefornecedor1Click(Sender: TObject);
    procedure PesquisaXML1Click(Sender: TObject);
    procedure Acertodeestoque1Click(Sender: TObject);
    procedure Cancelarrequisiespendentes1Click(Sender: TObject);
    procedure ListaitensmovimentadoswellxWms1Click(Sender: TObject);
    procedure Formatacomando1Click(Sender: TObject);
    procedure Listafichasporcatcontabil1Click(Sender: TObject);
    procedure ListaestoquedivergenteWellxWms1Click(Sender: TObject);
    procedure ZerarPickingEstoqueNegativo1Click(Sender: TObject);
    procedure Vendabrutafornecedorvalor1Click(Sender: TObject);
    procedure GeraEANvlidoaleatrio1Click(Sender: TObject);
    procedure addFornaLista(lista:TadLabelListBox);
    procedure DadosEntradasadaevenda1Click(Sender: TObject);
    procedure GerarUmaNotaComoSitensdeoutra1Click(Sender: TObject);
    procedure mnAnMovEstCdClick(Sender: TObject);
    procedure mnRelCredCliClick(Sender: TObject);
    procedure mnRestoreOsClick(Sender: TObject);
    procedure imprim1Click(Sender: TObject);
    procedure ListarDescontosporperodo1Click(Sender: TObject);
    procedure Espelhodetrocadeprodutos1Click(Sender: TObject);
    procedure Ajustedecaddecidade1Click(Sender: TObject);
    procedure IncluirItememOramento1Click(Sender: TObject);
    function getTextGeradorEmail():TStringlist;
    procedure AlterarQuantidadeporcaixa1Click(Sender: TObject);
    procedure CadastradadosparaoProtheus1Click(Sender: TObject);
    procedure CalcularFatordopedido1Click(Sender: TObject);
    procedure ListaVarejoecustodeitensvendidos1Click(Sender: TObject);
    procedure AjustaNFJaboti1Click(Sender: TObject);
    procedure mnSpedContabilClick(Sender: TObject);
    procedure ReceberNotadeTransfernciaXML1Click(Sender: TObject);

  private
     DS_PERMISSOES:TdataSet;
     function getAcesso(codTela: integer; campo:String): boolean;
  public
     IS_LOGADO:boolean;
     PARAMS_APLICACAO: TStringList;
     DADOS_CON_MAIL:THash;
     DATA_APLICACAO:Tdate;
  end;

var

  fmMain: TfmMain;
  data:Tdate;
  
implementation

uses
	  f, uTelnet, uAcbr, uCF, uRequisicao, uLogin, uTabela,
     uOsDeposito, uAvarias, uPropostaLoja, uMapa, uDetEntrada, uTotalSaidas,
     uprecoswell, uDescPedido, uAnaliseVenda, uEtiquetas, unNotasTransfrencia, uResumoEstoque,
     uPrecosCusto, uAlteraFinanceira, uDetalhesNotas, uRelatorioComissao, uComporEstoque,
     unClientes, uAjustaNota, uAnaliseEstoque, uConReqProd, uRelGeral,
     uClassificaProd, uCompFornecedor, fmAbrirAvarias, uParametros,
     uRemoveRegTEF, uCadastrarNCM, uAjustaSPED, uCustoPorPedido, Math,

     fdt, uObterSaldoFiscal, uAjusteModPag, uGeraEstoque, uRelInventario,
     uSelCat, uTotalEntSai, uDetalhesCRUC, uPedidosFornecedor, uResumoECF, uRRANA,
     fmMudaSerieNota, uCEP, uCadImagem, uCadImpNFE, uManutencaoCX, ufornACriticar, uConReqDep,
     uPermissoes, uListaFornecedores, uExportaTable, uExportaPedido,
     uItensSemMov, unAjusteNumeracao, uAlteraForPedido, uCargaVendas,
     uReqTransferidas, uReqEmSeparacao, uRelPedForn, uRotinasDiversas,
     uConsultaPedCompra, uCredCliente, uRemLancContabil, uContabil, uTabelaModal,
     uCadBairro, aAjChNfe, uFiscal, ufmTelnet, uAutorizacao, uUsuarios, uEmail,
     uGuia, uRecibo, msg, uDm, cf, uPedCliente, ufmMovDiario, uFTp, uLj, uEstoque,
     uFluxoClientes, uTipoImpGeraEstoque, uCriaReqFromPed, uWms, uPedFornecedor,
     uImpPedForn, uImpXmlEnt, uListaItensPorNota, uAcertoEstoque,
     UpcoAlteradoPorPeriodo, uRemReqPendente, ufmLstDrvEntSaiCD, uImpFichas,
     uLsdDrvgWellWms, uVdBrutaIt, uProd, uPessoa, uEntUsaivdMed, uFmCriaNf,
	  AnaliseDeSaidaEstCd, uRelCredCli, uEtq, uDescPorData, uTroca,
  ufmImpTrocas, ufmAjCidades, uAddItOrc, uDadosAdTotvs, uLstCustoDeVenda,rSped ,
  uSpedCont; //, ufmImpTrocas; //, fmImpTrocas;



{$R *.dfm}

function TfmMain.getAcesso(codTela: integer; campo:String): boolean;
var
   aux:boolean;
begin
   DS_PERMISSOES.Locate('codTela', intToStr(codTela),[]);
   aux := (DS_PERMISSOES.FieldByName(campo).AsString = '-1') ;
   f.gravaLog('getAcesso('+campo+'), cod tela:'+ intToStr(codTela)+ ' result: '+ sysutils.BoolToStr(aux, true));
   result := aux;
end;

function TfmMain.isGrupoRestrito(codTela: integer): boolean;
begin
   result:= getAcesso(codTela, 'isAcessoRestrito');
end;

function TfmMain.isAcessoTotal(codTela: integer): boolean;
begin
   result:= getAcesso(codTela, 'isAcessoTotal');
end;                                   

function TfmMain.isTelaRequerSenha( codTela:smallInt ):boolean;
begin
   DS_PERMISSOES.Locate('codTela', intToStr(codTela),[]);
   result := (DS_PERMISSOES.FieldByName('isPedeAutorizacao').asString = '1');
   f.gravaLog('isTelaRequerSenha( )' + sysutils.boolToStr(result, true));
end;

function TfmMain.getUserLogado(): String;
begin
   // retona o cd_usu do usuario logado
   result := PARAMS_APLICACAO.Values['CD_USU'];
end;

function TfmMain.getUoEmpresa: String;
begin
   // retona o cod da empresa
   result := PARAMS_APLICACAO.Values['codEmp'];
end;

function TfmMain.isPermiteAbrirTela( codTela:smallInt ): boolean;
var
  grupos:String;
begin
   grupos := uUsuarios.getGrupoAutPorTela(codTela, getGrupoLogado());

   if (isTelaRequerSenha(codTela) = true) then
      result :=  (uUsuarios.getAutorizadorWell('', grupos, '13') <> '')
   else
      result :=  true;

   f.gravaLog('isPermiteAbrirTela()' + sysutils.boolToStr( result, true))
end;

procedure TfmMain.verificaPermissao(item:TmenuItem; camposPermitidos:Tstringlist);
var
   i:integer;
begin
//   f.gravaLog(camposPermitidos);
   if (DS_PERMISSOES.Locate('codTela', intToStr(item.tag),[]) = true)  then
      item.Visible := true
   else
      item.Visible := false;

   if (camposPermitidos.Count > 0) and (  camposPermitidos.IndexOf(intToStr(item.tag)) < 0 ) then
      item.Visible := false;


//	f.writeFile(f.getDirLogs() + 'menus.dat', intToStr(item.Tag) +' ' +   item.Caption);

   if (item.Count > 0) then
   begin
      for i:=0 to item.Count -1 do
         verificaPermissao(item.Items[i], camposPermitidos );
    end
end;

procedure TfmMain.montarMenu(nomeloja, is_uo, is_usu:string);
var
  i:integer;
  ds:TdataSet;
  lstCpPermitidos:Tstringlist;
begin
   ds:= uUsuarios.getDadosUsuario(is_usu);

   f.gravaLog('montaMenu()   ' + #13+
                    ' nomeLoja:' + nomeloja +#13+
                    ' nomeUsuario:' +ds.fieldByName('nm_usu').asString +#13+
                    ' is_uo:'+ is_uo +#13+
                    ' is_usu:' +is_usu
                   );

   fmMain.Menu := menuPrincipal;

   if (is_uo <> '-1') then
   begin
      PARAMS_APLICACAO.Values['uocd'] :=  dm.getParamBD('uocd', '');
      PARAMS_APLICACAO.Values['IS_UO'] := is_uo;
      PARAMS_APLICACAO.Values['CD_USU'] := is_usu;
      PARAMS_APLICACAO.Values['cd_pes'] :=  ds.fieldByName('cd_pes').AsString;
      PARAMS_APLICACAO.Values['CD_GRUSU'] := ds.fieldByName('cd_grusu').AsString;
      PARAMS_APLICACAO.Values['codEmp'] := dm.getParamBD('comum.CodEmpWell', '0');


      DATA_APLICACAO := dm.getDateBd();

      StatusBar1.Panels[0].Text := nomeloja;
      StatusBar1.Panels[1].Text := ds.fieldByName('nm_usu').asString;
      getTelasPermDoGrupo(getGrupoLogado(),  ds.fieldByName('cd_pes').AsString );
   end;

// apagar o dataset de permissoes para
   DS_PERMISSOES.free();
   DS_PERMISSOES := uUsuarios.getTelasPermDoGrupo(getGrupoLogado(), ds.fieldByName('cd_pes').AsString);


   for i:=0 to fmMain.Menu.Items.Count -1 do
      verificaPermissao(menuPrincipal.Items[i], f.camposToStringlist(f.getParamIni('Menu', 'Habilitados')) );

   ds.free();

   DADOS_CON_MAIL := getDadosConEmail(getUoLogada());

   f.gravaLog(PARAMS_APLICACAO);

   f.gravaLog('Fim da inicalização');
   f.gravaLog('-----------------------------------------------');
   f.gravaLog('');
end;

procedure TfmMain.loginAutomatico();
var
   nmUo, uo, user:String;
begin
   user:= paramStr( f.getIdxParam('-user') +1);

   if f.getIdxParam('-uo') > -1 then
      uo := paramStr( f.getIdxParam('-uo') +1)
   else
     uo := dm.getParamBD('uocd', '');

   nmUo := dm.openSQL('select ds_uo from zcf_tbuo  where is_uo= ' + uo, 'ds_uo');

   montarMenu(nmUo, uo, user);
end;

procedure TfmMain.FormActivate(Sender: TObject);
var
   versao_BD:String;
begin
   fmMain.Caption := fmMain.versao.Caption + ' ' + fmMain.sub_versao.Caption + ' ® - Programas da loja.  ';


// monta o menu com todas as opcoes quando estiver desenvolvendo
   if (f.getIdxParam('-user') > -1) and (IS_LOGADO = false)   then
   begin
      fmMain.WindowState := wsNormal;
      IS_LOGADO := true;

      fmMain.Width := 900;
      fmMain.Height := 700;
      fmMain.Left := 100;
      fmMain.top := 10;

      loginAutomatico();
   end;

   if (IS_LOGADO = false) then
   begin
      fmMain.Menu := nil;
      begin
         versao_BD := dm.getParamBD('comum.versaoBd','');
         gravaLog('versão BD: ' +  versao_BD + ' versão EXE: ' + fmMain.versao.Caption);
         if (trim(fmMain.versao.Caption) <> versao_BD ) and (versao_BD <> '')  then
         begin
            msg.msgErro( 'A versão do programa é diferente do banco de dados, ' +#13+
                         'isso pode resultar em erros na execução do programa.' +#13+#13+
                         '  Entre em contato com o T.I. '                       +#13+#13+
                         '  Versão do BD:       ' + versao_BD                   +#13+
                         '  Versão do programa: ' + fmMain.versao.Caption
            );

            Application.Terminate();
         end
         else
         begin
            IS_LOGADO := true;
            Application.CreateForm(TfmLogin, fmLogin);
            fmLogin.Show();
            fmLogin.Caption := 'Login';
         end;
      end;
   end;
end;

procedure TfmMain.appException(Sender: TObject; E: Exception);
begin
   msg.msgErro('Erro:'+#13+e.Message);
   f.gravaLog('Erro - Loja: ' + fmMain.getUoLogada() +'  usuario: '+ fmMain.getUserLogado()  + ' ' + e.Message );

   if dm.con.Connected = false then
   begin
   	showmessage('erro de conexao, tentando reconectar');
      dm.con.Connected := true;
   end;
end;

procedure TfmMain.ConsultaARequisies2Click(Sender: TObject);
begin
   if (fmConReqDep = nil) then
   begin
      Application.CreateForm(TfmConReqDep, fmConReqDep);
      fmConReqDep.show;
   end;
end;

procedure TfmMain.rocarDeUsuario1Click(Sender: TObject);
var
  i:integer;
  aux:String;
  erro:Boolean;
  telas:String;
begin
   erro := false;
   for i:=0 to Application.ComponentCount -1 do
   begin
      aux := application.Components[i].ClassType.ClassName;
      if (pos('Tfm',aux) > 0) and ( aux <> 'TfmMain') and ( aux <> 'TfmTelnet') then
      begin
         erro := true;
         telas := telas + ' '+ aux;
      end;
   end;
   if (erro  = true) then
   begin
      msg.msgErro(dm.getMsg('errTelaAberta'));
      f.gravaLog('Erro ao tentar troca de usuário, telas abertas:' + telas)
   end
   else
   begin
      Application.CreateForm(TfmLogin, fmLogin);
      fmlogin.Show;
      fmLogin.Caption :=  fmMain.versao.Caption +' '+ fmMain.sub_versao.Caption + ' -  Mudar a loja ou usuário';
   end;
end;

procedure TfmMain.Requisicoentreloas1Click(Sender: TObject);
begin
   if (fmReqLojas = nil)then
   begin
      Application.CreateForm(TfmReqLojas, fmReqLojas);
      fmReqLojas.Show
   end;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// verifica se ha uma nova versao do programa de upgrade e substitui o antigo.
   f.renomearArquivoUpgrade('UpgradeNovo.exe', 'upgrade.exe');
   application.Terminate();
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
   computador, usuario:String;
begin
   try
      if (fileExists(f.getDirExe()+ 'CF.ico') = true) then
         Application.Icon.LoadFromFile(f.getDirExe()+ 'CF.ico')
       else
         f.gravaLog('Não achei o arquivo de icone da aplicação');

       DM.openConnection(F.getDirExe() + 'ProgramasCasaFreitas.ini');


       if (dm.con.Connected = true) then
       begin
         // carrega o arquivo de resources
          dm.loadCommandsBD(getStrArqResource());

          PARAMS_APLICACAO := TStringlist.Create();
          RvProject1.ProjectFile :=  sysUtils.extractFilePath(paramStr(0)) +  '\RelatoriosPCF.rav';
          StatusBar1.Panels[2].Text := dm.con.DefaultDatabase + ' ' +  f.getParamIni('Conexao', 'server');


          f.getComputadorUsuario(computador, usuario);

          if cf.isEstacaoPermitida(usuario) = false then
          begin
            msg.msgErro(dm.getMsg('estBloqueada'));
            application.Terminate();
          end;

       end;
       if ( f.getIdxParam('-tray') >-1) then
       begin
          CoolTrayIcon1.MinimizeToTray := true;
          CoolTrayIcon1.IconVisible := true;
       end;
 except
      on e:Exception do
      begin
         msg.msgErro(dm.getMsg('errConexao'));
         application.Terminate();
      end;
   end;
end;

function TfmMain.ehTelaPermitida(tag:string;  Telas:Tstrings): Boolean;
var
   i:integer;
   achou:boolean;
begin
   achou := false;
   for i:=0 to telas.Count-1 do
   begin
      if (tag = telas[i]) or ( telas[0] = '-1') then
         begin
            achou := true;
            break;
         end;
   end;
   result := achou;
end;

procedure TfmMain.msgStatus(msg: String);
begin
    fmMain.StatusBar1.Panels[3].Text := msg;
 //   f.gravaLog('-- msgStatus: '+ msg);
    fmMain.StatusBar1.Refresh;
    fmMain.Refresh();
end;

procedure TfmMain.Fornecedoreacriticar1Click(Sender: TObject);
begin
   if (fmFornACriticar = nil) then
   begin
      Application.CreateForm(TfmFornACriticar, fmFornACriticar);
      fmFornACriticar.Show
   end;
end;

procedure TfmMain.Permisses2Click(Sender: TObject);
begin
   if  (fmPermissoes = nil)then
   begin
      Application.CreateForm(TfmPermissoes, fmPermissoes);
      fmPermissoes.Show;
   end;
end;

procedure TfmMain.abreFormRequisicao(mostraMsg: Boolean; perfil:integer);
begin
   if (fmOsDeposito = nil) then
   begin
      if ( uLj.isDeposito(getUoLogada()) = true  ) and ( perfil <> 3 )  then
         msg.msgErro(dm.getMsg('osDepErrLocal'))
      else
      if  (  uLj.isDeposito(getUoLogada()) = false ) and ( perfil =  3 )  then
         msg.msgErro(dm.getMsg('osDepErrLjLogada'))
      else
      begin
         if (mostraMsg = true) then
            msg.msgErro( dm.getMsg('osDepAvisoTela'));

         Application.CreateForm(TfmOsDeposito, fmOsDeposito);
         fmOsDeposito.Show;
         fmOsDeposito.SetPerfil(perfil);
      end;
   end;
end;

procedure TfmMain.Requisicaoparaocd1Click(Sender: TObject);
begin
   abreFormRequisicao(true, 1);
end;

procedure TfmMain.Cadastrodeavarias1Click(Sender: TObject);
begin
   if (fmCadAvarias = nil) then
   begin
      application.CreateForm(TfmCadAvarias, fmCadAvarias);
      fmCadAvarias.Show()
   end;
end;

procedure TfmMain.Propostasdaloja1Click(Sender: TObject);
begin
   if (fmProposta = nil) then
   begin
      application.CreateForm(TfmProposta, fmProposta);
      fmProposta.Show()
   end;
end;

procedure TfmMain.Mapadeseparao1Click(Sender: TObject);
begin
   if (fmMapa = nil) then
   begin
      application.CreateForm(TfmMapa, fmMapa);
      fmMapa.Show()
   end;
end;

procedure TfmMain.abeladePreos2Click(Sender: TObject);
begin
   if (fmTabela = nil) then
   begin
      application.CreateForm(TfmTabela, fmTabela);
      fmTabela.Show()
   end;
end;

procedure TfmMain.Precosalteradosporperodo2Click(Sender: TObject);
begin
   if (fmPrecosAlterados = nil) then
   begin
      application.CreateForm(TfmPrecosAlterados, fmPrecosAlterados);
      fmPrecosAlterados.Show();
   end;
end;

procedure TfmMain.AjustedePrecos1Click(Sender: TObject);
begin
   if (fmLancaPc = nil) then
   begin
      application.CreateForm(TfmLancaPc, fmLancaPc);
      fmLancaPc.Show();
   end;
end;

procedure TfmMain.Descontodepedido1Click(Sender: TObject);
begin
   if (fmDescPed = nil) then
   begin
      application.CreateForm(TfmDescPed, fmDescPed);
      fmDescPed.Show();
   end;
end;

procedure TfmMain.AnaliseVLC1Click(Sender: TObject);
begin
   if (fdt.isHoraPermitida(AnaliseVLC1.tag, fmMain.getGrupoLogado() ) = true ) then
      if (fmFaturamento = nil) then
      begin
        application.CreateForm(TfmFaturamento, fmFaturamento);
        fmFaturamento.Show();
      end;
end;

procedure TfmMain.imprimeRave(qr, qr2, qr3, qr4, qr5:TDataSet; nRelatorio:String; params:Tstrings);
var
  i:integer;
begin
   f.gravaLog('imprimeRave()');

   if qr <> nil then
      RvDSConn.DataSet := qr;

   if qr2 <> nil then
      RvDSConn2.DataSet := qr2;

   if qr3 <> nil then
      RvDSConn3.DataSet := qr3;

   if qr4 <> nil then
      RvDSConn4.DataSet := qr4;

   if qr5 <> nil then
      RvDSConn5.DataSet := qr5;

   gravaLog('Impressao de relatorio:' + nRelatorio);

   if (params <> nil) then
      for i:=0 to params.Count-1 do
         RvProject1.SetParam(intToStr(i), params[i]);

   RvProject1.SetParam('versao', fmMain.versao.Caption + ' '+ fmMain.sub_versao.Caption);


//   params.SaveToFile('c:\params.txt');
   sleep(100);
   RvProject1.ExecuteReport(nRelatorio);

   if (f.getIdxParam('-tray') > -1 ) then
      msg.msgErro('msg desenvolvimento');

   fmMain.msgStatus('');
end;

procedure TfmMain.impressaoRavePDF(qr,qr2:TDataSet; nRelatorio:String; params:Tstrings;nmArquivo:String);
begin
   if(ExtractFilePath(nmArquivo) = '') then
     nmArquivo := f.getDirLogs() + nmArquivo;

   if ( ExtractFileExt(nmArquivo) = '') then
     nmArquivo := nmArquivo + '.pdf';



   RvSystem1.SystemSetups := RvSystem1.SystemSetups - [ssAllowSetup];
   RvSystem1.DefaultDest := rdFile;
   RvSystem1.DoNativeOutput:= false;
   RvSystem1.RenderObject:= rvRenderPDF1;
   RvSystem1.OutputFileName:=  nmArquivo;

   imprimeRave(qr, qr2, nil, nil, nil, nRelatorio, params);
   RvSystem1.SystemSetups := RvSystem1.SystemSetups + [ssAllowSetup];
   RvSystem1.DefaultDest := rdPrinter;
   RvSystem1.DoNativeOutput:= true;
end;

procedure TfmMain.Geracaopreodecusto1Click(Sender: TObject);
begin
   if (fmPrecoCustos = nil) then
   begin
      application.CreateForm(TfmPrecoCustos, fmPrecoCustos);
      fmPrecoCustos.Show();
   end;
end;

procedure TfmMain.Etiquetas1Click(Sender: TObject);
begin
   if (fmEtiquetas = nil) then
   begin
      application.CreateForm(TfmEtiquetas, fmEtiquetas);
      fmEtiquetas.Show();
   end;
end;

procedure TfmMain.Relacaodenotasdetransferncia1Click(Sender: TObject);
begin
   if (fmNotasTransf = nil) then
   begin
      application.CreateForm(TfmNotasTransf, fmNotasTransf);
      fmNotasTransf.Show();
   end;
end;

procedure TfmMain.obterResumoEstoque(is_ref, is_disponivel: String);
begin
   if (fmResEstoque = nil) then
   begin
      Application.CreateForm( TfmResEstoque , fmResEstoque);
      fmResEstoque.obterEstoques( is_ref, is_disponivel);
      fmResEstoque.ShowModal;
   end;
end;

procedure TfmMain.obterDetalhesEntrada(is_ref: String);
begin
   if (fmDetEntrada  = nil) then
   begin
      Application.CreateForm( TfmDetEntrada , fmDetEntrada );
      fmDetEntrada.consultaDetalhesEntrada(is_ref);
      fmDetEntrada.showModal;
   end;
end;

procedure TfmMain.obterDetalhesSaida(is_ref,uo:String; dtInicio:Tdate);
begin
   if (fmTotalSaidas  = nil) then
   begin
      Application.CreateForm( TfmTotalSaidas , fmTotalSaidas );
      fmTotalSaidas.calcularVenda(is_ref, uo, dtInicio, now );
      fmTotalSaidas.ajustaDataInicio(dtInicio);
      fmTotalSaidas.showModal;
   end;
end;

procedure TfmMain.Mudarfinanceiradeboleto1Click(Sender: TObject);
begin
   if (fmAlteraFiananceira = nil) then
   begin
      application.CreateForm(TfmAlteraFiananceira, fmAlteraFiananceira);
      fmAlteraFiananceira.Show();
   end;
end;

procedure TfmMain.mostraDetalhesNota(is_nota: String);
begin
//   if (fmDetEntrada = nil) then
   begin
      application.CreateForm(TfmDetalhesNota, fmDetalhesNota);
      fmDetalhesNota.carregarDadosNota(is_nota);
      fmDetalhesNota.ShowModal();
   end;
      fmDetalhesNota := nil;
end;

procedure TfmMain.RelatriodeComisso1Click(Sender: TObject);
begin
   if (fdt.isHoraPermitida( RelatriodeComisso1.tag, fmMain.getGrupoLogado() ) = true ) then
      if (fmRelatorioComissao = nil) then
      begin
         application.CreateForm(TfmRelatorioComissao, fmRelatorioComissao);
         fmRelatorioComissao.Show();
      end;
end;

procedure TfmMain.Comporavendafiscal1Click(Sender: TObject);
begin
  if (fmComporEstoque = nil) then
  begin
     Application.CreateForm(TfmComporEstoque, fmComporEstoque);
     fmComporEstoque.Show;
  end
end;

procedure TfmMain.EtiquetasDeClientes1Click(Sender: TObject);
begin
  if (fmetqClientes = nil) then
  begin
     Application.CreateForm(TfmetqClientes, fmetqClientes);
     fmetqClientes.Show;
  end
end;

procedure TfmMain.Ajustedenotas1Click(Sender: TObject);
begin
   if (fmAjustaNota = nil) then
   begin
      application.CreateForm(TfmAjustaNota, fmAjustaNota);
      fmAjustaNota.Show();
   end;
end;

procedure TfmMain.Analisedeestoque1Click(Sender: TObject);
begin
   if (fmAnaliseEstoque = nil) then
   begin
      application.CreateForm(TfmAnaliseEstoque, fmAnaliseEstoque);
      fmAnaliseEstoque.Show();
   end;
end;

function TfmMain.getNomeUsuario: String;
begin
   result := fmMain.StatusBar1.Panels[1].Text;
end;

function TfmMain.getUOCD(): String;
begin
   result := PARAMS_APLICACAO.Values['uocd'];
end;

procedure TfmMain.Requisiodereposio1Click(Sender: TObject);
begin
   abreFormRequisicao(false, 2);
end;

procedure TfmMain.RequisioparaoCDAbastecimento1Click(Sender: TObject);
begin
   abreFormRequisicao(false, 3);
end;

procedure TfmMain.abreTelaConsultaRequisicao(cd_ref, uo: String; dataInicio: Tdate);
begin
   if (fmConReqProduto = nil) then
   begin
      Application.CreateForm(TfmConReqProduto, fmConReqProduto);

      if (cd_ref <> '' )then
      begin
         fmConReqProduto.FormStyle := fsStayOnTop;
         fmConReqProduto.consultaExterna(cd_ref, uo, dataInicio);
      end
      else
         fmConReqProduto.FormStyle := fsMDIChild;

      fmConReqProduto.Show();
   end;
end;

procedure TfmMain.ConsultaaRequisioCDporProduto1Click(Sender: TObject);
begin
   abreTelaConsultaRequisicao('', '', now());
end;

procedure TfmMain.consultaRequisicaoPorProduto(cd_ref: String);
begin
   ConsultaarequisioCDporproduto1Click(nil);
end;

function TfmMain.getNomeLojaLogada(): String;
begin
   result := fmMain.StatusBar1.Panels[0].Text;
end;

procedure TfmMain.Alterafornpedidodecompra1Click(Sender: TObject);
begin
   if (fmAlteraPedForn = nil ) then
   begin
      Application.CreateForm(TfmAlteraPedForn, fmAlteraPedForn);
      fmAlteraPedForn.Show();
   end;
end;

procedure TfmMain.Classificaodepro1Click(Sender: TObject);
begin
   if (fmAlteraPedForn = nil) then
   begin
      Application.CreateForm(TfmClassificaProd, fmClassificaProd);
      fmClassificaProd.Show();
   end;
end;

procedure TfmMain.SetaAVersoNoBd1Click(Sender: TObject);
var
  antiga, nova:String;
begin
   antiga :=   dm.GetParamBD('comum.VersaoBD', '');
   nova := InputBox('', 'Entre com o novo número da versão:', antiga ) ;

   if (antiga <> nova) then
      dm.updateParamBD('comum.VersaoBD', '', nova, 'versao do sistema' );
end;

function TfmMain.getCdPesLogado(): String;
begin
   result := PARAMS_APLICACAO.Values['CD_PES'];
end;

function TfmMain.getGrupoLogado: String;
begin
   result := PARAMS_APLICACAO.Values['CD_GRUSU'];
end;

function TfmMain.getUoLogada(): String;
begin
   result := PARAMS_APLICACAO.Values['IS_UO'];
end;

function TfmMain.ehCampoPermitido(nParam:String): Boolean;
var
   str:String;
begin
   str:= dm.getParamBD(nParam, '');
   if pos(fmMain.getGrupoLogado(), str) > 0 then
      result := true
   else
      result := false;
end;

procedure TfmMain.Parmetrosdosistema1Click(Sender: TObject);
begin
   if (fmParametros = nil) then
   begin
      Application.CreateForm(TfmParametros, fmParametros);
      fmParametros.show;
   end;
end;

procedure TfmMain.Cadastrarcodigodebarrasdeproduto1Click(Sender: TObject);
var
  is_ref, EAN,desc,cd_ref:String;
begin
   cd_ref := InputBox('','Qual o código do produto que você quer' +#13+ 'cadastrar?', cd_ref  ) ;
   desc := dm.openSQL('Select cd_ref +'' - ''+ ds_ref as cd_ref from crefe(nolock) where cd_ref = ' + quotedStr(cd_ref), 'cd_ref' );
   if desc = '' then
      msg.msgErro('Produto não cadastrado.')
   else
   begin
      EAN :=  msg.msgInput('Digite o EAN que você quer informar para o produto: ' +#13+ desc , EAN );

      if (length(EAN) < 13) then
         msg.msgErro('EAN inválido')
      else if ( dm.openSQL('select cd_pesq from dscbr where cd_pesq = ' + quotedStr(ean) , 'cd_pesq' ) ) <> '' then
         msg.MsgErro('Esse EAN já é cadastrado')
      else
      begin
         is_ref := dm.openSQL('select is_ref from crefe where cd_ref = ' + quotedStr(cd_ref), 'is_ref' );
         uEstoque.insereEAN(is_ref, EAN);
         msg.msgErro('O EAN foi incluído com sucesso.');
      end;
   end;
end;

function TfmMain.getDescUO(cb: TCustomComboBox): String;
begin
   result := copy(cb.Items[cb.itemIndex], 01, 30);
end;

procedure TfmMain.getParametrosForm(form: Tform);
var
  i:integer;
begin
//   Carrega os hints dos campos
//  para carregar o hint, marque a propriedade showHint como True
   for i:=0 to form.ComponentCount -1 do
   begin
      if GetPropInfo(form.Components[i], 'ShowHint') <> nil then
         if ((form.Components[i] as TControl).ShowHint = true ) then
            (form.Components[i] as TControl).Hint := dm.getHint(form.Name + '.'+form.Components[i].Name);
      f.gravaLog('carregar o hint do campo:'  + form.Name + '.'+form.Components[i].Name);
   end;
// carrega as informacoes dos components
   f.carregaCampos(form);
end;

procedure TfmMain.CompromissosDeFornecedoresPorData1Click(Sender: TObject);
begin
   if (fmCompFornecedor = nil) then
   begin
      Application.CreateForm( TfmCompFornecedor, fmCompFornecedor);
      fmCompFornecedor.Show();
   end;
end;

procedure TfmMain.CadastrarNCM1Click(Sender: TObject);
begin
   if (fmCadastraNCM = nil) then
   begin
      Application.CreateForm( TfmCadastraNCM, fmCadastraNCM);
      fmCadastraNCM.Show();
   end;
end;

procedure TfmMain.AjustedoarquivoSPED1Click(Sender: TObject);
begin
   if (fmAjustaSPED = nil) then
   begin
      Application.CreateForm(TfmAjustaSPED, fmAjustaSPED);
      fmAjustaSPED.Show();
   end;
end;

function TfmMain.getCodPreco(cb: TCustomComboBox): String;
begin
   result := f.SohNumeros(copy(cb.Items[cb.ItemIndex],50, 08) );
end;

function TfmMain.getDescPreco(cb: TCustomComboBox): String;
begin
    result := trim(copy(CB.Items[CB.itemIndex], 01, 30));
end;

procedure TfmMain.Listarcustodeitensporpedido1Click(Sender: TObject);
begin
   if ( fmCustoPorPedido = nil) then
   begin
      Application.CreateForm( TfmCustoPorPedido, fmCustoPorPedido);
      fmCustoPorPedido.Show();
   end;
end;

procedure TfmMain.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
begin
   f.gravaLog('Erro:' + e.Message);
end;

procedure TfmMain.EnviarXML1Click(Sender: TObject);
var
   cmd:String;
begin
   cmd := getIsNota();
   if (cmd <> '') then
      uFiscal.exportaXMLNota(cmd, dm.con);
end;

procedure TfmMain.EnviarespelhoPDFdeNFeParaEmail1Click(Sender: TObject);
var
   isNota, arqPDF:String;
   msgEmail: TStringList;
   ds:TdataSet;
begin
   isNota := getIsNota();
   if (isNota <> '') then
   begin
      ds:= uFiscal.getDadosNota(isNota, '','','');
      screen.Cursor := crHourglass;
      arqPDF := GetPDFNFe(isNota);
      if (fileExists(arqPDF)= true) then
      begin
         msgEmail := TStringlist.Create();
         msgEmail.add( 'Segue cópia do DANFE da nota fiscal ' +  ds.FieldByName('Num').asString);
         msgEmail.add( 'Emitida pela loja: '+ ds.FieldByName('loja').asString );
         fmMain.enviarEmail( '', 'Envio de PDF, nota fiscal eletrônica', arqPDF,  msgEmail, 'Envio de XML');
         ds.Free();
         deleteFile(isNota);
      end;
   end;
   screen.Cursor := crDefault;
end;


procedure TfmMain.visualizarDANFE(Sender: TObject);
var
   cmd:String;
begin
   cmd := getIsNota();
   if (cmd <> '') then
      cmd := uACBR.getPDFNFe(cmd);

    gravaLog('fmMain.getPDFNFe()~> '+cmd);

    if (cmd <> '') then
    begin
       fmMain.MsgStatus('Impressão....');
       f.execFileExternal( cmd );
    end;
    msgStatus('');
end;

procedure TfmMain.Saldofiscalpormes1Click(Sender: TObject);
begin
   if (fmObterSaldoFiscal = nil) then
   begin
      Application.CreateForm(TfmObterSaldoFiscal, fmObterSaldoFiscal);
      fmObterSaldoFiscal.Show();
    end;
end;

procedure TfmMain.PagamentosEmCartao1Click(Sender: TObject);
begin
  if (isPermiteAbrirTela(Pagamentosemcarto1.Tag) = true) then
  begin
     Application.CreateForm(TfmRelGeral, fmRelGeral);
     fmRelGeral.show();
     fmRelGeral.setPerfil(Pagamentosemcarto1.Tag);
  end
  else
     msgErro('Sem permissao');
end;

procedure TfmMain.Cargadedadosparaconciliao1Click(Sender: TObject);
begin
   Application.CreateForm(TfmRelGeral, fmRelGeral);
   fmRelGeral.show();
   fmRelGeral.setPerfil(407);
end;

procedure TfmMain.DeletarRegistrodecartoTEF1Click(Sender: TObject);
begin
   if (fmRemRegTEF = nil) then
   begin
      Application.CreateForm( TfmRemRegTEF, fmRemRegTEF);
      fmRemRegTEF.Show();
   end;
end;

procedure TfmMain.ImprimirDANFE1Click(Sender:Tobject);
var
   impressora, server, dirNFE, cmd:String;
   ds:TdataSet;
begin
   cmd := uFiscal.getIsNota();
   if (cmd <> '') then
   begin
      impressora:= uCF.getNomeImpressoraNFe();
      ds:= uFiscal.getDadosNota(cmd, '','','');
      if (impressora <> '') then
         if (ds.FieldByName('chave_acesso_nfe').AsString <> '') then
         begin
            server := dm.getParamBD('ServerNFE.ip',ds.FieldByName('is_estoque').AsString);

            dirNFE := dm.getParamBD('ServerNFE.pastaBaseNFE', ds.FieldByName('is_estoque').AsString)
                      + dm.getParamBD('ServerNFE.DirNFE', ds.FieldByName('is_estoque').AsString)
                      + uAcbr.getSubPastaXML(ds.fieldByName('dt_emis').asString);

            cmd :='NFE.ImprimirDANFE("' + dirNFE + ds.FieldByName('chave_acesso_nfe').AsString + '-nfe.xml","'+  impressora+'")';
            uTelnet.execCmdBool( ds.FieldByName('is_estoque').AsString, cmd);
         end
         else
            msg.msgErro( dm.getMsg('MSG_ERRO_CH_NFE'));
   end;
      msgStatus('');
end;

procedure TfmMain.Geraestoque1Click(Sender: TObject);
begin
   if (fmGeraEstoque  = nil) then
   begin
      Application.CreateForm(TfmGeraEstoque, fmGeraEstoque);
      fmGeraEstoque.show;
   end;
end;

procedure TfmMain.obterResumoEntSai(isref, uo: String);
begin
   f.gravaLog('obterResumoEntSai() ' + uo + ' ' + isref);
   if (fmTotalEntSai = nil) then
   begin
      Application.CreateForm(TfmTotalEntSai, fmTotalEntSai);
      fmTotalEntSai.show();
      fmTotalEntSai.calculaTotalEntSai(isref, uo, fmMain.getUOCD() );
   end;
end;

procedure TfmMain.getDadosCRUC(is_ref: String);
begin
   if (fmDetalhesCRUC = nil) then
   begin
      Application.CreateForm(TfmDetalhesCRUC, fmDetalhesCRUC);
      fmDetalhesCRUC.show();
      fmDetalhesCRUC.getDadosCRUC(is_ref);
   end;
end;

procedure TfmMain.getPedidosFornecedor(is_ref, uo: String);
begin
   if (fmPedidosFornecedor = nil) then
   begin
      Application.CreateForm(TfmPedidosFornecedor, fmPedidosFornecedor);
      fmPedidosFornecedor.getPedidosProduto(is_ref, uo);
   end;
end;

procedure TfmMain.Processarinventrio1Click(Sender: TObject);
begin
   if (fmRelInventario = nil) then
   begin
      Application.CreateForm(TfmRelInventario, fmRelInventario);
      fmRelInventario.show()
   end;
end;

procedure TfmMain.Produtostransferidos1Click(Sender: TObject);
begin
   Application.CreateForm(TfmRelGeral, fmRelGeral);
   fmRelGeral.show();
   fmRelGeral.setPerfil(ProdutosTransferidos1.Tag);
end;

procedure TfmMain.ajustaValoresCategorias(var descCat01, descCat02, descCat03, numNivel, vlNivel: Tlabel);
begin
{
 se nao escolher nada  nivel = 0
 valor = 0000

}

   descCat01.Caption := '--------------------';
   descCat02.Caption:= '--------------------';
   descCat03.Caption:= '--------------------';
   numNivel.Caption := '0';
   vlNivel.Caption := '0000';

   application.CreateForm( TfmSelCat, fmSelCat);
   fmSelCat.ShowModal();

   if (fmSelCat.ModalResult = mrOK) then
   begin
      numNivel.Caption := fmSelCat.lbnivel.Caption;
      vlNivel.Caption := fmSelCat.lbValorNivel.Caption;

      if (numNivel.Caption= '3') then
      begin
         descCat01.Caption := fmSelCat.qrClasse1.fieldByName('ds_vcampo').asString;
         descCat02.Caption := fmSelCat.qrClasse2.fieldByName('ds_vcampo').asString;
         descCat03.Caption := fmSelCat.qrClasse3.fieldByName('ds_vcampo').asString;
      end;
      if (numNivel.Caption= '2') then
      begin
         descCat01.Caption := fmSelCat.qrClasse1.fieldByName('ds_vcampo').asString;
         descCat02.Caption := fmSelCat.qrClasse2.fieldByName('ds_vcampo').asString;
      end;

      if (numNivel.Caption= '1') then
         descCat01.Caption := fmSelCat.qrClasse1.fieldByName('ds_vcampo').asString;
   end;
   fmSelCat.close();
   fmSelCat := nil;
end;

procedure TfmMain.Log1Click(Sender: TObject);
var
  cmd:String;
begin
   cmd := f.getDirLogs() + 'Baretail.exe ' + getArqLog();
   winexec(pChar(cmd), sw_normal);
end;

procedure TfmMain.ListaCuponspordia1Click(Sender: TObject);
begin
   if (fmResumoECF = nil) then
   begin
      application.CreateForm(TfmResumoECF, fmResumoECF);
      fmResumoECF.show();
   end;
end;

procedure TfmMain.RazoAnalticoRRANA1Click(Sender: TObject);
begin
   if (fmRelGeral1 = nil) then
   begin
      application.CreateForm(TfmRelGeral1, fmRelGeral1 );
      fmRelGeral1.show();
   end;
end;

procedure TfmMain.mxOneInstance1InstanceExists(Sender: TObject);
begin
  if (f.getIdxParam('-ge') > -1) then
  begin
     f.gravaLog('mxOneInstanceDesabilitada pelo parametro -ge');
     mxOneInstance1.SwitchToPrevious := false;
     mxOneInstance1.Terminate := false;
  end;
end;

procedure TfmMain.ConfiguraSeriesparacontingencia1Click(Sender: TObject);
begin
   if (fmAjustaSerie = nil) then
   begin
      application.CreateForm(TfmAjustaSerie, fmAjustaSerie);
      fmAjustaSerie.show();
   end;
end;

procedure TfmMain.CadastrodeCEP1Click(Sender: TObject);
begin
   if ( fmCep = nil) then
   begin
      application.CreateForm(TfmCep, fmCep );
      fmCep.show();
   end;
end;

procedure TfmMain.Cadastrodeimagens1Click(Sender: TObject);
begin
   if (fmCadastro = nil) then
   begin
      application.CreateForm(TfmCadastro, fmCadastro );
      fmCadastro.show();
   end;
end;

procedure TfmMain.AlteraStatusdoCaixa1Click(Sender: TObject);
begin
   if (fmManutencaoCX = nil) then
   begin
      application.CreateForm(TfmManutencaoCX, fmManutencaoCX);
      fmManutencaoCX.show();
   end;
end;

procedure TfmMain.CoolTrayIcon1Click(Sender: TObject);
begin
   Application.Restore();
   Application.BringToFront();
end;

procedure TfmMain.ImpressorasNFE1Click(Sender: TObject);
begin
   if (fmCadImpNFE = nil) then
   begin
      application.CreateForm(TfmCadImpNFE, fmCadImpNFE );
      fmCadImpNFE.show();
   end;
end;

function TfmMain.getCD_PES(tipo: String):String;
var
	res:String;
begin
   Application.CreateForm(TfmListaFornecedores, fmListaFornecedores);

   if (tipo = 'F') then
     fmListaFornecedores.rgTpConsulta.ItemIndex := 1
   else if (tipo = 'C') then
     fmListaFornecedores.rgTpConsulta.ItemIndex := 0;

   if (tipo <> '') then
	   fmListaFornecedores.rgTpConsulta.Enabled := false;

   fmListaFornecedores.ShowModal;

   if (fmListaFornecedores.ModalResult = mrOk) then
      res := fmListaFornecedores.dsPes.DataSet.fieldByName('codigo').asString
   else
      res := '';

   fmListaFornecedores.free();
   result := res;
end;

procedure TfmMain.getDadosPessoa(var cd_pes, nome, ds_end: String; tipo:String);
var
   ds:TdataSet;
begin
   cd_pes := '';
   nome := '';
   cd_pes := fmMain.getCD_PES(tipo);

   if (cd_pes <> '') then
   begin
      if (perfil = 'Fornecedor') then
         ds := uPessoa.getDadosFornecedor(cd_pes, '')
      else
         ds := uPessoa.getDadosCliente(cd_pes, '');

     if (ds <> nil) then
     begin
      nome :=  ds.FieldByName('nome').asString;
      cd_pes :=  ds.FieldByName('codigo').asString;
      ds.Free();
     end
     else
     begin
        nome :=  '';
        cd_pes :=  '';
     end;
   end;
end;

procedure TfmMain.getDadosFornecedor(var cd_pes, nome, ds_end: String);
begin
   fmMain.getDadosPessoa(cd_pes, nome, ds_end, 'F');
end;

procedure TfmMain.getDadosCliente(var cd_pes, nome, ds_end:String);
begin
   getDadosPessoa(cd_pes, nome, ds_end, 'C');
end;

procedure TfmMain.Exportacaodeitesdepedido1Click(Sender: TObject);
begin
   if (fmExportaPedido= nil) then
   begin
      application.CreateForm(TfmExportaPedido, fmExportaPedido);
      fmExportaPedido.show();
   end;
end;

procedure TfmMain.exportaDataSetNome(ds:TdataSet; msgEmail: Tstringlist; nomeArq:String);
var
   arq:String;
   style:TmxExportStyle;
   typo:TmxExportType;
begin
  // abre o fomulario para definir para onde vou mandar a exportacao

   if ( ds.IsEmpty = false) then
   begin
      Application.CreateForm(TfmExportaTable, fmExportaTable);
      fmExportaTable.ShowModal;

      if (fmExportaTable.ModalResult = mrOK) then
      begin
         case fmExportaTable.rgDestino.ItemIndex of
            0:style := xsView;
         else
            style := xsFile;
         end;

         case fmExportaTable.rgFormato.ItemIndex of
            0:typo := xtExcel;
         else
            typo := xtCSV;
         end;

         if (style = xsview ) then
            dm.exportacaoDeTabela(ds, typo, style, nomeArq)
         else
         begin
            arq:= dm.exportacaoDeTabela(ds, typo, style, nomeArq);

            if (fileExists(arq) = true) then
               fmMain.EnviarEmail( '', 'Exportação de dados', arq, msgEmail, 'Envio de email');
         end;
      end;
      fmExportaTable := nil;
   end
   else
      msg.msgErro( dm.getMsg('comum.errExport1'));
end;


procedure TfmMain.exportaDataSet(ds:TdataSet; msgEmail: Tstringlist);
begin
   exportaDataSetNome(ds, msgEmail, '');
end;

procedure TfmMain.msgStatusProgresso(index, Count:integer; msg:String);
var
  val:real;
  percent:string;
begin
   val := (index * 100) div (count +1);

   percent := floatToStr ( val );

   if index mod 10 = 0 then
      fmMain.msgStatus(msg +' ' +  percent + '% (' + intToStr(index) + ' de ' + intTostr(count)  + ')' );

   if (index = count) then
	   fmMain.msgStatus('');
end;

procedure TfmMain.ListaItenssemmovimentao1Click(Sender: TObject);
begin
   if (fmItensSemMov= nil) then
   begin
      application.CreateForm(TfmItensSemMov, fmItensSemMov);
      fmItensSemMov.show();
   end;
end;

procedure TfmMain.RemoverEansinvalidos2Click(Sender: TObject);
var
  inicio, fim:String;
begin
   inicio := InputBox('','IS_REF inicial:', '0') ;
   fim :=  InputBox('','IS_REF final:', '999999') ;
   uEstoque.removeEansInvalidos(inicio, fim);
end;

procedure TfmMain.Ajustanumerodenota1Click(Sender: TObject);
begin
   if (fmAjustaNumNF  = nil) then
   begin
      application.CreateForm(TfmAjustaNumNF, fmAjustaNumNF);
      fmAjustaNumNF.show();
   end;
end;

procedure TfmMain.Cargadadosdasvendas1Click(Sender: TObject);
begin
   if (fmCargaVendas = nil) then
   begin
      application.CreateForm(TfmCargaVendas, fmCargaVendas);
      fmCargaVendas.show();
   end;
   CoolTrayIcon1.MinimizeToTray := true;
   CoolTrayIcon1.IconVisible := true;
end;

procedure TfmMain.getRequisicoesTransferidas(isRef, uo: String; dti, dtf: Tdate);
begin
   if ( fmReqTransferidas = nil) then
   begin
      application.CreateForm(TfmReqTransferidas, fmReqTransferidas);
      fmReqTransferidas.show();
      fmReqTransferidas.consultaReqtransferida(isRef, fmMain.getUOCD(), uo, dti, dtf );
   end;
end;

procedure TfmMain.ListaItensemseparaonoCD1Click(Sender: TObject);
begin
   if ( fmReqEmSeparacao= nil ) then
   begin
      Application.CreateForm(TfmReqEmSeparacao, fmReqEmSeparacao);
      fmReqEmSeparacao.show();
   end;
end;

procedure TfmMain.Listapedidosdecompra1Click(Sender: TObject);
begin
   if ( fmConsultaPedCompra = nil) then
   begin
      Application.CreateForm(TfmConsultaPedCompra, fmConsultaPedCompra);
      fmConsultaPedCompra.show();
   end;
end;

procedure TfmMain.RotinasDiversas1Click(Sender: TObject);
begin
   if ( fmRotinasDiversas = nil) then
   begin
      Application.CreateForm(TfmRotinasDiversas, fmRotinasDiversas);
      fmRotinasDiversas.show();
   end;
end;

function TfmMain.getCaptionNivelAcesso(captionForm:String; is_restrito:boolean):String;
begin
   if is_restrito = true then
      result := captionForm + ' (restrito)'
   else
      result := captionForm + ' (Sem restrição)';
end;

procedure TfmMain.CrditodeCliente1Click(Sender: TObject);
begin
   if ( fmCredCliente = nil ) then
   begin
      Application.CreateForm(TfmCredCliente, fmCredCliente);
      fmCredCliente.show();
   end;
end;

procedure TfmMain.Removerlancamentos1Click(Sender: TObject);
begin
   if ( fmRemLancContabil = nil) then
   begin
      Application.CreateForm(TfmRemLancContabil, fmRemLancContabil);
      fmRemLancContabil.Show();
   end;
end;

procedure TfmMain.Sincronizarplanodecontas1Click(Sender: TObject);
var
   cmd:String;
begin
   cmd := 'Deseja sincronizar os planos de contas das empresas ?' +#13+
          ' FL para CF, PM, PM';
   if (msg.msgQuestion(cmd)= mrYes )then
      ucontabil.sincronizaPlanoDeContas();
end;

procedure TfmMain.Cadastrodebairros1Click(Sender: TObject);
begin
   if ( fmCadBairro = nil) then
   begin
      Application.CreateForm(TfmCadBairro, fmCadBairro);
      fmCadBairro.Show();
   end;
end;

procedure TfmMain.AjustachaveNFe1Click(Sender: TObject);
begin
  if ( fmAjChaveNFe = nil) then
  begin
     Application.CreateForm(TfmAjChaveNFe, fmAjChaveNFe);
     fmAjChaveNFe.show;
  end;
end;

procedure TfmMain.etiquetasParaTapetes(qt:integer);
var
  arq, x01, x02, y01, y02:string;
  i:integer;
begin
   arq:=   f.getArqImpPorta();
   DeleteFile(arq);

   x01 := '0020';
   x02 := '0005';
   y01 := '0085';
   y02 := '0050';

   for  i:= 1 to qt do
   begin
      f.writeFile(arq,'L');
      f.writeFile(arq,'H15');
      f.writeFile(arq, '1111000'+ '0085' + x01 + 'Composicao: ');
      f.writeFile(arq, '1111000'+ '0070' + x01 + 'Superficie 100% em Poliester.');
      f.writeFile(arq, '1111000'+ '0055' + x01 + 'Base: Plastico.');
      f.writeFile(arq, '1111000'+ '0040' + x01 + 'Modo de limpar:');
      f.writeFile(arq, '1111000'+ '0025' + x01 + 'Use um pano limpo umedecido em agua.');
      f.writeFile(arq, '1111000'+ '0010' + x01 + 'Produto nao lavavel.');
      f.writeFile(arq, 'E');
   end;
   f.imprimeArquivoPorta(arq, dm.getParamBD('impCodBarras', fmMain.getUOCD()) );
end;

procedure TfmMain.Etiquetasparatapetes1Click(Sender: TObject);
var
  qt:String;
begin
    qt := '1';
    qt:= msg.msgInput('Quantas etiquetas deseja imprimir ? ', '');

    if (f.SohNumeros(qt) <> '') then
       etiquetasParaTapetes(strToInt(copy(qt, 01, 04)))
    else
       msg.msgErro('Informe corretamente a quantidade');
end;

procedure TfmMain.emiteGuiaEntregaClick(Sender: TObject);
begin
   if ( fmGuia = nil ) then
   begin
      application.CreateForm(TfmGuia, fmGuia);
      fmGuia.show;
   end;
end;

function TfmMain.getStrArqResource: String;
var
  arqBaseCmd:String;
  arqCmd:String;
begin
	// remover o arquivo cmd_sql_base das estacoes

{	if f.getIdxParam('-resourceBase') < 0 then
		deletefile(f.getDirExe() + 'cmdSQl_base.sql');
}
   arqCmd :=  f.getDirExe() + 'cmdSQl.dll';

   arqBaseCmd :=  f.getDirExe() + 'cmdSQl_base.sql';

   if (FileExists(arqBaseCmd) = true) then
      CopyFile(pchar(arqBaseCmd), pchar(arqCmd), false);

   result := f.getDirExe() + 'cmdSQl.dll';
end;

function TfmMain.converterJPegParaBmp(Arquivo: string):String;
var
  JPeg: TJPegImage;
  Bmp: TBitmap;
  nArquivo:String;
begin
  JPeg := TJPegImage.Create;
  Bmp := TBitmap.Create();
 try
    JPeg.LoadFromFile(Arquivo);
    try
      Bmp.Assign(JPeg);
      nArquivo := f.getDirLogs() + 'arq.bmp';
      Bmp.SaveToFile(nArquivo);
    finally
      Bmp.Free;
    end;
  finally
    JPeg.Free;
    result :=nArquivo;
  end;
end;

function TfmMain.converterBmpParaJPeg(Arquivo: string):String;
var
  JPeg: TJPegImage;
  Bmp: TBitmap;
  nArquivo:String;
begin
   if FileExists(arquivo) = false then
   begin
      msg.msgErro(Arquivo + ' Nao existe');
      result:= '';
      exit;
   end;

  JPeg := TJPegImage.Create;
  Bmp := TBitmap.Create();
 try
    bmp.LoadFromFile(Arquivo);
    DeleteFile(Arquivo);
    delete(Arquivo, length(arquivo) -3, 4);
    try
      JPeg.Assign(bmp);
      nArquivo :=   Arquivo + '.jpg';
      JPeg.SaveToFile(nArquivo);
    finally
      Bmp.Free;
    end;
  finally
    JPeg.Free;
    result :=nArquivo;
  end;
end;



procedure TfmMain.Rebibodevenda1Click(Sender: TObject);
begin
    if ( fmRecibo = nil ) then
   begin
      application.CreateForm(TfmRecibo, fmRecibo);
      fmRecibo.show;
   end;
end;

procedure TfmMain.mnResDiarioClick(Sender: TObject);
begin
   if ( fmMovDiario = nil) then
   begin
      Application.CreateForm(TfmMovDiario, fmMovDiario);
      fmMovDiario.show();
   end;
end;

procedure TfmMain.mnAprovaPedCliClick(Sender: TObject);
begin
   uPedcliente.getPedClienteParaAprovacao(
      fmMain.getUoLogada(),
      fmMain.getCdPesLogado(),
      isAcessoTotal(mnAprovaPedCli.Tag)
   );
end;

procedure TfmMain.Fluxodeclientesporhora1Click(Sender: TObject);
begin
   if ( fmVdPorHora = nil) then
   begin
      application.CreateForm(TfmVdPorHora, fmVdPorHora);
      fmVdPorHora.Show();
   end;
end;

procedure TfmMain.SalvarXMLdenfe1Click(Sender: TObject);
begin
	uFiscal.importarXmlNfe();
end;

function TfmMain.getStrLogoEmpresa(): String;
var
  dsImagem:Tdataset;
  image:Timage;
  sLocal:String;
begin
   sLocal := f.getDirLogs() + 'Logo.bmp';
   image := TImage.Create(nil);
   dsImagem := uProd.getImagemProduto('-1', false);

   if (dsImagem.FieldByName('imagem').AsString <> '') then
      Image.Picture.Assign(dsImagem.FieldByName('imagem'));

   image.Picture.SaveToFile(sLocal);

   image.Free();
   dsImagem.free;

   result := sLocal;
end;

function TfmMain.getTpImpressao():integer;
var
  res:integer;
begin
   Application.CreateForm(TfmTipoImpressaoGera, fmTipoImpressaoGera);
   fmTipoImpressaoGera.showModal();

   if (fmTipoImpressaoGera.ModalResult = mrOk) then
      res := fmTipoImpressaoGera.rgTpImpressao.ItemIndex
   else
      res := -1;

   fmTipoImpressaoGera := nil;
   result := res;
end;

procedure TfmMain.GeraReqvendaapartirdepedido1Click(Sender: TObject);
begin
   if (fmCriaReqFromPed = nil) then
   begin
      Application.CreateForm(TfmCriaReqFromPed, fmCriaReqFromPed);
      fmCriaReqFromPed.Show
   end;
end;

procedure TfmMain.FinalizarnotadeentradanoWMS1Click(Sender: TObject);
begin
   uWms.finalizarInternacaoNf(fmMain.getCdPesLogado());
end;

procedure TfmMain.FinalizarOSnoWMS1Click(Sender: TObject);
var
  cont: TModalResult;
begin
   cont := mrYes;
   while (cont = mrYes) do
   begin
      uWms.finalizarDocSeparacao(fmMain.getCdPesLogado());
      cont := msg.msgQuestion( dm.getMsg('wmsConfOsContinua'));
   end;
end;

procedure TfmMain.Impressodepedidodefornecedor1Click(Sender: TObject);
begin
   if (fmImpPedForn = nil) then
   begin
      Application.CreateForm(TfmImpPedForn, fmImpPedForn);
      fmImpPedForn.Show
   end;
end;

procedure TfmMain.PesquisaXML1Click(Sender: TObject);
begin
   if (fmImpXmlEnt = nil) then
   begin
      Application.CreateForm(TfmImpXmlEnt, fmImpXmlEnt);
      fmImpXmlEnt.Show;
   end;
end;

procedure TfmMain.Acertodeestoque1Click(Sender: TObject);
begin
   if (fmAcertoEstoque = nil) then
   begin
      Application.CreateForm(TfmAcertoEstoque, fmAcertoEstoque);
      fmAcertoEstoque.show();
   end;
end;

procedure TfmMain.Cancelarrequisiespendentes1Click(Sender: TObject);
begin
   if (fmRemItensSep = nil) then
   begin
      Application.CreateForm(TfmRemItensSep, fmRemItensSep);
      fmRemItensSep.show;
   end;
end;

procedure TfmMain.ListaitensmovimentadoswellxWms1Click(Sender: TObject);
begin
   if (fmLstDrvEntSaiCD = nil) then
   begin
      Application.CreateForm(TfmLstDrvEntSaiCD, fmLstDrvEntSaiCD);
      fmLstDrvEntSaiCD.Show();
   end;
end;

procedure TfmMain.Formatacomando1Click(Sender: TObject);
begin
   f.gravaLog(msg.msgInput('Comando SQL'));
end;

function TfmMain.enviarEmail(para, assunto, anexo:String; corpoMsg:Tstringlist; titJanela:String): boolean;
var
   c:String;
begin
   c:= dm.getCMD1('msg', 'mail.MsgRodape', DADOS_CON_MAIL.getValor('RemetenteNome'));
   if (corpoMsg = nil) then
      corpoMsg := TStringList.Create();

   corpoMsg.Add(c);

   result := uEmail.enviarEmail(DADOS_CON_MAIL, para, assunto, anexo, corpoMsg, titJanela);
end;

function TfmMain.getDadosConEmail(uo:String): THash;
var
   mailRemetente, user:String;
   hash:THash;
begin
   user :=  dm.getParamBD('comum.emailUser', '0');

   mailRemetente := dm.openSQL(dm.getCMD1('adm', 'getMailCdpes', getCdPesLogado()), '');
   if  (mailRemetente = '' )then
      mailRemetente := dm.getEmail(uo);

   hash := THash.Create();
   hash.add('host', 'smtp.gmail.com');
   hash.add('user', user);
   hash.add('password', dm.getParamBD('comum.emailpassword', '0'));
   hash.add('RemetenteNome', mailRemetente);
   hash.add('RemetenteDominio', dm.getParamBD('emailDominioEmpresa', '0') );
   result := hash;
end;

procedure TfmMain.ListaFichasPorCatContabil1Click(Sender: TObject);
begin
   if (fmLstFichaCatCont = nil) then
   begin
      Application.CreateForm(TfmLstFichaCatCont, fmLstFichaCatCont);
      fmLstFichaCatCont.show;
   end;
end;

procedure TfmMain.ListaestoquedivergenteWellxWms1Click(Sender: TObject);
begin
   if (fmLsdDrvgWellWms = nil) then
   begin
      Application.CreateForm(TfmLsdDrvgWellWms, fmLsdDrvgWellWms);
      fmLsdDrvgWellWms.show;
   end;
end;

procedure TfmMain.N1Click(Sender: TObject);
var
   sl:Tstringlist;
begin
   montarMenu( fmMain.getNomeLojaLogada(), fmMain.getUoLogada(), getUserLogado());
   dm.loadCommandsBD(getStrArqResource());
end;

procedure TfmMain.Zerarpickingestoquenegativo1Click(Sender: TObject);
begin
   uWms.zerarPickingNegativos();
end;

procedure TfmMain.Vendabrutafornecedorvalor1Click(Sender: TObject);
begin
   if (fmVdBrutaIt = nil) then
   begin
      Application.CreateForm(TfmVdBrutaIt, fmVdBrutaIt);
      fmVdBrutaIt.show;
   end;
end;

procedure TfmMain.GeraEANvlidoaleatrio1Click(Sender: TObject);
begin
   uProd.geraEanValido();
end;

procedure TfmMain.addFornaLista(lista: TadLabelListBox);
var
  cd_pes, ds_pes, ds_end:String;
begin
   fmMain.getDadosFornecedor(cd_pes, ds_pes, ds_end);
   if (cd_pes <> '') then
      lista.Items.add(f.preencheCampo(100,' ','D', ds_pes) + cd_pes);
end;

procedure TfmMain.DadosEntradasadaevenda1Click(Sender: TObject);
begin
	if ( fmDadosEntSaiMed = nil) then
   begin
		Application.CreateForm(TfmDadosEntSaiMed, fmDadosEntSaiMed);
		fmDadosEntSaiMed.show();
   end;
end;

procedure TfmMain.Gerarumanotacomositensdeoutra1Click(Sender: TObject);
begin
   if (fmCriaNf = nil) then
   begin
      Application.CreateForm(TfmCriaNf, fmCriaNf);
      fmCriaNf.show;
   end;
end;

procedure TfmMain.mnAnMovEstCdClick(Sender: TObject);
begin
	if (fmAnEstCd = nil )then
   begin
		Application.CreateForm(TfmAnEstCd, fmAnEstCd);
		fmAnEstCd.Show();
   end;
end;

procedure TfmMain.mnRelCredCliClick(Sender: TObject);
begin
	if (fmRelCredCli = nil) then
   begin
		Application.CreateForm(TfmRelCredCli, fmRelCredCli);
      fmRelCredCli.show;
   end;
end;

procedure TfmMain.mnRestoreOsClick(Sender: TObject);
begin
	uWms.retornaOs();
end;

procedure TfmMain.imprim1Click(Sender: TObject);
begin
	uEtq.impEtqBlocoCd();
end;

procedure TfmMain.ListarDescontosporperodo1Click(Sender: TObject);
begin
	if (fmDescPorData = nil) then
   begin
		Application.CreateForm(TfmDescPorData, fmDescPorData);
      fmDescPorData.show;
   end;
end;

procedure TfmMain.Espelhodetrocadeprodutos1Click(Sender: TObject);
begin
	if (fmImpTroca = nil) then
   begin
	   Application.CreateForm(TfmImpTroca, fmImpTroca);
      fmImpTroca.show();
	end;
end;

procedure TfmMain.Ajustedecaddecidade1Click(Sender: TObject);
begin
	if (fmAjCidades = nil) then
   begin
	   Application.CreateForm(TfmAjCidades, fmAjCidades);
      fmAjCidades.show();
	end;
end;

procedure TfmMain.IncluirItememOramento1Click(Sender: TObject);
begin
	if (fmAjCidades = nil) then
   begin
      Application.CreateForm(TfmAddItOrc, fmAddItOrc);
      fmAddItOrc.show();
	end;
end;

function TfmMain.getTextGeradorEmail: TStringlist;
var
   msgEmail:TStringlist;
begin
   msgEmail := TStringList.Create();
   msgEmail.Add('Arquivo  enviado pelo geraEstoque:');
   msgEmail.Add('Gerado por:' + fmMain.getNomeUsuario());
   msgEmail.Add('Em:' + dateTimeToStr(now) );
   result :=  msgEmail;
end;


procedure TfmMain.AlterarQuantidadeporcaixa1Click(Sender: TObject);
begin
   uProd.AltEmbProd();
end;

procedure TfmMain.CadastradadosParaoProtheus1Click(Sender: TObject);
begin
  	if (fmDadosAdTotvs = nil) then
   begin
      Application.CreateForm(TfmDadosAdTotvs, fmDadosAdTotvs);
      fmDadosAdTotvs.show();
	end;
end;

procedure TfmMain.CalcularFatordopedido1Click(Sender: TObject);
begin
   uPedCliente.visualizaValorFator();
end;

procedure TfmMain.ListaVarejoecustodeitensvendidos1Click(Sender: TObject);
begin
  	if (fmLstCustoDeVenda = nil) then
   begin
      Application.CreateForm(TfmLstCustoDeVenda, fmLstCustoDeVenda);
      fmLstCustoDeVenda.show();
	end;
end;

procedure TfmMain.AjustaNFJaboti1Click(Sender: TObject);
begin
   msg.msgWarning(dm.getMsg('fiscal.funcAjNfJaboti'));
   uFiscal.chamaRecalculoNf();
end;

procedure TfmMain.mnSpedContabilClick(Sender: TObject);
begin
   Application.CreateForm(TfmSpedCont, fmSpedCont);
   fmSpedCont.Show
end;

procedure TfmMain.ReceberNotadeTransfernciaXML1Click(Sender: TObject);
begin
   if msg.msgQuestion(dm.getMsg('300.0001')) = mrYes then
      uFiscal.chamaReceberTranfProtheus();
end;

end.





