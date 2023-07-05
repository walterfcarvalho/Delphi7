unit uDBClass;

interface

uses
  ADODB, DB, classes, SysUtils, GrFingerXLib_TLB, ActiveX, Controls,
  dialogs, QForms;

//const
  // the database we'll be connecting to
type
  // Class TTemplate
  // Define a type to temporary storage of template
  TTemplate = class

    public
      // Template data.
      tpt:        PSafeArray;
      // Template size
      size:       Integer;
      // Template ID (if retrieved from DB)
      id:         Integer;

      // Allocates space to template
      constructor Create;
      // clean-up
      destructor Destroy; override;
  end;

  TDBClass = class

  private
    dsBatidas: TADOQuery;
    // a data set to mantain all templates of database
    dsTemplates: TADODataSet;
    // Template object used to get a template from database.
    tptBlob: TTemplate;

  public
    function ativaEmpregado(matricula:String):boolean;
    function addTemplate(template: TTemplate; mat,lado,nome, cartao:string): Integer;
    function deletaEmpregado(matricula:String):boolean;
    function getAutorizadores():Tstrings;
    function getCadastroDeEmpregados(localizacao:String):TdataSet;
    function getDadosFuncionarios(localizacao:String): Tstrings;
    function getDataSetQ(ComandoSQL:string):TdataSet;
    function getDataHoraBD():String;
    function getDate():Tdate;
    function getDetalheEmpregado(cartaoPonto:String):TdataSet;
    function getJustificativas():TstringList;
    function getNextTemplate(): TTemplate;
    function getNomeLojasPonto(mostraOpcTodas, mostraNenhum:boolean): Tstrings;
    function getNomeMatPorLocalizacao(localizacao: String): TdataSet;
    function getTemplate(id: Integer) : TTemplate;
    function getTemplates():boolean;
    function GetTempoAposUltBatida(cartao:String):integer;
    function getUserAutorizador():TStringList;
    function getUserAutorizadorPonto(listaJustificativas:boolean):String;
    function isDigitalCadastrada(matricula, lado:String):boolean;
    function insereEmpregado(empresa,matricula,cartaoPonto, nome,funcao, dataAdmissao, isHoraFlexivel, horario, localizacao, dataDemissao:String):boolean;
    function insereRegistroFerias(tipo, matricula: String; dtI, dtF:TDate):boolean;
    function isAtivo(data, matricula: string): boolean;
    function isCadastroEmpOk(cartaoPonto:String):boolean;
    function isConnected():boolean;
    function isDiaBaseFolga(matricula:String; data:Tdate):boolean;
    function isDSTemplateClosed():boolean;
    function isFeriado(data, cartaoPonto:String):boolean;
    function isAtzAbn(codJust:string):boolean;
    function isJustificado(matricula, ocorrencia:String; data:Tdate; var tpJust, obsJust, jusUsuario, LjDajust:String ):String;
    function isPontoCadastrado(cartaoPonto:String):boolean;
    function justificar(mat, just, data1, data2, tipo, hora1,hora2, ocorr,Cartao,DtLancamento,Obs,banco,Estabelecimento,loja, diaGeradorFolga, autorizador:string):String;
    function lerParametroBD(parametro:String):String;
    function numRegistros():integer;
    function openDB(): boolean;
    function registraPonto(data, Hora, cartao,loja:string):boolean;
    function setParamBD(parametro, uo, valor:String):boolean;
    function removeCadastroDigital(cartaoPonto, lado:String):boolean;
    function listaJustificativas(mat, di:String):TdataSet;
    procedure beginTemplates();
    procedure clearDB();
    procedure closeDB();
    procedure criaTbResumo(var Table:TADOTAble);
    procedure deletajustificativa(numJustificativa:String);
    procedure getQuery(var qr:TADOQuery; ComandoSQL:string);
    procedure getTable(var tb:TADOTable; tbFields:string);
    procedure preencheListaDosDias(var tabela:TADOTable; dti,dtf:Tdate; pegaDiaAtual:boolean);
    function getOcorrencias():Tstrings;

end;

implementation

uses f, fdt, funcSQL, uDm;


