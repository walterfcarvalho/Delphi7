unit uEstoque;

interface
   uses  windows,
  Forms,
StdCtrls, adLabelComboBox, Controls, classes, ADODB, sysutils, DB, ExtCtrls ;

   function ajustaCodigoNCM(isRef, ncm_sh:String):boolean;
   function diasDesdeFirstVenda(uo, is_ref:String):integer;
   function cadastraCategoria(cd_campoPai, cd_vCampoPai, ds_vCampo:String):boolean;
	function getDadosConfWms(os, isRef:String):TdataSet;
   function getDadosEntProduto(uo, isRef:String):TDataSet;
   function getDadosPedidoDeCompra(numPedido:String):TdataSet;
   function getDadosProdFromArqInv(linha:String; EAN_POS_INI, EAN_TAM:integer):TdataSet;
   function getDadosIntenWms(nota, isRef:String; di, df:Tdate):TdataSet;

   function getDiasSemMov(uo, is_ref, tp_mov:String):integer;
   function getAutorizadorWMS(tipo, numOperacao:String):Tdataset;
   function getEntradasPorItem(is_ref, uo:String; di, df:Tdate; dtInvertida, soCompras:boolean):TdataSet; overload;
   function getEntradasPorItem(is_ref, uo:String; di, df:Tdate):TdataSet; overload;
   function getEstoqueLojas(is_ref, isDisponivel:String):TDataSet;
   function getEstoqueParaRequisicao(is_ref, UO_CD:String):integer;
   function getEstoqueProduto(uo, is_ref, tipoSaldo:String):integer; overload;
   function getEstoqueProduto(uo, is_ref, tipoSaldo:String; data:Tdate):String; overload;
   function getDetalhesCRUC(is_ref:String):TdataSet;
   function getIsLancFromIsMovi(is_movi:String):String;
   function getItPorOperacao(uo, cdTrans, nivelcat, codCat:String; di, df:Tdate; isAgrupado:boolean; cd_ref:String):TdataSet;
   function getItensParaCadastroNCM(var tabela:TADOTable; isNota:String):boolean;
   function getRRANAItem(is_ref, uo, cd_trans, uoDestino:String;  dti, dtf:Tdate ):TdataSet;
   function getStrLancEstoque(empresa, sq_opf, uo, is_lanc, is_oper, Is_doc, is_ref, qtMov, vItem, flEntrada:String; vl_mov, saldo:real; data:Tdate; custoF:String):String;
   function getTabelaPrecos(tipoPesquisa, tpEstoque:smallInt; ds_ref, cd_ref, uo, pc01, pc02, numNivel, vlNivel:String):TdataSet;
   function getTotaisVendaAvaria(lojas:TadLabelComboBox; datai, dataf:Tdate; tabela:String):String;
   function getTotalDeEntradasProduto(entradas:TdataSet; isFormatado:boolean):String;
   function getVendaProduto(is_ref, uo, uocd :String; datai, dataf:Tdate):String;
   function getVendaProdutoDLEST(is_ref, is_uo, uocd:String; datai, dataf:Tdate):String;
   function getUltIsLanc(is_ref, uo:String):String;
   function insereEAN(is_ref, ean:String):boolean;
   function isPrdComPicking(is_ref:String):boolean;
   function isReqPendProduto(uo_cd, uo, is_ref:String; QT_DIAS_PEND:integer): TDataSet;
   function isRequisicaoAberta(uo, uoCd, userAtual:String): Boolean;

   procedure acertaQuantidadeItens(uo, usuario: String; tbItens:TADOTable; mostraMsgSemitem:boolean);
   procedure baixaDeAvarias(tbAvarias:TADOTable; uo, aprovador:String );
   procedure cadastraEanPorArquivo(arq:String);
   procedure calculaRRANA(tbItens, tbMov:TADOTable; is_refs:TStringlist; uo:String; dti, dtf:Tdate);
   procedure calculaTotaisAvariasPorFornecedor(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
   procedure calculaTotaisAvariasPorLoja(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
   procedure confereInvLoja(uo, arqInv, arqSaida:String; data:Tdate);
   procedure criaSessaoReq(uo, uo_cd, ds_usu: String);
   procedure fechaSessaoReq(uo, uo_cd:String);
   procedure getCRUCBaseNota(var query:TADOquery; is_ref:String);
   procedure getItensclassificacaoCategoria(tb:TADOTable; cdRef, ds_ref:String; isClasificado:integer; dtInicioMov:TdateTime; tpConsulta:integer);
   procedure getTotaisAvariasPorFornecedor(var tbTotais:TadoTAble; nmTabela:String);
   procedure getTotaIsPorTipoDeAvaria(var tbTotais:TadoTAble; nmTabela:String);
   procedure inserirItensNotasUsoConsumo(di, df:Tdate; user:String);
   procedure insItemTbAcerto(tpAcerto:String; qtAct:real; dsIt:TdataSet; tb:TADOTable);
   procedure listaItTransfComWMS(tb:TADOTable; uo:String; di, df:Tdate; isDivergentes, remDirvgAutoriz:boolean; cd_ref:String);
   procedure listaItTransf(tb:TADOTable; uo:String; di, df:Tdate);
   procedure listaItRecComWMS(tb:TADOTable; uo:String; di, df:Tdate; isDivergentes, remDirvgAutoriz:boolean; cd_ref:String);
   procedure removeEAN(cd_pesq, is_ref: String);
   procedure removeEansInvalidos(inicio, fim:String);
   procedure removeItemCategoria(cd_campo, cd_vCampo:String);
   procedure setImagem( image:Timage; is_ref:String);
   procedure listaItensDirvgWellWms(tb:TADOTable; codigo:String; isNegativos:boolean);
   procedure listarItensPorTipoOperacao(tb:TadoTable; tpOperacao, uo, nvCat, vlCat:String; di, df:Tdate);
   procedure listarVendaBrutaFor(tb:TadoTable; di, df:Tdate; uo, nivelCat, codCat, cd_pes:String);
   procedure zerarEstoque(uo:String);

   procedure zeraPendenciaEstoque(uo, is_ref:String);

implementation

uses uMain, ucf, cf, uDm, f, fdt, uFiscal, msg, uPreco, uProd, ureq, uLj, messages, uAcertoEstoque;

CONST
  STR_NAO_CONSTA = 'Nao Consta';

function getAutorizadorWMS(tipo, numOperacao:String):Tdataset;
var
   cmd:String;
begin
//   tipo são Os  e Ent

   cmd := dm.getCMD2('wms', 'getAutOprWms', quotedStr(tipo), numOperacao);
   result := dm.getDataSetQ(cmd);
end;

function getEstoqueProduto(uo, is_ref, tipoSaldo:String; data:Tdate):String; overload;
var
   ds:TdataSet;
   strTpSaldo, saldo, cmd:String;
begin
   { contas
     1           Pendências de fornecimento
     2           Distribuição aguardando fornecimento
     3           Reservado para distribuição
     4           A receber de distribuição e reservado no depósito
     5           A receber de distribuição Aguardando Fornecimento
     6           Estoque
     8           Reservado para venda
     9           Mercadoria avariada
    12           Em trânsito
  10000004       Auditoria da distribuição
}
   saldo := '0';
   f.gravaLog('DataBD:' + dateToStr(dm.getDateBd()));

   if  true {(data >= funcSQL.getDateBd(fmMain.conexao) )} then
   begin
      if (upperCase(tipoSaldo) = 'D') then
         strTpSaldo:= 'qtSaldoDisponivel'
      else
         strTpSaldo:= 'SaldoFisico';

      cmd := 'select ' + strTpsaldo + ' from viwestoque with(nolock) where is_ref= '+
             is_ref + ' and is_estoque=' + uo;

      ds := dm.getDataSetQ(cmd);

      if ( ds.isEmpty = false) then
        saldo := ds.fieldByName(strTpSaldo).asString;

   end
   else
      f.gravaLog('DataBD dif da atual: ' + dateToStr(data) + ' ' + dateToStr(dm.getDateBd()));

   ds.free();
   result := saldo;
end;

function getEstoqueProduto(uo, is_ref, tipoSaldo:String):integer; overload;
begin
   result := strToInt(getEstoqueProduto(uo, is_ref, tipoSaldo, dm.getDateBd() ) );
end;

procedure acertaQuantidadeItens(uo, usuario:String; tbItens:TADOTable; mostraMsgSemitem:boolean);
var
   flEntrada:String;
   sq_opf, auxVitem, cmd:string;
   is_oper, is_doc, is_lanc:string;
   vItem :real;
   i:integer;
   lista:TStringList;
   codEmpresa:String;
   data: Tdate;
   custoF, CMU:String;
begin
   vItem := 0;

   f.gravaLog('uEstoque.acertaQuantidadeItens()');

   codEmpresa := dm.getParamBD('comum.codEmpresa', '');

   lista := Tstringlist.Create();

   data := dm.getDateBd();

   is_oper := dm.getContadorWell('IS_OPER');
   is_doc := dm.getContadorWell('IS_doc');

   tbItens.First();
   while (tbItens.Eof = false) do
   begin
      // cada item precisa de um is_lanc
      is_lanc :=  dm.getContadorWell('is_lanc');

      sq_opf := tbItens.FieldByName('entSai').AsString;

      if (  uppercase(sq_opf) = 'E') then
         sq_opf :=  '10000013'	//ACERTO DE ESTOQUE A credito
      else
         sq_opf :=  '10000012'; //ACERTO DE ESTOQUE A debito

      // tenta pegar opreco de custo se nao houver pega o custo unico,
      // se nao houver pega o valor na avaria e divide por 2

      custoF :=  uPreco.getPcProd( uo, '', tbItens.FieldByName('is_ref').AsString, '10');

      // para evistar que ao zerar o estoque da loja o item fique sem custo
      if (custoF = '0') and (mostraMsgSemItem = false) then
         custoF := '1';

      CMU :=  uPreco.getPcProd( uo, tbItens.FieldByName('codigo').AsString, '', '5');

      if CMU = '0' then
        CMU :=  uPreco.getPcProd( uo, tbItens.FieldByName('codigo').AsString, '', '101');

      if CMU = '0' then
        CMU :=  '1';



      vItem :=  strToFloat(custoF) * tbItens.FieldByName('QtAcerto').asFloat;

      if (vItem = 0) then
         f.gravaLog('Item com Custo Zerado:, is_ref '+ tbItens.FieldByName('codigo').AsString);

      tbItens.Edit();
      tbItens.FieldByName('is_oper').asString := is_oper;
      tbItens.FieldByName('is_doc').asString := is_doc;
      tbItens.FieldByName('is_lanc').asString := is_lanc;
      tbItens.FieldByName('saldo').AsFloat := 0;
      tbItens.FieldByName('vl_mov').asFloat :=  vItem ;
      tbItens.FieldByName('custoFiscal').AsString := custoF;
      tbItens.FieldByName('CMU').AsString := CMU;

      tbItens.Post;
      tbItens.Next();
   end;

   // pega o valor total dos itens
   auxVitem := f.ValorSql( dm.SomaColTable(tbItens, 'vl_mov', true));


   if (tbItens.RecordCount > 0) then
   begin
      cmd :=
      uFiscal.getStrInsertToper( codEmpresa, is_oper, sq_opf, usuario, '5', data);
      lista.Add(cmd);

      cmd := uFiscal.getStrInsertDsdoc(codEmpresa, uo, is_doc, 'A', is_oper, fmMain.getCdPesLogado(), usuario, data);
      lista.Add(cmd);

      cmd := 'exec StoInsertAcerto @vl_acerto= ' + auxVitem +', '+
      		 '@IS_DOC= '+is_doc+ ', '+
             '@IS_FILIAL= '+ uo + ', '+
             '@IS_OPER= '+ is_oper +', '+
             '@CD_MOT= 6, @DS_OBS= '''' ';
      lista.Add(cmd);

     tbItens.First;
     while tbItens.Eof = false do
     begin
        if (tbItens.FieldByName('entSai').AsString = 'E') then
          flEntrada := '1'
        else
          flEntrada := '0';

        if (tbItens.FieldByName('QtAcerto').asString <> '0') then
        begin
           cmd :=
           getStrLancEstoque(
              codEmpresa,
              sq_opf,
              uo,
              tbItens.FieldByName('is_lanc').asString,
              is_oper,
              is_doc,
              tbItens.FieldByName('is_ref').asString,
              floatToStr(abs(tbItens.FieldByName('QtAcerto').AsInteger)),
              f.valorSql(tbItens.FieldByName('vl_mov').asString),
              flEntrada,
              vItem,
              tbItens.FieldByName('saldo').AsFloat,
              data,
              tbItens.FieldByName('custoFiscal').AsString
           );
	        lista.Add(cmd);
        end;

        tbItens.Next;
     end;
   end;


   if (tbItens.RecordCount  >  0) and (auxVitem <> '0.00') then
   begin
      f.gravaLog(lista);


      for i := 0 to lista.Count -1 do
      begin
			fmMain.msgStatusProgresso(i , lista.Count -1, 'Executando script...');
      	sleep(100);
        dm.execSQL(lista[i]);
      end;
   end
   else
      if ( mostraMsgSemItem = true) then
         msg.msgWarning('Nao há itens no acerto, ou há itens com custo zerado');

   lista.free();
end;


function getEntradasPorItem(is_ref, uo:String; di, df:Tdate; dtInvertida, soCompras:boolean):TdataSet; overload;
var
   strTpEnt, cmd:String;
begin
   f.gravaLog('function getEntradasPorItem(is_ref:'+ is_ref + ', uo:'+  uo + ', Entradas de : ' +  DateToStr(di) + ' até: ' + DateToStr(df)+' )');

   if (uo <> '') and (uo <> '999') then
      uo := dm.getCMD1('estoque', 'getEntItem.uo', uo)
   else
      uo := dm.getCMD('estoque', 'getEntItem.semUo');

   if (SoCompras = true )then
      strTpEnt := dm.getCMD('estoque', 'getEntItem.socompras')
   else
      strTpEnt :=  '/* sem filtro */';

   cmd := dm.getCMD5('estoque', 'getEntItem', is_ref, fdt.dateToSqlDate(di), fdt.dateToSqlDate(df), uo, strTpEnt);

   if (dtInvertida = true) then
      dm.setParam(cmd,  dm.getCMD('estoque', 'getEntItem.desc'))
   else
      dm.setParam(cmd, '');

   result := dm.getDataSetQ(cmd);
end;

function getEntradasPorItem(is_ref, uo:String; di, df:Tdate):TdataSet; overload;
begin
   result := getEntradasPorItem(is_ref, uo, di, df, true, false);
end;

function getTotalDeEntradasProduto(entradas:TdataSet; isFormatado:boolean):String;
begin
   result := dm.somaColTable(entradas, 'quant', isFormatado);
end;
function getVendaProduto(is_ref, uo, uocd :String;  datai, dataf:Tdate):String;
var
   ds:TdataSet;
   valor:String;
begin
   ds:= uProd.getVdItemDetPorLojaPeriodo(is_ref, uo, datai, dataf);
   if ( ds.IsEmpty = true) then
      valor := '0'
   else
      valor :=  floatTostrf(dm.somaColunaTable(ds,'qt_mov') , ffgeneral, 18, 0);
   ds.free();
   result := valor;
end;

function getVendaProdutoDLEST(is_ref, is_uo, uocd:String; datai, dataf:Tdate):String;
var
   ds:TDataSet;
   cmd:String;
begin
   cmd :=
   '  select dlest.is_estoque '+#13+
   ', DLEST.is_ref '+#13+
   ', dlest.is_lanc '+#13+
   ', case  '+#13+
   '     when  toper.codTransacao in ( 09, 26, 43 ) then   ( QT_MOV * -1 ) '+#13+
   '     when  toper.codTransacao in ( 23, 24, 25, 44 , 46 ) then  ( QT_MOV ) '+#13+
   ' end as qt_mov '+#13+
   ' from dlest (nolock) '+#13+
   ' inner join toper (NOLOCK) on dlest.is_oper = toper.is_oper '+#13+
   ' where dlest.dt_mov between '+#13+
   fdt.dateTimeToSqlDateTime(dataI, ' 00:00:01') + ' and ' +#13+
   fdt.dateTimeToSqlDateTime(dataF, ' 23:59:00') +#13+
   ' and dlest.is_estoque = ' + is_uo +#13+
   ' and toper.codTransacao in ( 09, 23, 24, 25, 26, 43, 44 , 46 ) '+#13+
   ' and dlest.st_mov = '''' '+#13+
   ' and dlest.is_ref = ' + is_ref;

   ds:=  dm.getDataSetQ(cmd);

   if (ds.isEmpty = true )then
     result := '0'
   else
      result :=  floatTostrf(  dm.somaColunaTable(ds, 'qt_mov'), ffNumber, 18, 0);
end;

function getDadosEntProduto(uo, isRef:String):TDataSet;
var
  cmd:String;
begin
   cmd := ' Select sum(qt_mov) as qt_mov, dt_mov '+
          ' from zcf_dsdei where ' +
          ' is_ref = ' + isRef +
          ' and is_estoque = '+ uo +
          ' and dt_mov in( select top 01  dt_mov ' +
          ' from zcf_DSDEI (nolock) where is_ref = ' + isRef +
          ' and is_estoque = '+ uo +
          ' order by is_lanc desc ) '+
          ' group by dt_mov ';
  result := dm.getDataSetq(cmd);
end;

function getDadosPedidoDeCompra(numPedido:String):TdataSet;
var
  cmd:String;
begin
   cmd :=' select prod.is_ref, Prod.cd_ref as CODIGO, Prod.ds_ref AS DESCRICAO, CAST ( item.qt_ped as int) as QUANT, item.pr_uni AS UND, item.pc_ipi AS IPI' +
         ' from crefe prod (NOLOCK), dsipe item (NOLOCK) where prod.is_ref = item.is_ref'+
         ' and item.is_pedf = '+ quotedStr(numPedido);
//   dm.getDataSetQ(cmd);
   result := dm.getDataSetQ(cmd);
end;

procedure getCRUCBaseNota(var query:TADOquery; is_ref:String);
var
   cmd:String;
begin
   cmd :=
   ' begin ' +#13+
   ' declare @is_oper int' +#13+
   ' set @is_oper = ' +
   ' isnull( (select top 01 is_oper from zcf_dsdei where is_ref = ' +is_ref+ ' and codTransacao = 1 AND DT_MOV <' + fdt.dateToSqlDate('01/01/2011') + ' order by dt_mov desc ), 0)' +
   ' select ' + #13+
   ' dnota.sr_docf as Serie' +#13+
   ' ,dnota.nr_docf as Nota' +#13+
   ' ,tbuo.ds_uo as Loja' +#13+
   ' , ceiling( (dnota.VL_DSPEXTRA / (dnota.VL_DSPEXTRA + dnota.vl_tot)) * 100) as [% extra nota]' +#13+
   ' ,dmovi.pr_tabela  as [Vl de Nota]'+#13+
   ' ,dmovi.PC_IPI as [% IPI]'+#13+
   ' ,(dmovi.pR_TABELA * (PC_IPI/100)) as [(+) Vl IPI]'+#13+
   ' ,dmovi.Pc_icm as[ %ICMS]'+#13+
   ' ,(dmovi.pR_TABELA * (PC_ICM/100)) as [(-) Vl ICMS]'+#13+
   ' , dmovi.pr_tabela / (1 - (dnota.VL_DSPEXTRA / (dnota.VL_DSPEXTRA + dnota.vl_tot))) + (dmovi.pR_TABELA * (PC_IPI/100))  as [Custo +IPI]' +#13+
   ' , dmovi.pr_tabela / (1 - (dnota.VL_DSPEXTRA / (dnota.VL_DSPEXTRA + dnota.vl_tot))) + (dmovi.pR_TABELA * (PC_IPI/100)) - (dmovi.pR_TABELA * (PC_ICM/100))  as [Custo +IPI -ICMS]' +#13+
   ' from dnota (nolock)' +#13+
   ' inner join dmovi (nolock) on dnota.is_nota = dmovi.is_nota'+#13+
   ' left join zcf_tbuo tbuo on dnota.is_estoque = tbuo.is_uo'+#13+
   ' where'+#13+
   '     dnota.is_oper = @is_oper'+#13+
   ' and dmovi.is_ref = ' + is_ref + ' end';
   dm.getQuery(query, cmd);
end;

procedure getTotaisAvariasPorFornecedor(var tbTotais:TadoTAble; nmTabela:String);
var
   cmd:String;
begin
   if (tbTotais.Active = true) then
       tbTotais.Close();
   cmd := 'tipoAvaria varchar(30), qtItens int, valorTotalCusto money, valorTotalVenda money, fornecedor varchar(60) ';
   dm.getTable(tbtotais, cmd);

   cmd :=
      ' insert ' + tbTotais.TableName +
      ' select '''', sum(qtItens), sum(valorTotalCusto) as valorTotalCusto, sum(ValorTotalPcVarejo)as ValorTotalPcVarejo, Fornecedor from ' + nmTabela +' group by fornecedor ';

   dm.execSQL(cmd);
   tbTotais.Close();
   tbTotais.Open();
end;


procedure getTotaisPorTipoDeAvaria(var tbTotais:TadoTAble; nmTabela:String);
var
   cmd:String;
begin
   if (tbTotais.Active = true) then
       tbTotais.Close();

   cmd := 'tipoAvaria varchar(30), qtItens int, valorTotalCusto money, valorTotalVenda money, fornecedor varchar(30) ';
   dm.getTable(tbtotais, cmd);

   cmd :=
      ' insert ' + tbTotais.TableName +
      ' select tipoAvaria, sum(qtItens), sum(valorTotalCusto) as valorTotalCusto, sum(ValorTotalPcVarejo)as ValorTotalPcVarejo, '''' as Fornecedor from ' + nmTabela +' group by tipoAvaria '+
      ' union '+
      ' select ''Totalização: '' , sum(qtItens), sum(valorTotalCusto) as valorTotalCusto, sum(ValorTotalPcVarejo)as ValorTotalPcVarejo, '''' as Fornecedor from ' + nmTabela ;

   dm.execSQL(cmd);
   tbTotais.Close();
   tbTotais.Open();
end;


function getTotaisVendaAvaria(lojas:TadLabelComboBox; datai, dataf:Tdate; tabela:String):String;
var
   uo,cmd:String;
begin
   uo := f.getCodUO(lojas);
   cmd := 'Select isNull(sum(qt*und),0) as valorVenda from zcf_avariasDescontos  (nolock) '+
          'where data between '+fdt.dateToSqlDate(datai)+' and '+ fdt.dateToSqlDate(dataf)+
          ' and is_uo in (select distinct is_uo from ' + tabela +')';

   result := dm.openSQL(cmd, 'valorVenda');
end;

procedure calculaTotaisAvariasPorFornecedor(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
var
   uo, cmd:String;
begin
   criaTabelaDosTotaisDeAvarias(tb);

   uo := f.getCodUO(lojas);
   cmd := ' insert ' + tb.TableName +
   ' select UO.is_uo, UO.ds_uo, Par.valor, ' +
   'sum(I.quant) as totalQuantItens, '+
   'sum(quant*pco) as TotalCustoItens, '+
   'sum(quant*pcoVarejo) as TotalVendaItens, '+
   '0 as totalVendido, ' +#13+
   'F.nm_fantasi ' +#13+
   'from zcf_AvariasItens I ' +#13+
   'inner join zcf_avarias A on A.loja = I.loja and I.numAvaria = A.numAvaria '+#13+
   'inner join crefe P on I.is_ref = P.is_ref '+#13+
   'inner join dspes F on P.cd_pes = F.cd_pes '+#13+
   'inner join zcf_tbuo UO on I.loja = UO.is_uo '+#13+
   'left join zcf_paramGerais Par on Par.uo = A.TipoAvaria  and par.nm_Param = ''avarias.tpOrigem''  '+#13+
   'where a.data between ' + fdt.dateToSqlDate(datai) +' and '+ fdt.dateToSqlDate(dataf) +#13;

   if (uo <> '999') then
   cmd :=  cmd + ' and I.loja = ' + uo;

   cmd := cmd +   ' group by UO.is_uo, UO.ds_uo, P.cd_pes, F.nm_fantasi, A.tipoAvaria, Par.Valor ' +
                  ' order by UO.is_uo, F.nm_fantasi, PAR.valor';

    dm.execSQL(cmd);

    tb.close();
    tb.Open();
end;

procedure calculaTotaisAvariasPorLoja(var tb:TADOTable; lojas:TadLabelComboBox; datai, dataf:Tdate);
var
  uo, cmd:String;
begin
    criaTabelaDosTotaisDeAvarias(tb);

    uo := f.getCodUO(lojas);

    cmd := ' insert ' + tb.TableName +
    ' select A.loja, UO.ds_uo,  P.valor as TipoAvaria, ' +#13+
    'sum(i.quant) as qtItens, ' +#13+
    'sum(i.pcoTotal) as [valorCusto Total], '+#13+
    'sum(i.quant*I.pcoVarejo) as [valorVenda Total], '+#13+
    'totalVenda = ( select isNull(sum(qt*und),0) as valorVenda from zcf_avariasDescontos D (nolock) where D.is_uo = A.loja and data between ' + fdt.dateToSqlDate(datai) +' and '+ fdt.dateToSqlDate(dataf) + '), '+#13+
    ' '''' as fornecedor ' + #13+
    'from zcf_avariasitens I (nolock) '+#13+
    'inner join zcf_avarias A (nolock) on i.numAvaria = A.numAvaria and I.loja = A.loja and a.ehAtiva = 1 ' +#13+
    'inner join zcf_tbuo UO (nolock) on UO.is_uo = A.loja ' +#13+
    'left join zcf_paramGerais P (noLock) on P.nm_Param = ''avarias.tpOrigem'' and A.tipoAvaria = p.uo ' +#13+
    'where a.data between ' + fdt.dateToSqlDate(datai) +' and '+ fdt.dateToSqlDate(dataf) +#13;

    if (uo <> '999' )then
      cmd := cmd + ' and A.Loja = ' + uo;

    cmd := cmd +
    'group by '+
    'A.loja,  A.TipoAvaria, p.valor, UO.ds_uo ' +

    'order by A.loja, P.valor ' ;

    dm.execSQL(cmd);
    tb.Close();
    tb.Open();
end;

function getItensParaCadastroNCM(var tabela:TADOTable; isNota:String):boolean;
var
  ds:TdataSet;
begin
   ds:= uFiscal.getItensNota(isNota);
   ds.First();
   while (ds.Eof = false) do
   begin
      tabela.AppendRecord([
         ds.FieldByName('is_ref').asString,
         ds.FieldByName('cd_ref').asString,
         ds.FieldByName('ds_ref').asString,
         ds.FieldByName('ncm_sh').asString
                         ]);
      ds.Next();
   end;
   ds.Destroy();
   result := true;
end;

function ajustaCodigoNCM(isRef, ncm_sh:String):boolean;
begin
   result := dm.execSQL('update crefe set NCM_SH= ' + quotedStr(ncm_sh) + ' where is_ref = ' + isRef);
end;

procedure inserirItensNotasUsoConsumo(di, df:Tdate; user:String);
var
  dsNotas, dsItem, dsNota:TDataSet;
  is_ref, cmd:String;
begin
   fmMain.msgStatus('Listando as notas de outras saidas...');

   cmd := dm.getCMD2('fiscal', 'getNfUsoCons', fdt.dateToSqlDate(di), fdt.dateToSqlDate(df));

   dsNotas := dm.getDataSetQ(cmd);


   dsNotas.First();
   while ( dsNotas.Eof = false) do
   begin
      if ( dsNotas.FieldByName('cd_cfo').AsString = '1556') or( dsNotas.FieldByName('cd_cfo').AsString = '2556') then
         is_ref := dm.getParamBD('fiscal.itemConsumo', '')
      else
         is_ref := dm.getParamBD('fiscal.itemServico', '');

      dsNota := uFiscal.getDadosNota(dsNotas.fieldByName('is_nota').AsString);
      dsItem := uProd.getDadosProd( dsNotas.fieldByName('is_estoque').asString, '', is_ref, '101', false);

      uFiscal.insereItemDeNota( dsItem, dsNota, is_ref, user);

      dsItem.free();
      dsNota.free();

      dsNotas.next();
   end;

  dsNotas.free();
end;


function getEstoqueLojas(is_ref, isDisponivel:String):TdataSet;
var
   cmd:String;
begin
   cmd := dm.getCMD('Estoque','getDsEstEmp');
   dm.setQtParam(cmd, is_ref );
   dm.setQtParam(cmd, isDisponivel );
   result := dm.getDataSetQ(cmd);
end;

function isReqPendProduto(uo_cd, uo, is_ref:String; QT_DIAS_PEND:integer): TDataSet;
var
  cmd:String;
begin
   cmd := dm.getCMD('Estoque','getReqPendProd');
   dm.setParams(cmd, is_ref, uo_cd, uo );
   dm.setParam(cmd, fdt.dateToSqlDate(now-QT_DIAS_PEND) );

   result := dm.getDataSetQ(cmd);
end;

function getTabelaPrecos(tipoPesquisa, tpEstoque:smallInt; ds_ref, cd_ref, uo, pc01, pc02, numNivel, vlNivel:String):TdataSet;
var
   cmd:String;
begin
  cmd :=
  '  select crefe.cd_ref as codigo '+#13+
  ' ,crefe.ds_ref as descricao '+#13+
  ' ,crefe.qt_emb '+#13+
  ' ,dbo.Z_CF_EstoqueNaLoja( is_ref, ' + uo+ ' , 1 ) as estoqueDisponivel '+#13+
  ' ,dbo.Z_CF_FunObterPrecoProduto_CF( '+pc01+ ', is_ref, ' +uo+ ', 0 ) as [Preco 01] '+#13+
  ' ,dbo.Z_CF_FunObterPrecoProduto_CF( '+pc02+ ', is_ref, ' +uo+ ', 0 ) as [Preco 02] '+#13+
  ' ,crefe.cd_pes '+#13+
  ' ,crefe.is_ref '+#13+
  ', dt_imp' +
  ' from crefe with(NoLock) ';

  if (numNivel <> '0') then
  cmd := cmd + 'inner join cccom on crefe.is_ref = cccom.cd_chave ' +#13+
               ' and cccom.cd_campo= '+ numNivel +#13+
               ' and cccom.cd_vcampo= '+ vlNivel +#13;

  cmd := cmd +  ' where crefe.cd_ref like '+ quotedStr(cd_ref + '%') +#13 ;

  if (ds_ref <> '') then
  begin
    //  tipo pesquisa =1 produtos que comecam com a descricao
    //  tipo pesquisa = 2 produtos q contem a descricap

     if (tipoPesquisa = 1) then
       cmd := cmd + ' and crefe.ds_ref like '+quotedStr(ds_ref +'%')+#13;

     if (tipoPesquisa = 2) then
       cmd := cmd + ' and crefe.ds_ref like '+quotedStr('%' + ds_ref+ '%')+#13;
  end;

  if (tpEstoque = 1) then
     cmd := cmd +  ' and dbo.Z_CF_EstoqueNaLoja( is_ref, '+uo +', 1) <> 0 '+#13;

  if (tpEstoque = 2) then
     cmd := cmd + ' and dbo.Z_CF_EstoqueNaLoja( is_ref, '+uo +', 1 ) > 0 '+#13;

  if (tpEstoque = 3) then
     cmd := cmd + ' and dbo.Z_CF_EstoqueNaLoja( is_ref, '+uo +', 1 ) < 0 '+#13;

  cmd := cmd +' order by  crefe.ds_ref';

  result := dm.getDataSetQ(cmd);
end;


function getDiasSemMov(uo, is_ref, tp_mov:String):integer;
var
	ds:Tdataset;
begin
	ds := uprod.getDadosUltMov(is_ref, uo, tp_mov);

   if (ds.FieldByName('qtDias').AsString = '') then
      result := 9999
   else
      result := ds.FieldByName('qtDias').AsInteger;

	ds.Free();
end;

function getStrLancEstoque(empresa, sq_opf, uo, is_lanc, is_oper, Is_doc, is_ref, qtMov, vItem, flEntrada:String; vl_mov, saldo:real; data:Tdate; custoF:String):String;
var
   cmd:String;
begin
   f.gravaLog('getStrLancEstoque()');

   cmd := dm.getCMD('Estoque', 'stoAtualizaLancEStoque');
   dm.setParam(cmd, is_lanc);
   dm.setParam(cmd, is_oper);
   dm.setParam(cmd, is_doc);
   dm.setParam(cmd, uo);
   dm.setParam(cmd, is_ref);
   dm.setParam(cmd, fdt.DateTimeToSqlDateTime(data, ''));
   dm.setParam(cmd, qtMov);
   dm.setParam(cmd, f.valorSql(saldo) + '/*saldo*/' );
   dm.setParam(cmd, f.valorSql(vl_mov) );
   dm.setParam(cmd, empresa);
   dm.setParam(cmd, sq_opf);
   dm.setParam(cmd, flEntrada);

   dm.setParam(cmd, f.valorSql(custoF) + '/* custoFiscal */');

   result := cmd;
end;

procedure baixaDeAvarias(tbAvarias:TADOTable; uo, aprovador:String );
var
   tbAcerto:TADOTable;
begin
   tbAcerto := TADOTable.Create(nil);
   dm.getTable(tbAcerto, dm.getCMD('Estoque', 'getTbAcerto'));

   tbAvarias.First();

   while (tbAvarias.Eof = false) do
   begin
      tbAcerto.Append;
      tbAcerto.Edit;
      tbAcerto.FieldByName('qtAcerto').Assign( tbAvarias.FieldByName('estoqueDisponivel') );
      tbAcerto.FieldByName('is_ref').Assign( tbAvarias.FieldByName('is_ref') );
      tbAcerto.FieldByName('vl_mov').Assign( tbAvarias.FieldByName('preco') );
      tbAcerto.FieldByName('codigo').Assign( tbAvarias.FieldByName('codigo') );
      tbAcerto.FieldByName('entSai').AsString := 'S';

      tbAcerto.Post();

      tbAvarias.Next();
   end;
   uEstoque.acertaQuantidadeItens( uo, aprovador, tbAcerto, false);
   tbAcerto.Free();
end;


function getDadosProdFromArqInv(linha:String; EAN_POS_INI, EAN_TAM:integer):TdataSet;
var
   dsItem:TdataSet;
begin
   dsItem := uProd.getDadosProd(fmMain.getUoLogada(), trim(copy(linha, EAN_POS_INI, EAN_TAM)), '', '101', false);

   if ( dsItem.IsEmpty = true ) then
      dsItem:= uProd.getDadosProd( fmMain.getUoLogada, trim(copy(linha, 02, 12)), '', '101', false);
   if ( dsItem.IsEmpty = true) then
      dsItem:= uProd.getDadosProd( fmMain.getUoLogada, trim(copy(linha, 07, 07)), '', '101', false);
   if ( dsItem.IsEmpty = true) then
      dsItem:= uProd.getDadosProd( fmMain.getUoLogada, trim(copy(linha, 06, 08)), '', '101', false);
  result := dsItem;
end;

procedure confereInvLoja(uo, arqInv, arqSaida:String; data:Tdate);
var
//  tbInv:TADOTable;
  arq:TStringList;
  i:Integer;
  dsItem:TdataSet;
  diasSemMov:real;
begin
 // veridfica se tem movimentcao de estoque no mesmo dia

   diasSemMov := (dm.getDateBd - data);

   arq := TSTringList.Create();
   arq.LoadFromFile(arqInv);

   for i:= 0 to arq.Count -1 do
   begin
      dsItem:= getDadosProdFromArqInv( arq[i], 1, 13);

      if (dsItem.IsEmpty = false) then
      begin
         if (diasSemMov <> uEstoque.getDiasSemMov(uo,   dsItem.fieldByName('is_ref').AsString, '5')) then
            f.gravaLinhaEmUmArquivo(arqSaida, arq[i]);
      end
      else
         f.gravaLinhaEmUmArquivo('c:\NaoEncontrados.txt', arq[i]);

      sleep(100);
      dsItem.free();
   end
end;

function getEstoqueParaRequisicao(is_ref, UO_CD:String):integer;
begin
   result := strToInt(dm.OpenSql('Select dbo.zcf_EstLojaParaReq('+ is_ref +', '+UO_CD+ ',1) as qt', 'qt'));
end;



procedure criaSessaoReq(uo, uo_cd, ds_usu: String);
begin
   dm.execSQL( dm.getQtCMD3('Estoque', 'osDepBloqSessao', uo, uo_cd, ds_usu));
end;

procedure fechaSessaoReq(uo, uo_cd:String);
begin
   dm.execSQL( dm.getQtCMD3('Estoque', 'osDepCloseSessao', uo, uo_cd, ''));
end;


function isRequisicaoAberta(uo, uoCd, userAtual:String): Boolean;
var
  nm_usu, cmd:String;
begin
   cmd := dm.getCMD3('Estoque', 'getSessionReq', uo, uoCd, '');
   nm_usu := dm.openSQL(cmd, 'ds_usu');


   if (nm_usu <> '') and (nm_usu = userAtual) then
   begin
      msg.msgErro(dm.getCMD1('msg', 'osDepErrReqOpen', nm_usu));
      Result := true;
   end
   else
      result := false;
end;

function diasDesdeFirstVenda(uo, is_ref:String):integer;
var
   cmd:String;
begin
   cmd := dm.getCMD3('Estoque', 'getDiasFristVd', is_ref, uo, '');
   result := strToint( dm.openSQL(cmd, ''));
end;


procedure getItensclassificacaoCategoria(tb:TADOTable; cdRef, ds_ref:String; isClasificado:integer; dtInicioMov:TdateTime; tpConsulta:integer);
var
  nmTb, strclass, cmd, tpLstItens :String;
  i:integer;
begin
{Nao classificados
Classificados
Todos
}
   if tb.TableName <> '' then
      tb.Close();

   nmTb := dm.getNomeTableTemp();

   case isClasificado of
      0: strClass := dm.getCMD('cat', 'getItensPclassCat.notClass');
      1: strClass := dm.getCMD('cat', 'getItensPclassCat.isClass');
   else
      strClass := '';
   end;

   if tpConsulta = 0 then
      tpLstItens := dm.getCMD1('cat', 'getItensPclassCat.crefe', cdRef)
   else
      tpLstItens := dm.getCMD1('cat', 'getItensPclassCat.pedCompra', cdRef);

   cmd :=   dm.getCMD4('cat', 'getItensPclassCat', fdt.dateToSqlDate(dtInicioMov), nmTb, tpLstItens, ds_ref );


   cmd := cmd + strclass + dm.getCMD('cat', 'getItensPclassCat.ordem');

   dm.execSQL(cmd);

   tb.TableName := nmTb;

   tb.Open();

   for i:=0 to tb.FieldCount-1 do
     tb.Fields[i].ReadOnly := true;

   tb.FieldByName('S').ReadOnly:= false;
end;

function insereEAN(is_ref, ean:String):boolean;
begin
   result := dm.execSQL( dm.getCMD2('Estoque', 'insereEAN', quotedstr(ean), is_ref) );
end;

procedure removeEAN(cd_pesq, is_ref: String);
var
   cmd :String;
begin
   cmd := 'delete from dscbr where ' +
          'cd_pesq= ' +quotedstr(cd_pesq) + ' and is_Ref=' + is_ref;
   dm.execSQL(cmd);
end;

procedure cadastraEanPorArquivo(arq:String);
var
   lst, nCadastrado:TStringlist;
   i:integer;
   cd_ref, ean:String;
   ds:tdataSet;
begin
   lst:= TStringList.Create();
   nCadastrado := TStringList.Create();

   lst.LoadFromFile(arq);

   for i:= 0 to lst.Count-1 do
   begin
      fmMain.msgStatus(intToStr(i));

      cd_ref :=  trim(copy(lst[i], 83, 10));

      ean := trim(copy(lst[i], 01, 13));

      ds:= uProd.getDadosProd( fmMain.getUOCD(), cd_ref, '', '101', false);
      if ( ds.IsEmpty = false ) then
         insereEAN(ds.fieldByName('is_ref').asString, ean)
      else
         nCadastrado.Add( lst[i] );

      ds.Free();
   end;
   nCadastrado.SaveToFile('c:\ItensNaoImportados.txt');
   lst.Free();
end;

procedure removeEansInvalidos(inicio, fim:String);
var
   ds:TdataSet;
   cmd:String;
begin
   cmd := ' select crefe.is_ref, crefe.cd_ref, crefe.ds_ref, dscbr.cd_pesq' +
          ' from crefe'+
          ' left join dscbr on crefe.is_ref= dscbr.is_ref and tp_cdpesq= ''1'''+
          ' where crefe.is_ref between + '+inicio+ ' and ' + fim +
          ' order by crefe.is_ref ';

   ds:= dm.getDataSetQ(cmd);

   ds.First();

   while( ds.Eof = false ) do
   begin
      fmMain.msgStatusProgresso(ds.recNo, ds.recordCount, 'Cod cadastrados');
      gravaLog('Verificando item:' + ds.FieldByName('is_ref').asString);

      if (ds.FieldByName('cd_pesq').asString = '') then
      begin
         gravaLog('Item sem Nenhum EAN, is_ref: ' +ds.fieldByName('is_ref').asString + ' codigo: '+ ds.fieldByName('cd_ref').asString);
         uEstoque.insereEAN(ds.fieldByName('is_ref').asString, ds.fieldByName('cd_ref').asString);
      end
      else
      begin
         if (f.isEAN13( ds.fieldByName('cd_pesq').asString) = false) then
         begin
            f.gravaLinhaEmUmArquivo(
               f.getDirLogs()+'Eans.txt',
               'cd_pes: ' + ds.fieldByName('cd_pesq').asString + ' is_ref: '+ds.fieldByName('is_ref').asString
             );

            uEstoque.removeEAN(ds.fieldByName('cd_pesq').asString, ds.fieldByName('is_ref').asString);
//            uEstoque.insereEAN(ds.fieldByName('is_ref').asString, ds.fieldByName('cd_ref').asString);

         end;
         gravaLog('Item OK! ' + ds.fieldByName('is_ref').asString + ' codigo: '+ ds.fieldByName('cd_ref').asString);
      end;
      ds.Next();
   end;
   ds.free();
   msg.msgExclamation('Terminado.');
   fmMain.msgStatus('');
end;

procedure setImagem(image:Timage; is_ref:String);
var
  ds:TdataSet;
begin
   ds:= uProd.getImagemProduto(is_ref, true);
     Image.Picture.Assign(ds.FieldByName('imagem'));
     image.Picture.SaveToFile('logo.bmp');


   ds.free();
end;

function isPrdComPicking(is_ref:String):boolean;
begin
   result := not(dm.getDatasetq( dm.getCMD1('wms', 'getPikingPrd', is_ref)).IsEmpty);
end;

function getDetalhesCRUC(is_ref:String):TdataSet;
begin
  result := dm.getDataSetQ( dm.getCMD1('Estoque', 'getDetCRUC', is_ref) );
end;

procedure insItemTbAcerto(tpAcerto:String; qtAct:real; dsIt:TdataSet; tb:TADOTable);
var
  saldo:real;
  entSai:String;
begin
   tpAcerto := uppercase(tpAcerto);
   if (tpAcerto = 'E') then
   begin
      entSai := 'E';
      saldo := dsIt.fieldByName('estoque').AsFloat + qtAct;
   end
   else
   if (tpAcerto = 'S') then
   begin
      entSai := 'S';
      saldo := dsIt.fieldByName('estoque').AsFloat - qtAct;
   end
   else
   begin
      // se o acerto for do tipo 'A', que é:
      // acerte para a quantidade tal...

      if (dsIt.fieldByName('estoque').AsFloat > qtAct) then
         entSai := 'S'
      else
         entSai := 'E';

         saldo := qtAct;

         qtAct :=  abs(dsIt.fieldByName('estoque').AsFloat - qtAct);
   end;

   if (dsIt.IsEmpty = false)then
   begin
      tb.AppendRecord([
         dsIt.fieldByName('is_ref').AsString,
         dsIt.fieldByName('codigo').AsString,
         dsIt.fieldByName('descricao').AsString,
         dsIt.fieldByName('estoque').AsString,
         qtAct,
         saldo,
         entSai
      ]);
   end;
end;

procedure listaItensDirvgWellWms(tb:TADOTable; codigo:String; isNegativos:boolean);
var
   quant, cmd:String;
begin
   tb.TableName:= dm.getNomeTableTemp();

   if (codigo <> '' )then
      codigo := dm.getCMD1('Estoque', 'getTbdirvgWellWMS', codigo )
   else
     codigo := '';

   if (isNegativos = true )then
      quant := '<'
   else
      quant := '>';

   cmd := dm.getCMD3('Estoque', 'getTbdirvgWellWMS', tb.TableName, codigo, quant );

   dm.execSQL(cmd);

   tb.Open();
end;

function getRRANAItem(is_ref, uo, cd_trans, uoDestino:String;  dti, dtf:Tdate ):TdataSet;
var
   cmd:String;
begin
   f.gravaLog('getRRANAItem()');

   if (cd_trans <> '') then
      cd_trans := dm.getCMD1('Estoque', 'rranaIt.codTrans', cd_trans)
   else
      cd_trans := '/* cdTRans */';

   if (uoDestino <> '') then
      uoDestino :=  dm.getCMD1('Estoque', 'rranaIt.uoDest', uoDestino)
   else
      uoDestino := '/* uoDest */';

   cmd := dm.getCMD6(
             'Estoque',
             'rranaIt',
             uo,
             is_ref,
             fdt.dateTimeToSqlDateTime(dti, '00:00:00'),
             fdt.dateTimeToSqlDateTime(dtf, '23:59:00'),
             cd_trans,
             uoDestino
           );

    result := dm.getDataSetQ(cmd);
end;

procedure calculaRRANA(tbItens, tbMov:TADOTable; is_refs:TStringlist; uo:String; dti, dtf:Tdate);
var
   i:integer;
   cmd:String;
   dsItem, dsMov:TdataSet;
begin
   f.gravaLog('calculaRRANA()');

   for i:= 0 to is_refs.count -1 do
   begin

      dsMov:= getRRANAItem(is_refs[i], uo, '', '', dti, dtf, );

      if (dsMov.isEmpty = false) then
      begin
         dsMov.first();

	     // pegar o saldo atual do item
         cmd :=
         dm.getCMD3('estoque','getSaldoAntSeq',
            uo,
            is_refs[i],
            dsMov.fieldByName('sq_dlest').asString
         );
         cmd := dm.openSQL(cmd, 'qt_sldatu');

         if (cmd='') then
            cmd := '0'
         else
            cmd:= floatToStrf(strToFloat(cmd), ffNumber, 18, 0);


         while (dsMov.eof = false) do
         begin
           tbMov.appendRecord([
                          dsMov.fieldByName('dt_mov').asString,
                          dsMov.fieldByName('ds_res').asString,
                          dsMov.fieldByName('nm_usu').asString,
                          floatToStrf( dsMov.fieldByName('qt_mov').asFloat, ffNumber, 18, 0),
                          floatToStrf( dsMov.fieldByName('qt_sldatu').asFloat, ffNumber, 18, 0),
                          dsMov.fieldByName('tipoMovEstoque').asString,
                          dsMov.fieldByName('is_filDest').asString,
                          dsMov.fieldByName('ds_uo').asString,
                          trim(dsMov.fieldByName('sr_docf').asString),
                          dsMov.fieldByName('nr_docf').asString
                              ]);
           dsMov.Next();
         end;
         dsMov.free();
      end;

      dsItem := uProd.getDadosProd(uo, '', is_refs[i], '101', false);

      tbItens.appendRecord([
                             dsItem.fieldByName('is_ref').asString,
                             dsItem.fieldByName('codigo').asString,
                             dsItem.fieldByName('descricao').asString,
                             cmd
                          ]);
        dsItem.free();
   end;
end;

function getItPorOperacao(uo, cdTrans, nivelcat, codCat:String; di, df:Tdate; isAgrupado:boolean; cd_ref:String):TdataSet;
var
   c:String;
begin
   f.gravaLog('uEstoque.ItPorOperacao() ');

   if (cdTrans = 'Vendas') then
   begin
      if (uo <> '') and (uo <> '999') then
        uo := dm.getCMD1('Vendas', 'qtItVend.uo', uo )
      else
        uo := dm.getCMD('Vendas', 'qtItVend.uoTodas');

        if nivelcat <> '0' then
           codCat := dm.getQtCMD2('geraEst', 'getItPed.cat', nivelcat,  codCat )
        else
           codCat := '';

        c := dm.getCMD4('Vendas', 'qtItVend', codCat, uo, fdt.dateToSqlDate(di), fdt.dateToSqlDate(df));
   end
   else
   begin
      {
         retorna todos os itens de uma determinada operacao,
         por loja, por dia
      }
     if (isAgrupado = true) then
     begin
        c :=
        dm.getCMD4('estoque', 'getItPorTpOper_agrupado',
           cdTrans,
           uo,
           fdt.dateTimeToSqlDateTime(di, '00:00:00'),
           fdt.dateTimeToSqlDateTime(df, '23:59:00')
        );
      end
      else
      begin
      	if (cd_ref<> '' )then
         	cd_ref := dm.getCMD1('estoque', 'getItPorTpOper.cod', cd_ref);

         c :=
         dm.getCMD5('estoque', 'getItPorTpOper',
            cdTrans,
            uo,
            fdt.dateTimeToSqlDateTime(di, '00:00:00'),
            fdt.dateTimeToSqlDateTime(df, '23:59:00'),
            cd_ref
         );
      end;
   end;
//   f.gravaLog(c);
   result := dm.getDataSetQ(c);
end;

procedure listaItTransf(tb:TADOTable; uo:String; di, df:Tdate);
var
   ds:Tdataset;
begin
   if (tb.tableName <> '') then
      tb.close();

   tb.Open();

   ds := getItPorOperacao(uo, '2', '', '', di, df, true, '');

   ds.First();
   while (ds.Eof = false) do
   begin
      fmMain.msgStatusProgresso(ds.RecNo, ds.RecordCount, 'Verificando itens: ');
      tb.Append();
      tb.FieldByName('cd_ref').Assign(ds.FieldByName('cd_ref'));
      tb.FieldByName('ds_ref').Assign(ds.FieldByName('ds_ref'));
      tb.FieldByName('QtTransferida').Assign(ds.FieldByName('qt_mov'));
      tb.Post();
      ds.Next();
   end;
   ds.Free();
end;

procedure removerItensMovOk(tb:TADOTable);
begin
   {
    remover os itens que estao com a movimentacao ok no well e no wms
    relatorio de divergencias de movimento do  well e wms
   }
   tb.First();
   while (tb.Eof = false) do
   begin
      if (tb.FieldByName('qtOprWms').AsInteger = tb.FieldByName('qt_mov').AsInteger) then
        tb.Delete
      else
        tb.Next();
   end;
end;

procedure reMoveItensComAutorizador(tb:TADOTable);
begin
   {
    remover os itens que estao com a movimentacao ok no well e no wms
    relatorio de divergencias de movimento do  well e wms
   }
   tb.First();
   while (tb.Eof = false) do
   begin
      if (tb.FieldByName('autOs').AsString <> STR_NAO_CONSTA ) then
        tb.Delete
      else
        tb.Next();
   end;
end;

procedure listaItTransfComWMS(tb:TADOTable; uo:String; di, df:Tdate; isDivergentes, remDirvgAutoriz:boolean; cd_ref:String);
var
   dsAut, dsItens, dsReq:Tdataset;
   os:String;
begin
   // lista as saidas por conferencia


   f.gravaLog(#13+'uEstoque.listaItTransfComWMS()' + #13);
   f.gravaLog('');

   if (tb.tableName <> '') then
      tb.close();

   dm.getTable(tb, dm.getCMD('estoque', 'getTbdirvgWellWMS'));
   tb.close();

   dsItens := uEstoque.getItPorOperacao(uo, '2, 6, 11', '', '', di, df, false, cd_ref);

   tb.Open();

   tb.Sort := 'OS';

   dsItens.First();
   while (dsItens.Eof = false) do
   begin
      fmMain.msgStatusProgresso(dsItens.RecNo, dsItens.RecordCount, 'Consultando WMS...');

// pegar o numero da OS
		if	((dsItens.fieldByName('codTransacao').AsString = '11') or
			(dsItens.fieldByName('codTransacao').AsString = '6') ) then
		begin
      	os :=
      	dm.getCMD4('wms', 'getOsDevForn',
         	quotedStr(dsItens.fieldByName('cd_ref').AsString),
         	dsItens.fieldByName('cd_pes').AsString,
				fdt.dateTimeToSqlDateTime(di, '00:00:00'),
				fdt.dateTimeToSqlDateTime(df, '23:59:00'),
         );

         os := dm.openSQL(os, '');
      end
      else if (dsItens.fieldByName('codTransacao').AsString = '2') and (dsItens.fieldByName('os').AsString = '0') then
			os := dsItens.fieldByName('nr_docf').AsString
      else
      	os := dsItens.fieldByName('os').AsString;

      dsReq :=
      uEstoque.getDadosConfWms(
      	os,
         dsItens.fieldByName('is_ref').AsString +  ' /*'+ dsItens.fieldByName('cd_ref').AsString + '*/'
      );



      tb.Append();
      tb.FieldByName('ds_trans').Assign( dsItens.FieldByName('ds_trans'));
      tb.FieldByName('is_ref').Assign( dsItens.FieldByName('is_ref'));
      tb.FieldByName('is_uo').Assign( dsItens.FieldByName('is_uo'));
      tb.FieldByName('ds_uo').AsString := dsItens.FieldByName('uoDestino').AsString + '  Nf:'+ dsItens.FieldByName('sr_docf').AsString + '/'+ dsItens.FieldByName('nr_docf').AsString;
      tb.FieldByName('qt_mov').Assign( dsItens.FieldByName('qt_mov'));
      tb.FieldByName('cd_ref').Assign( dsItens.FieldByName('cd_ref'));
      tb.FieldByName('ds_ref').Assign( dsItens.FieldByName('ds_ref'));
      tb.FieldByName('os').AsString := os;

      if (dsReq.IsEmpty = false) then
         tb.FieldByName('qtOprWms').Assign(dsReq.FieldByName('qtOprWms'));

      if (dsReq.FieldByName('qtOprWms').AsInteger <> tb.FieldByName('qt_mov').AsInteger) then
      begin
         dsAut := getAutorizadorWMS('Os', os );

         if (dsAut.IsEmpty = false) then
            tb.FieldByName('autOs').Assign(dsAut.FieldByName('nm_usu'))
         else
            tb.FieldByName('autOs').AsString := STR_NAO_CONSTA;

         dsAut.Free();
      end;

      tb.Post();
      dsReq.Free();
      dsItens.Next();
   end;

   if (isDivergentes = true)then
      uEstoque.removerItensMovOk(tb);

   if (remDirvgAutoriz = true) then
		reMoveItensComAutorizador(tb);

   dsItens.Free();
   fmMain.msgStatus('');
end;

function getDadosIntenWms(nota, isRef:String; di, df:Tdate):TdataSet;
var
   cmd:String;
begin;
   cmd :=
   dm.getCMD4('wms', 'getDadosInter',
      nota,
      isRef,
      fdt.dateTimeToSqlDateTime(di-5, '00:00:00'),
      fdt.dateTimeToSqlDateTime(df+5, '23:59:00')
    );
   result := dm.getDataSetQ(cmd);
end;

function getDadosConfWms(os, isRef:String):TdataSet;
var
   cmd:String;
begin;
   cmd :=
   dm.getCMD2('wms', 'getDadosConf',
      os,
      isRef,
    );
   result := dm.getDataSetQ(cmd);
end;

procedure listaItRecComWMS(tb:TADOTable; uo:String; di, df:Tdate; isDivergentes, remDirvgAutoriz:boolean; cd_ref:String);
var
   dsItens, dsInter, dsAut:Tdataset;
begin
   // pegar os dados de internação do wms

   f.gravaLog('listaItRecComWMS()');

   if (tb.tableName <> '') then
      tb.close();

   dm.getTable(tb, dm.getCMD('estoque', 'getTbdirvgWellWMS'));
   tb.close();

   dsItens := getItPorOperacao(uo, '3, 1', '', '', di, df, false, cd_ref);

   tb.Open();

   tb.Sort := 'ds_uo';
   tb.Refresh();

   dsItens.First();
   while (dsItens.Eof = false) do
   begin
      fmMain.msgStatusProgresso(dsItens.RecNo, dsItens.RecordCount, 'Consultando WMS...');

      tb.Append();
      tb.FieldByName('ds_trans').Assign(dsItens.FieldByName('ds_trans'));
      tb.FieldByName('is_ref').Assign( dsItens.FieldByName('is_ref'));
      tb.FieldByName('is_uo').Assign( dsItens.FieldByName('is_uo'));
      tb.FieldByName('ds_uo').AsString := trim(dsItens.FieldByName('sr_docf').AsString) +' - '+ dsItens.FieldByName('nr_docf').AsString;
      tb.FieldByName('qt_mov').Assign( dsItens.FieldByName('qt_mov'));
      tb.FieldByName('cd_ref').Assign( dsItens.FieldByName('cd_ref'));
      tb.FieldByName('ds_ref').Assign( dsItens.FieldByName('ds_ref'));

// pesquisar a quantidade internada
      dsInter :=
      uEstoque.getDadosIntenWms(
      	dsItens.FieldByName('isn_nota_cega').AsString,
      	dsItens.FieldByName('is_ref').AsString +  '/* ' + dsItens.FieldByName('cd_ref').AsString + ' */',
         di-1,
         df+1
      );


      tb.FieldByName('qtOprWms').AsInteger := dsInter.FieldByName('qtOprWms').AsInteger {* dsInter.FieldByName('PROQT_UNIDADE_ARMAZENAMENTO').AsInteger};


      if ( tb.FieldByName('qt_mov').AsInteger <> dsInter.FieldByName('qtOprWms').AsInteger) then
      begin
         dsAut := getAutorizadorWMS('Ent',  dsItens.FieldByName('nr_docf').AsString);

         if dsAut.IsEmpty = false then
   			tb.FieldByName('autOs').AsString := dsAut.fieldByname('nm_usu').AsString
         else
   			tb.FieldByName('autOs').AsString := STR_NAO_CONSTA;

         dsAut.free();
      end;

      tb.Post();
      dsItens.Next();

      dsInter.Free();
   end;
   dsItens.Free();

   if (isDivergentes = true)then
      uEstoque.removerItensMovOk(tb);

   if ( remDirvgAutoriz = true) then
		reMoveItensComAutorizador(tb);

   fmMain.msgStatus('');
end;

procedure listarItensPorTipoOperacao(tb:TadoTable; tpOperacao, uo, nvCat, vlCat:String; di, df:Tdate);
var
   cmd:String;
   dsI:TdataSet;
begin
   cmd:=  dm.getCMD('estoque', 'getTbItTpMov');

   dm.getTable(tb, cmd);

   if (uo = '999') then
     uo := '';

   dsI := getItPorOperacao(uo, tpOperacao, nvCat, vlCat, di, df, false, '');

   dsI.First();
   while (dsI.Eof = false) do
   begin
      tb.Append();
      tb.FieldByName('cd_ref').Assign(dsI.FieldByName('cd_ref'));
      tb.FieldByName('ds_ref').Assign(dsI.FieldByName('ds_ref'));
      tb.FieldByName('qt_mov').Assign(dsI.FieldByName('qt_mov'));
      tb.FieldByName('ds_trans').Assign(dsI.FieldByName('ds_trans'));
      tb.FieldByName('nm_usu').Assign(dsI.FieldByName('nm_usu'));


      tb.post();
      dsI.Next();
   end;

   tb.sort := 'qt_mov DESC';

   dsI.Free();
end;

procedure listarVendaBrutaFor(tb:TadoTable; di, df:Tdate; uo, nivelCat, codCat, cd_pes:String);
var
   tbAux, cmd:String;
begin
   f.gravaLog(#13+ 'VelistarVendaBrutaFor()' + #13);


   if (tb.TableName <> '') then
     tb.Close();

   tbAux := dm.getNomeTableTemp();

   if cd_pes <> '' then
      cd_pes := dm.getCMD1('Vendas', 'lstVdBrutaForn.cd_pes', cd_pes)
   else
      cd_pes := '/* cd_pes */';

   if (uo <> '999') then
      uo := dm.getCMD1('Vendas', 'lstVdBrutaForn.uo', uo)
   else
      uo := '/* uo */';

   if (nivelCat <> '0') then
      nivelCat := dm.getCMD2('Vendas', 'lstVdBrutaForn.cat', nivelCat, codCat)
   else
      nivelCat := '/* cat */';

   cmd :=
   dm.getCMD6('vendas', 'lstVdBrutaForn',
   	tbAux, nivelCat, fdt.dateToSqlDate(di), fdt.dateToSqlDate(df), uo,
      cd_pes
   );

   f.gravaLog(cmd);

   dm.execSQL(cmd);

   tb.TableName := dm.getNomeTableTemp();


   cmd :=
   dm.getCMD2('Vendas','lstVdBrutaForn.consolida',
     tb.TableName,
     tbAux
   );

   dm.execSQL(cmd);
   tb.Open();
end;

function getUltIsLanc(is_ref, uo:String):String;
var
	cmd:String;
begin
	if (uo <> '') and (uo <> '999') then
   	uo := dm.getCMD1('estoque', 'getUltimoIsLanc.uo', uo );

	cmd := dm.getCMD2('estoque', 'getUltimoIsLanc', is_ref, uo );

	cmd := dm.openSQL(cmd, '');

   if cmd = '' then
   	cmd := '-1';

   result := cmd;
end;

function getIsLancFromIsMovi(is_movi:String):String;
var
	cmd:String;
begin
	cmd := dm.getCMD1('estoque', 'getIsLancFromIsMovi', is_movi);
   result := dm.openSQL(cmd, '');
end;

function getProxNumCat(cd_campoPai, cd_vCampoPai:String):String;
var
   ds:Tdataset;
   i:integer;
   res:String;
begin
   ds:= dm.getDataSetQ(dm.getQtCMD2('cat', 'getFilhos', cd_campoPai, cd_vCampoPai));
   ds.Last();

   f.gravaLog('numero de registros '+ intToStr(ds.RecordCount));


   if (cd_campoPai = '0') then
   begin
      if (ds.IsEmpty = true) then
      begin
         res := '010000'
      end
      else
      begin
         res := ds.fieldByName('cd_vcampo').AsString;
         i :=  strToInt( copy(res, 01, 02));
         inc(i);
         res := f.preencheCampo(2, '0', 'E', intToStr(i)) + '0000';
      end
   end
   else if (cd_campoPai = '1') then
   begin
      if (ds.IsEmpty = true) then
      begin
         res := copy(cd_vCampoPai, 01, 02) + '01'
      end
      else
      begin
         res := ds.fieldByName('cd_vcampo').AsString;
         i :=  strToInt( copy(res, 03, 02));
         inc(i);
         res := copy(cd_vCampoPai, 01, 02) + f.preencheCampo(2, '0', 'E', intToStr(i)) + '00';
      end
   end
   else
   begin
      if (ds.IsEmpty = true) then
      begin
         res := copy(cd_vCampoPai, 01, 04) + '01'
      end
      else
      begin
         res := ds.fieldByName('cd_vcampo').AsString;
         i :=  strToInt( copy(res, 05, 02));
         inc(i);
         res := copy(cd_vCampoPai, 01, 04) + f.preencheCampo(2, '0', 'E', intToStr(i));
      end
   end;
   ds.Free();
   result := res;
end;


function cadastraCategoria(cd_campoPai, cd_vCampoPai, ds_vCampo:String):boolean;
var
   cmd:String;
   dsCatPai:Tdataset;
   cd_campo, cd_vcampo:String;
begin
   cd_campo := intToStr(strToInt(cd_campoPai) +1 );

   if (Length(ds_Vcampo) > 3) then
   begin

      dsCatPai := nil;

      cd_vcampo := getProxNumCat(cd_campoPai, cd_vCampoPai );

      if msg.msgQuestion(  dm.getCMD2('msg', 'confIncCat', uppercase(ds_Vcampo), '' )) = mrYes then
      begin
         cmd := dm.getQtCMD5('cat', 'insertCat', cd_campo, cd_Vcampo, uppercase(ds_Vcampo), cd_campoPai, cd_vCampoPai);
         dm.execSQL(cmd);
         msg.msgExclamation('Cadastrado');
      end;
   end
   else
      msg.msgErro( dm.getMsg('errCadCategoria'));
end;

procedure removeItemCategoria(cd_campo, cd_vCampo:String);
var
   cmd:String;
begin
   if ( msg.msgQuestion(dm.getMsg('remCat')) = mrYes) then
   begin
      cmd := dm.getQtCMD2('cat', 'remove', cd_campo, cd_vCampo);
      dm.execSQL(cmd);
   end;
end;

procedure zeraPendenciaEstoque(uo, is_ref:String);
var
  cmd:String;
  dsContas, dsLanc:TDataSet;
begin
   dsContas := dm.getDataSetQ(dm.getCMD('estoque', 'zeraEstGetCta'));
   while dsContas.Eof = false do
   begin
      // pegar o is_lanc da conta q nn esta zerada
      cmd :=  dm.getCMD4('estoque', 'zeraEstGetIslanc', uo, is_ref, dsContas.fieldByName('is_tpcte').AsString, '' );
      dsLanc := dm.getDataSetQ(cmd);

      if (dsLanc.IsEmpty = false) then
      begin
        dsLanc.First();
        while (dsLanc.Eof = false) do
        begin
           dm.execSQL(  dm.getcmd1('estoque', 'zeraEstIsLanc', dsLanc.fieldByName('is_lanc').AsString) );
           dsLanc.Next
        end;
      end;
     dsContas.Next();
   end;

   dsLanc.Free();
   dsContas.Free();
end;

procedure chamaZeraContaEstoque();
var
  desc, cd_Ref:String;
  dsIt:TdataSet;
begin
   cd_ref := msg.msgInput('Qual o código do produto que você quer' +#13+ 'Zerar?', cd_ref  ) ;
   dsIt :=  uProd.getDadosProd(fmMain.getUoLogada(), cd_Ref, '','101', true);

   if (dsIt.IsEmpty = false) then
      if (msg.msgQuestion('zera as pendencias de estoque ? do item '+#13+ dsIt.fieldByName('codigo').AsString + ' '+ dsIt.fieldByName('descricao').AsString) = mrYes) then
        uEstoque.zeraPendenciaEstoque(fmMain.getUoLogada(), dsIt.fieldByName('is_ref').AsString);

    dsIt.Free();
end;

procedure zerarEstoque(uo:String);
var
   dsItens, dsContas, dsLanc:Tdataset;
   cmd :String;
begin
{// zerar as contas que não são de estoque da loja
   fmMain.msgStatus('Obtendo os produtos...');
   dsContas := dm.getDataSetQ(dm.getCMD('estoque', 'zeraEstGetCta'));

   dsItens := dm.getDataSetQ(dm.getCMD1('estoque', 'zeraEstGetItens', uo));



   dsContas.First();
   while dsContas.Eof = false do
   begin
      fmMain.msgStatus('Zerando as pendências de estoque, conta:' + dsContas.fieldByName('is_tpcte').AsString);
      dsItens.First();
      while dsItens.Eof = false do
      begin
         cmd :=  dm.getCMD4('estoque', 'zeraEstGetIslanc', uo, dsItens.fieldByName('is_ref').AsString, dsContas.fieldByName('is_tpcte').AsString, dsItens.fieldByName('cd_ref').AsString );
         dsLanc := dm.getDataSetQ(cmd);

         if (dsLanc.IsEmpty = false) then
          dsLanc.First();

         dsItens.Next();
         dsLanc.Free();
      end;
      dsContas.Next();
   end;

   dsContas.Free();

   // fazer o acerto do estoque fisico
   fmMain.msgStatus('Zerando estoque físico...');


   Application.CreateForm(TfmAcertoEstoque, fmAcertoEstoque);
   fmAcertoEstoque.FormStyle := fsNormal;
   fmAcertoEstoque.Hide();

   f.setUoNacomboBox(fmAcertoEstoque.cbLoja, uo);
   fmAcertoEstoque.rgTpAcerto.ItemIndex := 2; // acertar para a quantidade

   dsItens.First();
   while ( dsItens.Eof = false) do
   begin
      fmAcertoEstoque.edCodigo.Text := dsItens.fieldByName('cd_ref').AsString;
      fmAcertoEstoque.btConsultaProdutoClick(nil);
      fmAcertoEstoque.edPcNovo.Text := '0';
      fmAcertoEstoque.AdicionaItemnaGridAcerto();
      fmAcertoEstoque.iniciaProcessoDeAcerto(false);
      dsItens.Next();
   end;
//   fmAcertoEstoque.fsBitBtn1Click(nil);
//   fmAcertoEstoque.btAjustaPrecoClick(nil);

   fmAcertoEstoque.Close();
   fmAcertoEstoque := nil;

   dsItens.Free();
}
end;

end.
