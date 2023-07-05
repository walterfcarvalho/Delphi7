unit uLista;

interface

	uses db, adodb;

   function isPodeImprimirTermo(tpLista:String):boolean;

	function calcVlBonusLista(var itensFora:String; numLista:String):real;



implementation

   uses udm, uProduto, Unit1, funcoes, funcSQL, classes;

function isPodeImprimirTermo(tpLista:String):boolean;
begin
   result := dm.getDataSetQ( dm.getCMD1('lst','getDadosTp', tpLista) ).FieldByName('impTermo').AsBoolean;
end;


function calcVlBonusLista(var itensFora:String; numLista:String):real;
var
	qrLst:TADOquery;
   dsItem:TdataSet;
   uo, cmd:String;
   bonus:real;
   fornSemBonus:Tstringlist;
   prdSemBon, isPcPromo:boolean;
begin
   fornSemBonus := dm.getListagem( dm.getCMD('param', 'getFornSemBonus'), 0);

	uo := funcoes.RParReg('listas', 'loja');

//pega os itens
	qrLst := TADOQuery.Create(nil);
	uProduto.getQrItensLst(qrLst, numLista, 1 {produtos baixados} );

	qrLst.First();
   while (qrLst.Eof = false) do
   begin
   	prdSemBon := false;
		isPcPromo := false;

		dsItem := uproduto.getDadosProduto(qrLst.fieldByName('codigo').AsString);
// verifica se e bonificado
      if (fornSemBonus.IndexOf(dsItem.fieldByName('fornecedor').AsString) > 0) then
      	prdSemBon := true;

// verifica se e promocao
      isPcPromo := (dsItem.fieldByName('fornecedor').AsString = '1');

      if (prdSemBon = true) then
	     	itensFora :=
  	      	itensFora +
         	dsItem.fieldByName('codigo').AsString + ' '+
         	copy(dsItem.fieldByName('descricao').AsString, 01, 20) + ' -> '+
            ' Forn não bonificado.' +#13;

		if (isPcPromo = true) then
	     	itensFora :=
  	      	itensFora +
         	dsItem.fieldByName('codigo').AsString + ' '+
         	copy(dsItem.fieldByName('descricao').AsString, 01, 20) + ' -> '+
            ' item em promoção.' +#13;

		if (isPcPromo = false) and (prdSemBon = false) then
   		bonus := bonus + qrLst.fieldByName('valor').AsFloat;

		dsItem.free();
      qrLst.Next;
   end;
   fornSemBonus.Free;
   qrLst.Free();
	result := bonus;
end;



end.
