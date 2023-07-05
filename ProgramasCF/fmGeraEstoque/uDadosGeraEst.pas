unit uDadosGeraEst;

interface
	uses qforms, windows, classes, controls, dB, aDODb, sysUtils, math, adLabelComboBox;

	function getDataVendaInicial(tbGe:TADOTAble; dtPadrao:Tdate):Tdate;
	function lojaAProcessar(isCalcEmpr:boolean; cbLoja:TadLabelComboBox):String;
	function selectItens(tpBusca:smallint; cod, nvCat, vlCat:String; soAtivos:boolean; lstForn:Tstrings ):TdataSet;
	function verificaParametros(tpCalculo, tpPreco, tpUo:smallint; codigo:String; forn:TStrings):String;

	procedure calcularVenda(tbGe:TADOTable; uo:String; isEntSaiTot:boolean; diasIniDefault:integer);
   procedure calculaVendasMedias(tbGe:TADOTable; uo:String);
	procedure getDadosEntrada(tbGe:TADOTable; uo:String; isEntSaiTot:boolean);
	procedure getDadosUltSaida(tbGe:TADOTable; uo:String);
	procedure getItensGeraEstoque(dsItens:TdataSet; table:TADOTable; uo, preco:String; diponivel:boolean);
   procedure listaEntradas(tb:TADOTable);
	procedure listaFormRequisicao(tbGe:TADOTable; uo:String; dtIniPadrao:Tdate);
	procedure listaFormVendas(tbGe:TADOTable; uo:String; dtIniPadrao:Tdate);
	procedure listaVendas(tb:TADOTable; cbLoja:TadLabelComboBox; qtMesesPadrao:real);
	procedure preencheCategorias(tb:TADOtable);
	procedure preencheQtTransferida(tb:TADOtable; uo:String);
   procedure preencheDadosUltimoMov(tb:TADOtable; uo:String);



implementation

uses uEstoque, f, fdt, uMain, uProd, uDm, uCategoria;


function verificaParametros(tpCalculo, tpPreco, tpUo:smallint; codigo:String; forn:TStrings):String;
var
  erro:String;
begin
   if (tpCalculo = 0)  and  (length(codigo) < 3) then
      erro := 'Informe ao menos o código com 3 caracteres' + #13;

   if (tpCalculo = 1)  and  (length(codigo) < 1) then
      erro := 'Informe o numero do pedido.' + #13;

   if (tpCalculo = 2)  and  (forn.Count < 1) then
      erro := 'Escolha ao menos um fornecedor' + #13;

   if (tpPreco < 0) then
      erro := erro +  'Escolha um tipo de preço para exibir' + #13;

   if (tpUo < 0) then
      erro := erro +  'Escolha uma loja para gerar o relatório' + #13;

   if (tpCalculo < 0 )then
      erro := erro +  'Escolha um tipo  de relatório' + #13;

   result := erro;
end;


function lojaAProcessar(isCalcEmpr:boolean; cbLoja:TadLabelComboBox):String;
begin
   if (isCalcEmpr = true) then
      result := '999'
   else
      result := f.getCodUO(cbLoja);
end;

procedure calculaVendasMedias(tbGe:TADOTable; uo:String);
var
	dsPrimEnt:TdataSet;
   di, dataPEnt:Tdate;
   med, valor:real;
begin
   tbGE.First();
   while (tbGE.Eof = false) do
   begin
      fmMain.msgStatusProgresso(tbGe.RecNo,  tbGE.RecordCount, 'Calculando venda média...');

      tbGE.Edit();

		dsPrimEnt := uProd.getDadosPrimEnt( tbGE.fieldByName('is_ref').AsString);
	   dataPEnt := dsPrimEnt.fieldByname('dt_mov').asDateTime;
      dsPrimEnt.free();

      f.gravaLog('Data primeira entrada:' + tbGE.fieldByName('codigo').AsString +' - '+ DateToStr(dataPEnt));


      if (dataPEnt <= (now -365)) then
      	di := (now -365)
      else
      	di := dataPEnt;

      valor :=
      getVendaProduto(
         tbge.fieldByName('is_ref').AsString,
         uo,
         (now -365),
         now
      );
      med :=(valor/365);
      if med < 0 then med := 0.00;
      tbGe.fieldByName('vdMed12').AsString := floatToMoney(med);



// 6 meses
      if (dataPEnt <= (now -180)) then
      	di := (now -180)
      else
      	di := dataPEnt;

      valor :=
      getVendaProduto(
         tbge.fieldByName('is_ref').AsString,
         uo,
         (now -365),
         now
      );
      med :=(valor/180);
      if med < 0 then med := 0.00;
      tbGe.fieldByName('vdMed6').AsString := floatToMoney(med);

