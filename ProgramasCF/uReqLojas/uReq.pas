unit uReq;

interface

uses db, adodb, classes, Controls, SysUtils, uEstoque;

   function gerarReq(tb:TADOTable; uo_cd, uo, usuario:String;mostraNumero, ehReqDeVenda:Boolean; var ocoItens:TStringList;QT_DIAS_PEND:integer):String;

   function getReqPorItem(is_ref, uo:String; dti, dtf:Tdate; isEmSeparacao:boolean; faixaCodigo:String; uoCd, qtTransf:String):TdataSet;
   function getReqPendPorDataOS(uo:String; di, df:Tdate):TdataSet;
   function getStrInsPlanoDist(isPlanoD, cdPes, isOper, uoCd:String):String;
   function reqTransferida(req:String):boolean;
   procedure apagaRequisicao(numReq:String);
   procedure getItensReq(qrItens:TADOquery; numReq:String);
   procedure getReqLojasPorData(qr:TAdoQuery; di, df:Tdate; uo_cd, uoOrigem:String);
   procedure loadTableReq(tbName, uo, uo_cd, pc:String);
   procedure remItemDaRequisicao(is_planod, os, isRef:String; novaQt:integer);
   procedure reqFromPedCliente(uo_cd, pedido, usuario:String);
   procedure removeReqPendentes(ds:TDataset);
   procedure salvaItReqAbast(uo, is_ref, qt, qtMax, uo_cd:String);
   procedure salvaReqAbastecimento(tb:TADOTable; uo, uo_cd:String);




implementation

uses f, uDm, fdt, cf, msg, uMain;



procedure getReqLojasPorData(qr:TAdoQuery; di, df:Tdate; uo_cd, uoOrigem:String);
var
   cmd:String;
begin
   cmd :=
   dm.getCMD3('Estoque', 'conReqPorLoja', fdt.dateTimeToSqlDateTime(di,' 00:00:00'), fdt.dateTimeToSqlDateTime(df,' 00:00:00'), uo_cd );

   if (uoOrigem <> '999') then
      cmd := cmd + dm.getQtCMD1('Estoque', 'conReqPorLoja.uo', uoOrigem);

   cmd :=
   cmd + dm.getCMD('Estoque', 'conReqPorLoja.Ordem');

   dm.getQuery(qr, cmd);
end;

procedure getItensReq(qrItens:TADOquery; numReq:String);
begin
   dm.getQuery(qrItens, dm.getCmd1('Estoque', 'conItensReq', numReq));
end;

function getStrInsPlanoDist(isPlanoD, cdPes, isOper, uoCd:String):String;
var
   codEmp, cmd:String;
begin

   codEmp := dm.getParamBD('comum.CodEmpWell', '0');

   cmd := dm.getCMD('Estoque', 'insPlanoDist');

   dm.setParams(cmd, fdt.DateTimeToSqlDateTime(dateToStr(now), ''),  isPlanoD, cdPes );
   dm.setParams(cmd, isOper, uoCd, codEmp);

   result := cmd;
end;

function getReqPendPorDataOS(uo:String; di, df:Tdate):TdataSet;
var
  cmd:String;
begin
   if (uo <> '999') then
     uo := dm.getCMD1('Estoque', 'getRequisicao.uo', uo)
   else
     uo :=  ' ';

	cmd :=
   dm.getCMD3('Estoque', 'getReqPorOs',
   	fdt.dateToSqlDate(di),
      fdt.dateToSqlDate(df),
      uo
   );
   result := dm.getDataSetQ(cmd);
end;


function getReqPorItem(is_ref, uo:String; dti, dtf:Tdate; isEmSeparacao:boolean; faixaCodigo:String; uoCd, qtTransf:String):TdataSet;
var
   aux, cmd:String;