function TDBClass.openDB(): boolean;
begin
  try
     dsTemplates := TADODataSet.Create(nil);
     tptBlob := TTemplate.Create();
     dsBatidas := TADOQuery.Create(nil);
     dsTemplates.Connection :=  dm.con;
     dsBatidas.Connection := dm.con;

  except
     openDB := false;
  end;
end;

// Default constructor
constructor TTemplate.Create();
var
  Bounds: array[0..0] of TSafeArrayBound;
begin
  // Allocate memory for template and initialize its size to 0
  Bounds[0].lLbound := 0;
  Bounds[0].cElements := GR_MAX_SIZE_TEMPLATE;
  tpt := SafeArrayCreate(VT_UI1, 1, Bounds);
  size := 0;
end;

// Default destructor
destructor TTemplate.Destroy();
begin
  // free resources
  FreeMemory(tpt);
end;


// Close conection
procedure TDBClass.closeDB();
begin
{   dsTemplates.Close();
   dsBatidas.Close();
   dsTemplates.Free();
   tptBlob.Free();
   connection.Close();
   connection.Free();
   connection := nil;
}
end;

// Clear the database
procedure TDBClass.clearDB();
begin
end;

// Add template to database. Returns added template ID.
function TDBClass.addTemplate(template: TTemplate; mat, lado, nome, cartao:string): Integer;
var
  rs: TADODataSet;
  tptStream: TMemoryStream;
  id: Integer;
  p: PChar;

begin
  // get DB data and append one row
  rs := TADODataSet.Create(nil);
  rs.Connection :=  dm.con; //connection;
  rs.CommandTimeout := 0;
  rs.CursorType := ctStatic;
  rs.LockType := ltOptimistic;
  rs.CommandText := dm.getCMD('emp', 'getdsDigitais');

  rs.Open();
  rs.Append();
  tptStream := TMemoryStream.Create();
  // write template data to memory stream.
  SafeArrayAccessData(template.tpt, pointer(p));
  tptStream.write(p^, template.size);
  SafeArrayUnaccessData(template.tpt);
  // save template data from memory stream to database.
  rs.FieldByName('id').asString := f.preencheCampo(8,'0','E', mat);
  rs.FieldByName('lado').asString := lado;
  rs.FieldByName('nome').asString := NOME;
  (rs.FieldByName('template') as  TBlobField).LoadFromStream(tptStream);
  rs.FieldByName('cartao').asString := cartao;

  // update the database with added template.
  rs.post();
  // get the ID of enrolled template.
  id := rs.FieldByName('ID').AsInteger;
  // close connection
  tptStream.Free();
  rs.Close();
  rs.Free();
  addTemplate := id;
{}
end;

// Start fetching all enrolled templates from database.
function TDBClass.getTemplates():boolean;
begin
   try
      gravaLog('TDBClass.getTemplates()');
      dsTemplates.CacheSize := 15000;
      dsTemplates.CursorLocation := clUseClient;
      dsTemplates.CursorType := ctOpenForwardOnly;
      dsTemplates.LockType := ltReadOnly;
      dsTemplates.CommandText :=  dm.getCMD('emp', 'getDigitais'); {zcf_PontoCadDigitais}
      dsTemplates.Open();
      dsTemplates.BlockReadSize := 15000;
      gravaLog('TDBClass.getTemplates() result = true');
      result := true;
   except
      on  e: exception do
      begin
         gravaLog('TDBClass.getTemplates() result = false');
         result := false;
      end;
  end;
end;


// Returns template with supplied ID.
function TDBClass.getTemplate(id: Integer): TTemplate;
Var
  template: TTemplate;
begin
  dsTemplates.Close();
  dsTemplates.Connection := dm.con; //connection;
  dsTemplates.CursorType := ctDynamic;
  dsTemplates.LockType := ltReadOnly;
  dsTemplates.CommandText := 'SELECT * FROM  zcf_PontoCadDigitais WHERE ID = ' + IntToStr(id); {zcf_PontoCadDigitais}
  // Get query response
  dsTemplates.Open();
  // Deserialize template and return it
  template := getNextTemplate();
  dsTemplates.Close();
  getTemplate := template;