// 3 meses
      if (dataPEnt <= (now -90)) then
      	di := (now -90)
      else
      	di := dataPEnt;

      valor :=
      getVendaProduto(
         tbge.fieldByName('is_ref').AsString,
         uo,
         (now -90),
         now
      );
      med :=(valor/90);
      if med < 0 then med := 0.00;
      tbGe.fieldByName('vdMed3').AsString := floatToMoney(med);


// 1 meses
      if (dataPEnt <= (now -90)) then
      	di := (now -90)
      else
      	di := dataPEnt;

      valor :=
      getVendaProduto(
         tbge.fieldByName('is_ref').AsString,
         uo,
         (now -90),
         now
      );
      med :=(valor/30);
      if med < 0 then med := 0.00;
      tbGe.fieldByName('vdMed1').AsString := floatToMoney(med);

      tbGE.Post();
      tbGE.Next();
   end;
end;

function selectItens(tpBusca:smallint; cod, nvCat, vlCat:String; soAtivos:boolean; lstForn:Tstrings):TdataSet;
var
	dsItens:TdataSet;
begin
   dsItens := TDataSet.Create(nil);
   case (tpBusca) of
   	0:dsItens:= uProd.getIsrefPorFaixaCodigo(cod, nvCat, vlCat, soAtivos, false);
      1:dsItens:= uProd.listaProdutoPorPedido(uProd.getStrCat(nvCat, vlCat), cod);
      2:dsItens:= uProd.listaProdPorFornecedor(uProd.getStrCat(nvCat, vlCat), f.getLista(lstForn, false), uProd.getStrAtivos(soAtivos));
   end;
   result := dsItens;
end;

procedure getItensGeraEstoque(dsItens:TdataSet; table:TADOTable; uo, preco:String; diponivel:boolean);
var
  insereItem:boolean;
  ds:TdataSet;
begin
	f.gravaLog('');
	f.gravaLog('getItensGeraEstoque()');
	f.gravaLog('');

	f.gravaLog(dsItens, '-----------Itens para inserir na tabela---------------');

   dsItens.first;
   while (dsItens.Eof = false) do
   begin
      insereItem:= true;
      ds := uprod.getDadosProdBasico(uo, dsItens.fieldByname('is_ref').AsString, preco, '0' );

      if (ds.IsEmpty = false) then
      begin
         fmMain.msgStatus(intToStr(ds.recNo) +' '+ intToStr(table.recordCount) + ' Obtendo Itens...');

         if (diponivel = true ) and (ds.fieldByName('estoque').AsInteger <= 0) then
            insereItem:= false;

         if  (insereItem = true ) then
         begin
            gravaLog('Inserir item ' + ds.fieldByName('codigo').asString +'  '+ ds.fieldByName('descricao').asString);

            table.Append;
            table.FieldByName('codigo').AsString := ds.fieldByName('codigo').asString;
            table.FieldByName('descricao').AsString := ds.fieldByName('descricao').asString;
            table.FieldByName('is_ref').AsString   := ds.fieldByName('is_ref').asString;

            table.FieldByName('Estoque').AsString := ds.fieldByName('estoque').asString;

				if (f.dataSetTemCampo(table, 'PV')) then
					table.FieldByName('PV').AsString := ds.fieldByName('preco').asString;

				if (f.dataSetTemCampo(table,'cd_pes')) then
	            table.FieldByName('cd_pes').AsString   := ds.fieldByName('cd_pes').asString;

				if (f.dataSetTemCampo(table,'dt_imp')) then
               table.FieldByName('dt_imp').AsString := ds.fieldByName('dt_imp').asString;

            if (f.dataSetTemCampo(table,'estoqueDesejavel') and f.dataSetTemCampo(dsItens, 'qt_mov') = true  )then
               table.FieldByName('estoqueDesejavel').AsString := dsItens.fieldByName('qt_mov').asString;

            if (f.dataSetTemCampo(table,'nm_pes') = true) and (f.dataSetTemCampo(ds, 'nm_pes') = true) then
               table.FieldByName('nm_pes').AsString := ds.fieldByName('nm_pes').asString;

            if (f.dataSetTemCampo(table,'cd_rfor') = true) and (f.dataSetTemCampo(ds, 'cd_rfor') = true) then
               table.FieldByName('cd_rfor').AsString := ds.fieldByName('cd_rfor').asString;

            table.Post;
         end
         else
            gravaLog('Sem estoque disponivel: ' + ds.fieldByName('codigo').asString +'  '+ ds.fieldByName('descricao').asString);

         dsItens.Next;
      end
      else
         dsItens.Next;
      ds.free;
   end;