begin
   cmd := dm.getCMD('Estoque', 'getRequisicao');
   dm.setParam(cmd, fdt.DateTimeToSqlDateTime(dti, '00:00:00') );
   dm.setParam(cmd, fdt.DateTimeToSqlDateTime(dtf, '23:59:59') );
   dm.setParam(cmd, uoCd );

   if (isEmSeparacao = true) then
      dm.setParam(cmd, dm.getCMD('Estoque', 'getRequisicao.isEmSeparacao') );

   if (uo <> '999') then
   begin
      aux := dm.getCMD('Estoque', 'getRequisicao.uo');
      dm.setParam(aux, uo);
      dm.setParam(cmd, aux);
   end
   else
      dm.setParam(cmd, '');

   if ( is_ref <> '') then
   begin
      aux := dm.getCMD('Estoque', 'getRequisicao.is_ref');
      dm.setParam(aux, is_ref);
      dm.setParam(cmd, aux);
   end
   else
      dm.setParam(cmd, '');

   if ( faixaCodigo <> '') then
   begin
      aux := dm.getCMD('Estoque', 'getRequisicao.faixa');
      dm.setParam(aux, quotedStr(faixaCodigo+'%'));
      dm.setParam(cmd, aux);
   end
   else
      dm.setParam(cmd, '');

   if (qtTransf <> '') then
      aux := dm.getCMD1('estoque', 'getRequisicao.qtTransf', qtTransf)
   else
      aux := '/* qt_transf */';

   dm.setParam(cmd, aux);

   result := dm.getDataSetQ(cmd);

   f.gravaLog( intToStr(result.RecordCount) );
end;

procedure remItemDaRequisicao(is_planod, os, isRef:String; novaQt:integer);
var
  ds:TdataSet;
  cmd:String;
  qtAjuste:integer;
begin
   f.gravaLog('remItemDaRequisicao(is_planod:' + is_planod + ' os:' + os + ' is_ref:'+ isRef + ', novaQuant:' + intToStr(novaQt) + ')');

   cmd := dm.getCMD2('Estoque', 'osGetItemDspdi', is_planod, isRef);
   ds := dm.getDataSetQ(cmd);

   if (novaQt = 0) then
   begin
      qtAjuste := ds.fieldByName('qt_ped').AsInteger;

   // ajusta a quantidade
      if (os <> '') then
      begin
         cmd := dm.getCMD2('Estoque', 'osRemItemDocSep', os, ds.fieldByName('cd_ref').asString);
         dm.execSQL(cmd);
      end;

   // apagar o item da dspdi
      cmd := dm.getCMD2('Estoque', 'osRemItemDspdi', is_planod, isRef);
      dm.execSQL(cmd);

   end
   else
   begin
      qtAjuste := ds.fieldByName('qt_ped').AsInteger - novaQt;

   // ajusta a quantidade
      if (novaQt <> 0) then
         cmd := dm.getCMD3('Estoque', 'updateWmsDocSepItem', intToStr(novaQt), quotedStr(ds.fieldByName('seqOrdemSeparacao').AsString), quotedStr(ds.fieldByName('cd_ref').AsString))
      else
         cmd := dm.getCMD2('Estoque', 'osRemItemDocSep', ds.fieldByName('seqOrdemSeparacao').AsString, ds.fieldByName('cd_ref').AsString);

      dm.execSQL(cmd);


      cmd := dm.getCMD3('Estoque', 'altQtDspsi',  intToStr(novaQt), quotedStr(ds.fieldByName('is_planoD').AsString), quotedStr(ds.fieldByName('is_ref').AsString));
      dm.execSQL(cmd);
   end;

// devolver o estoque para o disponivel
   cmd := dm.getCMD3('Estoque', 'acertaQtReserva', intToStr(qtAjuste), ds.fieldByName('loja').AsString, ds.fieldByName('is_ref').AsString);
   dm.execSQL(cmd);

   ds.Free();
end;

function gerarReq(tb:TADOTable; uo_cd, uo, usuario:String;mostraNumero, ehReqDeVenda:Boolean; var ocoItens:TStringList;QT_DIAS_PEND:integer):String;
var
  cd_pes,is_planod,cmd, codTransacao,sq_opf,is_oper:String;
  lista:TStringList;
  is_movpd:integer;
  nItensReq, i:integer;
  incluiItem:boolean;
  estReqCD:integer;
