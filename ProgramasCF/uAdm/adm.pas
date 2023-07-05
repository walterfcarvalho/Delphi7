unit adm;

interface

   uses Controls,
        uMain, f, fdt, uDm;

   function getSomaCompromissoPorCategoria(di, df: Tdate; categoria:String):String;

implementation

uses SysUtils;

var
  cmd:String;


function getSomaCompromissoPorCategoria(di, df:Tdate; categoria:String):String;
begin
   cmd :=
   ' select sum(dspar.valpar) as valor from dsdct ' +
   ' inner join dspar  on dspar.numdoc= dsdct.numdoc ' +
   ' where ' +
   ' dspar.datven >= ' + fdt.dataToSqlInt(di) +
   ' and dspar.datven <= ' + fdt.dataToSqlInt(df) +
   ' and dsdct.cod_categ= ' + QuotedStr(categoria);

   result := dm.openSQL(cmd, 'valor' );
end;

end.
 