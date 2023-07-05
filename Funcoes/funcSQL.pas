unit funcSQL;

interface
   uses ADODB,Classes, sysutils, Dialogs, forms, DBGrids,
        QGrids, fdt, mxExport, adLabelComboBox, windows, QStdCtrls, DB, Controls,
        messages, msg, ComObj, OleCtrls, variants;

   function criaTabelaTemporaria(conexao:TADOConnection; camposTabela:String):String;
   function delParamBD(nParametro, loja: String; conexao : TADOConnection):boolean;
   function execSQL(comando:string; connection: TADOConnection):boolean; overload;
   function executeSQL(comando:string; connection: TADOConnection):String;
   function executeSQLint(comando:string; connection: TADOConnection):integer;
   function exportacaoDeTabela(tb:TdataSet; tipoSaida:TmxExportType; estilo:TmxExportStyle; nomeArq:String):String;
   function getADODataSetQ(comando:String; conexao:TADOConnection):TADODataSet;
   function getCaixas(Connection:TADOConnection; uo:String; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean): Tstrings;
   function getContadorWell(conexao:TADOConnection; campo:String):String; overload;
   function getContadorWell(conexao:TADOConnection; campo:String; quantidade:integer):integer; overload;
   function getCustoPorData(uo,is_ref, data:String; conexao:TADOconnection):String;
   function getDataBd(conexao:TADOConnection; diasARecuar:integer):String; overload;
   function getDataSetQ(comando:String; conexao:TADOConnection):TDataSet; overload;
   function getDataSetQArq(arq:String; conexao:TADOConnection):TDataSet;
   function getDateBd(conexao:TADOConnection; diasARecuar:integer):TDate;
   function getDateTimeBd(conexao:TADOConnection; diasArecuar:integer):TdateTime;
   function getDsFromExcel(conexao:TADOConnection; arqXls:String):String;
   function getEmpregadosPonto(conexao:TadoConnection):TStrings;
   function getGruposWell(Connection : TADOConnection ):Tstrings;
   function getHint(nObjeto:String; conexao:TADOConnection):String;
   function getIdentity(conexao:TADOConnection):String;
   function getListagem(Comando:String;  idx:integer; Connection : TADOConnection):Tstringlist;
   function getListagemH(Comando:String; Connection : TADOConnection; isQuoted:boolean ):String;
   function getMediaDeUmaColuna(cnnection:TADOConnection; ds:TDataSet; coluna:String):String;
   function getNomeTableTemp():String;
   function getParamBD(nParametro, loja: String; conexao : TADOConnection):String;
   function getUsersList(conexao:TADOConnection; cmd:String):String;
   function getUsuariosPonto(Connection : TADOConnection):Tstrings;
   function getUsuariosWell(Connection : TADOConnection; Grupos,cd_usu:String  ):Tstrings;
   function getValoresSQL(Lista:Tstrings; Comando:String; Connection : TADOConnection):Tstrings;
   function getValoresSQL2(Comando:String; Connection : TADOConnection):Tstrings;
   function getValorWell(ExeOrOpen:char; Comando:String; CampoRetorno:String; Connection : TADOConnection):string;
   function insertParamBD(nParametro, loja, valor, descricao, estacao: String; conexao : TADOConnection):boolean;
   function isGrupoComRestricao(grupo:String; codTela:integer; conexao: TADOConnection):boolean;
   function isHoraPermitida(conexao:TADOConnection; tela:integer; grupo:String):boolean;
   function openQuery  (Conexao :TADOConnection; CampoInicio,CampoFim:Smallint; Comando:String):TStringList;
   function openSQL(comando, retorno:string; Connection : TADOConnection):String;
   function setParamBD(parametro, uo, valor:String; conexao:TADOConnection):boolean;
   function somaColQuery(Query:TADOQuery;Coluna:String; nDecimais:integer):String;
   function somaColTable(Table:TDataSet;Coluna:String; isFormatado:boolean):String; overload;
   function somaColunaTable(Table:TDataSet;Coluna:String):real; overload;
   function somaColunaTable(Table:TDataSet;Coluna:String;condicao:boolean):real; overload;
   function updateParamBD(nParametro, loja, valor, descricao, estacao: String; conexao : TADOConnection):boolean;

   procedure doQuery(conexao:TADOConnection; var qr:TADOQUery; cmd:String);
   procedure exportaConsulta(qr:TADOQuery;expParaAqquivo:boolean; nArquivo:String; tipo:TmxExportType );
   procedure exportaDataSet(ds:TDataSet);
   procedure exportaQuery(qr:TADOQuery;ExpParaAqquivo:boolean; nArquivo:String {; tipo:TmxExportType } );
   procedure exportaTable(tb:TADOTable);
   procedure getQuery (Connection : TADOConnection; var qr:TADOQuery; ComandoSQL:string); overload;
   procedure getQuery (Connection : TADOConnection; var qr:TADOQuery; ComandoSQL:string; timeOut:integer); overload;
   procedure getTable(Connection : TADOConnection; var tb:TADOTable; tbFields, nomeDaTabela:string); overload;
   procedure getTable(Connection : TADOConnection; var tb:TADOTable; tbFields:string); overload;
   procedure openTempTable(tb:TADOTable; descricaoDosCampos:String ; conexao:TADOConnection);
   procedure organizarQuery(var query:TADOQuery;Coluna:Tcolumn);
   procedure organizarTabela(var tabela:TADOTable;Coluna:Tcolumn );

   procedure setaCampoMoneyParaDuasCasas(ds:TdataSet; fieldName:String);


implementation
uses f;


function getNomeTableTemp():String;
var
  i:integer;
  j:integer;
begin
   randomize;
   i:= random(999);
   j:= random(999);
   result := '#'  + f.getNomeDaEstacao() +'_'+ inttostr(i) +'_'+ inttostr(j)+ '_pcf';
end;

function getContadorWell(conexao:TADOConnection; campo:String; quantidade:integer):integer; overload;
var
   cmd:String;
begin
   cmd :=
   ' begin declare @P1 int set @P1=0 exec stoObterContador ' +
   quotedStr(campo)+ ', @P1 output, @QtdContador= '+ intToStr(quantidade) +
   ' select @P1 as contador end';

   result:= strToInt(funcSql.GetValorWell( 'O', cmd, 'contador', conexao));
end;

function getContadorWell(conexao:TADOConnection; campo:String):String; overload;
begin
   result := intToStr(getContadorWell(conexao, campo, 0));
end;

function getParamBD(nParametro, loja: String; conexao : TADOConnection):String;
var
  ds:TdataSet;
  cmd:String;