begin
   nItensReq := 0;

   lista:= Tstringlist.Create();
   sq_opf := dm.getParamBD( 'osDeposito.sq_opfRequisicao', ''); //10000031  cod daTransacao integrada de requisicao
   codTransacao := '4';  // tipo de transacao

   try
      // obter o cd_pes
      cd_pes := fmMain.getCdPesLogado();

      is_oper := inserirToper(usuario, sq_opf, codTransacao, '');

      //obter o plano
      is_planod :=  dm.getContadorWell('is_planod');


       cmd :=  ' exec StoInsertPlanoDistribuição ' +#13+
                 '@DT_PLANOD=' + fdt.DateTimeToSqlDateTime(dateToStr(now), '')  +' , '+#13+
                 '@IS_PLANOD=' + is_planod +' , '+#13+
                 '@cd_usu=' + cd_pes       +' , '+#13+
                 '@is_oper='+ is_oper      +' , '+#13+
                 '@is_tpdoc=5'             +' , '+#13+
                 '@is_estoque='+ uo_cd +', ' +#13+
                 '@IS_EMP=10033585 , @ST_PD=''2'' , @TP_PLANOD=4 , @CDPES=0 ';
       lista.add(cmd);

       tb.First;
       i:=1;
       while (tb.Eof = false) do
       begin
          estReqCD := uEstoque.getEstoqueParaRequisicao(tb.fieldByname('is_ref').AsString, uo_cd);
          incluiItem := true;


