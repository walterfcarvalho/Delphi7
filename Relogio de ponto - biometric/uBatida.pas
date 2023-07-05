unit uBatida;

interface

uses controls, classes, SysUtils, AdoDb, db;

   function getBatidas(dtInicio, dtFim, cartao: String): TStringList;
   function getTimeUltBat(cartao: String): integer;
   function isHaveBatida(dia:Tdate; cartao:String): boolean;
//   function isHaveBatida(cartao:String): boolean;   
   function isBatVaz(bat:String):boolean;



implementation

uses fdt, f, uDm;


function getTimeUltBat(cartao: String): integer;
var
   cmd:String;
begin
   cmd := dm.getCMD1('bat', 'getMinAposUlt', cartao);
   cmd := dm.openSQL(cmd, '');
   result :=  strToInt(cmd);
end;

function getBatidas(dtInicio, dtFim, cartao: String): TStringList;
var
   aux:TStringList;
   ds:TdataSet;
   cmd:String;
begin
   cmd := dm.getCMD3('bat', 'getPorPeriodo',
                     cartao,
                     fdt.DateTimeToSqlDateTime(dtInicio, '00:00:00'),
                     fdt.DateTimeToSqlDateTime(dtFim, '23:59:00')
                    );

   ds := dm.getDataSetQ(cmd);

   aux := TstringList.Create();
   ds.First;
   while (ds.eof = false) do
   begin
     aux.Add(ds.fieldByName('data').AsString +',00000000,'+ f.preencheCampo(3,'0','e', ds.fieldByName('Loja').AsString )  );
     ds.Next;
   end;
   ds.free();
   result := aux;
end;

function isHaveBatida(dia:Tdate; cartao:String): boolean;
begin
   result := (getBatidas(dateToStr(dia), dateToStr(dia), cartao ).Count > 0 );
end;

function isBatVaz(bat:String):boolean;
begin
   result := (bat = '  :  ');
end;




end.
