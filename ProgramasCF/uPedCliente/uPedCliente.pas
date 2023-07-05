unit uPedCliente;


interface

   uses db, ADODb, dialogs, Controls, SoftDbGrid;

   function aprovaPedidoPendente(ped, cd_pes:String):boolean;
   function atualizavlPed(uo, pedido:String; valor:real):boolean;
   function getDadosPedCliente(numPedido:String):TdataSet;
   function insereItem(dsPed:TdataSet; pcUnd:real; is_ref,qt:String):boolean;

   procedure carregaItensPedido(tbItens:TADOTAble; dsItens:TdataSource; grid:TSoftDbGrid; nPedido:String);
   procedure geraReqCD(numPed, uoCD:String);
   procedure getPedClienteParaAprovacao(uo, cd_pes:String; acessoTotal:boolean);
   procedure visualizaValorFator();

implementation

uses uDm, f, fdt, msg, SysUtils;


function getDadosPedCliente(numPedido:String):TdataSet;
begin
   result := dm.getDataSetQ( dm.getCMD1('pedCliente', 'consulta', numPedido) );
end;

function aprovaPedidoPendente(ped, cd_pes:String):boolean;
var
  cmd:String;
begin
   cmd := dm.getCMD('pedCliente', 'aprovar');
   dm.setParam(cmd, cd_pes);
   dm.setParam(cmd, fdt.dateToSqlDate(dm.getDateBd()));
   dm.setParam(cmd, ped);

   result := dm.execSQL(cmd);
end;

procedure getPedClienteParaAprovacao(uo, cd_pes:String; acessoTotal:boolean);
var
  dia:integer;
  ds:TdataSet;
  ped, erro:String;
begin
   dia := fdt.getdiaDaSemana(dm.getDateBd() );
   if ( (dia <> 1) and (dia <> 7) ) and (  acessoTotal = false) then
      msg.msgErro( dm.getMsg('pedcliente.errDia') )
   else
   begin
      ped := msg.msgInput(dm.getMsg('pedcliente.getNumPed'), '');
      ped := f.soLetrasNumerosPositivos(ped);

      if (ped = '' ) then
         msg.msgErro( dm.getMsg('pedcliente.naoExiste'))
      else
      begin
         ds := getDadosPedCliente(ped);

         if (ds.IsEmpty = true) then
            erro := dm.getMsg('pedcliente.naoExiste');

         if (ds.FieldByName('is_uo').AsString <> uo) then
            erro := erro + dm.getMsg('pedcliente.uoDif');

         if ((ds.FieldByName('tipoBloqueio').AsString = '') or (ds.FieldByName('tipoBloqueio').AsString = 'L')) then
            erro := erro + dm.getMsg('pedcliente.NaoBloqueado');

         if (ds.FieldByName('st').AsString <> 'P') then
            erro := erro + dm.getMsg('pedcliente.NaoPendente');

         if (erro = '') then
         begin
            erro := dm.getMsg('pedcliente.dadosPed');

            dm.setParams(erro, ds.fieldByName('Pedido').asString, ds.fieldByName('Loja').asString, ds.fieldByName('cliente').asString);
            dm.setParam( erro, f.floatToStrFomatado(ds.fieldByName('Vl Pedido').asFloat, false))  ;

            if (msg.msgQuestion(erro) = mrYes) then
               if aprovaPedidoPendente(ped, cd_pes) = true then
               msg.msgExclamation(dm.getMsg('pedcliente.pedAprovado'));
         end
         else
            msg.msgErro(erro);
      end;

   end;
   ds.free();
end;


procedure geraReqCD(numPed, uoCD:String) ;
begin

//

end;

procedure carregaItensPedido(tbItens:TADOTAble; dsItens:TdataSource; grid:TSoftDbGrid; nPedido:String);
var
   cmd:String;
