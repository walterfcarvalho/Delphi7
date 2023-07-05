unit uModPag;

interface
  uses classes, controls, sysutils, db;


	function getCodModPag(mostraItemTodos, isAcessoRestrito:boolean):TStringList;
   function getNsuTefFromSeq(seq:String):String;
   function gravaLogModalidades(uo, caixa, cd_pes, seqTransCaixa, tpAlteracao, codModAntigo, numParcAnt, codModNovo, numParcNovo, valorAnt, valorNovo, seqPagamento:String):boolean;

   procedure getMacOprTef(data:Tdate; seq, nsu:String);


implementation

uses f, fdt, msg, uDm;

function getNsuTefFromSeq(seq:String):String;
begin
   result := dm.openSQL(dm.getCMD1('TEF','getNsuFromSeq', seq), '');
end;

procedure getMacOprTef(data:Tdate; seq, nsu:String);
var
   cmd:String;
   ds:TdataSet;
begin
   if (nsu = '') then
      nsu := getNsuTefFromSeq(seq);

   if (nsu = '') then
     nsu := '-1';

   cmd := dm.getCMD2('tef', 'listaMac', fdt.dateToSqlDate(data), nsu);

   ds:= dm.getDataSetQ(cmd);

   msg.msgItDs(ds);

   ds.Free();
end;

function gravaLogModalidades(uo, caixa, cd_pes, seqTransCaixa, tpAlteracao, codModAntigo, numParcAnt, codModNovo, numParcNovo, valorAnt, valorNovo, seqPagamento:String):boolean;
var
   cmd:String;
begin
   cmd :=
   'Insert zcf_log_altModPag values( '+
   dm.getDataBd() + ', '+
   uo + ', '+
   quotedStr(caixa) + ', '+
   quotedStr(cd_pes) + ', '+
   quotedStr(seqTransCaixa) + ', '+
   quotedStr(tpAlteracao) + ', '+
   quotedStr(codModAntigo) + ', '+
   f.valorSQL(valorAnt)      + ', '+
   quotedStr(numParcAnt) + ', '+
   quotedStr(codModNovo) + ', '+
   valorSQL(valorNovo) + ', '+
   quotedStr(numParcNovo) +', '+
   quotedStr(seqPagamento) +
   ') ';

   result := dm.execSQL(cmd);
end;

function getCodModPag(mostraItemTodos, isAcessoRestrito:boolean):TStringList;
var
   aux:TStringList;
   cmd :String;
   ds:TdataSet;
begin
   aux := TStringList.Create();

   if ( isAcessoRestrito = false ) then
		cmd := dm.getCMD('cx', 'getLstModPag')
   else
		cmd := dm.getCMD('cx', 'getLstModPagRest');

   ds := dm.getDataSetQ(cmd);
   ds.first();

   if (mostraItemTodos = true) then
      aux.add('< Todos >');

   while (ds.eof = false) do
   begin
      aux.add(  f.preencheCampo(50, ' ', 'D', ds.fieldByName('ds_mve').asString) +
                ds.fieldByName('cd_mve').asString
              );
      ds.next();
    end;
    result := aux;
end;




end.
