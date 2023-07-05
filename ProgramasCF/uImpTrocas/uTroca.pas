unit uTroca;


interface

   uses ADODB, Classes, sysutils, Dialogs, forms, QForms,
        ComCTRLs, windows, QStdCtrls, DB, DBCtrls,
        Controls, messages;

	function getItensTroca(num:String; isEntrada:boolean):Tdataset;
	function getTroca(num, uo:String):Tdataset;


implementation

	uses uEstoque, uMain, uDm, fdt, f, uSelecionaUo, uListaImpNFE, msg, uProd;


function getTroca(num, uo:String):Tdataset;
var
   cmd:String;
begin
	cmd := dm.getCMD2('vendas','lstTroca', num, uo );
   result := dm.getDataSetQ(cmd);
end;

function getItensTroca(num:String; isEntrada:boolean):Tdataset;
var
   tipo,cmd:String;
begin
	if (isEntrada = true) then
	   tipo := '1'
   else
	   tipo := '0';

	cmd := dm.getCMD2('vendas', 'lstItemsTroca', num, tipo);
   result := dm.getDataSetQ(cmd);
end;



end.