begin
    cmd := 'Select valor from zcf_paramGerais where nm_param= ' + quotedStr(nParametro);
     if (loja <> '') then
       cmd := cmd + ' and uo = ' + quotedStr(loja);

    ds:= getDataSetq(cmd, conexao);

    if (ds.IsEmpty = false) then
       cmd := ds.Fields[0].AsString
    else
    begin
       insertParamBD(nParametro, loja, '', '', ' ', conexao);
       cmd := '';
       msg.msgErro('Não consegui ler o parametro de BD: ' +nParametro+#13+'Erros de execução do programa poderão ocorrer.');
       f.gravaLog(#13+'Parametro: ' + nParametro + ' não existe.' +#13 );
   end;
   ds.free;
   result := cmd;
end;

function delParamBD(nParametro, loja: String; conexao : TADOConnection):boolean;
var
   cmd:String;
begin
   cmd := 'delete from zcf_paramGerais where nm_param = ' + quotedStr(nParametro);
   if (loja <> '') then
      cmd := cmd + ' and uo = ' + quotedStr(loja);
   result := execSQL(cmd, conexao);
end;

function isGrupoComRestricao(grupo:String; codTela:integer; conexao: TADOConnection):boolean;
var
  cmd:String;
begin
   cmd := getParamBD('gruposRestritosTela', intToStr(codTela), conexao);
   cmd := 'Select top 01 cd_grusu as cod from dsgrusu (nolock) where cd_grusu = ' + grupo + 'and cd_grusu in (' + cmd + ')';

   if openSql(cmd, 'cod', conexao) = grupo then
      result := true
   else
      result := false;
end;

function getDataSetQ(comando:String; conexao:TADOConnection):TDataSet;
var
   qr:TADOQuery;
   lst:TstringList;
begin
   qr := TADOQuery.Create(nil);
   qr.Connection := Conexao;
   qr.CommandTimeout := 0;
   qr.SQL.Add(comando);
   qr.Open;
   result := qr;
end;

function getDataSetQArq(arq:String; conexao:TADOConnection):TDataSet;
var
   qr:TADOQuery;
   lst:TstringList;
begin
   qr := TADOQuery.Create(nil);
   qr.Connection := Conexao;
   qr.CommandTimeout := 0;
   qr.SQL.LoadFromFile(arq);
   qr.Open;
   result := qr;
end;

function getADODataSetQ(comando:String; conexao:TADOConnection):TADODataSet;
var
   qr:TADODataSet;
begin
   f.gravaLog(comando);
   qr := TADODataSet.Create(nil);
   qr.Connection := Conexao;
   qr.CommandTimeout:=0;
   qr.CommandText := comando;
   qr.Open;
   result := qr;
end;

procedure getTable(Connection : TADOConnection; var tb:TADOTable; tbFields, nomeDaTabela:string); overload;
var
   nTable:String;
begin
   // cria uma tabela e retorna ela com stato Open
   //

   if ( Assigned(tb) = false ) then
      tb := TADOTable.Create(nil);

   if (nomeDaTabela = '' )then
   begin
	   nTable := getNomeTableTemp();
   	execSQL( 'create table ' + nTable + ' ( ' + tbFields +' ) ', Connection);

	   if (tb.TableName <> '') then
   	   tb.close();

      tb.TableName := nTable;
   end
   else
   begin
   	execSQL( ' if not exists (select top 1 * from sysobjects where name=' + quotedStr(nomeDaTabela) + ')' +
					' create table ' + nomeDaTabela + ' ( ' + tbFields +' )', Connection);
      tb.TableName := nomeDaTabela;
   end;
   tb.Connection := Connection;
   tb.Open;
end;

procedure getTable(Connection: TADOConnection; var tb:TADOTable; tbFields:string);
begin
	getTable(Connection, tb, tbFields, '');
end;

procedure doQuery(conexao:TADOConnection; var qr:TADOQUery; cmd:String);
begin
   qr := TADOQuery.Create(nil);
   qr.Connection := conexao;
   qr.CommandTimeout := 0 ;
   qr.SQL.Add(cmd);
   qr.Open;
end;

function getUsuariosWell(Connection : TADOConnection; Grupos,cd_usu:String  ):Tstrings;
var
  aux:tstrings;
  query:TadoQuery;
begin
   query := Tadoquery.Create(Connection);
   query.Connection := Connection;
   query.SQL.Clear;

   if cd_usu = '' then cd_usu := '-1';
   if Grupos = '' then Grupos := '-1';

   query.SQL.Add('Select nm_usu, cd_usu from  dsusu with(nolock) where ( cd_grusu in ('+Grupos+') or cd_usu in ('+ cd_usu +')      ) and fl_ativo = 1 order by nm_usu');
   query.Open;

   aux := TstringList.create();
   while query.Eof = false do
   begin
      aux.add(f.preencheCampo(100,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   result := aux;
   query.Close;
   query.Free;
end;

function getUsuariosPonto(Connection : TADOConnection):Tstrings;
var
  aux:tstrings;
  query:TadoQuery;
begin
   query := Tadoquery.Create(Connection);
   query.Connection := Connection;
   query.SQL.Clear;
   query.SQL.Add('Select nm_usu, cd_usu from  dsusu with(nolock) where cd_usu in (select cd_usu from zcf_PontoAutorizadores ) and fl_ativo = 1 order by nm_usu');
   query.Open;

   aux := TstringList.create();
   while query.Eof = false do
   begin
      aux.add(f.preencheCampo(100,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   result := aux;
   query.Close;
   query.Free;
end;

function getCaixas(Connection:TADOConnection; uo:String; IncluirLinhaTodas:Boolean; IncluiNenhuma:Boolean ): Tstrings;
var
   query:tadoquery;
   aux:tStrings;
begin
   query := Tadoquery.Create(Connection);
   query.Connection := Connection;
   query.SQL.Clear;
   query.SQL.Add('select descEstacao, codCaixa from caixas with(noLock) where numportaCMC7 is not null and codloja = ' + uo + ' order by descEstacao');
   query.Open;

   aux := TstringList.create();

   if IncluirLinhaTodas = true then
     aux.Add(' Todas ');

   if IncluiNenhuma = true then
     aux.Add(' Nenhuma ');

   query.First;
   while query.Eof = false do
   begin
      aux.add(f.preencheCampo(50,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   Result := aux;
   query.Destroy;
end;

function getValorWell(ExeOrOpen:char; Comando:String; campoRetorno:String; Connection : TADOConnection):string;
var
  query:TADOQuery;
begin
   query := TADOQuery.Create(Connection);
   query.Connection := Connection;
   query.SQL.Clear;
   query.SQL.Add(comando);
   query.CommandTimeout := 0;

   try
      if CampoRetorno = '@@identity' then
         ExeOrOpen := 'E';

      if (UpperCase( ExeOrOpen ) = 'E') then
         query.ExecSQL
      else
        query.Open;

      if (campoRetorno <> '') and (campoRetorno <> '@@error') and (campoRetorno <> 'rows') and (campoRetorno <> '@@identity')then
      begin
         if (query.FieldByName(campoRetorno).AsString <> '' ) then
            result :=  query.FieldByName(Trim(campoRetorno)).AsString
         else
            result :=  '';
      end;

      if (CampoRetorno = '@@error') then
      begin
         query.SQL.Clear;
         query.SQL.Add('Select @@error');
         query.Open;
         result := query.Fields[0].AsString;
      end;

      if campoRetorno = 'rows' then
      begin
         f.gravaLog('Linhas afetadas:' + intTostr(query.RowsAffected));
         result :=  intTostr(query.RowsAffected);
      end;

      if (campoRetorno = '@@identity') then
         result := getIdentity(Connection);

      if (campoRetorno = '') then
         result := query.Fields[0].AsString;

   except
      on e:exception do
      begin
         if( pos('was deadlocked on lock', e.Message) > 0 )then
				result := 'deadLock'
         else
			if( pos('Violation of PRIMARY KEY', e.Message) > 0 )then
	         result := 'keyViolation'         
         else
				msg.msgErro('Erro ao executar o comando,o erro é:' + e.Message);

         if (campoRetorno = 'rows') then
         	result := '0';

         if (campoRetorno = '@@error') then
         begin
            if( pos('Violation of PRIMARY KEY', e.Message) > 0 )then
               result := 'keyViolation'
         end;
      end;
   end;
  query.Free();
end;

function openQuery (Conexao :TADOConnection; CampoInicio,CampoFim:Smallint; Comando:String):TStringList;
var
   query:tadoquery;
   i:integer;
   resultado:TStringList;
   aux:string;
begin
   query := Tadoquery.Create(Conexao);
   query.Connection := Conexao;
   query.SQL.Clear;
   query.SQL.Add(comando);

   query.Open;
   Resultado := TStringList.Create();
   query.First;
   while query.Eof = false do
   begin
      aux := '';
      for i:= campoInicio to campofim do
         if i <= query.FieldCount -1 then
         aux:= aux + query.Fields[i].Asstring;

      Resultado.Add(aux);
      query.Next;
   end;
   result :=  resultado;
end;

function execSQL(comando:string; connection: TADOConnection):boolean; overload;
begin
   result := (getValorWell('e', comando, '@@error', connection) = '0');
end;

function executeSQL(comando:string; connection: TADOConnection):String;
begin
   result := getValorWell('e',comando, '@@error', connection);
end;

function executeSQLint(comando:string; connection: TADOConnection):integer;
begin
   result := strToInt(getValorWell('e', comando, 'rows', connection));
end;

procedure getQuery(Connection : TADOConnection; var qr:TADOQuery; ComandoSQL:string); overload;
begin
   getQuery(Connection, qr, ComandoSQL, Connection.CommandTimeout);
end;

procedure getQuery (Connection : TADOConnection; var qr:TADOQuery; ComandoSQL:string; timeOut:integer); overload;
begin
   if (qr = nil) then
      qr := TADOQuery.Create(nil);

   qr.SQL.Clear();
   qr.Connection := connection;
   qr.CommandTimeout := timeOut;
   qr.SQL.Add(ComandoSQL);
   qr.open;
end;

function somaColQuery(Query:TADOQuery;Coluna:String; nDecimais:integer):String;
var
   aux:real;
begin
   Query.First;
   aux := 0;
   while Query.Eof = false do
   begin
      aux := aux + Query.fieldByName(coluna).AsFloat;
      Query.Next;
   end;
   Result := floattostrf( aux , ffNumber, 18, nDecimais);
end;

function somaColunaTable(Table:TDataSet;Coluna:String;condicao:boolean):real; overload;
var
   aux:real;
   i:integer;
begin
  if (table <> nil) then
   begin
      Table.First;
      aux := 0;
		for i:=1 to Table.RecordCount do
      begin
         aux := aux + table.fieldByName(coluna).AsFloat;
         table.Next;
      end;
      table.First();
      result := aux;
   end
   else
      result := 0;
end;

function somaColunaTable(Table:TDataSet;Coluna:String):real; overload;
begin 
   result := somaColunaTable(table, coluna, true);
end;

function somaColTable(Table:TDataSet;Coluna:String; isFormatado:boolean):String; overload;
var
   aux:real;
begin
  f.gravaLog('somaColTable (String)');
  aux := funcsql.somaColunaTable(table, Coluna, true);
  if isFormatado = true then
     Result := floattostrf( aux, ffNumber, 18, 2)
  else
     Result := floatToStr(aux);
end;

function getListagem(Comando:String; idx:integer; Connection : TADOConnection):Tstringlist;
var
   ds:TdataSet;
   aux:Tstringlist;
begin
    aux := TStringList.Create;

    ds:= getDataSetq(comando, Connection);

    ds.First;
    while (ds.Eof = false) do
    begin
       aux.Add(ds.Fields[idx].AsString );
       ds.Next;
    end;

  f.gravaLog(ds, '')  ;

    ds.free();
    result := aux;
end;

function getListagemH(Comando:String; Connection : TADOConnection; isQuoted:boolean ):String;
var
  lista:TstringList;
  aux:String;
  i:integer;
begin
   lista := getListagem(Comando, 0, Connection);
   if (isQuoted = false) then
   begin
      for i:=0 to lista.Count-2 do
         aux := aux + lista[i] + ', ';
      aux := aux +lista[lista.count-1];
   end
   else
   begin
      for i:=0 to lista.Count-2 do
         aux := aux + quotedStr(lista[i]) + ', ';
      aux := aux + QuotedStr( lista[lista.count-1] ) ;
   end;
   lista.Destroy();
   result := aux;
end;

function getValoresSQL2(Comando:String; Connection : TADOConnection):Tstrings;
var
   Query:TADOQuery;
   i:integer;
   lista:Tstringlist;
begin
   Lista := Tstringlist.Create();
   Query := TADOQuery.Create(connection);
   query.Connection := Connection;
   query.CommandTimeout := 0;
   query.SQL.Clear;
   Query.SQL.add(comando);
   Query.Open;
   query.First;

   for i:=0 to query.FieldCount-1 do
      Lista.Add( query.Fields[i].AsString);
   Result := Lista;
end;

function getValoresSQL(Lista:Tstrings; Comando:String; Connection : TADOConnection):Tstrings;
var
   Query:TADOQuery;
   i:integer;
begin
   Lista := Tstringlist.Create();
   Query := TADOQuery.Create(connection);
   query.Connection := Connection;
   query.CommandTimeout := 0;
   query.SQL.Clear;
   Query.SQL.add(comando);
   Query.Open;
   query.First;

   for i:=0 to query.FieldCount-1 do
      Lista.Add( query.Fields[ i ].AsString);
   Result := Lista;
end;

procedure organizarTabela(var tabela:TADOTable;Coluna:Tcolumn);
begin
   tabela.tag := tabela.tag * -1;
   if tabela.Tag < 0  then
   begin
      tabela.Tag := -1;
      tabela.Sort := '['+Coluna.FieldName+']';
   end
   else
   begin
      tabela.Tag := 1;
      tabela.Sort := '['+Coluna.FieldName+'] DESC';
   end;
end;

procedure organizarQuery(var query:TADOQuery;Coluna:Tcolumn);
begin
   query.tag := query.tag * -1;
   if query.Tag < 0  then
   begin
      query.Tag := -1;
      query.Sort := '['+Coluna.FieldName+']';
   end
   else
   begin
      query.Tag := 1;
      query.Sort := '['+Coluna.FieldName+'] DESC';
   end;
end;

function openSQL(comando,retorno:string; Connection : TADOConnection):String;
begin
    result := getValorWell('O', comando, retorno, connection);
end;

procedure exportaQuery(qr:TADOQuery;expParaAqquivo:boolean; nArquivo:String {; tipo: TmxExportType} );
begin
   exportaConsulta(qr, ExpParaAqquivo, nArquivo, xtExcel);
end;

procedure exportaConsulta(qr:TADOQuery;expParaAqquivo:boolean; nArquivo:String; tipo:TmxExportType);
var
   export:TmxDataSetExport;
begin
   export := TmxDataSetExport.Create(nil);
   export.ExportType := tipo;
   export.DataSet := qr;

   if ExpParaAqquivo = true then
   begin
      export.ExportStyle := xsFile;
      export.ExportType := xtExcel;
      export.FileName := nArquivo;
   end
   else
      export.ExportStyle := xsView;
   export.Execute;
end;

function exportacaoDeTabela(tb:TdataSet;  tipoSaida:TmxExportType;  estilo:TmxExportStyle; nomeArq:String):String;
var
   export1:TmxDataSetExport;
begin
   export1 := TmxDataSetExport.Create(nil);
   with export1 do
   begin
      TempDir := f.getDirLogs();
      ExportType := tipoSaida; { [xtHTML,xtExcel,xtWord,xtTXT,xtCSV,xtTAB,xtRTF,xtDIF,xtSYLK,xtClipboard] }
      DataSet :=  tb;
      ExportStyle := estilo; {xsView, ou xsFile}


      FileName := TempDir + 'MAX' + intToStr(Random(9999));

      Options := [xoShowProgress, xoUseAlignments, xoRowNumbers, xoShowHeader];
      Execute;
   end;
   nomeArq := export1.NativeExcel.FileName;
   f.gravaLog('function exportacaoDeTabela:'+ nomeArq);
   export1.Free();
   result := nomeArq;
end;

procedure exportaTable(tb:TADOTable);
begin
   f.gravaLog('Arquivo exportado:' + exportacaoDeTabela(tb, xtExcel, xsView, ''));
end;

procedure exportaDataSet(ds:TDataSet);
var
   export:TmxDataSetExport;
begin
   export := TmxDataSetExport.Create(nil);
   export.ExportType := xtExcel;
   export.DataSet :=  ds;
   export.ExportStyle := xsView;
   export.Execute;
end;

function getCodUo(cbox:TadLabelComboBox):string;
begin
   result := f.SohNumeros(copy(cbox.items[cbox.itemIndex],50,100));
end;
{
function devolucaoDeProduto(is_ref,uo,usuario,codCli,is_emp,nLista,sq_opf,tipoPreco, srNota:string; valor:real; Conexao:TADOConnection):boolean;
var
  codUsuADM,empresa, numNF ,strValor, is_lanv, {is_mov, is_nota, is_oper, is_movi, is_docv, cmd,str, dataDev, codEmp, codLoja, nmUser:string;
  lista:TStringList;
  is_doc, tp_doc, auxInserirDoc:array[1..3]of String;
  qt_sldatu, custoU:real;
  i:integer;
  valorDoSaldo, qt_mov, sq_dlest, vl_custocont,  custoM, custoMu:string;
  is_lanc: TStringList;
begin
   is_lanc := Tstringlist.create();

   qt_sldatu := 0;
   strValor := f.ValorSql( floatToStr(valor));
   tp_doc[1] := 'N';  tp_doc[2] := 'T';   tp_doc[3] := 'D';
   lista := TStringList.Create();

   dataDev := funcSql.getDataBd(conexao, 0);

// pegar o codigo da empresa
   empresa := funcSql.GetValorWell( 'O', 'exec StoListarEmpresas', 'cd_uo',  conexao );

// pegar o codigo da loja e transformar em is_ref
   is_ref := funcSql.GetValorWell( 'O', 'Select is_ref from crefe where cd_ref  = ' + quotedStr(is_ref), 'is_ref',  conexao );

//pegar o codigo da uo
   codEmp := funcSql.GetValorWell( 'O', 'Select top 01 cd_uo as codEmp from tbuo where is_uo = ' + uo, 'codEmp',  conexao );

// pegar o codigo da loja para a dsadi
   codLoja := funcSql.GetValorWell( 'O', 'Select top 01 cd_uo as codLoja from tbuo where is_uo = ' + uo,  'codloja', conexao );

//  usuario
   nmUser := funcSql.GetValorWell( 'O', 'Select top 01 nm_usu from dsusu where cd_pes = ' + usuario, 'nm_usu', conexao );

// codigo usuario adm
   codUsuADM := funcSql.GetValorWell( 'O', 'Select top 01 P_cod_usu from dsusu where cd_usu = ' + usuario, 'P_cod_usu', conexao );

//   pegar o is_lanv
   str:= 'is_lanv';
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''' +str+ ''', @P1 output, 0   select @P1 as '+str+ ' end ';
   is_lanv := funcSql.GetValorWell( 'O', cmd, str,  conexao );

  //   pegar o is_movi
   str:= 'is_movi';
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''' +str+ ''', @P1 output, 0   select @P1 as '+str+ ' end ';
   is_movi := funcSql.GetValorWell( 'O', cmd, str,  conexao );

//pegar os is_doc
   for i:=1 to 3 do
   begin
      str:= 'is_doc';
      cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''' +str+ ''', @P1 output, 0   select @P1 as '+str+ ' end ';
      is_doc[i] := funcSql.GetValorWell( 'O', cmd, str,  conexao );
   end;

// obter o numero da nota fiscal que sera utilizada
   str:= 'numNF';
   cmd := ' begin declare @P1 int  set @P1=0  exec zcf_stoObterNumNF ' + uo + ' , ' + quotedStr(srNota) + ' , @P1 output   select @P1 as '+str+ ' end ';
   numNF := funcSql.GetValorWell( 'O', cmd, str,  conexao );

//  pegar os is_lanc
   for i:=1 to 3 do
   begin
      str:= 'is_lanc';
      cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''' +str+ ''' , @P1 output , 0 select @P1 as '+str+ ' end ';
      is_lanc.Add(funcSql.GetValorWell( 'O', cmd, str,  conexao ) )
   end;

// pegar o is_docv
   str:= 'is_docv';
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''' +str+ ''', @P1 output, 0   select @P1 as '+str+ ' end ';
   is_docv := funcSql.GetValorWell( 'O', cmd, str,  conexao );


//   pegar o is_nota
   str:= 'is_nota';
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ' +str+ ' , @P1 output, 0   select @P1 as '+str+ ' end ';
   is_nota := funcSql.GetValorWell( 'O', cmd, str,  conexao );


//   pegar o is_oper
   str:= 'is_oper';
   cmd := ' begin declare @P1 int  set @P1=0    exec stoObterContador ''' +str+ ''', @P1 output, 0   select @P1 as '+str+ ' end ';
   is_oper := funcSql.GetValorWell( 'O', cmd, str,  conexao );
// iserir o valor na toper                   exec StoInsertTOPER @IS_OPER= 5295320,@DT_OPER='2009-05-09 00:00:00',@IS_EMP= 10033585,@SQ_OPF= 10000013,@DT_TRAB='2009-05-09 09:12:52',@CD_USUARIO= 10035469,@CodTransacao=Null,@CodUsuAutWMS=Null
   cmd := 'Exec stoInsertToper @is_oper = ' + is_oper + ' ,'+#13+
           '@DT_OPER= ' + fdt.DateTimeToSqlDateTime(dateToStr(now), '') + ' ,'+#13+
           '@IS_EMP= 10033585 , @SQ_OPF=10000168' + ' ,'+#13+
           '@DT_TRAB= ' + fdt.DateTimeToSqlDateTime(dateToStr(now),timeToStr(now))  + ' ,'+#13+
           '@CD_USUARIO= '+ usuario + ' , @CodTransacao=Null , @CodUsuAutWMS=Null ' ;
   lista.Add(cmd);


// inserir os documentos
   auxInserirDoc[1] := 'N';
   auxInserirDoc[2] := 'D';
   auxInserirDoc[3] := 'T';
   for i :=1 to 3 do
   begin
	    cmd := ' exec StoInsertDocumento '   +
              '  @IS_FILIAL= ' + uo +
              ' , @IS_DOC= ' + is_doc[i] +
              ' , @CD_PES= ' + codCli +
              ' , @IS_OPER= '+ is_oper  +
              ' , @DT_LANC=' + dataDev  +
              ' , @DT_EMISS=' + dataDev  +
              ' , @CD_USU= ' + usuario +
              ' , @IS_EMP= '+ is_emp+
              ' , @FL_TPDOC=' + quotedStr( auxInserirDoc[i]) +
              ' , @NR_DOCORI= 0,@SR_DOCORI=''0         '',@IS_REMESSACONT=Null' ;
      lista.Add(cmd);
   end;

// inserir na dsdocR
   for i:=2 to 3 do
   begin
       cmd := ' exec stoInserirDSDOCR  ' +
              '   @IS_FILIAL= '+ uo +
              ' , @IS_DOC= '+  is_doc[i] +
              ' , @IS_FILIALREF= ' + uo +
              ' , @IS_DOCREF= ' +is_doc[1] ;
       lista.Add(cmd);
   end;

// inserir o alor da dnota
   CMD := ' Exec stoInsertDNOTA ' +
          ' @IS_NOTA = ' + is_nota +
          ' , @CD_CCT = 0 ' +
          ' , @IS_DOC = '+ is_doc[1] +
          ' , @IS_ESTOQUE = ' + uo +
          ' , @CD_CFO = 9999' +
          ' , @IS_OPER = '+ is_oper +
          ' , @CD_OBS = 0' +
          ' , @CD_USU = ' + usuario +
          ' , @IS_FILDEST = null, @IS_ESTDEST = null, @DT_CANC = null ' +
          ' , @DT_DIG = '+ dataDev +
          ' , @DT_EMIS = '+ dataDev +
          ' , @DT_ENTSAI = '+  dataDev +
          ' , @CD_EVECTB ='''' , @CD_CX = null , @CD_TIPV = 0' +
          ' , @NR_DOCF = ' +  numNF +
          ' , @NR_PED = 0, @PC_DESC = 0, @SR_DOCF = ''GE'' ' +
          ' , @ST_NF = '''', @ST_TRAM=NULL, @TP_NFV=NULL, @VL_DESC=0, @VL_JURO=0'+
          ' , @VL_NOTA = '+ strValor +
          ' , @VL_TOT = ' + strValor +
          ' , @CD_VEND =0, @NR_DOCVEN = null, @TP_DOCVEN=D' + #13+
          ' , @CD_PES = ' + codCli +
          ' , @FL_DNOTB = null, @FL_DNOTC=null, @FL_DNOTD=null, @VL_BSICMSFNt=null' +
          ' , @VL_ICMSFNT=null, @VL_FRETE=0, @VL_SEGURO=0, @VL_DSPACES=0, @VL_DSPEXTRA=0'+
          ' , @VL_BSIPI=0, @VL_IPI=0, @VL_AGREGADO=0, @FL_IPIAPOSDESC=0'+
          ' , @IS_EMP = '+ is_Emp +
          ' , @TP_PRECO = '+ tipoPreco +
          ' , @CD_MVE=0, @FL_MENSAL=null, @NR_DIASPARC=null' +
          ' , @TP_MVE = null, @FL_FINPROPRIO = null, @FL_PARIG =null, @FL_PROM = null ' +
          ' , @PC_JUROS =null, @VL_COEF = null, @NR_DIAENT = null , @PC_ENTMIN =null ' +
          ' , @NR_PARC = null, @FL_ENTRADA=1, @TP_EMIS=0, @VL_ICMSFRETE=0, @ValorBaseIcmsSubstituido=0 ' +
          ' , @ValorBaseIcmsAntecipado=0, @ValorBaseIcmsReduzido=0, @ValorBaseIcmsDiferido=0'+
          ' , @ValorIcmsSubstituido=0, @ValorIcmsAntecipado=0' +
          ' , @ValorIcmsReduzido=0, @ValorIcmsdiferido=0, @TipoPrecoSugerido=101, @ValorDescontoItens=0 '+
          ' , @ImprimiuAcrescimo=0, @ValorResidualDescontoItens=0'+
          ' , @SerieECF=null, @NumeroECF=mull, @GeradaPeloSistema=0, @ValorPercentualDesconto=0 '+
          ' , @Observacao = ''devolucao de produtos da lista  ' +nLista + ''' '   +
          ' , @SeqOrdemSeparacao = null, @DescontoIcms = null, @NumeroSelo =null ' +
          ' , @SerieSelo=null, @NumeroDoECF=null, @NumeroFormulario=null '+
          ' , @MotivoDevolucao = ''Dev itens lista'' ' +
          ' , @DataSeloAntecipacao=null, @UOPagto='+uo+ ' , @ValorBaseComissao=0, @SeqFator=0 '+
          ' , @fator=0, @ValorOriginal=0';
    lista.Add(cmd);

// inserir os valores de icms da nota
    cmd := 'exec StoInsertDNOTC ' +
           '   @IS_ESTOQUE= '+ uo +
           ' , @IS_NOTA= ' + is_nota +
           ' , @NR_ITEM= 1, @PC_ICM= 0 , @TP_ENTSAI=Null , @TP_ICM= 2 ' +
           ' , @VL_BASE= '+ strValor +
           ' , @VL_BASFRE=Null , @VL_FRE=Null  '+
           ' , @VL_ICM= 0 ' +
           ' , @VL_IPI=Null , @ValorSubstituido=Null , @BaseSubstituida=Null ';
    lista.Add(cmd);

// inserir na dmovi


//    cmd := getStrInsertDmovi( sq_dlest,  is_doc[1], is_movi, uo, codCli, is_oper, is_ref, dataDev, is_nota, usuario, numNf, strValor, is_emp, sq_opf, is_lanc );
{
   cmd := ' exec stoInsertDMOVI '+
          '   @IS_MOVI = '+ is_movi +
          ' , @IS_ESTOQUE = ' + uo +
          ' , @CD_PES = '+ codCli +
          ' , @IS_TPCTE = 6 ' +
          ' , @IS_OPER = '+ is_oper +
          ' , @IS_REF = '+is_ref +
          ' , @DT_MOVI = '+ dataDev +
          ' , @IS_NOTA = '+ is_nota +
          ' , @CD_USU = '+usuario +
          ' , @CD_VEND = null ' +
          ' , @DT_DIG = '+ dataDev +
          ' , @DT_EMIS ='+ dataDev +
          ' , @FL_VPROM = '''' '+
          ' , @NR_DOCF = ' + numNF +
          ' , @NR_ITEM = 1' +
          ' , @NR_PEDF = 0 , @FT_CONV = 1, @PC_DESC = 0 , @PC_IPI = 0 '+
          ' , @PR_TABELA = '+ strValor +
          ' , @QT_BON = 0 , @QT_DESP =0 , @QT_MOV = 1 '+
          ' , @SR_DOCF = ''GE'' ' +
          ' , @ST_MOV = '''' , @VL_COMIS = 0, @VL_DESC = 0, @VL_JURO=0, @VL_PESO=0, @PC_ICM=0 '+
          ' , @VL_MOVEST = ' + strValor +
          ' , @TP_ICM = 2' +
          ' , @VL_ITEM = ' + strValor +
          ' , @VL_RATEIOAG =0, @QT_EMB=1'+
          ' , @CL_DOCMOV = 1 , @NR_DOCMOV = 0 , @CL_DOCREF = 0 , @NR_DOCREF = null '+
          ' , @IS_EMP = ' + is_emp +
          ' , @SQ_OPF = ' + sq_opf +
          ' , @IS_DOC = ' + is_doc[1] +
          ' , @VL_CUSTOVEND = 0 '+
          ' , @SQ_DLEST = '+ sq_dlest + //is_lanc[1]**** +
          ' , @VL_CUSTOCONT=0, @QT_SLDATU=0 '+
          ' , @VL_SLDATU =0 ' +
          ' , @IS_LANC = '+ is_lanc[1] +
          ' , @IS_LANC1 = '+ is_lanc[2] +
          ' , @IS_LANC2 = '+ is_lanc[3] +
          ' , @PercIcmsReducao =0 , @PercIcmsAgregacao = 0' +
          ' , @ValorBaseIcms =0 , @PercIcmsVendaEntrada =0' +
          ' , @CodCFO = ''9999''' +
          ' , @ValorFiscalDocumento = 0, @ValorIcms = 0' +
          ' , @SitTributariaTabelaA = ''0'', @SitTributariaTabelaB = ''0'', @VL_DESCRAT =0' +
          ' , @IS_UOORIGEM = '+ uo +
          ' , @IS_MOVIORIGEM = '+ uo +
          ' , @ValorJurosRateado =0 '+
          ' , @ValorPrecoSugerido = '+strValor +
          ' , @TipoPrecoSugerido = 101' +
          ' , @PrecoUnitarioLiquido = '+strValor +
          ' , @ValorResidualDesconto = 0 '+#13+
          ' , @IS_TPMVE = 6, @ValorIPI = 0' +
          ' , @IS_ESTOQUE_Destino = '+ uo +
          ' , @PrecoUnitarioFornecedor = 0'+
          ' , @VL_BSIPI=0, @CodVendedor2=0'+
          ' , @DescIcmsRat=0, @CodigoSituacaoTributaria=null, @VL_MOVESTCU=null, @FL_CALCCU=null ';

   lista.Add(cmd);

// inserir na tabela de vendas da loja
   cmd := ' exec StoInsertDDOCV ' +
          '   @IS_FILIAL= ' + uo +
          ' , @IS_DOCV= ' + is_docv +
          ' , @NR_PED= 0 ' +
          ' , @IS_OPER= '+ is_oper +
          ' , @CD_PES= ' + codCli +
          ' , @DT_VENDA= ' + dataDev +
          ' , @IS_FILIALDEST= '+ uo +
          ' , @IS_TPCTV=Null, @IS_TPMVV=Null, @PC_DESCONTO= 0 ' +
          ' , @ST_VENDA=Null, @TP_NFV=Null, @VL_AGREGADO= 0,@VL_DESCONTO= 0 '+
          ' , @VL_FRETE= 0, @VL_JURO= 0'+
          ' , @VL_VENDA= ' +   strValor +
          ' , @DT_FATURAMENTO = '+ dataDev+
          ' , @CD_TIPV=Null,@CD_VEND=Null,@IS_NOTA=Null,@FL_EXTERNO=Null,@CD_MVE=Null '+
          ' , @FL_MENSAL=Null,@NR_DIASPARC=Null,@TP_MVE=Null,@FL_FINPROPRIO=Null,@FL_PARIG=Null'+
          ' , @FL_PROM=Null,@PC_JUROS= 0,@VL_COEF=Null,@NR_DIAENT=Null,@PC_ENTMIN=Null '+
          ' , @NR_PARC=Null,@FL_ENTRADA=1,@NR_DOCVEN=Null,@VL_ENTRADA=Null' +
          ' , @TP_DOCVEN=''D'''+
          ' , @IS_DOC= '+is_doc[1] +
          ' , @CODCONVENIADA=Null,@CodFuncionarioConveniada=Null,@NumAutorizacaoConvenio=Null ' +
          ' , @VendaSubsidiada=Null,@ValorDescontoItens= 0,@TipoPrecoSugerido=Null '+
          ' , @ImprimiuAcrescimo=Null,@ValorResidualDescontoItens=Null ' +
          ' , @ValorProdutos= ' + strValor +
          ' , @DescontoIcms= 0 ';
   lista.Add(cmd);

// inserir na dlanv
   cmd := ' exec StoInsertDLANV '+
           '   @SeqFilial= '+ uo +
           ' , @IS_LANV= ' + is_lanv +
           ' , @is_ref= '+ is_ref +
           ' , @IS_DOCV='+ is_docv +
           ' , @is_Oper= '+ is_oper +
           ' , @IS_MOVI= '+ is_movi +
           ' , @CD_VEND=Null,@PC_DESCONTO= 0 '+
           ' , @PR_TABELA= ' + strValor +
           ' , @qt_mov= 1  ' +
           ' , @VL_COMIS= '+ strValor +
           ' , @VL_CUSVEND= 0, @VL_DESCONTO= 0,@VL_MEDVEND= 0,@VL_RATEIOAGREG= 0,@TP_PRECO= 0 '+
           ' , @VL_VENDA= ' + strValor +
           ' , @PR_VENDA= ' + strValor +
           ' , @VL_RATEIODESC= 0,@VL_RATEIOFRETE= 0 ' +
           ' , @VL_CUSTOCONT= '+ strValor +
           ' , @ValorJurosRateado= 0,@ValorPrecoSugerido= 0,@TipoPrecoSugerido= 0 '+
           ' , @PrecoUnitarioLiquido= ' + strValor +
           ' , @ValorResidualDesconto= 0,@ValorRateioPercDesconto= 0,@DescIcmsRat= 0 ';
   lista.Add(cmd);

   cmd := 'update dlest set qt_sldatu = ' + floatToStr(qt_sldatu + 1)     +
                            ' , vl_custoVend = null '                      +
                            ' , vl_mov = ' +   ValorSql(FloatToStr(valor))              +
                            ' , custounitario = ' + valorSql(FloatToStr(custoU))        +
                            ' , custoMedioUnitario = ' + valorSql(custoM)   +
                            ' , custoMedioUnitarioUnico = ' + custoMU +
                            ' , vl_custocont = ' +    vl_custocont +
                            ' , vl_sldatu = ' + valorDoSaldo +
                            ' Where is_lanc = ' + is_lanc[1];
    lista.Add(cmd);

// inserrir o adiantamento
   cmd := ' EXEC SP_INC_DSADI ' +
          '   @COD_EMP = '+ empresa +
          ' , @COD_EST = 1 , @CONTABILIZ = '''' '+
          ' , @DAT_ADI = ' + dateToInteiro(dataDev) +
          ' , @DAT_PRE = 0, @HISTORICO = ''Gerado pelo programa das listas nota  '+srNota +'-'+ numNF  + ' ''' +
          ' , @ID_ADI = '''' ' +
          ' , @NUM_CLI = ' +  codCli +
          ' , @OPC_CTADEB = '''''+
          ' , @TIP_ADI = ''D'' ' +
          ' , @VAL_ADI = ' + strValor +
          ' , @CTA_CREDIT = 0 , @CTA_DEBITO = 0, @INTERV_CRE = 0, @INTERV_DEB = 0, @CTA_GFI = 0 ' +
          ' , @LOJA_ORIGEM = ' + codLoja +
          ' , @VAL_CALC = ' + strValor +
          ' , @IS_OPER = '+ is_oper +
          ' , @COD_USU = '+ quotedstr(codUsuADM)  +
          ' , @COD_USU_AUTOR = '''', @VAL_DESP = 0 ' ;
    lista.add(cmd);

//    lista.SaveToFile('c:\zComandosDEvolucaoLista.txt');
    for i:=0 to lista.Count-1 do
      funcSql.execSQL(lista[i], Conexao);
end;
}


function getgruposWell(Connection : TADOConnection ):Tstrings;
var
  aux:tstrings;
  query:TadoQuery;
begin
   query := Tadoquery.Create(Connection);
   query.Connection := Connection;
   query.SQL.Clear;
   query.SQL.Add('Select nm_grusu, cd_grusu from dsgrusu with(nolock) order by nm_grusu') ;
   query.Open;

   aux := TstringList.create();
   while query.Eof = false do
   begin
      aux.add(f.preencheCampo(100,' ','D',query.Fields[0].AsString) +query.Fields[1].AsString );
      query.Next;
   end;
   result := aux;
   query.Close;
   query.Free;
end;


function criaTabelaTemporaria(conexao:TADOConnection; camposTabela:String):String;
var
   nTable :String;
begin
   nTable := funcsql.getNomeTableTemp;

   if ( pos('(' , trim(copy(camposTabela, 01, 02))) <= 0 ) then
      camposTabela := '( ' + camposTabela + ' )';

   execSQL( 'create table ' +nTable +  camposTabela, conexao );

   result := nTable;
end;

function isHoraPermitida(conexao:TADOConnection; tela:integer; grupo:String):boolean;
var
   qr:TdataSet;
   hour:integer;
   isPermitido:Boolean;
   str:String;
begin
   //  se a hora atual estiver dentro to intervalo de bloqueio, nao deixa
   //  gerar o relatório.


   isPermitido := true;
   hour := StrToInt(openSQL('Select DATEPART ( hour , getdate()) as hora', 'hora', conexao ) );


   qr:= getDataSetQ('Select codTela, codgrupo, horI, horF from  zcf_horBloqRel (nolock) where codTela = ' + intToStr(tela)  + ' and codGrupo = ' + grupo, conexao );

   if qr.IsEmpty  = false then
   begin
      qr.First;
      while qr.Eof = false do
      begin
         if ( hour >= qr.FieldByName('horI').asInteger ) and( hour <= qr.FieldByName('horF').asInteger ) then
         begin
            isPermitido := false;
            break;
         end;
         qr.Next;
      end;

      if isPermitido = false then
      begin
         qr.First;
         while qr.Eof = false do
         begin
            str := str+ '       De ' +  qr.FieldByName('horI').asString + ':00 as ' + qr.FieldByName('horf').asString+':00. '+#13;
            qr.Next;
          end;
          str := ' Esse relatório é bloqueado para geração nos seguintes horários: ' + #13 + str;
          qr.Close;
          msg.msgErro(str);
      end;
   end;
   result := isPermitido;
   qr.Free();
end;


procedure openTempTable(tb:TADOTable; descricaoDosCampos:String; conexao:TADOConnection);
var
   nTable, cmd:String;
begin
   if tb.TableName <> '' then
      tb.close;
   nTable := funcSQl.getNomeTableTemp;
   tb.Connection := conexao;
   cmd := ' Create table ' + nTable +  '( ' +  descricaoDosCampos+ ' )';
   funcsql.execSQL(cmd, conexao);
   tb.TableName := nTable;
   tb.Open;
end;

function getUsersList(conexao:TADOConnection; cmd:String):String;
var
   qr:TADOQuery;
   continua:Boolean;
   aux:String;
begin
   qr := TADOQuery.Create(nil);
   getQuery( conexao, qr, cmd);
   continua := not(qr.IsEmpty);
   aux := '';
   while continua = true do
   begin
      aux := aux + qr.Fields[0].AsString;
      qr.Next();
      if qr.Eof = false then
         aux := aux + ', '
      else
         continua := false;
   end;
   qr.Destroy();
   result := aux;
end;

function getEmpregadosPonto(conexao:TadoConnection):TStrings;
var
   qr:TADOQuery;
   lst:TstringList;
begin
  getQuery(conexao, qr, 'select nome, cartaoponto from zcf_pontoEmpregados (nolock) order by nome' );
  lst := TStringList.Create();
  qr.First();
  while( qr.Eof = false ) do
  begin
     lst.Add (f.preencheCampo(100,' ','D', qr.fieldByname('nome').asString ) + qr.fieldByname('cartaoPonto').asString );
     qr.Next();
  end;
  qr.Destroy();
  result := lst;
end;

function getDataBd(conexao:TADOConnection; diasARecuar:integer):String; overload;
begin
   result:= dateToStr(getDateBd(conexao, diasARecuar));
end;


function getDateBd(conexao:TADOConnection; diasARecuar:integer):TDate; overload;
var
  ano, mes, dia:word;
  dt:TdateTime;
begin
   dt:= getDateTimeBd(conexao, diasARecuar);
   SysUtils.DecodeDate( dt, ano, mes, dia);
   result := EncodeDate(ano, mes, dia);
end;

function getDateTimeBd(conexao:TADOConnection; diasArecuar:integer):TdateTime;
var
  ds:TdataSet;
begin
// retorna a data e hora em formato dd/mmm/aaa hh:mm:ss
   ds:= getDataSetQ('select getdate() - ' +intToStr(diasArecuar) + ' as dataHora', conexao);
   result := ds.fieldByname('dataHora').asDateTime;
   ds.Free();
end;

function setParamBD(parametro, uo, valor:String; conexao:TADOConnection):boolean;
var
   cmd:String;
begin
   if getParamBD(parametro, uo, conexao) <> '' then
      cmd := ' update zcf_paramGerais set valor = ' +  quotedstr(valor) + ' where nm_param = ' + quotedstr(parametro) + ' and  uo = ' + quotedstr(uo)
   else
      cmd := ' insert zcf_paramGerais (valor, nm_param, uo ) values ('+quotedstr(valor) +', '+ quotedstr(parametro) + ' , ' +quotedstr(uo) + ')';
   result :=    execSQL(cmd,conexao);
end;

function getHint(nObjeto:String; conexao:TADOConnection):String;
begin
   result := openSQL('Select hint from zcf_hints where nome = ' + quotedStr(nObjeto), 'hint', conexao );
end;

function getMediaDeUmaColuna(cnnection:TADOConnection; ds:TDataSet; coluna:String):String;
begin
   result := floatToStr( somaColunaTable( ds, coluna) / ds.RecordCount) ;
end;

function getCustoPorData(uo,is_ref, data:String; conexao:TADOconnection):String;
var
   cmd:String;
begin
   if ( strToDate(data) <> now ) then
   begin
      cmd := ' Select top 01 custoUnitario from dlest (nolock)' +
             ' inner join toper on dlest.is_oper = toper.is_oper'+
             ' where is_ref = ' + is_ref +
             ' and toper.dt_trab  <= ' + fdt.dateToSqlDate(data) +
             ' and is_estoque = ' + uo +
             ' order by is_movi desc';
       cmd := openSQL(cmd, 'custoUnitario', conexao ) ;
   end
   else
   begin
      cmd :=  ' Select top 01  custoUnitario from dlest (nolock)' +
              ' inner join toper on dlest.is_oper = toper.is_oper where is_ref = ' + is_ref +
              ' and custoUnitario > 0 rder by is_movi desc ';
      cmd := openSQL(cmd, 'custoUnitario', conexao ) ;
   end;

   if( cmd = '' )then
      cmd := '0';
   result := cmd;
end;


function insertParamBD(nParametro, loja, valor, descricao, estacao:String; conexao:TADOConnection):boolean;
var
   cmd:String;
begin
   cmd := 'insert zcf_paramGerais (nm_param, uo, valor, obs, estacao) values(' + quotedStr(nParametro) +', '+
          quotedStr(loja)      +', '+
          quotedStr(valor)     +', '+
          quotedStr(descricao) +', '+
          quotedStr(estacao)   +') ';
   result := execSQL(cmd, Conexao);
end;

function updateParamBD(nParametro, loja, valor, descricao, estacao: String; conexao : TADOConnection):boolean;
begin
   delParamBD(nParametro,loja,conexao);
   insertParamBD( nParametro, loja, valor, descricao, estacao, conexao);
end;

function getIdentity(conexao:TADOConnection):String;
begin
   result := openSQL('Select @@identity', '', conexao);
end;

function getDsFromExcel(conexao:TADOConnection; arqXls:String):String;
const
	xlCellTypeLastCell = $0000000B;
var
	grid: TStringGrid;
	XLApp, Sheet: OLEVariant;
	RangeMatrix: Variant;
	x, y, k, r: Integer;

   Campos:String;
   tb:TADOTable;
   i, l,c :integer;
begin
	try
   	grid := TStringGrid.Create(nil);

      //Cria Excel- OLE Object
      XLApp:=CreateOleObject('Excel.Application');
      try
         //Esconde Excel
         XLApp.Visible:=False;
         //Abre o Workbook
         XLApp.Workbooks.Open(arqXls);
         Sheet:=XLApp.Workbooks[ExtractFileName(arqXls)].WorkSheets[1];
         Sheet.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
         //Pegar o número da última linha
         x:=XLApp.ActiveCell.Row;
         //Pegar o número da última coluna
         y:=XLApp.ActiveCell.Column;
         //Seta Stringgrid linha e coluna
         grid.RowCount:=x;
         grid.ColCount:=y;
         //Associaca a variant WorkSheet com a variant do Delphi
         RangeMatrix:=XLApp.Range['A1', XLApp.Cells.Item[X, Y]].Value;
         //Cria o loop para listar os registros no TStringGrid
         k:=1;
         f.gravaLog('Lendo registros do arquivo');
         repeat
            for r:=1 to y do
               grid.Cells[(r - 1),(k - 1)]:= RangeMatrix[K, R];
            Inc(k,1);
         until k > x;
         f.gravaLog('Registros lidos' + intToStr(k));

         RangeMatrix:=Unassigned;
      finally
         //Fecha o Excel
         if not VarIsEmpty(XLApp) then
            begin
	            XLApp.Quit;
	            XLAPP:=Unassigned;
	            Sheet:=Unassigned;
            end;
      end;

   	// criar os campos da tabela
      for i:=0 to y-1 do
      	if (trim(grid.Cells[i,0]) <> '' ) then
	         campos := campos +'['+ grid.Cells[i,0] + ']' + ' char(50), '
         else
   	      campos := campos  +'[col'+ intToStr(i) +']'+  ' char(50), ';


    	if (trim(grid.Cells[y,0]) <> '' ) then
	      campos := campos  +'['+  grid.Cells[y, 0]  +']'+  ' char(50)'
      else
	      campos := campos  +'[col'+ intToStr(y) +']'+  ' char(50)';

// campos extras para colocar as referencias e quantidades.
		campos := 'Linha int identity (1,1), is_ref int, qt_mov varchar(7), ' + campos;

      funcSQL.getTable(conexao, tb, Campos);

      f.gravaLog('grid, Linhas: ' + intToStr(grid.RowCount) + ' colunas:' + intToStr(grid.ColCount) );
      f.gravaLog('tb Colunas: '+ intToStr(tb.FieldCount));

      f.gravaLog('Inserindo os registros da tabela temporaria...');
      for l:= 1 to grid.RowCount-2 do
      begin
        	tb.Append();

      	for c:=0 to tb.FieldCount-4 do
         begin
				tb.Fields[c+3].AsString := grid.Cells[c, l];
         end;

			tb.Post();
		end;
      f.gravaLog('Inserindo os registros da tabela temporaria... OK' + intToStr(k));

      result := tb.TableName;
      tb.Close();
      tb.Free();
      grid.Free;
	except
   	on e:exception do
      begin
      	msg.msgErro('Erro ao tentar ler a planilha');
         result := '';
      end;
   end;
end;

procedure setaCampoMoneyParaDuasCasas(ds:TdataSet; fieldName:String);
var
   aux:real;
   i:integer;
begin
   ds.First();
   for i:=0 to ds.RecordCount do
   begin
      aux := ds.fieldByName(fieldName).AsCurrency;
      ds.Edit();
      ds.fieldByName(fieldName).AsString :=
      floattostrf( aux, ffNumber, 18, 2);
      ds.Post();
      ds.Next();
   end;
end;



end.


