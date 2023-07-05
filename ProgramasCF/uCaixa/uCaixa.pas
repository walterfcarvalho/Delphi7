unit uCaixa;

interface
   uses classes, QForms, ADODB, DB, Controls, ComCtrls, SysUtils;


	function getDescCaixas(uo:String; mostraTodos, mostraNumPDV:boolean):TStrings;
   function getPreviaGeralCaixa(uo, caixa:String; dataI, dataF:Tdate; listaVendaPMaracanau, listaSomenteCartao, listaSangria, listaEstorno:boolean):TDataSet;
	function getTotalCartaoPorModo(tb:TADOTable):TStringlist;

	procedure getModalidadesCaixa(nmTbPreviaDeCaixa:String; tbTotaisRecebimento :TADOTable; cd_tpm, tp_mve: String);
	procedure getOperadoresPorCaixa(tb:TADOTable; uo, caixa:String; dti, df: TDateTimePicker);
	procedure getRecebimentosEmCartao(tb, tbVendasCartao :TADOTable; detalhaCartoes:boolean);
	procedure getRecebDeCaixa(nmTbPreviaDeCaixa:String; tbReceb:TADOTable);
	procedure getSangriasDoCaixa(nmTbPreviaDeCaixa:String; tbSangria :TADOTable);
   procedure listaRecebimentosCaixa(tb:TADOTAble; uo, caixa:String; dti, dtf: TDateTimePicker; listaSoCartao, removeTrocos, listaSangria, listaEstorno:boolean);

   procedure obterDescPorData(tb:TADOTable; di, df:Tdate; uo:String);


implementation

uses uMain, f, fdt, uDm;

procedure getSangriasDoCaixa(nmTbPreviaDeCaixa:String; tbSangria :TADOTable);
begin
   getModalidadesCaixa( nmTbPreviaDeCaixa, tbSangria , '2', '');
end;

procedure getRecebDeCaixa(nmTbPreviaDeCaixa:String; tbReceb:TADOTable);
begin
// pega as entradas no caixa para compor o total de recebimento por modalidades
   getModalidadesCaixa( nmTbPreviaDeCaixa, tbReceb, '5, 4', '');
end;

procedure getRecebimentosEmCartao(tb, tbVendasCartao :TADOTable; detalhaCartoes:boolean);
begin
	dm.getTable(tbVendasCartao, dm.getCMD('financeiro', 'getTbRecCartao'));

   tbVendasCartao.Close();

   if (detalhaCartoes = true) then
	   dm.execSQL( dm.getCMD2('financeiro', 'getRecDetCartoes', tbVendasCartao.tableName, tb.TableName) );

	tbVendasCartao.Open();
end;


function getDataSetPrevCaixa(uo, caixa:String; dataI, dataF:Tdate; listaVendaPMaracanau, listaSomenteCartao, listaSangria:boolean):TDataSet;
var
  codEmp, cmd:String;
  fields, joins, wheres, orderBy :String;
  clientesAExcluir:String;
  modExcluidas:String;
  getEstorno:String;
begin
   f.gravaLog('getDataSetPrevCaixa() caixa:'+ caixa + ' uo:'+ uo);

   if (listaVendaPMaracanau = false ) then
      clientesAExcluir := dm.getParamBD('AVL.CodcliExc', '');

   codEmp := dm.getParamBD('comum.codEmpresa', '0');

   fields:=  dm.getCMD('Financeiro', 'previaCx.fields');

   joins :=  dm.getCMD3('Financeiro', 'previaCx.joins', codEmp, codEmp, '');

   wheres :=  dm.getCMD3('Financeiro', 'previaCx.where', uo, fdt.dateTimeToSqlDateTime(dataI, '00:00:00'), fdt.dateTimeToSqlDateTime(dataF, '00:00:00') );

   if (caixa <> '0') then
      wheres :=   wheres + dm.getCMD3('Financeiro', 'previaCx.caixa', caixa, '', '');

   if(listaSomenteCartao <> false) then
      wheres := wheres + dm.getCMD('Financeiro', 'previaCx.soCartoes');

   if (listaVendaPMaracanau = false) then
      wheres := wheres + dm.getCMD3('Financeiro', 'previaCx.clientesRemovidos', clientesAExcluir, '', '' );

   if (listaSangria = false) then
      wheres := wheres + dm.getCMD('Financeiro', 'previaCx.listaSangria');

   modExcluidas := dm.getParamBD('AVL.modModExluidas', '');

   if (modExcluidas = '') then
      modExcluidas := ' -1 ';

   // insere os pagamentos que terao as modalidades excluidas
   wheres := wheres +
   dm.getCMD3('Financeiro', 'previaCx.modExcluidas', modExcluidas, '', '' );

   orderBy := dm.getCmd('Financeiro', 'previaCx.orderBy');

   cmd := fields + joins + wheres + getEstorno + orderBy;

   result := dm.getDataSetQ(cmd);
   f.gravaLog('getDataSetPrevCaixa() - fim');
