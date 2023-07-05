unit uPedFornecedor;

interface

uses  db, ADODB, Controls, sysUtils, windows, classes;

   function getItPedFornecedor(numPed:String):TdataSet;
   function getVlParcPedCompra(numPedido:String):TDataSet;
   function mudaDataVencPedido(numPed:String; numDias:Real):boolean;
   procedure getDadosPedidosFornecedor(var tb:TADOTable; di, df: TDate; uo, comprador, fornecedor:String; soPendentes:boolean; nvCat, cat, numPedido:String);

   procedure getTotaisParcPedforn(var tbPed, tbParc, tbParcCons :TADOTable);
   procedure mudaDataPedidoDeCompra(tb:TADOTable; numDias:Real; comprador, fornecedor:String);
   procedure setUoPedForn(pedido, uo, comprador:String);

   procedure getTotaisPedidosFornecedor(tbPedidos, tbPedRes:TADOTable);

   procedure impPedFornecedor(numPed:String; destino:char);

implementation

uses umain, f, fdt, uDm, msg, uEstoque;


function getItPedFornecedor(numPed:String):TdataSet;
begin
   result := dm.getDataSetQ( dm.getCMD1('cpr', 'getItPedForn', numPed));
end;

procedure getDadosPedidosFornecedor(var tb:TADOTable; di, df: TDate; uo, comprador, fornecedor:String; soPendentes:boolean; nvCat, cat, numPedido:String);
var
   strNumPed, strComp, strUo, strCat, strForn, cmd:String;
   dsValPed:TdataSet;
begin
// lista os pedidos de compra de acordo com os parametros

   if (numPedido <> '') then
   begin
     strNumPed :=  dm.getCMD('cpr','lstPed.numPedido');
     dm.setParam(strNumPed, numPedido);
   end
   else
     strNumPed := '/*all Ped */';

   if (uo <> '999') then
     strUo := dm.getCMD1('cpr', 'lstPed.uo', uo)
   else
     strUo := '/*All uo*/';

   if (comprador <> '') then
      strComp :=  dm.getCMD1('cpr', 'lstPed.Comp', comprador)
   else
      strComp :=  '/*All Comprador*/';

   if (fornecedor <> '') then
      strForn :=  dm.getCMD1('cpr', 'lstPed.Forn', fornecedor)
   else
      strForn :=  '/*All fornecedor*/';

   // fecha tabela , se estiver aberta.
   if( tb.TableName <> '') then
      tb.Close();

   // criar a tabela temporaria
   cmd :=  dm.getCMD('cpr', 'getTbRelPedForn');
   dm.getTable(tb, cmd );
   tb.Close();

   cmd :=
   dm.getCMD7('cpr', 'lstPed',
   	tb.TableName,
      strNumPed,
      fdt.dateTimeToSqlDateTime(di, '00:00:00'),
      fdt.dateTimeToSqlDateTime(df, '00:00:00'),
      strUo,
      strComp,
      strForn,
   );
   dm.execSQL(cmd);

   tb.Open();
   if (tb.IsEmpty = false) then
   begin
      tb.First();

      while( tb.Eof = false) do
      begin
         fmMain.msgStatusProgresso(tb.recNo, tb.recordCount, 'Valores Pedidos');

         if (nvCat<> '0') then
            strCat := dm.getQtCMD2('cpr', 'lstPed.Cat', nvCat, cat)
         else
            strCat := '/* */';

         cmd := dm.getCMD3('cpr', 'lstPed.ValItens', tb.fieldByName('Pedido').AsString, strCat, strCat);

         dsValPed := dm.getDataSetQ(cmd);
         if dsValPed.IsEmpty = false then
         begin
            tb.Edit();
            tb.FieldByName('vl_merc').AsInteger := dsValPed.FieldByName('vl_Merc').AsInteger;
            tb.FieldByName('VlPendente').AsInteger := dsValPed.FieldByName('VlPendente').AsInteger;
            tb.Post();
         end;
         tb.Next;
         dsValPed.Free();
      end;
      tb.Close
   end;