end;

// Return next template from dataset
function TDBClass.getNextTemplate(): TTemplate;
Var
  tmp: String;
  p: PChar;
begin
  // No results?
  if dsTemplates.Eof then
  begin
    tptBlob.size := -1;
    getNextTemplate := tptBlob;
  end else
  begin
    // Get template ID from database
    tptBlob.id := dsTemplates.FieldByName('cartao').AsInteger;
    // Get template data from database as string.
    tmp := dsTemplates.FieldByName('template').AsString;
    // Get template size from database.
    tptBlob.size := length(tmp);
    // Move template data from temporary string
    // to template object.
    SafeArrayAccessData(tptBlob.tpt, Pointer(p));
    Move(PChar(tmp)^, p^, tptBlob.size);
    SafeArrayUnaccessData(tptBlob.tpt);
    // move foward in the list of templates
    dsTemplates.Next();
    getNextTemplate := tptBlob;
  end;
end;

procedure TDBClass.beginTemplates;
begin
    dsTemplates.First;
end;

function TDBClass.registraPonto(data, hora, cartao, loja:string):boolean;
var
   cmd :String;
begin
   cmd := dm.getCMD3('bat', 'gravar', fdt.dateTimeToSqlDateTime(data, hora), cartao, loja);
   result := dm.execSQL(cmd);
end;

function TDBClass.numRegistros: integer;
begin
   result := dsTemplates.RecordCount;
end;

function TDBClass.getUserAutorizador(): TStringList;
var
   users:TDataSet;
   lstUser:Tstrings;
var
   ds:TDataSet;
   aux:TStringList;
   cmd: String;
begin
   cmd :=
   'Select distinct dsusu.nm_usu, aut.cd_usu, dsusu.sn_ope from zcf_PontoAutorizadores aut ' +
   'inner join dsusu on aut.cd_usu = dsusu.cd_usu';

   ds := funcSQL.getDataSetQ(cmd, dm.con);
   aux := TStringList.Create();
   while ds.Eof = false do
   begin
      aux.add(f.preencheCampo(50, ' ', 'D', ds.fieldByName('nm_usu').AsString) +
              f.preencheCampo(50, ' ', 'D', ds.fieldByName('cd_usu').AsString) +
              f.preencheCampo(10, ' ', 'D', ds.fieldByName('sn_ope').AsString)
             );
      ds.Next();
   end;
   ds.free();
   result := aux;
end;

function TDBClass.GetTempoAposUltBatida(cartao: String): integer;
begin
end;

function TDBClass.getCadastroDeEmpregados(localizacao:String):TdataSet;
var
   cmd:String;
begin
   cmd := dm.getCMD1('emp', 'getCadastros', f.bolToStr(true) );
   result := dm.getDataSetQ(cmd);
end;

function TDBClass.listaJustificativas(mat, di:String):TdataSet;
var
   cmd:String;
begin
   cmd := dm.getCMD3('jus', 'consulta', quotedStr(mat), fdt.dateToSqlDate(di), ''  );
   result := dm.getDataSetQ(cmd);
end;

procedure TDBClass.deletaJustificativa(numJustificativa: String);
begin
   dm.execSQL( dm.getCMD1('jus', 'deleta', numJustificativa));
end;

function TDBClass.isFeriado(data, cartaoPonto:String):boolean;
var
   cmd:String;
begin
   cmd := 'select data from zcf_pontoFeriados where ' +
          '(data = ' + fdt.DateTimeToSqlDateTime(data, '') + ' and localizacao in '+
          '(select localizacao from zcf_pontoEmpregados where cartaoPonto  = ' + QuotedStr(cartaoPonto) + ' ) ) ';
   result := ( (funcsql.openSQL(cmd, 'data', dm.con {connection} ) <> '') or ( DayOfWeek(strToDate(data)) = 1)   );
end;

function TDBClass.getAutorizadores():Tstrings;
var
   ds:TDataSet;
   aux:TStringList;
