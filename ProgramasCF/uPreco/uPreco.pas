unit uPreco;

interface
   uses qForms, db, classes, controls, sysutils, ADoDb, adLabelCheckListBox, DBClient;

	function ajustaCustosPorIsLanc(is_lanc, is_ref:string; custoFiscal, cmu:real):boolean;
   function reajustaPc(valor, percentual:real):real;
   function calcCustoEnt(tpEnt, tpCusto:String; dsEntItem, dsNfEnt, dsItNfTransf, dsNfTransf:TdataSet; vlDespExtra:real; tbItTrf:TdataSet):real;
   function existePrecofuturo(pc, is_ref, uo:String; dtAlt:Tdate; verificaPcNovo:boolean):boolean;
   function getCMUPorPeriodo(is_ref:String; di, df:Tdate):String;
   function getListaPrecos(mostraPcoCusto, MostraCampoNhenhum,MostraPrecosCalculados:boolean; grupo:String): Tstrings;
   function getPcProd(uo, cd_ref, is_ref, codPc:String):String;
   function listarPrecosAlteradosPoPeriodo(uo, preco:String; data:Tdate):Tdataset;
   function recalcCMUItem(is_ref:String; di, df:Tdate;  vlItem, vlDespExt, icm, ipi, qt, vlItensNota:real):String;
   function removePreco(isAlp, is_oap:String):boolean;
   function setPrecoCusto(uo, is_ref, descPreco:String; valor:Real; cd_pes, codPreco:String):boolean;
   procedure ajustaCMUItemCompleto(is_ref, cd_pes:String;di, df:Tdate);
   procedure ajustaPcCusto(uo, is_ref, custo:String; dtBase, di, df:Tdate; pcAnt, pcNovo, cd_pes:String);
   procedure getAlteracoesPrecoItem(qr:TADOQuery; is_ref, uo, pc:String; di, df:Tdate);
   procedure lancaNovoPc(tb:TADOTable; lojas:TadLabelCheckListBox; codPc, cd_pes, campoPc:String; dtReajuste, dtRetPcAnt:Tdate; lancaPcAnt, verificaPcNovo:boolean);
   procedure lancaPcProd(uo, cd_pes, tpPreco, isRef, cd_ref: String; valor:real; data:Tdate);
   procedure listaTabelaPrecos(tipoPesquisa, tpEstoque:smallInt; ds_ref, cd_ref, uo, pc01, pc02, numNivel, vlNivel:String; qr:TADOQuery; contaEst:integer);
   procedure gravaLogPcCusto(is_ref, uo,cd_pes, codPreco:String; valor:real);
   procedure ajustaZcf_custos(is_ref, is_lanc:String; dtEnt:Tdate;  fiscal, cmu:real);

	procedure getTbPreco(tb:TADOTable; tipoPesquisa, tpEstoque:smallInt; ds_ref, cd_ref, uo, pc01, pc02, numNivel, vlNivel:String; contaEst:integer);

implementation

 uses uDm, fdt, f, uEstoque, uProd, msg, Math;

function existePrecofuturo(pc, is_ref, uo:String; dtAlt:Tdate; verificaPcNovo:boolean):boolean;
var
   cmd:String;
   dsA:TdataSet;
begin
   if (verificaPcNovo = true) then
   begin
      cmd := dm.getCMD4('Preco', 'pcLancAposDt', is_ref, pc, uo, fdt.dateToSqlDate(dtAlt));
      dsA := dm.getDataSetQ(cmd);

      if (dsA.IsEmpty = false) then
      begin
         cmd := dm.getCMD5('msg', 'msgPcFuturo',
                   dsA.fieldByName('cd_ref').asString +'-'+ dsA.fieldByName('ds_ref').asString,
                   dsA.fieldByName('ds_uo').asString,
                   pc,
                   dateToStr(dtAlt),
                   dsA.fieldByName('vl_preco').asString,
                );

         if (msg.msgQuestion(cmd)= mrYes )then
           result := false
         else
           result := true;
      end
      else
         result := false;

      dsA.Free()
   end   
   else
      result := false;
end;


