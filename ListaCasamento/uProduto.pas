unit uProduto;

interface

   uses adodb, db, SysUtils, Controls;

   function isEntregue(ref:String):boolean;
   function isfornProdBonificado(cd_ref:String):String;
 	function getDadosEntProduto(ref:String):TdataSet;
	function getDadosProduto(cd_ref:String):TdataSet;
   procedure getQrItensLst(qr:TADOQuery; numLista:String; tpLstConvidados: integer);

   procedure ajustaEntCaminhao(isEntrega:boolean; ref:String);
   procedure listaPrdPendEntrega(tb:TADOTable; uo:String);
   procedure getTbItensEntrega(tb:TADOTable);
   procedure getTbItensEntImpr(tb, tbImpr:TADOTable);
   procedure gravaDadosSaidaCam(tb:TADOTable; motorista:String );



implementation

uses uDm, funcoes, msg, fdt, funcSQL, Unit1, QForms;

procedure getQrItensLst(qr:TADOQuery; numLista:String; tpLstConvidados: integer);
var
  cmd:String;
begin
   cmd := dm.getCMD('prd', 'Espelho');

   dm.setParam(cmd, numLista);

   case  tpLstConvidados of
      0: dm.setParam(cmd, dm.getCMD('prd', 'Espelho.ItNBaixado')); {Não comprados, }
      2: dm.setParam(cmd, dm.getCMD('prd', 'Espelho.ItBaixado')); {so Comprados }
      1: dm.setParam(cmd, ' '); {todos}
   end;

   dm.getQuery(qr, cmd);
   funcoes.gravaLog(intTostr(qr.RecordCount));
{
   Não comprados
    Todos
   Somente Comprados
}
end;

procedure ajustaEntCaminhao(isEntrega:boolean; ref:String);
var
   cmd:String;
begin
   if (isEntrega = true) then
      cmd := dm.getCMD1('prd', 'insEntCarro', ref )
   else
      cmd :=  dm.getCMD1('prd', 'remEntCarro', ref );

   dm.execSQL(cmd);   
end;

function isEntregue(ref:String):boolean;
var
  ds:TdataSet;
begin
   ds:= dm.getDataSetQ(  dm.getCMD1('PRD', 'getDadosEnt', ref ));
   result := (ds.FieldByName('dtSaida').AsString <> '');
   ds.free();
end;

procedure getTbItensEntrega(tb:TADOTable);
begin
   if (tb.TableName <> '') then
      tb.Close();
   dm.getTable(tb, dm.getCMD('PRD', 'getTbPrdEntrega') );
   tb.Close();
end;

procedure listaPrdPendEntrega(tb:TADOTable; uo:String);
var
   cmd: String;
begin
   getTbItensEntrega(tb);

// inserir os dados na tabela nova
   cmd := dm.getCMD2('PRD', 'getItensTbPrdEntrega', tb.TableName, quotedStr(uo));
   dm.execSQL(cmd);

   tb.Open();
end;


procedure getTbItensEntImpr(tb, tbImpr:TADOTable);
begin
   getTbItensEntrega(tbImpr);

   tbImpr.Open();

   tb.First();
   while (tb.Eof = false) do
   begin
     if (tb.fieldByName('entregar').AsString = 'X') then
     begin
        tbImpr.AppendRecord([
           tb.FieldByName('entregar').AsString,
           tb.FieldByName('seqProduto').AsString,
           tb.FieldByName('codigo').AsString,
           tb.FieldByName('NomeProduto').AsString,
           tb.FieldByName('noiva').AsString
        ]);
      end;
      tb.Next();
   end;
end;

procedure gravaDadosSaidaCam(tb:TADOTable; motorista:String );
var
  data:TDate;
  dateTime, cmd :String;
begin
   data := now;

   tb.First();

   while ( tb.Eof=false ) do
   begin
      cmd := dm.getCMD('prd', 'setEntrega');

      dm.setParams(cmd, fdt.dateToSqlDate(data), QuotedStr(motorista), tb.fieldByName('seqProduto').AsString);
      tb.Next();

      dm.execSQL(cmd);
   end;
end;

function getDadosEntProduto(ref:String):TdataSet;
var
   cmd:String;
begin
   cmd := dm.getCMD('prd', 'getDadoEnt');
   dm.setParam(cmd, ref);
   result := dm.getDataSetQ(cmd);
end;

function getDadosProduto(cd_ref:String):TdataSet;
var
   uo, codPc, cmd:String;
begin
	screen.cursor := crhourglass;
	uo := fmMain.GetParamBD('is_uoWell', fmMain.RParReg('Loja'));
	codPc := rParReg('listas','CodPreco');

	cmd := dm.getCMD3('prd', 'getDados', quotedStr(trim(cd_ref)), uo, codPc);

   funcoes.gravaLog(cmd);

   result := funcSQL.getDataSetQ(cmd, fmMain.getconexaoWell());
	screen.cursor := crDefault;
end;


function isfornProdBonificado(cd_ref:String):String;
var
	res:boolean;
   ds:TdataSet;
begin
   ds:= getDadosProduto(cd_ref);











end;



end.