begin
   dm.getTable(tbItens, dm.getCMD('pedCliente', 'getTbDecPed'));
   tbItens.Close();

   cmd :=  dm.getCMD2('pedCliente', 'getItensTbDescPed', tbItens.TableName, nPedido );
   dm.execSQL(cmd);

   tbItens.Open();
   dsItens.DataSet := tbItens;

   grid.Refresh();
   f.ajGridCol(grid, tbItens, 'und', 50, 'Und');
   f.ajGridCol(grid, tbItens, 'origem', 80, 'origem');
   grid.columns[tbItens.FieldByname('seq').index].visible := false;
   grid.columns[tbItens.FieldByname('is_ref').index].visible := false;
   grid.columns[tbItens.FieldByname('codLoja').index].visible := false;
end;

function atualizavlPed(uo, pedido:String; valor:real):boolean;
var
   cmd:String;
begin //
   cmd := dm.getCMD3('pedCliente', 'AtuDadosPed', f.valorSql(valor), uo, pedido);
   result := dm.execSQL(cmd);
end;

function insereItem(dsPed:TdataSet; pcUnd:real; is_ref,qt:String):boolean;
var
   seqItPed, cmd:String;
   tItem:real;
   codVend:String;
begin
   codVend := dsPed.fieldByName('codVendedorAtual').AsString;
   if (codVend = '0') then
      codVend := dm.openSQL(dm.getCMD1('pedCliente', 'getVendedor', dsped.fieldByName('Pedido').asString), '' );


   seqItPed := dm.getContadorWell('SeqItemPedido');

   tItem := pcUnd * strToFloat(qt);

   cmd := dm.getCMD('pedCliente', 'insItem');


   dm.setParams(cmd,
      dsPed.fieldByName('is_uo').AsString,
      seqItPed,
      dsPed.fieldByName('Pedido').AsString,
   );

   dm.setParams(cmd,
      codVend,
      is_ref,
      qt
   );

   dm.setParams(cmd,
      f.valorSql(tItem),
      f.valorSql(pcUnd),
      dsPed.fieldByName('TipoPrecoSugerido').AsString
   );

   dm.setParams(cmd,
      f.valorSql(pcUnd),
      fdt.dateToSqlDate(dsPed.fieldByName('data').AsDateTime),
      dsPed.fieldByName('is_uo').AsString,
   );

   dm.setParams(cmd,
      qt,
      '',
      '',
   );
   f.gravalog(cmd);
   dm.execSQL(cmd);

 // atualiza a cabeça do pedido

   atualizavlPed(
      dsPed.fieldByName('is_uo').AsString,
      dsPed.fieldByName('Pedido').AsString,
      (dsPed.fieldByName('vl Pedido').AsFloat + tItem)
   );
{}
   result := true;
end;

procedure visualizaValorFator();
var
   cmd, nPedido:String;
   tbItens:TADOTable;
   dataSource:TdataSource;
   grid : TSoftDbGrid;
   vl:Real;
begin
   nPedido := msg.msgInput('Informe o número do pedido', '6317008');

   tbItens := TADOTable.create(nil);
   dataSource := TdataSource.Create(nil);
   grid := TSoftDbGrid.Create(nil);
   grid.DataSource := dataSource;
   dataSource.DataSet := tbItens;


   if (trim(nPedido) <> '' )then
   begin
      carregaItensPedido(tbItens, dataSource, grid, nPedido);

      tbItens.First();
      while (tbItens.Eof = false) do
      begin
         vl := vl+ tbItens.fieldByName('qt').AsFloat * tbItens.fieldByName('custoFator').AsFloat;
         tbItens.Next();
      end;

      cmd := dm.getCMD2('Msg', 'mostraVlFator', nPedido, ' R$:'+f.floatToStrFomatado(vl, false) );

      msg.msgExclamation(cmd);
  end;

  tbItens.Free();
  dataSource.Free();
  grid.Free();
end;

end.