begin
   aux := TStringList.Create();
   ds :=  funcsql.getDataSetQ('select d.nm_usu, u.cd_usu from zcf_pontoAutorizadores U inner join dsusu d on u.cd_usu = d.cd_usu order by d.nm_usu', dm.con { connection} );
   while ds.Eof = false do
   begin
      aux.add(
             f.preencheCampo(100,' ' ,'D', ds.fieldByName('nm_usu').AsString) +
             f.preencheCampo(10,' ' ,'D', ds.fieldByName('cd_usu').AsString)
             );
      ds.Next();
   end;
   ds.Destroy();
   result := aux;
end;


function TDBClass.isAtivo(data, matricula: string): boolean;
var
   isAtivo,isAfastado:boolean;
   cmd:String;
begin
// verificando se estava registrado naquele dia.
   cmd := ' Select top 01 matricula from zcf_pontoEmpregados where matricula = '+ quotedStr(matricula) + ' and dataAdmissao  <= ' + fdt.dateToSqlDate(data) ;
   isAtivo := ( funcsql.openSQL(cmd, 'matricula', dm.con ) <> '' );
   gravaLog(' Verificando se está ativo: ' + BoolToStr(isAtivo,true) );

// verificando se existe afastamento.
   cmd := ' Select matricula from zcf_pontoAfastamentos where ( matricula = ' + quotedStr(matricula) + ' and '+ fdt.DateTimeToSqlDateTime(data,'') + ' >= dataInicio  and '+fdt.DateTimeToSqlDateTime(data,'') +' <= dataFim ) or ( matricula = ' + quotedStr(matricula) +' and  dataFim is null )';
   isAfastado := ( funcsql.openSQL(cmd, 'matricula', dm.con ) <> '' );
   GravaLog( data + ' Verificando se está afastado ou de ferias: ' + BoolToStr(isAfastado,true) );
   GravaLog( 'funcao isativo: ' + BoolToStr( (( isAtivo = true ) and (isAfastado = false)) , true ) );
   result := ( ( isAtivo = true ) and (isAfastado = false) );
end;

function TDBClass.isAtzAbn(codJust:string):boolean;
var
   cmd:String;
begin
   cmd := funcSql.openSQL( dm.getCMD1('jus', 'isAtzAbn', codJust), 'JustAbonaAtraso', dm.con);

   if ( cmd = 'True') then
   begin
      f.gravaLog('consulta no BD, Justificativa Abona atraso.');
      result := true;
   end
   else
   begin
      f.gravaLog('consulta no BD,  Justificativa nao abona atraso.');
      result := false;
   end;
end;


function TDBClass.isJustificado(matricula, ocorrencia:String; data:Tdate ; var tpJust, obsJust, jusUsuario, ljDaJust:String):String;
var
   cmd:String;
   ds:TdataSet;
begin
	cmd :=
	dm.getCMD4('jus', 'consulta2',
   	matricula,
		fdt.DateTimeToSqlDateTime(data,''),
		fdt.DateTimeToSqlDateTime(data,''),
		quotedStr(ocorrencia)
   );

    ds := funcSql.getDataSetQ(cmd, dm.con);

    if (ds.IsEmpty = false) then
    begin
       tpJust := ds.fieldByName('opc_descricao').AsString;
       obsJust := ds.fieldByName('jus_observacao').AsString;
       jusUsuario := ds.fieldByName('nm_usu').AsString + ' Data: ' + ds.fieldByName('jus_dataHora').AsString ;
       cmd := ds.fieldByName('jus_referencia').AsString;
		 ljDajust := ds.fieldByName('jus_usuario').AsString;
       ds.Destroy();
       gravaLog('Justificado, seq da justificativa: ' + cmd);
       result := cmd;
    end
    else
    begin
       ds.Destroy();
       gravaLog('Nao Justificado');
       result := '';
    end;
end;

function TDBClass.Justificar(mat, just, data1, data2, tipo, hora1, hora2, ocorr, Cartao, DtLancamento, Obs, banco, Estabelecimento, loja, diaGeradorFolga, autorizador:string):String;
var
   cmd :String;