end;


function getPreviaGeralCaixa(uo, caixa:String; dataI, dataF:Tdate; listaVendaPMaracanau, listaSomenteCartao, listaSangria, listaEstorno:boolean):TDataSet;
begin
   f.gravaLog('ucaixa.getPreviaGeralCaixa() inicio');

   if (dataf = 0) then
      dataf := datai;

   if (caixa = '') then
      caixa := '0';

   if ( uo <> '' ) and (uo <> '999') then
      uo := ('transacoesDoCaixa.codloja = '+ uo)
   else
      uo := ('transacoesDoCaixa.codloja != 0 ');

   result := getDataSetPrevCaixa(uo, caixa, dataI, dataF, listaVendaPMaracanau, listaSomenteCartao, listaSangria);

   f.gravaLog('ucf.getPreviaGeralCaixa() fim');
end;

procedure listaRecebimentosCaixa(tb:TADOTAble; uo, caixa:String; dti, dtf: TDateTimePicker; listaSoCartao, removeTrocos, listaSangria, listaEstorno:boolean);
var
   ds:TdataSet;
begin
// criar a tabela de vendas
   if (tb.TableName <> '') then
      tb.Close();

   tb.tablename:= dm.criaTabelaTemporaria( dm.getCMD('Financeiro','getTbPrevCx'));

   // lista a previa de caixa
   ds := getPreviaGeralCaixa( uo, caixa, dti.date, dtf.date, true, false, listaSangria,listaEstorno);

   fmMain.msgStatus('Carregando registros da previa geral... aguarde');

   screen.cursor := crHourglass;

   ds.first();
   tb.open();


   while (ds.eof = false) do
   begin
   	tb.Append();
      tb.FieldByName('codLoja').Assign(ds.fieldByname('codLoja'));
      tb.FieldByName('descEstacao').Assign(ds.fieldByname('descEstacao'));
      tb.FieldByName('cd_mve').Assign(ds.fieldByname('cd_mve'));
      tb.FieldByName('ds_mve').Assign(ds.fieldByname('ds_mve'));
      tb.FieldByName('dataSessaoCaixa').Assign(ds.fieldByname('dataSessaoCaixa'));
      tb.FieldByName('seqTransacaoCaixa').Assign(ds.fieldByname('seqTransacaoCaixa'));
      tb.FieldByName('seqModPagtoPorTransCaixa').Assign(ds.fieldByname('seqModPagtoPorTransCaixa'));
      tb.FieldByName('valor').Assign(ds.fieldByname('valor'));
      tb.FieldByName('numParcelas').Assign(ds.fieldByname('numParcelas'));
      tb.FieldByName('ds_mveReal').Assign(ds.fieldByname('ds_mveReal'));
      tb.FieldByName('cd_mveReal').Assign(ds.fieldByname('cd_mveReal'));      
      tb.FieldByName('is_oper').Assign(ds.fieldByname('is_oper'));
      tb.FieldByName('seqTefTransCaixa').Assign(ds.fieldByname('seqTefTransCaixa'));
      tb.FieldByName('cd_tpm').Assign(ds.fieldByname('cd_tpm'));
      tb.FieldByName('tp_mve').Assign(ds.fieldByname('tp_mve'));
      tb.FieldByName('tefMagnetico').Assign(ds.fieldByname('tefMagnetico'));

      tb.Post();
      ds.next();
   end;
   ds.free();

   fmMain.msgStatus('');

   f.gravaLog('Carregando registros da previa geral, fim');

   if (removeTrocos = true) then
   begin
      tb.close;
      dm.execSQL('delete from ' + tb.tableName + ' where valor < 0');
      tb.open();
   end;
   screen.cursor:= crDefault;
end;