function getPcProd(uo, cd_ref, is_ref, codPc:String):String;
var
   ds:TdataSet;
   aux:String;
begin
   // retorna o preco no formato normal.
   f.gravaLog('getPcProd() uo:' + uo + ', cd_ref: ' +cd_ref + ', is_ref:' + is_ref);

   aux := '0';

   if ( is_ref <> '') then
      ds := uProd.getDadosProd(uo, '', is_ref, codPc, true)
   else
      ds := uProd.getDadosProd(uo, cd_ref, '', codPc, true);

   if (ds.isEmpty = false) then
      aux := ds.fieldbyName('preco').asString
   else
      aux := '0.00';
      
   ds.free();

   result := aux;
end; 

function setPrecoCusto(uo, is_ref, descPreco:String; valor:Real; cd_pes, codPreco:String):boolean;
var
   is_lanc, cmd, chaveCMD:String;
begin
	is_lanc := getUltIsLanc(is_ref, uo);

   if ( descPreco =  'CustoMedioUnitarioUnico') then
      chaveCMD :=  'updatePcCMU'
   else
      chaveCMD :=  'updatePcCusto';

   cmd := dm.getCMD5('Preco', chaveCMD, is_ref, uo, descPreco, f.valorSql(valor), is_lanc);
   gravaLogPcCusto(is_ref, uo,cd_pes,codPreco, valor);
   result := dm.execSQL(cmd);
end;

procedure lancaPcProd(uo, cd_pes, tpPreco, isRef, cd_ref: String; valor:real; data:Tdate);
var
   is_alp, is_oap:String;
   cmd:String;
begin
   is_alp := dm.getContadorWell('IS_ALP');
   is_oap := dm.getContadorWell('IS_oap');

   cmd := dm.getCMD3('Preco', 'insertDsalp', isRef, is_alp, tpPreco);
   dm.setParams(cmd, fdt.dateToSqlDate(data), is_oap, uo);
   dm.setParam(cmd, f.valorSql(valor));
   dm.execSQL(cmd);

   cmd := dm.getCMD3('Preco', 'insertDsoap', is_oap, tpPreco, cd_pes);
   dm.setParams(cmd, fdt.dateToSqlDate(data), uo, quotedStr(cd_ref) );
   dm.setParams(cmd, quotedStr(cd_ref), f.valorSql(valor), '');
   dm.execSQL(cmd);
end;


function getListaPrecos(mostraPcoCusto,MostraCampoNhenhum, MostraPrecosCalculados:boolean; grupo:String): Tstrings;
var
   ds:TdataSet;
   aux:tStrings;
   str:String;
begin
   str := dm.getCMD1('Preco', 'listarPco', grupo );
   if (MostraPrecosCalculados = true) then
      str := str + dm.getCMD('Preco', 'listarPco.tbBase');

   ds:= dm.getDataSetQ(str);

   aux := TstringList.create();
   ds.First;
   while ds.Eof = false do
   begin
      aux.add(ds.Fields[0].AsString + ds.Fields[1].AsString );
      ds.Next;
   end;

   if (mostraPcoCusto = true) then
   begin
      Aux.add('Custo Fiscal(1)                                    1');
      aux.add('Custo Médio Unitário(02)                           2');
      Aux.add('Custo da última entrada(10)                       10');
      Aux.add('CMU(05)                                            5');
      Aux.add('Último ped compra(06)                              6');
      Aux.add('CRUC(07)                                           7');
   end;

   if MostraCampoNhenhum = true then
      Aux.add('< Nenhum >                                        -1');

   ds.free;
   Result := aux;
end;

procedure getAlteracoesPrecoItem(qr:TADOQuery; is_ref, uo, pc:String; di, df:Tdate);
var
   cmd:String;
begin
   cmd :=
   dm.getCMD3('preco', 'lstAltPc', is_ref, pc, fdt.dateToSqlDate(di));
   dm.setParam(cmd, fdt.dateToSqlDate(df));

   if (uo <> '999') then
      cmd := cmd +' ' + dm.getCMD1('preco', 'lstAltPc.uo', uo);

   cmd := cmd +' ' + dm.getCMD('preco', 'lstAltPc.order');

     dm.getQuery(qr, cmd);
