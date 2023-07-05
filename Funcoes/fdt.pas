unit fdt;

interface
   uses dateUtils, ComCtrls, Controls, SysUtils, ADODB, f, windows, fCtrls, db, uDm;

   function acertarDataHora(data:TdateTime):boolean;
   function ajustaDataMes(mesAno, sinal: String):String;
	function avancaHora(data, hora:String): String;
   function dataDDMMAAAtoData(data:String):String;
   function dataDDMMAAAtoDate(data:String):Tdate;
   function dataIntWelltoData(data:String):Tdate;
   function dataPorExtenso(data:Tdate):string;
   function dataSqlToData(dataSql:String):String;
   function dataToSqlInt(data:Tdate):String;
   function dateTimeToSqlDateTime(data,hora:string):string; OverLoad;
   function dateTimeToSqlDateTime(data:Tdate; hora:string):string; Overload;
   function dateToDDMMAAA(date:Tdate):String;
   function dateToIntSQL(date:Tdate):String;
   function dateToSqlDate(data:String):string; OverLoad;
   function dateToSqlDate(data:Tdate):string; OverLoad;
   function datatNointerv(data, di, df:Tdate):boolean;
   function ehAnoBiSexto(Ayear: Integer): Boolean;
   function extractFromGetDate(parte:String; dateTimeBD:String):String;
   function getAnoMes(data:String):String;
   function getDatePart(parte:String; data:Tdate):String; overload;
   function getDatePart(parte, data:String):String; overload;
   function getDescricaoDia(data:TDate;ehDescAbreviada:Boolean):string;
   function getdiaDaSemana(data:Tdate):integer;
   function getMaxIntervData(codTela:integer):integer;
   function getStrDiasPeriodo(di, df:Tdate):String;
   function getUltimoDiaMes(data:Tdate):String; overload;
   function getUltimoDiaMes(str:String):String; overload;
   function isDataValida(Str:string):Boolean;
   function isIntervDataValido(di, df:TfsDateTimePicker; mostraMsg:boolean):boolean; overload;
   function isIntervDataValido(di, df:TfsDateTimePicker; mostraMsg:boolean; qtDiasInterv:integer):boolean; overload;
   function isHoraPermitida(tela:integer; grupo:String):boolean;
   function nomeDoDia(data:String; isDataAbreviada:boolean):String;
   function SQLDateTimeToStrDateTime(strSQLDateTime:String):String;
   function strToSqlDate(Str:string):string;
   function ultimoDisDoMes(DiaInicial:String):String;

   procedure decodeDate(var d, m, a:String; data:Tdate);
   procedure formataIntervDatas(data:Tdate; di, df:TDateTimePicker);


implementation


uses msg;

function ultimoDisDoMes(DiaInicial:String):String;
var
  d,m,a:integer;
begin
   m:= strToInt(copy(DiaInicial,04,02));
   a:= strToInt(copy(DiaInicial,07,04));

   case m of
      1,3,5,7,8,10,12: d:= 31;
      4,6,9,11: d:=30;
   else
      begin
         if  ehAnoBiSexto(a) = true then
             d := 29
         else
             d := 28;
      end;
   end;
   result := intToStr(d) +'/'+ preencheCampo(02,'0', 'e', intToStr(m) ) +'/'+ intToStr(a) ;
end;

function ehAnoBiSexto(Ayear: Integer): Boolean;
begin
   Result := (AYear mod 4 = 0) and ( (AYear mod 100 <> 0) or (AYear mod 400 = 0) );
end;

function getDatePart(parte:String; data:Tdate):String; overload;
var
   aux, d,m,a:String;
begin
   DecodeDate(d,m,a, data);

   if parte = 'd' then
      aux := f.preencheCampo(2,'0', 'e', d, false )
   else if parte = 'm' then
      aux := f.preencheCampo(2,'0', 'm', m, false )
   else
      aux := a;

   result := aux;

{	// a= ano m = mes d= dia
   if pos('a', parte) > 0 then
      result := copy(dateToStr(data),07,04)
   else if pos('m', parte) > 0 then
      result := copy(dateToStr(data),04,02)
   else
      result := copy(dateToStr(data),01,02);
}
end;

function getDatePart(parte, data:String):String; overload;
begin
    result:= getDatePart(parte, strToDate(data));
end;

function nomeDoDia(data:String; isDataAbreviada:boolean):String;
var
  ADate: TDateTime;
  days: array[1..7] of string;