begin
   if (diaGeradorFolga <> '') then
      diaGeradorFolga :=  fdt.strToSqlDate(diaGeradorFolga)
   else
      diaGeradorFolga := 'null';

   cmd :=
   dm.getCMD8('jus', 'ins',
   	quotedstr(Estabelecimento),
   	quotedstr(mat),
   	quotedstr(just),
		fdt.strToSqlDate(data1),
		fdt.strToSqlDate(data2),
		quotedStr(tipo),
		quotedStr(hora1),
		quotedStr(hora2)
    );
	dm.setParams(cmd, quotedStr(ocorr), quotedStr(''), 'GETDATE()');
	dm.setParams(cmd, quotedStr('Loja: ' + loja), quotedStr(obs), diaGeradorFolga);
	dm.setParam(cmd,  autorizador);

   result := funcSQL.executeSQL(cmd, dm.con);
end;

procedure TDBClass.getTable(var tb: TADOTable; tbFields: string);
begin
   funcSQL.getTable( dm.con, tb, tbFields );
end;

function TDBClass.getNomeLojasPonto(mostraOpcTodas, mostraNenhum:boolean): Tstrings;
var
   qr:TADOQuery;
   lst:TstringList;
begin
   lst := TStringList.Create();
   funcSql.getQuery(  dm.con, qr, dm.getCMD('local','get'));

   if (mostraOpcTodas= true) then
      lst.Add('< Todas >');

   if (mostraNenhum= true) then
      lst.Add('< Nenhum >');

   while (qr.Eof = false) do
   begin
      lst.Add(f.preencheCampo(100,' ', 'd',qr.fieldByname('ds_uo').AsString) + qr.fieldByname('localizacao').AsString);
      qr.Next();
   end;
   qr.Destroy();
   result := lst;
end;

function TDBClass.getDadosFuncionarios(localizacao:String): Tstrings;
var
   aux:TstringList;
   ds:TDataSet;
begin
   aux := TstringList.Create();
   ds:= getCadastroDeEmpregados(localizacao);
   ds.First;
   while (ds.Eof = false) do
   begin
      aux.Add(
      f.preencheCampo(100, ' ', 'D', ds.fieldByName('nome').asString) +
      '00' + ds.fieldByName('cartaoPonto').asString
             );
      ds.Next();
   end;
   ds.Destroy();
   result := aux;
end;

procedure TDBClass.getQuery(var qr:TADOQuery; ComandoSQL:string);
begin
   funcsql.getQuery(dm.con, qr, ComandoSQL);
end;

function TDBClass.getDataSetQ(ComandoSQL:string):TdataSet;
begin
   result :=  funcsql.getDataSetQ(ComandoSQL, dm.con);
end;


function TDBClass.getJustificativas(): TStringList;
var
   ds:TDataSet;
   aux:TStringList;
begin
   aux := TStringList.Create();

   ds := dm.getDataSetQ( dm.getCMD('oco', 'getJustTipos'));

   while ds.Eof = false do
   begin
      aux.add(
             f.preencheCampo(100, ' ' , 'D', ds.fieldByName('opc_descricao').AsString)+
             f.preencheCampo( 05, ' ' , 'D', ds.fieldByName('opc_codigo').AsString) +
             f.preencheCampo( 05, ' ' , 'D', ds.fieldByName('isMensal').AsString)
             );
      ds.Next();
   end;
   ds.free();
   result := aux;
end;

function TDBClass.isDSTemplateClosed: boolean;
begin
    gravaLog('TDBClass.isDSTemplateClosed, valor: ' + BoolToStr(dsTemplates.Active, true ) );
    result := not(dsTemplates.Active);
end;


function TDBClass.getNomeMatPorLocalizacao(localizacao: String): TdataSet;
begin
   if (localizacao <> '') then
      result := funcsql.getDataSetQ('Select nome, matricula, cartaoPonto from zcf_PontoEmpregados where dataDemissao is null and  localizacao  = '+localizacao  +' order by nome', dm.con)
   else
      result := funcsql.getDataSetQ('Select nome, matricula, cartaoPonto from zcf_PontoEmpregados where dataDemissao is null order by nome', dm.con);
end;

