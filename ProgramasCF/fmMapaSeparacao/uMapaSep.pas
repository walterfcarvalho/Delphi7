unit uMapaSep;

interface

   uses db;

   function getDadosMapa(numMapa:String):TdataSet;
   function getDadosItens(numMapa:String):TdataSet;

implementation

uses uDm, f;

function getDadosMapa(numMapa:String):TdataSet;
begin
   result := dm.getDataSetQ(dm.getCMD1('fmMapa', 'LoadMapa', numMapa));
end;

function getDadosItens(numMapa:String):TdataSet;
begin
   result :=  dm.getDataSetQ( dm.getCMD1('fmMapa', 'loadItens', numMapa) );
end;

end.
 