begin
   if (isDataAbreviada =true )then
   begin
      days[1] := 'DOM';
      days[2] := 'SEG';
      days[3] := 'TER';
      days[4] := 'QUA';
      days[5] := 'QUI';
      days[6] := 'SEX';
      days[7] := 'SAB';
   end
   else
   begin
      days[1] := 'Domingo';
      days[2] := 'Segunda';
      days[3] := 'Terca';
      days[4] := 'Quarta';
      days[5] := 'Quinta';
      days[6] := 'Sexta';
      days[7] := 'Sabado';
   end;
  ADate := StrToDate(data);
  result:=(days[DayOfWeek(ADate)]);
end;


function ajustaDataMes(mesAno, sinal: String):String;
var
  m,a:integer;
begin
   m:= strToInt(copy(mesAno,01,02));
   a:= strToInt(copy(mesAno,04,04));

   if sinal = '-' then
      m:= m -1
   else
      m:= m +1;

   if m > 12 then
   begin
      a := a +1;
      m := 01;
   end;

   if m < 1 then
   begin
      a:= a-1;
      m:= 12;
   end;

   mesAno := f.preencheCampo(2,'0','e', intToStr(m) ) + '/' + intToStr(a);
   result := mesAno;
end;

function StrToSqlDate(Str:string):string;
var
   aux:string;
begin
   if (str = '' )then
      result := ''
   else
   begin
      aux := copy(Str,07,04) + '-' + copy(Str,04,02) +'-'+ copy(Str,01,02);
      if pos(' ',str) = 0 then
         aux  := quotedStr(aux);

       result := aux;
   end;
end;

function DateToSqlDate(data:Tdate):string;
begin
   result := StrToSqlDate(dateToStr(data));
end;

function dateToSqlDate(data:String):string; OverLoad;
begin
   result := StrToSqlDate(data);
end;

function DateTimeToSqlDateTime(data, hora:string):string; OverLoad;
begin

  if (hora = '' ) then
     hora := '00:00:00';

   data := dateToSqldate(strToDate(data));
   data := trim(data);
   hora := trim(hora);

   insert(' '+ hora, data, length(data) );


   Result := data ; //+ ' ' + hora ;
end;


function DateTimeToSqlDateTime(data:Tdate; hora:string):string; Overload;
var
   aux:String;
begin
   if (hora = '' ) then
      hora := '00:00:00';
   aux := DateToSqlDate(data);
   insert(' '+ hora, aux, length(aux) );
   result := aux;
end;

function getDescricaoDia(data:TDate;ehDescAbreviada:Boolean):string;
var
  days: array[1..7] of string;
begin
   if (ehDescAbreviada = true )then
   begin
      days[1] := 'DOM';  days[2] := 'SEG'; days[3] := 'TER';  days[4] := 'QUA';
      days[5] := 'QUI';  days[6] := 'SEX';  days[7] := 'SAB';
   end
   else
   begin
      days[1] := 'DOMINGO';  days[2] := 'SEGUNDA'; days[3] := 'TERCA';  days[4] := 'QUARTA';
      days[5] := 'QUINTA';  days[6] := 'SEXTA';  days[7] := 'SABADO';
   end;
   getDescricaoDia:=(days[DayOfWeek(data)]);
end;

function getUltimoDiaMes(data:Tdate):String; overload;
var
   mes, AYear:integer;
   dia:String;
begin
   AYear := StrToInt( copy(dateTostr(data),07,04));
   mes :=   StrToInt( copy(dateTostr(data),04,02));
   case mes of
      01,03,05,07,08,10,12: dia := '31';
      04,06,09,11: dia := '30';
      02: begin
          if ((AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0)) ) then
             dia := '29'
          else
             dia := '28'
          end
   end;
   result := dia+copy(dateTostr(data), 03, 08);

end;

function getUltimoDiaMes(str:String):String; overload
begin
   result := getUltimoDiaMes(strToDate(str));
end;


function dataToSqlInt(data:Tdate):String;
var
   aux:String;
begin
   aux := datetoStr(data);
   result := copy(aux,07,04) + copy(aux,04,02)+ copy(aux,01,02);
end;

function dataSqlToData(dataSql:String):String;
begin
//2010/05/12'

   result := copy(dataSql, 09, 02) +'/'+ copy(dataSql, 06, 02)+'/'+ copy(dataSql, 01, 04);
end;

function SQLDateTimeToStrDateTime(strSQLDateTime:String):String;
begin
{
  recebe no formato 2005-01-01 00:00:01
  e retorna  no formato  00:00:01 01/01/2005
}
   f.gravaLog(strSQLDateTime);
   result := copy(strSQLDateTime, 09, 02) +'/'+
             copy(strSQLDateTime, 06, 02) +'/'+
             copy(strSQLDateTime, 01, 04) +' '+
             copy(strSQLDateTime, 12, 08);
end;

function getAnoMes(data:String):String;
begin
   result :=
   copy((data), 07, 04)+
   copy((data), 04, 02);
end;

