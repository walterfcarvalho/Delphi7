unit uContabil;

interface

uses  SysUtils, Controls, db;

   function removeLancContabil(empresa, prefixoSeq, seqI, seqF:String; is_fiscal:boolean):integer;
   function removeLotes( empresa, seqI, seqF:String):integer;
   function getFichasCatContabil(empr, catCont:String; di, df:Tdate):TdataSet;

   procedure sincronizaPlanoDeContas();



implementation

uses msg, f, uDm, uMain, fdt;

function removeLancContabil(empresa, prefixoSeq, seqI, seqF:String; is_fiscal:boolean):integer;
var
   cmd:String;
   res:integer;
begin
   res:= 0;
   cmd :=
   ' delete from dslan where ' +
   ' cod_emp= ' + quotedStr(trim(empresa)) +
   ' and seq_lanc between ' + prefixoSeq+seqI + ' and ' + prefixoSeq+seqF +
   ' and lanc_ger=  ' + f.SohNumerosPositivos(boolToStr(is_fiscal));
   res := dm.execSqlInt(cmd);

   dm.execSqlInt('delete from dster');

   result := res;
end;

procedure sincronizaPlanoDeContas();
var
   cmd:String;
   empresas:array[1..3] of String;
   i:integer;
begin
   empresas[1] := 'PM';
   empresas[2] := 'CF';
   empresas[3] := 'PF';

   for i:=1 to 3 do
   begin
      fmMain.msgStatus('Sincronizando empresa '+ empresas[i]  );

      cmd := dm.getQtCMD1('contab', 'limpPlConta', empresas[i] );
      dm.execSQL(cmd);

      cmd :=
      dm.getQtCMD1('contab', 'cpPlContas', empresas[i]);

      dm.execSQL(cmd);
   end;
   msg.msgExclamation('Plano de contas Copiado.');
end;

function getFichasCatContabil(empr, catCont:String; di, df:Tdate ):TdataSet;
var
   datas, cmd:String;
begin
   datas := fdt.getStrDiasPeriodo(di, df);

   cmd := dm.getCMD('contab', 'getFichasPorCodcont');
   dm.setQtParam(cmd, empr);
   dm.setParam(cmd, datas);
   dm.setQtParam(cmd, catCont);
   result := dm.getDataSetQ(cmd);
end;

function removeLotes( empresa, seqI, seqF:String):integer;
var
  c:String;
begin
   c:= dm.getQtCMD3('contab', 'remLotes', trim(empresa), trim(seqI), trim(seqF));
   result := dm.execSqlInt(c);
   f.gravaLog(Result);
end;

end.
