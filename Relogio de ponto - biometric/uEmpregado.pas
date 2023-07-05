unit uEmpregado;

interface

uses controls, ADODb, db, sysutils, uAutorizadores;

    function desativaEmpregado(matricula:String; dataDemissao:Tdate):boolean;
    function getEmpPorMatricula(matricula:String):TdataSet;
    function getEmpPorCpf(cpf:String):TdataSet;
    function getEmpPorCartao(cartao:String):TdataSet;
    function getHoraPrevista(cartaoPonto, campoDia: String; dsDetEmp:TDataSet): String;
    function insere(empresa, matricula, cartaoPonto, nome, funcao, isHoraFlexivel, horario, localizacao, cpf:String; dataAdmissao:Tdate; batePonto:boolean):boolean;
    function insereRegistroFerias(Tipo, matricula: String; dtI, dtF: TDate): boolean;
    function remove(mat:String):boolean;
    function removeCadastroDigital(matricula, lado:String):boolean;
    function salva(empresa, matricula, cartaoPonto, nome, funcao, isHoraFlexivel, horario, localizacao, cpf:String; dataAdmissao:Tdate; isAtivo:boolean):boolean;
    procedure getCadastro(qr:TADOQuery; local:String; batePonto:boolean; nome:String);
    function isPontoCadastrado(mat:String):boolean;
    function isCpfCadastrador(cpf:String):boolean;
    function getNewNumPonto():String;
    function getNomeEmpregado(cartao:String):String;
    function getHorarioEmpregado(cpf:String):TdataSet;

    procedure salvaHorario(cpf,
                           edSegSai, edSegEnt, edSegIntFim, edSegIntIni,
                           edTerSai, edTerEnt, edTerIntFim, edTerIntIni,
                           edQuaSai, edQuaEnt, edQuaIntFim, edQuaIntIni,
                           edQuiSai, edQuiEnt, edQuiIntFim, edQuiIntIni,
                           edSexSai, edSexEnt, edSexIntFim, edSexIntIni,
                           edSabSai, edSabEnt, edSabIntFim, edSabIntIni,
                           edDomSai, edDomEnt, edDomIntFim, edDomIntIni:String);


	procedure listaAfastamentos(var tb:TadoTable; cpf:String);


implementation

uses f, uDm, fdt;


function remove(mat:String):boolean;
var
   cmd:String;
begin
   cmd := dm.getQtCMD1('emp', 'remDigital', mat);
   dm.execSQL(cmd);

   cmd := dm.getQtCMD1('emp', 'remCadastro', mat);
   result := dm.execSQL(cmd);
end;

function getDetEmpPorCampo(campo, valor:String):TdataSet;
var
  cmd:String;
begin
   cmd := dm.getCMD3('emp', 'getDetalhe', campo, quotedStr(valor), '');
   result := dm.getDataSetQ(cmd);
end;

function getEmpPorMatricula(matricula:String):TdataSet;
begin
   result := getDetEmpPorCampo('matricula', matricula);
end;

function getEmpPorCartao(cartao:String):TdataSet;
begin
   result := getDetEmpPorCampo('cartaoPonto', cartao);
end;

function getEmpPorCpf(cpf:String):TdataSet;
begin
   result := getDetEmpPorCampo('cpf', cpf);
end;

function insere(empresa, matricula, cartaoPonto, nome, funcao, isHoraFlexivel, horario, localizacao, cpf:String; dataAdmissao:Tdate; batePonto:boolean):boolean;
var
   cmd:String;
begin
   cmd := dm.getCMD('emp', 'insere');

   dm.setQtParams(cmd, empresa, matricula, cartaoPonto);
   dm.setQtParams(cmd, copy(nome,01,40), localizacao, funcao);
   dm.setParams(cmd, quotedStr(isHoraFlexivel), quotedStr(horario), fdt.dateToSqlDate(dataAdmissao));
   dm.setqtParams(cmd, cpf, bolToStr(batePonto), '');

   result := dm.execSQL(cmd);
end;


function salva(empresa, matricula, cartaoPonto, nome, funcao, isHoraFlexivel, horario, localizacao, cpf:String; dataAdmissao:Tdate; isAtivo:boolean):boolean;
var
   cmd:String;
begin
   cmd := dm.getCMD('emp', 'salva');

   dm.setQtParams(cmd, empresa, cartaoPonto, copy(nome, 01, 50) );
   dm.setQtParams(cmd, localizacao, funcao, isHoraFlexivel );
   dm.setParams  (cmd, quotedStr(horario), fdt.dateToSqlDate(dataAdmissao), bolToStr(isAtivo) );
   dm.setParams  (cmd, QuotedStr(cpf), '', '');

   result := dm.execSQL(cmd);
end;

procedure getCadastro(qr:TADOQuery;local:String; batePonto:boolean; nome:String);
var
   sBatePonto, cmd:String;

begin
   if f.bolToStr(batePonto) = '1' then
		sBatePonto := '1'
   else
		sBatePonto := '0,1';

   cmd := dm.getCMD1('emp', 'getCadastros', sBatePonto );

   if (local <> '') then
      cmd := cmd + dm.getCMD1('emp', 'getCadastros.local', local);

	if (nome <> '' )then
	   cmd := cmd + dm.getCMD1('emp', 'getCadastros.nome',  quotedStr('%'+nome+'%'));

	dm.getQuery(qr, cmd);