// item sem estoque e sem ser de venda , nao faz requisicao
          if (tb.FieldByName('Qt Pedida').AsInteger >  estReqCD )  and ( ehReqDeVenda = false ) then
          begin
             ocoItens.Add(tb.fieldByName('codigo').AsString +' '+ tb.fieldByName('ds_ref').AsString  +  '  -  Não possui estoque disponível.');
             incluiItem := false;
          end;

          if (ehReqDeVenda = false) and (isReqPendProduto(uo_cd, uo, tb.fieldByname('is_ref').AsString, QT_DIAS_PEND).IsEmpty = false ) then
          begin
             ocoItens.Add(tb.fieldByName('codigo').AsString +' '+ tb.fieldByName('codigo').AsString  +  '  -  Existem requisições pendentes.');
             incluiItem := false;
          end;

          if (incluiItem = true) then
          begin
             inc(is_movpd);
             is_movpd := StrToInt( dm.getContadorWell('IS_movpd') );
             cmd := ' exec StoInsertItensPlanoDistribuição' +
                    ' @IS_MOVPD=' + IntToStr(is_movpd) +' , '+
                    ' @IS_ESTOQUE=' + uo +' , '+
                    ' @IS_REF=' + tb.fieldByName('is_ref').asString +' , '+
                    ' @DT_MOVPD=' +fdt.DateTimeToSqlDateTime(dateToStr(now), '' ) +' , '+
                    ' @IS_OPER=' + is_oper +' , '+
                    ' @IS_EMP=10033585'  +' , '+
                    ' @IS_PLANOD= ' + is_planod +' , '+
                    ' @NR_ITPD=' + intToStr(i)  +' , '+
                    ' @QT_PED=' + tb.fieldByName('Qt Pedida').asString+' , '+
                    ' @QT_PEND=0 ' +' , '+
                    ' @CD_GRDCOMPRAS=0,  @CD_GRDDISTRIBUICAO=0, @PC_QTDE=100, ' +
                    ' @QtdASeparar= ' + tb.fieldByName('Qt Pedida').asString+' , ' +
                    ' @QtdEmSeparacao=0 , @QtdSeparada=0 , @QtdNaoSeparada=0 , @QtdTransferida=0 , @ST_PD=''2'' , @AtualizaLancamentosEstoque=''S'' , @QtdCancelada=0 , @CD_CHV=''          '' ';
             lista.add(cmd);
             inc(i);
             inc(nItensReq);
          end;
          tb.Next;
       end;

      lista.SaveToFile(f.getDirLogs() + 'cmdReq.txt');
      if (nItensReq > 0) then
      begin
         for i:=0 to lista.Count-1 do
            dm.execSQL(lista[i]);

         if mostraNumero = true then
           msg.msgExclamation(' Gerada a requisição: ' + is_planod);

         result := is_planod;
      end
      else
      begin
          dm.execSQL('exec stoExcluirPlanoDistribuicao ' + is_planod);
          msg.msgErro(' Não foi gerada nenhuma requisição.');
          result := '';
      end;
   except
      on e:Exception do
      begin
         msg.msgErro('Ocorreu um erro: ' +#13+ e.Message);
         result := '';
      end
   end;

end;

function reqTransferida(req:String):boolean;
begin
   result := not(dm.getDataSetq( dm.getCMD1('req', 'isReqPendente', req) ).IsEmpty);
end;

procedure apagaRequisicao(numReq:String);
var
  qr :TADOQuery;
begin
   if (reqTransferida(numReq) = false) then
   begin
      qr:= TADoQuery.Create(nil);
      uReq.getItensReq(qr, numReq);

      qr.first();
      while ( qr.Eof = false ) do
      begin
         uReq.remItemDaRequisicao(
            qr.fieldByName('is_planoD').AsString,
            qr.fieldByName('seqOrdemSEparacao').AsString,
            qr.fieldByName('is_Ref').AsString,
            0
         );

         qr.Next();
      end;
      qr.Destroy();
   end
   else
      msg.msgErro(dm.getMsg('reqTemItensTansf'));

end;

procedure reqFromPedCliente(uo_cd, pedido, usuario:String);
var
  tb:TADOTable;
  cmd:String;
  oco_itens:TSTringlist;
begin
   oco_itens := TStringList.Create();

    dm.getTable(tb, dm.getCMD('req', 'getTbAbastec') );
    tb.Close();
    cmd := dm.getCMD2('req', 'getItPedToReq', tb.TableName, pedido);

    dm.execSQL(cmd);

    tb.Open();

    gerarReq(
       tb,
       uo_cd,
       tb.fieldByName('uo').AsString,
       usuario,
       true,
       true,
       oco_itens,
       30
    );

    tb.Close();
    tb.Destroy();
end;

procedure removeReqPendentes(ds:TDataset);
begin
	ds.First();
   while ( ds.Eof = false) do
   begin
      uReq.remItemDaRequisicao(
         DS.fieldByName('Requisição').AsString,
         DS.fieldByName('OS').AsString,
         DS.fieldByName('is_ref').AsString,
         0
      );
   DS.Next();
   end;
   DS.Close();
end;


procedure loadTableReq(tbName, uo, uo_cd, pc:String);
var
  cmd:String;
begin
   cmd :=
   dm.getCMD3('Estoque', 'loadTbReq', uo, uo_cd, pc);
   dm.setParam(cmd, tbName);
   dm.execSQL(cmd);
end;

procedure salvaItReqAbast(uo, is_ref, qt, qtMax, uo_cd:String);
var
   cmd:String;
begin
   cmd :=
   dm.getCMD5('req', 'salvaItTbReqabast',
      uo,
      uo_cd,
      is_ref,
      qt,
      qtMax,
   );

   dm.execSQL(cmd);
end;

procedure salvaReqAbastecimento(tb:TADOTable; uo, uo_cd:String);
var
   cmd:String;
begin
   f.gravaLog(' salvaReqAbastecimento()');
// remove s itens existentes
   cmd := dm.getCMD3('Estoque', 'delReqAbastLj', uo, uo_cd, '' );
   dm.execSQL(cmd);

   tb.First();
   while tb.Eof = false do
   begin
// insere os novos itens
      salvaItReqAbast(uo, tb.fieldByName('is_ref').asString, tb.fieldByName('Qt pedida').asString,
                      tb.fieldByName('Pedido Maximo').asString, uo_cd);


      tb.Next();
   end;
end;




end.