function TDBClass.insereEmpregado(empresa,matricula,cartaoPonto, nome,funcao, dataAdmissao, isHoraFlexivel, horario, localizacao, dataDemissao:String):boolean;
begin
   if (dataDemissao = '') then
     dataDemissao := 'null'
   else
     fdt.dateToSqlDate(strToDate(dataDemissao));

   result :=
   funcSql.execSQL( 'insert zcf_pontoempregados ' +
                    '(empresa, matricula, cartaoPonto, nome, localizacao, funcao, isHoraFlexivel, horario_num, dataAdmissao, dataDemissao ) '+
                    ' values ( ' + QuotedStr(empresa)   + ', ' +
                                   QuotedStr(matricula) + ', ' +
                                   QuotedStr(cartaoPonto) + ', ' +
                                   QuotedStr(copy(nome,01,40)) + ', '+
                                   QuotedStr(localizacao) + ', '+
                                   QuotedStr(funcao) + ', '+
                                   QuotedStr(isHoraFlexivel) + ', '+
                                   QuotedStr(horario) + ', '+
                                   fdt.dateToSqlDate(strToDate(dataAdmissao)) + ', '+
                                   dataDemissao + ' )'
                    , dm.con);
end;

function TDBClass.getDetalheEmpregado(cartaoPonto:String):TdataSet;
var
  cmd: String;
begin
   cmd := 'select e.*, L.ds_uo, H.descricao ' +
          'from zcf_pontoEmpregados e (nolock) ' +
          'left join  zcf_pontoLocalizacao L (nolock) on e.localizacao = L.localizacao ' +
          'left join zcf_pontoHorarios H (nolock) on e.horario_num = H.num ' +
          'where e.cartaoPonto = ' + cartaoPonto ;
   result := funcsql.getDataSetQ(cmd, dm.con);
end;


function TDBClass.deletaEmpregado(matricula:String):boolean;
begin
   result := funcSQl.execSQL('delete from zcf_pontoEmpregados where matricula = ' + quotedStr(matricula), dm.con );
end;

function TDBClass.lerParametroBD(parametro:String):String;
var
   cmd:String;
begin
   cmd := 'Select top 01 valor from zcf_paramgerais where nm_param = ' + quotedStr(parametro);
   result := funcsql.openSQL(cmd, 'valor', dm.con);
end;

function TDBClass.setParamBD(parametro, uo, valor:String):boolean;
begin
   result := funcsql.setParamBD( parametro,uo, valor, dm.con);
end;

procedure TDBClass.criaTbResumo(var Table:TADOTAble);
begin
   gravaLog('Criando tabela resumo');
   dm.getTable(table, dm.getCMD('oco', 'getTbResBat') );
end;

procedure TDBClass.preencheListaDosDias(var tabela:TADOTable; dti,dtf:Tdate; pegaDiaAtual:boolean);
const
   BATIDA_VAZIA  = '  :  ';
var
   dataAux:Tdate;
begin
   gravaLog('preenchendo a lista dos dias.');
   dataAux := dti;

   if (dtf > now) and (pegaDiaAtual = false) then
      dtf := now;

   if ( tabela.Active = false) then
      tabela.Open();

   while dataToInt(dataAux) <= dataToint( dtf ) do
   begin
      tabela.append;
      tabela.FieldByName('dia').AsString := copy( dateTostr(dataAux),01,02)  + '/'+fdt.getDescricaoDia(dataAux, TRUE) ;
      tabela.FieldByName('ent').AsString := BATIDA_VAZIA;
      tabela.FieldByName('int_sai').AsString := BATIDA_VAZIA;
      tabela.FieldByName('int_ent').AsString := BATIDA_VAZIA;
      tabela.FieldByName('sai').AsString := BATIDA_VAZIA;
      tabela.FieldByName('atraso').AsString := BATIDA_VAZIA;
      tabela.FieldByName('totDia').AsString := BATIDA_VAZIA;
      tabela.FieldByName('sai').AsString := BATIDA_VAZIA;
      tabela.FieldByName('sinal').AsString := BATIDA_VAZIA;
      tabela.FieldByName('dif').AsString := BATIDA_VAZIA;
      tabela.post;
      dataAux := dataAux +1;
   end;
   gravaLog('conclui o preenchimento da lista dos dias.');
