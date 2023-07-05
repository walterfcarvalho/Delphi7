unit uDm;

interface

uses
  SysUtils, Classes, Controls, DB, dbGrids, ADODB, forms, QForms, funcoes, funcSQL, mxExport;

type
  Tdm = class(TDataModule)
    con: TADOConnection;


    function isHoraPermitida(tela:integer; grupo:String):boolean;
    function exportacaoDeTabela(tb:TdataSet;  tipoSaida:TmxExportType;  estilo:TmxExportStyle; nomeArq:String):String;

    function execSqlInt(cmd:String):integer;
    function updateParamBD(nParametro, loja, valor, descricao: String): boolean;
    function setParamBD(parametro, uo, valor:String):boolean;
    function getHint(nObjeto:String):String;
    function getDateTimeBd():String;
    function delParamBD(nParametro, loja: String):boolean;
    function insertParamBD(nParametro, loja, valor, descricao: String): boolean;

    function gerarCreditoDecliente(cod_emp, usAutorizador, num_cli, loja, valor :String; conexao:TADOConnection):Boolean;
    function getValoresSQL(lista:Tstrings; comando:String):Tstrings;
    function criaTabelaTemporaria(camposTabela:String):String;
    function execSQL(comando:string):boolean;
    function getDataSetQ(comando:String):TDataSet;
    function getDataBd(diasARecuar:integer):String;
    function getDateBd():TDate;
    function getContadorWell(campo:String):String;
    function getListagem(Comando:String):Tstringlist;
    function getMediaDeUmaColuna(ds:TDataSet; coluna:String):String;
    function getParamBD(nParametro, loja: String):String;

    function getValorWell(ExeOrOpen:char; Comando:String; campoRetorno:String):string;
    function getValoresSQL2(Comando:String):Tstrings;
    function openSQL(cmd, retorno:String):String;
    function somaColunaTable(Table:TDataSet;Coluna:String):real;
    function somaColTable(Table:TDataSet; Coluna:String; isFormatado:boolean):String;
    function getNomeTableTemp():String;
    function getCustoPorData(uo,is_ref, data:String):String;



    procedure conExecuteComplete(Connection: TADOConnection; RecordsAffected: Integer; const Error: Error;   var EventStatus: TEventStatus; const Command: _Command; const Recordset: _Recordset);
    procedure conWillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType; var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus; const Command: _Command; const Recordset: _Recordset);
    procedure getQuery(var qr:TADOQuery; cmd:string);
    procedure getTable(var tb:TADOTable; tbFields:string);
    procedure organizarTabela(var tabela:TADOTable;Coluna:Tcolumn);

    function getEmail(loja:string):string;
    procedure DataModuleCreate(Sender: TObject);

    procedure organizarQuery(var query:TADOQuery;Coluna:Tcolumn);
    procedure DataModuleDestroy(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

procedure Tdm.conExecuteComplete(Connection: TADOConnection;
  RecordsAffected: Integer; const Error: Error;
  var EventStatus: TEventStatus; const Command: _Command;
  const Recordset: _Recordset);
begin
   Screen.cursor := 0;
end;

procedure Tdm.conWillExecute(Connection: TADOConnection;
  var CommandText: WideString; var CursorType: TCursorType;
  var LockType: TADOLockType; var CommandType: TCommandType;
  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;
  const Command: _Command; const Recordset: _Recordset);
begin
   Screen.cursor := -11{crHourGlass};
   funcoes.gravaLog(CommandText);
end;


function Tdm.getDataSetQ(comando: String): TDataSet;
begin
   result :=funcSQL.getDataSetQ(comando, con);
end;

function Tdm.getListagem(Comando:String):Tstringlist;
begin
   funcoes.gravaLog('Tdm.getListagem()');
   result := funcSQL.getListagem(Comando, con)
end;


procedure Tdm.getTable(var tb: TADOTable; tbFields: string);
begin
   funcSQL.getTable(con, tb, tbFields);
end;

function Tdm.openSQL(cmd, retorno: String): String;
begin
   result := funcSQL.openSQL(cmd, retorno, con);
end;

function Tdm.somaColunaTable(Table:TDataSet;Coluna:String):real;
begin
   funcoes.gravaLog('Tdm.somaColunaTable()');
   result := funcSQL.somaColunaTable(Table, Coluna);
end;

function Tdm.execSQL(comando:string):boolean;
begin
   result := funcSQL.execSQL(comando, con);

end;

function Tdm.getMediaDeUmaColuna(ds:TDataSet; coluna:String):String;
begin
   result := funcSQL.getMediaDeUmaColuna(con, ds, coluna);
end;

procedure Tdm.getQuery(var qr:TADOQuery; cmd:string);
begin
   funcSQL.getQuery(con, qr, cmd );
end;

function Tdm.criaTabelaTemporaria(camposTabela:String):String;
begin
   result := funcSQL.criaTabelaTemporaria(con, camposTabela);
end;

function TDM.getContadorWell(campo:String):String;
begin
   result := funcSQL.getContadorWell(con, campo);
end;

function Tdm.getParamBD(nParametro, loja: String):String;
var
   str:String;
begin
  str := funcSQL.getParamBD(nParametro, loja, con);
  funcoes.gravaLog('parametro: ' + nParametro + ' loja: ' + loja +' Resultado: '+ str );
  result := str;
end;

function Tdm.getDateBd():TDate;
begin
   result := funcSQL.getDateBd(con, 0);
end;

function Tdm.getDataBd(diasARecuar:integer):String;
begin
   result := funcSQL.getDataBd(con, diasARecuar);
end;

function Tdm.somaColTable(Table:TDataSet; Coluna:String; isFormatado:boolean):String;
begin
   result := funcSQL.somaColTable(Table, Coluna, isFormatado);
end;

procedure Tdm.organizarTabela(var tabela:TADOTable;Coluna:Tcolumn);
begin
   funcSQL.organizarTabela(tabela, coluna);
end;

function Tdm.getValorWell(ExeOrOpen:char; Comando:String; campoRetorno:String):string;
begin
   result := funcSQL.getValorWell(ExeOrOpen, Comando, campoRetorno, con);
end;

function Tdm.getEmail(loja:string):String;
begin
   result := OpenSQl( 'Select email from zcf_tbuo (nolock) where is_uo = ' + loja , 'email');
end;

function Tdm.getNomeTableTemp():String;
var
  i:integer;

begin
   randomize;
   i:= random(99999);
   result := '#' +  funcoes.getNomeDaEstacao() +'_'+ inttostr(i);
end;


function Tdm.getValoresSQL2(Comando:String):Tstrings;
begin
   result := funcSQL.getValoresSQL2(Comando, con);

end;

function Tdm.getValoresSQL(lista:Tstrings; comando:String):Tstrings;
begin //
   result := funcSQL.getValoresSQL(Lista, Comando, con)
end;




function Tdm.getCustoPorData(uo, is_ref, data: String): String;
begin
   result := funcSQL.getCustoPorData(uo, is_ref, data, con);
end;

function Tdm.getDateTimeBd: String;
begin
// retorna a data e hora em formato dd/mmm/aaa hh:mm:ss
   result :=  dateToStr(funcSQL.getDateTimeBd(con, 0));
end;

function Tdm.delParamBD(nParametro, loja: String): boolean;
begin
   result :=funcSQL.delParamBD(nParametro, loja, con);
end;

function Tdm.insertParamBD(nParametro, loja, valor,
  descricao: String): boolean;
begin
   result := funcSQL.insertParamBD(nParametro, loja, valor, descricao, con);
end;

function Tdm.updateParamBD(nParametro, loja, valor,
  descricao: String): boolean;
begin
   result := funcSQL.updateParamBD(nParametro, loja, valor, descricao, con);
end;

function Tdm.setParamBD(parametro, uo, valor:String):boolean;
begin
   result := funcSQL.setParamBD(parametro, uo, valor, con);
end;


function Tdm.isHoraPermitida(tela: integer; grupo: String): boolean;
begin
   result := funcSQL.isHoraPermitida(con, tela, grupo);
end;

function Tdm.getHint(nObjeto: String): String;
begin
   result :=funcSQL.getHint(nObjeto, con);
end;

function Tdm.execSqlInt(cmd:String):integer;
begin
   result := funcSQL.executeSQLint(cmd, con );
end;

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
   con.Connected := false;
   try
     if (fileExists( ParamStr(0) +  'ConexaoAoWell.ini') = true) then
        con.ConnectionString := funcoes.getDadosConexaoUDL(extractFilePath(ParamStr(0)) +  'ConexaoAoWell.ini')
     else
       con.ConnectionString := 'Provider=SQLOLEDB.1;Password='+ funcoes.RParReg('listas','DBPassWord')  +';Persist Security Info=True;User ID='+ funcoes.RParReg('listas','DBUserName') +';Initial Catalog='  +funcoes.RParReg('listas','DBName') +' ;Data Source='+funcoes.RParReg('listas','IPServer')+ ';Workstation ID='+ funcoes.GetNomeDoMicro();

        con.Connected := true;
     except
     on e:Exception do
     begin
        msg.msgErro('Não posso conectar ao BD, verifique as configurações e tente novamente.');
        application.terminate;
     end;
   end;
end;

procedure Tdm.organizarQuery(var query: TADOQuery; Coluna: Tcolumn);
begin
   funcSQL.organizarQuery(query, Coluna);
end;

function Tdm.exportacaoDeTabela(tb: TdataSet; tipoSaida: TmxExportType;
  estilo: TmxExportStyle; nomeArq: String): String;
begin
   result := funcSQL.exportacaoDeTabela(tb, tipoSaida, estilo, nomeArq);
end;

procedure Tdm.DataModuleDestroy(Sender: TObject);
begin
   con.Free();
end;

function Tdm.gerarCreditoDecliente(cod_emp, usAutorizador, num_cli, loja, valor :String; conexao:TADOConnection ):Boolean;
begin
   result := funcSQL.gerarCreditoDecliente(cod_emp, usAutorizador, num_cli, loja, valor,  conexao );
   conexao.free();
end;



end.