end;

function listarPrecosAlteradosPoPeriodo(uo,preco:String; data:Tdate):Tdataset;
var
   cmd:String;
begin
   cmd := dm.getCMD3('preco', 'listaRPVAL', fdt.dateToSqlDate(data), uo, preco);
   result := dm.getDataSetQ(cmd);
end;

function removePreco(isAlp, is_oap:String):boolean;
begin
 result :=   dm.execSQL(  dm.getCMD1('preco', 'delIsAlp', isAlp)) and dm.execSQL(  dm.getCMD1('preco', 'delIsOap', is_oap));
end;

procedure lancaNovoPc(tb:TADOTable; lojas:TadLabelCheckListBox; codPc, cd_pes, campoPc:String; dtReajuste, dtRetPcAnt:Tdate; lancaPcAnt, verificaPcNovo:boolean);
var
   j:integer;
   isRef, cdRef, uo:String;
   pcAntigo, pcNovo:Real;
begin
   tb.First();
   while (tb.Eof = false) do
   begin
      for j := 0 to lojas.Items.Count -1 do
         if lojas.Checked[j] = true then
         begin
            lojas.ItemIndex := j;
            if (existePrecofuturo(codPc, tb.fieldByName('is_ref').AsString, f.getCodUO(lojas), dtReajuste, verificaPcNovo ) = false) then
            begin
               if (lojas.Checked[j] = true) then
               begin
                  uo:= f.getCodUO(lojas);
                  isRef := tb.fieldByName('is_ref').AsString;
                  cdRef := tb.fieldByName('codigo').AsString;
                  pcNovo := tb.fieldByName(campoPc).asFloat;

                  uPreco.lancaPcProd(uo, cd_pes, codPc, isRef, cdRef, pcNovo, dtReajuste);

                  if (lancaPcAnt = true) then
                  begin
                  // pega o preco atual
                     pcAntigo := tb.fieldByName('preco atual').asFloat;
                     uPreco.lancaPcProd(uo, cd_pes, codPc, isRef, cdRef, pcAntigo, dtRetPcAnt);
                  end;
               end;
            end;
         end;
         tb.Next;
   end;
end;

function  reajustaPc(valor, percentual:real):real;
begin
   result := valor + (valor * (percentual/100));
end;

procedure listaTabelaPrecos(tipoPesquisa, tpEstoque:smallInt; ds_ref, cd_ref, uo, pc01, pc02, numNivel, vlNivel:String; qr:TADOQuery; contaEst:integer);
var
   cmd:String;
   tpDesc, cat:String;
   tpEst:String;
begin
	if (numNivel <> '0') then
   	cat := dm.getCMD2('geraEst', 'getItPed.Cat', quotedStr(numNivel), quotedStr(vlNivel))
   else
   	cat := ' /* sem cat */ ';

	if (ds_ref <> '') then
   begin
		if (tipoPesquisa = 1) then
			tpDesc := dm.getCMD1('preco', 'LstTabela.tpDesc', quotedStr(ds_ref +'%') );

		if (tipoPesquisa = 2) then
			tpDesc := dm.getCMD1('preco', 'LstTabela.tpDesc', quotedStr('%' + ds_ref+ '%') );
	end
	else
		tpDesc := '/*tpDesc*/';

	case (tpEstoque) of
   	1:	tpEst:= dm.getCMD1('preco', 'LstTabela.tpEst', '<>');
      2:	tpEst:= dm.getCMD1('preco', 'LstTabela.tpEst', '>');
      3:	tpEst:= dm.getCMD1('preco', 'LstTabela.tpEst', '<');
   else
   	tpEst := '/*tpEst*/';
	end;

	cmd := dm.getCMD8('preco','LstTabela2', uo, pc01, pc02, intToStr(contaEst), cat, quotedStr(cd_ref+'%'),  tpDesc, tpEst);

  dm.getQuerySemTimeOut(qr, cmd, 0);
end;

function getCMUPorPeriodo(is_ref:String; di, df:Tdate):String;
var
  cmd:String;