end;

function TDBClass.isCadastroEmpOk(cartaoPonto:String):boolean;
begin
end;

function TDBClass.isPontoCadastrado(cartaoPonto: String): boolean;
begin

end;

function TDBClass.isConnected: boolean;
begin
   result := dsTemplates.Active;
end;

function TDBClass.insereRegistroFerias(Tipo, matricula: String; dtI, dtF: TDate): boolean;
var
  cmd:String;
begin
   cmd := 'insert zcf_pontoAfastamentos values ( '+
             quotedStr(matricula) + ', ' +
             fdt.dateToSqlDate(dtI) + ', ' +
             fdt.dateToSqlDate(dtf) + ', ' +
             quotedStr(tipo) + ' )';
   result := funcSQL.execSQL(cmd, dm.con)
end;
{
function TDBClass.desativaEmpregado(matricula:String; dataDemissao:Tdate):boolean;
var
   cmd:String;
begin
   cmd := 'if exists( select matricula from zcf_pontoEmpregados  where matricula = ' + quotedstr(matricula) + ' and  dataDemissao is null ) ' +
          ' update zcf_pontoEmpregados set dataDemissao = ' + fdt.dateToSqlDate(dataDemissao)+ ' where matricula = ' + quotedstr(matricula);
   result := (funcSQL.executeSQLint(cmd, dm.con) > 0);
end;
}
function TDBClass.ativaEmpregado(matricula: String): boolean;
var
   cmd:String;
begin
    cmd := ' update zcf_pontoEmpregados set dataDemissao = null where matricula = ' + quotedstr(matricula);
    result := (funcSQL.executeSQLint(cmd, dm.con) > 0);
end;

function TDBClass.isDigitalCadastrada(matricula, lado: String):boolean;
var
   cmd:String;
begin
   cmd := 'Select id from zcf_pontoCadDigitais where id = ' + (matricula) +' and lado = ' + QuotedStr(lado);
   result := (funcSQL.openSQL(cmd, 'id', dm.con) <> '');
end;


function TDBClass.removeCadastroDigital(cartaoPonto, lado:String):boolean;
begin
   result := funcSQL.execSQL( 'delete from zcf_pontoCadDigitais where id = ' + (cartaoPonto) + ' and lado = ' + QuotedStr(lado),  dm.con) ;
end;

function TDBClass.isDiaBaseFolga(matricula:String; data:Tdate):boolean;
var
   cmd:String;
   ds:TdataSet;
begin
	cmd := 'Select jus_diaGeradorFolga from zcf_Pontojustificativas '+
          'where jus_matricula = '+ quotedstr(matricula) +
          ' and  jus_diaGeradorFolga= ' + fdt.dateToSqlDate(data);
   ds := dm.getDataSetQ(cmd);

   result := (ds.RecordCount < 2);
   ds.Free();
end;


function TDBClass.getDataHoraBD():String;
begin
   result := funcSQL.openSQL('select getDate() as data', 'data', dm.con );
end;

function TDBClass.getUserAutorizadorPonto(listaJustificativas:boolean):String;
var
  lstUsers,lstJus: TStrings;
begin
   if listaJustificativas = true then
      lstJus :=  getJustificativas()
   else
      lstJus :=  TStringList.Create();

   lstUsers := getAutorizadores();
end;


function TDBClass.getDate():Tdate;
begin
 	result := dm.getDateBd();
end;

function TDBClass.getOcorrencias():TStrings;
var
  ds:TdataSet;
  lst:TStringlist;
  cmd:String;
begin
	lst := TSTringList.Create();
	ds:= dm.getDataSetQ(dm.getCMD('jus', 'getOco'));
   ds.First();

   while (ds.Eof = false) do
   begin
   	cmd := ds.fieldByName('oco_codigo').asSTring+ ' - '+ds.fieldByName('oco_descricao').asSTring;
      cmd := f.preencheCampo(80,' ', 'D', cmd);

   	lst.Add(
      	cmd + ds.fieldByName('is_parcial').asString
		);
      ds.Next();
	end;
   ds.free();


	result := lst;

end;



end.