end;

function mudaDataVencPedido(numPed:String; numDias:Real):boolean;
var
   cmd:String;
   dsDatasPag:TdataSet;
   dataNova:Tdate;
begin
// ajusta a data de emissao do pedido
   cmd := ' update dspdf set dt_emis = dt_Emis + ' + floatToStr(numDias) +
          ' where is_pedf = ' + numPed;
   dm.execSQL(cmd);


// ajustar as datas de vencimento
   cmd := 'select numPar, datVen from dsppe where docume = ' + numPed;
   dsDatasPag := dm.getDataSetQ(cmd);
   dsDatasPag.first();

   while ( dsDatasPag.eof = false ) do
   begin
      dataNova :=  fdt.dataIntWelltoData( dsDatasPag.fieldByName('datVen').AsString );
      dataNova := dataNova + numDias;

      cmd :=
      ' update dsppe set datVen = ' + fdt.dateToIntSQL(dataNova) +
      ' where numdoc = ' + numPed +
      ' and numPar = ' + dsDatasPag.fieldByName('numPar').AsString;
      dm.execSQL(cmd);

      dsDatasPag.Next();
   end;
   dsDatasPag.free();
   result := true;
end;

procedure mudaDataPedidoDeCompra(tb:TADOTable; numDias:Real; comprador, fornecedor:String);
begin
   getDadosPedidosFornecedor( tb, strToDate('01/01/2009'), (now)+500, '999', comprador, fornecedor, true, '0','0', '');
   tb.Open();

   if (tb.IsEmpty = false ) then
   begin
      tb.First();
      while ( tb.Eof = false) do
      begin
         fmMain.msgStatusProgresso(tb.RecNo, tb.RecordCount, 'Atualizando datas');
         mudaDataVencPedido(tb.fieldByname('pedido').AsString, numDias);
         tb.Next();
      end;
   end;
   msg.msgExclamation(intToStr(tb.RecordCount) + ' pedidos alterados.');
   tb.close();
end;

procedure setUoPedForn(pedido, uo, comprador:String);
var
   cmd:String;
begin
   cmd :=
   ' update dsipe' +
   ' set is_estoque= '+ uo +
   'where is_pedf= ' + pedido;
   dm.execSQL(cmd);

   cmd :=
   'update DSPDF '+
   ' set is_estoque= '+ uo +', '+
   ' is_UOCOMPRA= ' + uo +', '+
   ' UOPAGTO= ' + uo + ', '+
   ' cd_usu= '+ comprador +
   ' where is_pedf= '+ pedido;
   dm.execSQL(cmd);

   cmd :=
   ' update DSEPF '+
   ' set is_estoque= '+ uo +
   ' where is_pedf= ' + pedido;
   dm.execSQL(cmd);
end;

function getVlParcPedCompra(numPedido:String):TDataSet;
var
   cmd:String;
begin
   cmd := dm.getCMD('cpr', 'getVlParcPedForn');
   dm.setParam(cmd, numPedido);
   dm.setParam(cmd, numPedido);
   dm.setParam(cmd, numPedido);
   result := dm.getDataSetQ(cmd);
end;


procedure getTotaisParcPedforn(var tbPed, tbParc, tbParcCons :TADOTable);
var
   cmd:String;
   ds:TdataSet;