procedure getModalidadesCaixa(nmTbPreviaDeCaixa:String; tbTotaisRecebimento :TADOTable; cd_tpm, tp_mve: String);
var
   cmd:String;
begin
   cmd := 'cd_mve varchar(50), valor money';

   dm.getTable(tbTotaisRecebimento, cmd);
   tbTotaisRecebimento.close();

   cmd :=
   ' insert ' + tbTotaisRecebimento.tableName +
   ' select ds_mve, sum(valor) from ' + nmTbPreviaDeCaixa +
   ' where cd_tpm in ('+cd_tpm+')';

   if( tp_mve <> '') then
      cmd := cmd + ' and tp_mve in (' + tp_mve+')';

   cmd := cmd + ' group by ds_mve order by ds_mve ';

   dm.execSQL(cmd);

   tbTotaisRecebimento.Open;

   f.gravaLog('tbTotaisRecebimento tem: ' + intToStr(tbTotaisRecebimento.RecordCount) );
end;


function getDescCaixas(uo:String; mostraTodos, mostraNumPDV:boolean):TStrings;
var
   strPdv, cmd:String;
   ds:TdataSet;
   lista:Tstrings;
begin
   cmd := dm.getCMD1('cx', 'getDesCx', uo );

   ds := dm.getDataSetQ(cmd);
   ds.first();

   lista := TStringlist.create();

   if (mostraTodos = true) then
      lista.add('<Todos>');
   while (ds.eof = false ) do
   begin
      if (mostraNumPDV = true) then
         strPdv := f.preencheCampo(2,'0','E', ds.fieldByName('codCaixa').asString ) + ' - '
      else
         strPdv := '';

      lista.add( f.preencheCampo(50, ' ', 'D', strPdv +  ds.fieldByName('descEstacao').asString) + ds.fieldByName('codCaixa').asString );
      ds.next();
   end;
   ds.free;
   result := lista;
end;

procedure getOperadoresPorCaixa(tb:TADOTable; uo, caixa:String; dti, df: TDateTimePicker);
var
   cmd:String;
begin
   f.gravaLog('getOperadoresPorCaixa()');

   if (tb.tablename <> '') then
      tb.close;

   tb.tablename:= dm.criaTabelaTemporaria( dm.getCMD('Financeiro', 'getTbOPr') ) ;

   if (caixa <> '') then
      caixa := dm.getCMD1('Financeiro', 'getOpr.caixa', caixa)
   else
      caixa := '';

   if (uo <> '') and (uo <> '999') then
      uo := dm.getCMD1('Financeiro', 'getOpr.uo', uo)
   else
      uo := '';

   cmd :=
   dm.getCMD5('Financeiro', 'getOpr',
      tb.TableName,
   	fdt.dateToSqlDate(dti.date),
   	fdt.dateToSqlDate(df.date),
      caixa,
      uo
   );
   dm.execSQL(cmd);
   tb.Open();
end;

function getTotalCartaoPorModo(tb:TADOTable):TStringlist;
var
  aux:TStringList;
  ds:TdataSet;
begin
   aux := TStringList.create();
   ds := dm.getDataSetQ( 'select count(*), sum(valor) from ' + tb.tableName + ' where tefMagnetico = ''0''');
   aux.add( ds.fields[0].asString);
   aux.add( floattostrf( ds.fields[1].asFloat , ffNumber, 18, 2));
   ds.free();

   ds := dm.getDataSetQ( 'select count(*), sum(valor) from ' + tb.tableName + ' where tefMagnetico = ''1''');
   aux.add( ds.fields[0].asString);
   aux.add( floattostrf( ds.fields[1].asFloat , ffNumber, 18, 2));
   ds.free();
   result := aux;
end;

procedure obterDescPorData(tb:TADOTable; di, df:Tdate; uo:String);
var
	cmd:String;
begin
	if (uo <> '999') then
   	uo := dm.getCMD1('Vendas', 'lstDescVendas.uo', uo)
	else
		uo := '';

 	dm.getTable(tb, dm.getCMD('Vendas', 'getTbDesc'));
   tb.Close();

   cmd :=
   dm.getCMD4('Vendas','lstDescVendas',
   	tb.TableName,
      fdt.dateToSqlDate(di),
      fdt.dateToSqlDate(df),
      uo
   );
	dm.execSQL(cmd);
   tb.Open();
end;







end.