begin
   f.gravaLog('getCMUPorPeriodo()');
   cmd :=
   dm.getCMD3('preco', 'getCmuMaxData', is_ref, fdt.dateToSqlDate(di), fdt.dateToSqlDate(df) );
   result := dm.openSQL( cmd, ''  );
end;

procedure ajustaPcCusto(uo, is_ref, custo:String; dtBase, di, df:Tdate; pcAnt, pcNovo, cd_pes:String);
var
   cmd:String;
begin
// grava o valor novo do MU na tabela zcf_recalculaCMU
   f.gravaLog('uPreco.ajustaPcCusto(uo:'+ uo + ' is_ref:' +is_ref + ')' );

   cmd :=
   dm.getCMD5('preco', 'incItRecCusto',
      uo,
      is_ref,
      f.valorSQL(custo),
      fdt.dateToSqlDate(dtBase),
      f.valorSql(pcAnt),
   );

   dm.setParams(cmd,
      f.valorSql(pcNovo),
      cd_pes,
      ''

    );

   dm.execSQL(cmd);

   if (custo = '5') then
   begin
      cmd :=
      dm.getCMD4('preco', 'upCmuData',
         f.valorSql(pcNovo),
         is_ref,
         fdt.dateToSqlDate(di),
         fdt.dateToSqlDate(df)
      );
   end
   else if (custo = '1') then
   begin
      cmd :=
      dm.getCMD4('preco', 'upCustoFiscalDt',
         valorSql(pcNovo),
         is_ref,
         fdt.dateToSqlDate(di),
         fdt.dateToSqlDate(df)
      );
   end;

   dm.execSQL(cmd);
end;

function calcCustoEnt(tpEnt, tpCusto:String; dsEntItem, dsNfEnt, dsItNfTransf, dsNfTransf:TdataSet; vlDespExtra:real; tbItTrf:TdataSet):real;
var
   subs, res, vlRat, vItem, desc, ipi, icm, frete, qt:real;
   mrgSub, custo, cx:real;
   regra:integer;
   cmd:String;
   auxDspExtra, auxValorProd, auxTotItensNf:real;
   logValores:TStringList;

   cod:String;