begin
 // calcula totais das parcelas dos pedidos


   // fecha tabela , se estiver aberta.
   if( tbParc.TableName <> '') then
      tbParc.Close();

   cmd := 'seq int identity(0,1), mes_ano varchar(07), ano_mes varchar(07), valor money, vlFornADM money, vlParcPendente money ';
   dm.getTable(tbParc, cmd );
   tbParc.Close();

   tbPed.Open();

   tbPed.First();
   while (tbPed.Eof = false) do
   begin
      fmMain.msgStatusProgresso(tbPed.recNo, tbPed.recordCount,'');

      ds:= uPedFornecedor.getVlParcPedCompra(tbPed.fieldByName('pedido').asString);

      ds.First();
      while ( ds.Eof = false ) do
      begin
         cmd:=
         'insert ' + tbParc.TableName + ' values (' +
         quotedStr( copy(ds.fieldByName('datVen').asString, 05, 02) +'/'+ copy(ds.fieldByName('datVen').asString, 01, 04)) + ', ' +
         quotedStr( copy(ds.fieldByName('datVen').asString, 01, 04) +'/'+ copy(ds.fieldByName('datVen').asString, 05, 02)) + ', ' +
         f.valorSql(ds.fieldByName('valPar').asString) + ', '+
         '0' + ', ' +
         f.valorSql(ds.fieldByName('valPar').asString) + ')';

         dm.execSQL(cmd);

         ds.Next();
      end;
      tbPed.Next();
      ds.Free();
   end;

// criar um nova table a apenas com os dados agregados

   cmd := 'seq int identity(0,1), mes_ano varchar(07), ano_mes varchar(07), valor money, vlFornADM money, vlParcPendente money  ';
   dm.getTable(tbParcCons, cmd );
   tbParcCons.Close();

   cmd := 'Insert ' + tbParcCons.TableName +
          ' select mes_ano, ano_mes, sum(valor), '''', sum(vlParcPendente) from ' + tbParc.TableName +
          ' group by ano_mes, mes_ano order by ano_mes';
   dm.execSQL(cmd);

   tbParcCons.Open();
end;

procedure impPedFornecedor(numPed:String; destino:char);
var
  dsIt:TdataSet;
  tb:TADOTable;
  arq:String;
  textoMsg:Tstringlist;
begin
   textoMsg := TStringList.Create();
   textoMsg.Add('Envio de copia do pedido de compra');

   tb := TADOTable.Create(nil);

   uPedfornecedor.getDadosPedidosFornecedor(
      tb, strToDate('02/01/2000'),strToDate('02/01/2000'), '999',
      '', '', false, '0', '0', numPed
   );

   if (tb.IsEmpty = true) then
   begin
      dsIt := getItPedFornecedor(numPed);;

      f.gravaLog(dsIt, 'dsitem');

      if (destino = 'P') then
         fmMain.imprimeRave(tb, dsIt, nil, nil, nil, 'rpPedForn', nil)
      else if (destino = 'M') then
      begin
         arq := f.getDirLogs() + 'Pedido de compra ' + numPed + '.pdf';
         fmMain.impressaoRavePDF(tb, dsIt, 'rpPedForn', nil, arq);

         fmMain.enviarEmail('', 'Envio de pedido de compra', arq, textoMsg, 'Envio de pedido de compra');
      end
      else
         fmMain.exportaDataSet(dsIt, textoMsg);


      dsIt.free();
      tb.Close();
      textoMsg := nil;
   end
   else
      msg.msgErro(dm.getMsg('pedFornErr1'));
end;

procedure getTotaisPedidosFornecedor(tbPedidos, tbPedRes:TADOTable);
var
   cmd:String;
begin
   if (tbPedRes.TableName <> '') then
      tbPedRes.Close();

   cmd := ' seq int identity (0, 1), nm_usu varchar(100), vl_merc money, vl_total money, [VlPendente] money,  ';

   dm.getTable(tbPedRes, cmd );
   tbPedRes.Close();

   cmd :=
   'insert ' + tbPedRes.TableName +
   ' select  nm_usu, sum(vl_merc) as totMerc, sum(vl_total)as totPed, '+
   ' sum(vlpendente) as totPend ' +
   ' from '+ tbPedidos.TableName +
   ' group by nm_usu order by nm_usu';
   dm.execSQL(cmd);

   tbPedRes.Open();
end;




end.