end;

procedure getDadosEntrada(tbGe:TADOTable; uo:String; isEntSaiTot:boolean);
var
   ds:TdataSet;
begin
   if (isEntSaiTot = false) then
   begin
      tbGE.First();
      while (tbGE.Eof = false) do
      begin
         fmMain.msgStatusProgresso(tbGe.RecNo,  tbGE.RecordCount, 'Obtendo dados sobre as entradas...');

         ds:= uProd.getDadosUltEntItem(tbGE.fieldByName('is_ref').AsString, uo);
         if (ds.IsEmpty = false) then
         begin
            tbge.Edit();
            tbge.FieldByName('Data Ultima Ent').AsDateTime := ds.fieldByName('dt_mov').AsDateTime;
            tbge.FieldByName('Quant Ultima Ent').AsString := ds.fieldByName('qt_mov').asString;
            tbGE.post();
         end;
         ds.free;
         tbGE.Next();
      end;
   end
   else
   begin
      tbGE.First();
      while (tbGE.Eof = false) do
      begin
         ds:= uEstoque.getEntradasPorItem( tbGE.fieldByName('is_ref').AsString, uo, strToDate('01/01/2000'), now);

         if (ds.IsEmpty = false) then
         begin
            tbge.Edit();
            tbge.FieldByName('Data Ultima Ent').AsDateTime :=  strToDate( uProd.getDataEntrada(ds,'U'));
            tbge.FieldByName('Quant Ultima Ent').AsString := uEstoque.getTotalDeEntradasProduto(ds, false);
            tbGE.post();
         end;
         ds.free;
         tbGE.Next();
      end;
   end;
end;


//procedure calcularVenda(tbGE:TADOTable);
procedure calcularVenda(tbGe:TADOTable; uo:String; isEntSaiTot:boolean; diasIniDefault:integer);
var
   dataI:Tdate;
begin
   f.gravaLog('TfmGeraEstoque.calcularVenda()');

   tbGE.first();
   while (tbGE.Eof = false) do
   begin
      fmMain.msgStatusProgresso(tbGe.RecNo, tbGe.RecordCount, 'Calculando vendas...');

      if (isEntSaiTot = true) then
         dataI := strToDate('01/01/2005')
      else
      begin
         if ( tbGE.FieldByName('Data Ultima Ent').AsString = '') then
            datai :=  now - (30* diasIniDefault)
         else
            datai := tbGE.FieldByName('Data Ultima Ent').AsDateTime;
      end;

      tbGE.edit();
      tbGE.fieldByName('Total Venda').asString :=
      uProd.getVendaProduto(  tbGe.fieldByName('is_ref').AsString,
                           uo,
                           datai,
                           now,
                           ''
                          );

      tbGE.post();
      tbGE.next();
   end;
end;

procedure getDadosUltSaida(tbGe:TADOTable; uo:String);
var
   ds:TdataSet;
begin
   tbGE.First();
   while (tbGE.Eof = false) do
   begin
      fmMain.msgStatusProgresso(tbGe.RecNo,  tbGE.RecordCount, 'Obtendo dados sobre as saidas...');

      ds:= uProd.getDadosUltSaiProd(uo, tbGE.fieldByName('is_ref').AsString);

      if (ds.IsEmpty = false) then
      begin
         tbge.Edit();
         tbge.FieldByName('dt_ult_vend').AsDateTime := ds.fieldByName('dt_mov').AsDateTime;
         tbge.FieldByName('qt_ult_vend').AsString := ds.fieldByName('qt_mov').asString;
         tbge.FieldByName('qtMaiorVenda').AsString := getMaiorQtVendPrd( tbGE.fieldByName('is_ref').AsString, uo);
         tbGE.post();
      end;
      ds.free;
      tbGE.Next();
   end;
end;

procedure listaFormVendas(tbGe:TADOTable; uo:String; dtIniPadrao:Tdate);
var
	dtInicio:Tdate;
begin
   dtInicio := getDataVendaInicial(tbGE, dtIniPadrao);

   if (tbGE.IsEmpty = false) then
       fmMain.obterDetalhesSaida(
       	tbGE.fieldByName('is_ref').asString,
			uo,
	  		dtInicio
		);
end;

procedure listaFormRequisicao(tbGe:TADOTable; uo:String; dtIniPadrao:Tdate);
var
   dti:tdate;
begin
  if not(tbGE.IsEmpty) then
  begin
     if (tbGE.FieldByName('Data Ultima Ent').asString <> '') then
      dti := tbGE.FieldByName('Data Ultima Ent').AsDateTime
     else
       dti := dtIniPadrao;

     fmMain.abreTelaConsultaRequisicao( tbGE.FieldByName('codigo').asString, uo, dti);
  end;
