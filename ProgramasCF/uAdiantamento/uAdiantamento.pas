unit uAdiantamento;


interface
   uses db, sysutils;

   function getBaixasAdiantamentos(nr_adi:String):TdataSet;
   function removeUsoDeCreditoCliente(nr_adi, titulo:String; devolveCredito:boolean):boolean;
   function getAdiantamentos(cd_pes:String):TdataSet;
   function removeCreditoCliente(nr_adi:String):boolean;
implementation

uses udm;

function getBaixasAdiantamentos(nr_adi:String):TdataSet;
begin
   result := dm.getDataSetQ( dm.getCMD1('financeiro', 'getBaixaAdi', nr_adi)) ;
end;

function getAdiantamentos(cd_pes:String):TdataSet;
var
   cmd:String;
begin
   result :=
   dm.getDataSetQ( dm.getCMD1('financeiro', 'getAdi', cd_pes)) ;
end;

function removeCreditoCliente(nr_adi:String):boolean;
begin
   result := dm.execSQL('delete from dsadi where nr_adi= ' + nr_adi);
end;

function removeUsoDeCreditoCliente(nr_adi, titulo:String; devolveCredito:boolean):boolean;
var
   cmd:String;
begin
   if ( devolveCredito = true ) then
   begin
      cmd :=
      ' update dsadi' +#13+
      ' set val_uti= ' +#13+
      ' val_uti - (select val_adi from dsadd where nr_adi= ' + nr_adi +
      ' and  id_titulo = ' + QuotedStr(titulo) +')' +#13+
      ' where nr_adi = ' + nr_adi;
      dm.execSQL(cmd);
   end;

   cmd :=
   'delete from dsadd where nr_adi = ' + nr_adi;

   if (titulo <> '') then
      cmd := cmd + ' and  id_titulo = ' + QuotedStr(titulo);

   result := dm.execSQL(cmd);
end;




end.