function dataDDMMAAAtoDate(data:String):Tdate;
begin
   insert('/',data, 3);
   insert('/',data, 6);
   result := strToDate(data);
end;

function dataDDMMAAAtoData(data:String):String;
begin
  result := dateToStr(dataDDMMAAAtoDate(data));
end;

function dataIntWelltoData(data:String):Tdate;
begin
   f.gravaLog('data:'+ data);
   f.gravaLog('dataIntWelltoData()' + copy(data, 07, 02)+ '/'+ copy(data, 05, 02) + '/'+ copy(data, 01, 04));
   result :=
   strToDate( copy(data, 07, 02)+ '/'+ copy(data, 05, 02) + '/'+ copy(data, 01, 04));
end;

function dateToIntSQL(date:Tdate):String;
var
   data :String;
begin
   f.gravaLog('dateToIntSQL()'+ dateToStr(date));
   data := dateToStr(date);
   result := copy(data, 07, 04) + copy(data, 04, 02) + copy(data, 01, 02);
end;

function extractFromGetDate(parte:String; dateTimeBD:String):String;
var
   res:String;
begin
// recebe a data no formato dd/mm/aaa
   if ( parte = 'data') then
   begin
      res :=
      copy(dateTimeBD, 01, 10);
   end
   else
   if ( parte = 'hora') then
   begin
      res := copy(dateTimeBD, 12, 08 );
   end;
   f.gravaLog('extractFromGetDate, entrada: ' + dateTimeBD + ' parametro:' + parte  + ' : ' + res);
   result := res;
end;

function dataPorExtenso(data:Tdate):string;
var
  aux:string;
begin
   aux := intToStr(dateUtils.dayOf(data));

   case MonthOfTheYear(data) of
      1:aux := aux+ ' de janeiro de ';
      2:aux := aux+ ' de fevereiro de ';
      3:aux := aux+ ' de marco de ';
      4:aux := aux+ ' de abril de ';
      5:aux := aux+ ' de maio de ';
      6:aux := aux+ ' de junho de ';
      7:aux := aux+ ' de julho de ';
      8:aux := aux+ ' de agosto de ';
      9:aux := aux+ ' setembro de ';
      10:aux := aux+ ' de outubro de ';
      11:aux := aux+ ' de novembro de ';
      12:aux := aux+ ' de dezembro de ';
   end;
   aux := aux+ IntToStr(YearOf(data));
   result := aux;
end;

function isDataValida(Str:string):Boolean;
begin
   isDataValida:=true;
   try
      StrToDate(str)
   except
      on e:exception do
         isDataValida := false;
   end;
end;

procedure decodeDate(var d, m, a:String; data:Tdate);
var
   aa,mm,dd:word;
begin
   SysUtils.DecodeDate(data, aa, mm, dd );

   d:= floatToStr(dd);
   m := floatToStr(mm);
   a := floatToStr(aa);

   if (length(d) < 2) then
     d := '0'+d;

   if (length(m) < 2) then
     m := '0'+m;
end;


function getdiaDaSemana(data:Tdate):integer;
begin
   // retorna o dia. o dia 1 é domingo e sabdo é 7
   result := DayOfWeek(data);
end;

function acertarDataHora(data:TdateTime):boolean;
var
   SystemTime : TSystemTime;
   dia,mes,ano,hora,min, seg, milSeg:Word;
begin
   decodeDateTime( data,  ano, mes, dia, hora, min, seg, milSeg);

   With SystemTime do
   begin
       wYear:= ano;
       wMonth:= mes;
       wDay:= dia;
       wHour:= hora;
       wMinute:= min;
       wSecond:= seg;
       wMilliseconds := milSeg;
    end;

    if  SetLocalTime(SystemTime) = false then
       f.gravaLog('Nao foi possivel acertar a hora')
    else
       f.gravaLog('Hora acertada para: ' +
          floatToStr(SystemTime.wHour)   +':'+
          floatToStr(SystemTime.wMinute) +':'+
          floatToStr(SystemTime.wSecond) +' '+
          floatToStr(SystemTime.wDay) +'/'+
          floatToStr(SystemTime.wMonth) +'/'+
          floatToStr(SystemTime.wYear)
       );
end;

function getStrDiasPeriodo(di, df:Tdate):String;
var
   sData, cmd:String;

begin
   cmd := '';
   while (di< (df-1)) do
   begin
      sData := f.tiraCaracter(dateToStr(di), '/');
      sData := f.preencheCampo(8, '0', 'E', sData);
      cmd := cmd + sData + ', ';
      di := di +1;
   end;
   sData := f.tiraCaracter( dateToStr(df), '/');
   sData := f.preencheCampo(8, '0', 'E', sData);
   cmd := cmd + sData;

   result := cmd;
   f.gravaLog('->'+cmd);
end;