end;

function getDataVendaInicial(tbGe:TADOTAble; dtPadrao:Tdate):Tdate;
begin
   if (tbGE.fieldByName('Data Ultima Ent').AsString <> '') then
      result := tbGE.fieldByName('Data Ultima Ent').AsDateTime
   else
      result :=  dtPadrao;
end;

procedure preencheDadosUltimoMov(tb:TADOtable; uo:String);
var
   ds:TdataSet;
begin
	f.gravaLog('uDadosGeraEst.preencheDadosUltimoMov()');

   tb.First();
   while (tb.Eof = false) do
   begin
      fmMain.msgStatusProgresso(tb.RecNo,  tb.RecordCount, 'Obtendo dados última movimentação...');

      ds:=  uProd.getDadosUltMov(tb.fieldByName('is_ref').AsString, uo, '2' );

      if (ds.IsEmpty = false) then
      begin
         tb.Edit();

         tb.FieldByName('dtUltSai').AsString := ds.fieldByName('dt_mov').AsString;
         tb.FieldByName('diasSemMov').AsString := ds.fieldByName('qtDias').AsString;

         tb.post();
      end;
      ds.free;
      tb.Next();
   end;
end;

procedure preencheQtTransferida(tb:TADOtable; uo:String);
var
   df, di:Tdate;
	percSaida : real;
begin
	f.gravaLog('uDadosGeraEst.preencheQtTransferida()');

	df := dm.getDateBd();
   tb.First();
   while (tb.Eof = false) do
   begin
      fmMain.msgStatusProgresso(tb.RecNo,  tb.RecordCount, 'Obtendo tranferências...');

      tb.Edit();

      if (tb.FieldByName('Data Ultima ent').AsString <> '') then
         di := tb.FieldByName('Data Ultima ent').AsDateTime
      else
         di := now - 90;

      tb.FieldByName('qtSaiUltEnt').AsString := uProd.getQtTransfPorPeriodo(uo, tb.fieldByname('is_ref').AsString, di, df);

		percSaida :=  (tb.FieldByName('qtSaiUltEnt').AsFloat / tb.FieldByName('Quant Ultima Ent').AsFloat) * 100;


      tb.FieldByName('percSaida').AsString := f.floatToMoney(percSaida);


      tb.post();

      tb.Next();
   end;
end;


procedure preencheCategorias(tb:TADOtable);
var
	qr:TADOQuery;
begin
	f.gravaLog('uDadosGeraEst.categorias()');

   tb.First();
   while (tb.Eof = false) do
   begin
	   qr := TADOQuery.Create(nil);

      fmMain.msgStatusProgresso(tb.RecNo,  tb.RecordCount, 'Obtendo categorias...');

      tb.Edit();

      uCategoria.getCatProduto(qr, tb.fieldByName('is_ref').asString);

      tb.fieldByName('categoria').asString := qr.fieldByName('Descrição').AsString;

	   tb.post();

      qr.Free();

      tb.Next();
   end;
end;


procedure listaEntradas(tb:TADOTable);
begin
   screen.Cursor := crhourglass;
   if (tb.IsEmpty = false) then
      fmMain.obterDetalhesEntrada(tb.fieldByName('is_ref').asString );
   screen.Cursor := crdefault;
end;


procedure listaVendas(tb:TADOTable; cbLoja:TadLabelComboBox; qtMesesPadrao:real);
var
   dtInicio:Tdate;
begin
   screen.Cursor := crHourGlass;

   if (tb.IsEmpty = false) then
   begin
   	if tb.FieldByName('Data Ultima Ent').AsString <> '' then
      	dtInicio := tb.FieldByName('Data Ultima Ent').AsDateTime
      else
      	dtInicio := now - (30 * qtMesesPadrao);


      uDadosGeraEst.listaFormVendas(
   		tb,
			uDadosGeraEst.lojaAProcessar((cbLoja.ItemIndex = 0), cbLoja),
         dtInicio
		);
   end;
   screen.Cursor := crdefault;
end;
{
procedure listaRequisicoes(tb:TADOTAble; uo:String; dtIni:Tdate);
var
   dti:tdate;
begin
  if not(tb.IsEmpty) then
  begin
     if (tb.FieldByName('Data Ultima Ent').asString <> '') then
	     dti := tb.FieldByName('Data Ultima Ent').AsDateTime
     else
			dti := dtIni;

     fmMain.abreTelaConsultaRequisicao( tb.FieldByName('codigo').asString, uo, dti);
  end;

end;
    }

end.