end;

function getNumMatricula(nCartao:String): String;
var
   cmd:String;
begin
   cmd := dm.getQtCMD1('emp', 'getMatFromPonto', nCartao);
   result := dm.openSQL(cmd, 'emp_matricula');
end;

function insereRegistroFerias(Tipo, matricula: String; dtI, dtF: TDate): boolean;
var
  cmd:String;
begin
   cmd := 'insert zcf_pontoAfastamentos values ( '+
             quotedStr(matricula) + ', ' +
             fdt.dateToSqlDate(dtI) + ', ' +
             fdt.dateToSqlDate(dtf) + ', ' +
             quotedStr(tipo) + ' )';
   result := dm.execSQL(cmd);
end;


function isPontoCadastrado(mat:String):boolean;
begin
   result := not(getEmpPorMatricula(mat).IsEmpty);
end;

function isCpfCadastrador(cpf:String):boolean;
begin
   result := not(getEmpPorCpf(cpf).IsEmpty);
end;

function desativaEmpregado(matricula:String; dataDemissao:Tdate):boolean;
var
   cmd:String;
begin
   cmd := dm.getCMD3('emp', 'desativar', QuotedStr(matricula), fdt.dateToSqlDate(dataDemissao), '');
   result := (dm.execSqlInt(cmd) > 0);
end;

function getNewNumPonto():String;
begin
   result := dm.openSQL(dm.getCMD('emp', 'getNewNumPonto'), '');
end;

function removeCadastroDigital(matricula, lado:String):boolean;
var
   cmd:String;
begin
   cmd := dm.getCMD3('emp', 'remDigital', matricula, quotedstr(lado), '' );
	f.gravaLog(cmd);
   result := dm.execSQL(cmd)
end;

function getNomeEmpregado(cartao:String):String;
begin
   result := getEmpPorCartao(cartao).fieldByName('nome').asString;
end;

function getHoraPrevista(cartaoPonto, campoDia: String; dsDetEmp:TDataSet): String;
var
   aux:String;
begin
   if (dsDetEmp <> nil) and (dsDetEmp.IsEmpty = true) then
   begin
      gravaLog('Pegando a hora prevista via Consulta no BD do campo:' + campoDia);
      aux := dm.getCMD3('horario', 'getHoraEnt', campoDia, cartaoPonto, '');
      aux :=  dm.openSQL(aux, '');
   end
   else
   begin
      gravaLog('Pegando a hora prevista via DS do campo:' + campoDia);
      aux := dsDetEmp.fieldByName(campoDia).AsString;
   end;
   gravaLog('Campo: ' + campoDia +   ' Resultado: ' + aux);
   result := aux;
end;

function getLocal(cartaoPonto:String): String;
var
  ds:TDataSet;
begin
   ds := getEmpPorCartao(cartaoPonto);
   if (ds = nil) then
      result := '0'
   else
      result := ds.fieldByName('localizacao').AsString;
   ds.Destroy();
end;

    procedure salvaHorario(cpf,
                           edSegSai, edSegEnt, edSegIntFim, edSegIntIni,
                           edTerSai, edTerEnt, edTerIntFim, edTerIntIni,
                           edQuaSai, edQuaEnt, edQuaIntFim, edQuaIntIni,
                           edQuiSai, edQuiEnt, edQuiIntFim, edQuiIntIni,
                           edSexSai, edSexEnt, edSexIntFim, edSexIntIni,
                           edSabSai, edSabEnt, edSabIntFim, edSabIntIni,
                           edDomSai, edDomEnt, edDomIntFim, edDomIntIni:String);
var
	cmd:String;
begin
	cmd := dm.getCMD1('horario', 'del', QuotedStr(cpf));
   dm.execSQL(cmd);

	cmd := dm.getCMD('horario', 'set');
   dm.setQtParam(cmd,cpf);
   dm.setQt4Params(cmd, edSegEnt, edSegIntIni, edSegIntFim, edSegSai);
   dm.setQt4Params(cmd, edTerEnt, edTerIntIni, edTerIntFim, edTerSai);
   dm.setQt4Params(cmd, edQuaEnt, edQuaIntIni, edQuaIntFim, edQuaSai);
   dm.setQt4Params(cmd, edQuiEnt, edQuiIntIni, edQuiIntFim, edQuiSai);
   dm.setQt4Params(cmd, edSexEnt, edSexIntIni, edSexIntFim, edSexSai);
   dm.setQt4Params(cmd, edSabEnt, edSabIntIni, edSabIntFim, edSabSai);
   dm.setQt4Params(cmd, edDomEnt, edDomIntIni, edDomIntFim, edDomSai);
   dm.execSQL(cmd);
end;

function getHorarioEmpregado(cpf:String):TdataSet;
begin
	result :=
   dm.getDataSetQ(dm.getQtCMD1('horario','getFromCPF', cpf));
end;


procedure listaAfastamentos(var tb:TadoTable; cpf:String);
var
   cmd:String;
begin
	if tb.TableName <> '' then
	   tb.Close();

	dm.getTable(tb, dm.getCMD('emp', 'getFieldTbFerias'));
      
   cmd :=
   dm.getCMD2('emp', 'getVlTbFerias', cpf, tb.TableName);
   dm.execSQL(cmd);
   tb.Open();
end;





end.
