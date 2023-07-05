unit uMapaSep;

interface

   uses db, classes, SysUtils;


   function criarMapa(tipo, nMapa, nome, uoDest, cd_pes, pc:string; uos:TstringList; soComEst:boolean):String;
   function getItensMapa(pco, tipo, nMapa, uoDest:String; soComEst:boolean):TdataSet;

   function getDadosMapa(numMapa:String):TdataSet;
   function getDadosItens(numMapa:String):TdataSet;
   function insereItem(seqMapa, pco:String; dsIt:TdataSet; uos:Tstringlist):boolean;

implementation

uses uDm, funcoes, msg, fdt;


function insereItem(seqMapa, pco:String; dsIt:TdataSet; uos:Tstringlist):boolean;
var
  c, cI:String;
  i:integer;
begin
   dsIt.First();
   while(dsIt.Eof = false) do
   begin
      c:=
      dm.getCMD5('fmMapa', 'insItem',
         seqMapa,
         dsIt.fieldByName('is_ref').AsString,
         dsIt.fieldByName('qt_emb').AsString,
         dsIt.fieldByName('qt').AsString,
         valorSql(dsIt.fieldByName('pco').AsString)
      );

      result := dm.execSQL(c);
      dsIt.Next();
   end;


   dsIt.First();
   while(dsIt.Eof = false) do
   begin
      for i:= 0 to uos.Count - 1 do
        cI := cI+ #13 +  dm.getCMD3('fmMapa', 'InstItemQt', seqMapa, dsIt.fieldByName('is_ref').AsString, uos[i]);
      dm.execSQL(cI);
      dsIt.Next();
   end;
end;

function getDadosMapa(numMapa:String):TdataSet;
begin
   result := dm.getDataSetQ(dm.getCMD1('fmMapa', 'LoadMapa', numMapa));
end;

function getDadosItens(numMapa:String):TdataSet;
begin
   result :=  dm.getDataSetQ( dm.getCMD1('fmMapa', 'loadItens', numMapa) );
end;

function getItensMapa(pco, tipo, nMapa, uoDest :String; soComEst:boolean):TdataSet;
var
   c, strEstoque:string;
   i:integer;
begin
   if (soComEst = true) then
      strEstoque := dm.getCMD1('fmMapa', 'getItEst', uoDest)
   else
      strEstoque :=  ' ';

   if (tipo = 'P') then
      c := dm.getCMD4('fmMapa', 'getItPed', pco, uoDest, nMapa, strEstoque)
   else if (tipo = 'C') then
      c := dm.getCMD4('fmMapa', 'getItCod', pco, uoDest, quotedStr(nMapa+'%'), strEstoque)
   else if (tipo = 'N') then
      c := dm.getCMD4('fmMapa', 'getItNf', pco, uoDest, nMapa, strEstoque);

   result := dm.getDataSetQ(c);


   if (Result.IsEmpty = true) then
      msg.msgErro(dm.msg('fmMapa.errNoitems'));

end;

function criarMapa(tipo, nMapa, nome, uoDest, cd_pes, pc:string; uos:TstringList; soComEst:boolean):String;
var
   seqMapa, c:String;
   dsI:TdataSet;
begin
   seqMapa := '-1';

   c := dm.getQtCMD2('fmMapa', 'mapaExiste', tipo, nMapa);
   c:= dm.openSQL(c, '');
   if ( c = '') then
   begin
      dsI := uMapaSep.getItensMapa(pc, tipo, nMapa, uoDest, soComEst);

      if  (dsI.IsEmpty = false) then
      begin
         c := dm.getCMD7('fmMapa', 'insereMapa', quotedStr(tipo), quotedStr(nMapa), quotedStr(nome), fdt.dateToSqlDate(dm.getDateBd()), cd_pes, pc, uoDest);
         seqMapa := dm.openSQL(c, '');
         uMapaSep.insereItem(seqMapa, pc, dsI, uos);
         result := seqMapa;
      end;
   end
   else
     msg.msgErro(dm.msg('fmMapa.errRep'));

   result := seqMapa;
end;

end.