procedure formataIntervDatas(data:Tdate; di, df:TDateTimePicker);
var
  aux:String;
begin
   df.date := data;
   aux := dateToStr(df.Date);
   delete(aux, 01, 02);
   insert('01', aux, 1);
   di.date := strToDate(aux);
end;

function isIntervDataValido(di, df:TfsDateTimePicker; mostraMsg:boolean; qtDiasInterv:integer):boolean; overload;
const
   MSG_DATA1_MAIORQ_DATA2 = ' - A data inicial não pode ser maior que a final.' + #13;
   MSG_DATA_fim_MENORQ_DATA_inicio = ' - A data final não pode ser menor que a inicial.' + #13;
var
   erro:String;
begin
   erro := '';
   if ( dateToInteiro(df.Date) < dateToInteiro(di.Date)  ) then
      erro := MSG_DATA_fim_MENORQ_DATA_inicio +  'Inicio: '+dateTimeToStr(di.date) + '  Fim: ' + dateTimeToStr(df.date) ;

   if ((df.date - di.date) > qtDiasInterv ) then
     erro := ' - Período maior que '+ intTostr(qtDiasInterv) + ' dias.'+ #13;;

   if (erro <> '' ) and (mostraMsg = true ) then
   begin
     erro := '  Corrija antes os seguintes erros: ' +#13+  erro;
     msg.msgErro(erro);
     df.Date := di.Date;
   end;
   result := (erro = '');
end;

function isIntervDataValido(di, df:TfsDateTimePicker; mostraMsg:boolean):boolean; overload;
begin
   result := isIntervDataValido(di, df, mostraMsg, 31);
end;

function dateToDDMMAAA(date:Tdate):String;
var
  aux:String;
begin
   aux := dateToStr(date);
   while ( Pos('/', aux) > 0) do
      delete(aux, Pos('/', aux), 1);
   result := aux;
end;

function datatNointerv(data, di, df:Tdate):boolean;
begin
   result :=  ( ( trunc(data) >= trunc(di)) and (trunc(data) <= trunc(df)) );
end;

function isHoraPermitida(tela:integer; grupo:String):boolean;
var
   qr:TdataSet;
   hAtual, hIni, hFim:integer;
   isPermitido:Boolean;
   str:String;
begin
   //  se a hora atual estiver dentro to intervalo de bloqueio, nao deixa
   //  gerar o relatório.

   hAtual := horaToInt(dm.getHoraBD());

   qr:= dm.getDataSetQ('Select codTela, codgrupo, hora_ini, hora_fim from  zcf_horBloqRel (nolock) where codTela = ' + intToStr(tela)  + ' and codGrupo = ' + grupo );

   isPermitido := true;
   if (qr.IsEmpty  = false) then
   begin
      qr.First;
      while qr.Eof = false do
      begin
         hIni := horaToInt(qr.FieldByName('hora_ini').asString);
         hFim := horaToInt(qr.FieldByName('hora_fim').AsString);

         if ( hAtual >= hIni ) and( hAtual <= hFim ) then
         begin
            isPermitido := false;
            break;
         end;
         qr.Next;
      end;

      if (isPermitido = false) then
      begin
         qr.First;
         while qr.Eof = false do
         begin
            str := str+ ' De ' +  qr.FieldByName('hora_ini').asString + ' as ' + qr.FieldByName('hora_fim').asString+'. '+#13;
            qr.Next;
          end;
          str := ' Esse relatório é bloqueado para geração nos seguintes horários: ' + #13 + str;
          msg.msgErro(str);
      end;
   end;
   result := isPermitido;
   f.gravaLog('fdt.isHoraPermitida(): ' + intToStr(tela) + ' grupo:' + grupo+ ' result: '+ boolToStr(result, true));
   qr.Free();
end;

function getMaxIntervData(codTela:integer):integer;
begin
//
end;

function avancaHora(data, hora:String): String;
var
	ss, mm, hh:integer;
   s,m,h:String;
begin
// '11:00:00';
	ss := strtoint( copy(hora, 07, 02));
   mm := strtoint( copy(hora, 04, 02));
	hh := strtoint( copy(hora, 01, 02));

   inc(ss);
   if (ss > 59) then
   begin
   	ss := 0;
      inc(mm);
   end;

   if (mm > 59) then
   begin
   	mm := 0;
      inc(hh);
   end;

   if (hh > 23) then
   begin
   	ss:= 0;
      mm:= 0;
      hh:= 0;
   end;

   s := f.preencheCampo(2,'0','E', intToStr(ss));
   m := f.preencheCampo(2,'0','E', intToStr(mm));
   h := f.preencheCampo(2,'0','E', intToStr(hh));

	result := h+':'+m+':'+s;
end;

function avancaData(data:String):String;
begin
//
end;




end.