begin
   f.gravaLog('uPreco.calcCustoEnt()' +#13+#13);
   f.gravaLog('');
   f.gravaLog('');

   custo :=0;
   cx := 1;
	if (dsEntItem.IsEmpty = false) then
   begin
      custo :=0;
      if (tpEnt = 'importacao') then
      begin
      	cod :=  dsEntItem.fieldByName('cProd').AsString;

         regra := 1;
         desc  :=  0;
         mrgSub :=  0;

         vItem :=  strToFloat(f.pontoPorVirgula(dsEntItem.fieldByName('vProd').AsString));
         ipi   :=  strToFloat(f.pontoPorVirgula(dsEntItem.fieldByName('vIPI').AsString));
         icm   :=  strToFloat(f.pontoPorVirgula(dsNfEnt.fieldByName('vICMS').AsString));

         auxDspExtra := vlDespExtra;

         auxTotItensNf := strToFloat(f.pontoPorVirgula( dsNfTransf.fieldByName('vProd').AsString));

			auxValorProd := strToFloat(f.pontoPorVirgula(dsItNfTransf.FieldByName('vProd').AsString));

         qt    :=  tbItTrf.fieldByName('qt_mov').asfloat;

         vlRat := (auxDspExtra * (auxValorProd / auxTotItensNf)) / qt;

      end
      else
      begin
      	cod := dsEntItem.fieldByName('cd_ref').AsString;
         regra := dsEntItem.fieldByName('codRegra').AsInteger;
         vItem := dm.somaColunaTable(dsEntItem, 'vl_item');
         desc  := dm.somaColunaTable(dsEntItem, 'VL_DESC');
         mrgSub :=  dm.somaColunaTable(dsEntItem, 'vlMargSubIcms');
         ipi   :=  dm.somaColunaTable(dsEntItem, 'ValorIPI');
         icm   :=  dm.somaColunaTable(dsEntItem, 'ValorIcms');
         qt    :=  dm.somaColunaTable(dsEntItem, 'qt_mov');
         vlRat :=  dsEntItem.fieldByName('vlRatPF').AsFloat / qt ;
      end;

      if (tpCusto = 'F') then
      begin
			vlDespExtra := 0;
         vlRat := 0;
      end;

      custo := ((vItem - desc + ipi - icm + mrgSub  ) / qt);

      if (tpCusto = 'G') then
      begin
			custo := custo + (vlRat);
      end;

		logValores := TSTringlist.Create();
		logValores.add( '----------------------------------------------------');
		logValores.add( '      Tipo: '   + tpCusto);
		logValores.add( '    Codigo: '	+ cod);
		logValores.add( '    ');
		logValores.add( 'Valor Item: '  	+ FloatToStr(vItem));
		logValores.add( '  Desconto: '   + FloatToStr(desc));
		logValores.add( '       IPI: '	+ FloatToStr(ipi));
		logValores.add( '       ICM: '   + FloatToStr(icm));
      logValores.add( 'Extra item: '   + FloatToStr(vlRat));
      logValores.add( '        qt: '   + FloatToStr(qt));
      logValores.add( '    custo : '   + FloatToStr(custo));
      logValores.add( '        ');


		f.gravaLinhaEmUmArquivo(f.getDirLogs() + 'custoImportado.txt', logValores);
      f.gravaLog(logValores);

		logValores.Free();
   end
   else
   begin
		custo := 0;
      f.gravaLog('Custo Zero');
	end;

   result := custo;
end;

function recalcCMUItem(is_ref:String; di, df:Tdate; vlItem, vlDespExt, icm, ipi, qt, vlItensNota:real):String;
var
  res:real;
  arq:String;
begin
   arq := f.getDirLogs() + 'Log_custo.txt';

   f.gravaLinhaEmUmArquivo(arq, ' ');
   f.gravaLinhaEmUmArquivo(arq, ' function uPreco.recalcCMUItem('+ is_ref +' di:' + DateToStr(di) + ' df:'+ DateToStr(df) +   ')');

   vlDespExt := (vlItem / vlItensNota) * vlDespExt;

   res :=  (vlItem + ipi - icm + vlDespExt) / qt;
   Result := f.floatToMoney(res);

   f.gravaLinhaEmUmArquivo( arq,
      'calculo do pc de custo ( is_ref:' + is_ref +
      '  vlItem: ' + floatToMoney(vlItem) +
      ', IPI: ' + floatToMoney(ipi) +
      ', ICM: ' + floatToMoney(icm) +
      ', Desp extra item: ' + floatToMoney(vlDespExt)+
      ', qt: ' +  floatToMoney(qt)+
      ', Custo: ' + Result
   );
end;

procedure ajustaCMUItemCompleto(is_ref, cd_pes:String;di, df:Tdate);
var
   dsEnt:TdataSet;
   cmu:String;
   vlItem, vlDespExt, icm, ipi, qt, vlItensNota:real;
   dAltI, dAltF:Tdate;
begin
   vlItem := 0;
   vlDespExt := 0;
   vlItensNota :=0;
   icm := 0;
   ipi := 0;
   qt := 0;

   dsEnt := uEstoque.getEntradasPorItem(is_ref, '', di, df, false, true);

   f.gravaLog(dsEnt, 'ds ent');

   if (dsEnt.IsEmpty = false) then
   begin
      dsEnt.First();

      while(dsEnt.Eof = false) do
      begin
         dAltI :=  dsEnt.fieldByName('data').AsDateTime;

         vlItem :=  vlItem +   dsEnt.fieldByName('totalItem').AsFloat;
         vlDespExt := vlDespExt + dsEnt.fieldByName('vl_dspExtra').AsFloat;
         vlItensNota :=  vlItensNota + dsEnt.fieldByName('vlItensNota').AsFloat;
         icm := icm + dsEnt.fieldByName('valorIcms').AsFloat;
         ipi := ipi + dsEnt.fieldByName('valoripi').AsFloat;
         qt :=  qt  + dsEnt.fieldByName('quant').AsFloat;

         dsEnt.Next();

         if (dsEnt.Eof = true)then
           dAltF := df
         else
           dAltF :=  dsEnt.fieldByName('data').AsDateTime;

         cmu := recalcCMUItem(is_ref, dAltI, dAltF, vlItem, vlDespExt, icm, ipi, qt, vlItensNota);

         sleep(100);
         upreco.ajustaPcCusto('0', is_ref, '5', dAltI, dAltI, dAltF, '0', cmu, cd_pes);
      end;
   end;
   dsEnt.Free();
end;

function ajustaCustosPorIsLanc(is_lanc, is_ref:string; custoFiscal, cmu:real):boolean;
var
  cmd:String;
  res:boolean;
begin
	res := true;
   if (is_lanc <> '-1') then
   begin
      cmd :=
      dm.getCMD4('Preco', 'upCustoCmuIsLanc',
         f.valorSql(custoFiscal, true),
         f.valorSql(cmu, true),
         is_lanc,
         is_ref
      );
      dm.execSQL(cmd);

// austa o custo dos itens do pedido dos utimos 5 dias
      cmd := dm.getCMD2('pedCliente', 'updCustoItem', f.valorSql(custoFiscal), is_ref);
      res:= dm.execSQL(cmd);

      gravaLogPcCusto(is_ref, '99999999', '10032378', '1', custoFiscal);
      gravaLogPcCusto(is_ref, '99999999', '10032378', '5', cmu);

// ajusta na tabela zcf_custos



   end;
	result := res;
end;

procedure gravaLogPcCusto(is_ref, uo, cd_pes, codPreco:String; valor:real);
var
   cmd:String;
begin
   cmd :=
   dm.getCMD5('preco', 'insLogPcCusto',
      is_ref,
      uo,
      cd_pes,
      codPreco,
      valorSql(valor)
   );
   dm.execSQL(cmd);
end;

procedure ajustaZcf_custos(is_ref, is_lanc:String; dtEnt:Tdate;  fiscal, cmu:real);
var
	cmd:String;
begin
	f.gravaLog('ajustaZcf_custos() is_ref= '+ is_ref);

	cmd :=    f.dateToSQLDateInt(dtEnt);

	cmd :=
   dm.getCMD5('Preco', 'insZcf_custo',
   	is_ref,
      is_lanc,
      f.valorSql(fiscal),
      f.valorSql(cmu),
      fdt.dateToSqlDate(dtEnt)
    );
	dm.execSQL(cmd);
end;

procedure getTbPreco(tb:TADOTable; tipoPesquisa, tpEstoque:smallInt; ds_ref, cd_ref, uo, pc01, pc02, numNivel, vlNivel:String; contaEst:integer);
var
	qr:TADOQuery;
begin
	if (tb.TableName <> '' )then
   	tb.Close();
   dm.getTable(tb, dm.getCMD('tb', 'tegTbTbPc') );

	qr := TADOQuery.Create(nil);
   uPreco.listaTabelaPrecos(
	   tipoPesquisa,
      tpEstoque,
      ds_ref,
      cd_ref,
      uo,
      pc01,
      pc02,
      numNivel,
      vlNivel,
      qr,
      contaEst
   );

{}
   screen.Cursor := crHourGlass;
   qr.First();
   while (qr.eof = false ) do
   begin
   	tb.Append();
      tb.FieldByName('codigo').Assign( qr.FieldByName('codigo') );
      tb.FieldByName('descricao').Assign( qr.FieldByName('descricao') );
      tb.FieldByName('qt_emb').Assign( qr.FieldByName('qt_emb') );
      tb.FieldByName('estoqueAtual').Assign( qr.FieldByName('estoqueAtual') );
      tb.FieldByName('Preco 01').Assign( qr.FieldByName('Preco 01') );
      tb.FieldByName('Preco 02').Assign( qr.FieldByName('Preco 02') );
      tb.FieldByName('cd_pes').Assign( qr.FieldByName('cd_pes') );
      tb.FieldByName('is_ref').Assign( qr.FieldByName('is_ref') );
      tb.FieldByName('nm_pes').Assign( qr.FieldByName('nm_pes') );
		tb.Post();
      qr.Next();
   end;
	qr.free();

end;



end.
