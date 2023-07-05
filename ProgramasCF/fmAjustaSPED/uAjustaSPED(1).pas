unit uAjustaSPED;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fCtrls, Buttons, adLabelEdit, IniFiles, DB, ComCtrls, math,
  ExtCtrls, adLabelNumericEdit;

type
  TfmAjustaSPED = class(TForm)
    edArq: TadLabelEdit;
    fsBitBtn1: TfsBitBtn;
    memo: TfsMemo;
    btOcoProduto: TButton;
    edRef: TEdit;
    cbAjustaDia: TfsCheckBox;
    data: TfsDateTimePicker;
    edECF: TadLabelEdit;
    pnFiscal: TPanel;
    cbAjustaECF: TfsCheckBox;
    cbAjCfoEnt: TfsCheckBox;
    cbAjVlTotNota: TfsCheckBox;
    cbAjTotTribEcf: TfsCheckBox;
    rgTpSped: TRadioGroup;
    pnPis: TPanel;
    cbAjusEcfPISCofins: TfsCheckBox;
    cbVerDrgRedPisCofins: TfsCheckBox;
    cbdirvg_c100: TfsCheckBox;
    edDifc100_170: TadLabelNumericEdit;
    edDicc481: TadLabelNumericEdit;
    cbAjCodProd: TfsCheckBox;
    cb_c190_c490: TfsCheckBox;
    cbAjC100: TfsCheckBox;
    cbRem_C425_duplicado: TfsCheckBox;
    function ajCfoItensNFEntrada(fl:TstringList):TStringList;
    function ajIsrefFromcdref(fl:TstringList):TStringlist;
    function AjReg_C190_490(Fl:TStringlist): TStringlist;
    function ajustaValoresECF(fl:TstringList):TStringlist;
    function ajRegC100(fl:Tstringlist):TstringList;
    function ajustaValoresECF_PisCofins(fl:TstringList):TStringlist;
    function ajustaValoresReducao(ds: TdataSet; fl:TstringList):TStringlist;
    function ajustaValoresReducao_pisCofins(ds: TdataSet; fl:TstringList):TStringlist;
    function ajValorTotalNfEnt(fl:TstringList):TStringList;
    function ajVlTotTribEcf(fl:TstringList): TStringList;
    function cpToDate(numCampo:integer; linha:String):Tdate;
    function getC190Nf(idxC100:integer; fl:TstringList):Tstringlist;
    function getC490(idxC405:integer; fl:TstringList):Tstringlist;
    function getCfoNf(idx:integer; fl:TstringList):String;
    function getCp(numCampo:integer; linha:String):String;
    function getCpInt(indice:integer; str:String):integer;
    function getIdx_c400(fl:TstringList; serie:String):integer;
    function getIdx_c405(fl:TstringList; idx_c400:integer; data:Tdate):integer;
    function getIdx_fim_c481_C485(fl:TstringList; tpReg:String; inicio:integer):integer;
    function getIdxC490_cfo():integer;
    function getIdxItemMaiorValor(var fl:TstringList; idxItemIni, idxItemFim:integer; codCampo:String):integer;
    function getIdxReg(arq: TStringList; idRegistro: String): integer;
    function getIndexReg(arq: TStringList; idRegistro: String; idxI, idxF:integer): integer; overload;
    function getIsRef(linha:String):String;
    function getItensFaturados(arq:TstringList):TStringList;
    function getItensReg0200(arq:TStringList):TStringList;
    function getNumNota(str:String):integer;
    function getNumReg(linha:String):String;
    function getNumRegDuplo(linha:String):String;
    function getPosInicio(idCampo:integer; linha:String):integer;
    function getVlCampo(numCampo:integer; linha:String):Real;
    function somaIntervalo(fl:Tstringlist; i,count, campo:integer):real;
    function updateCampo(linha:String; idCampo:integer; novoValor:String):String;
    function updateCampoArq(var arq:TStringlist; idRegistro:String; idCampo:integer; novoValor:String):boolean;
    function updateCampoItensPisCofins(linha:String; diF:Real):String;
    procedure addMemo(msg:String);
    procedure ajustaEmissorNota(nmArquivo:String);
    procedure ajustaNumeracoesNotas(nmArquivo:String);
    procedure ajustarArqParaSPED(nmArq:String);
    procedure ajustarArqParaSPED_pis_cofins(nmArq:String);
    procedure ajustaRegC425(nArq:String);
    procedure ajustaRegistroInventario(nmArquivo:String);
    procedure atualizaTotalLinhas(var arq:Tstringlist);
    procedure btOcoProdutoClick(Sender: TObject);
    procedure cbAjustaDiaClick(Sender: TObject);
    procedure cbdirvg_c100Click(Sender: TObject);
    procedure cbVerDrgRedPisCofinsClick(Sender: TObject);
    procedure diminuiVlItens(var fl:TstringList; idxItemIni, idxItemFim, idxItemMaisCaro:integer; vlExcesso:real);
    procedure edArqDblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure incluirItensFaturados(nmArquivo:String);
    procedure insereItensReg200(var arq:TStringList; itensAInserir: TStringList);
    procedure Log(str:String);
    procedure pesqMovimentoItem(isReF:String);
    procedure removeItensSemNota(nArq:String);
    procedure rgTpSpedClick(Sender: TObject);
    procedure trocaCfoItensNf(cfoNovo:String; idx:integer;  var fl:TstringList);
    procedure verDirvgC100_c170(fl:TstringList);
    procedure verDirvgC405_C481_c485(fl:TstringList);

    function getIdxCpDuplo(arq:Tstringlist; idxCampo1:integer; vlCampo1:String; idxCampo2:integer; vlCampo2:String):integer;
    function rem_C425_duplicado(Fl: TstringList):TStringList;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAjustaSPED: TfmAjustaSPED;

implementation

uses  uMain, fdt, f, funcSql, cf, uFiscal, uDm, uEstoque,
      msg, ulj, uPreco, uHash, uProd, uHash3F;

{$R *.dfm}

function TfmAjustaSPED.rem_C425_duplicado(Fl: TstringList):TStringList;
var
   i, i2, i3:integer;
   c490_b1_i, c490_b1_f:integer;
   c490_b2_i, c490_b2_f:integer;

   qtRemovidos:integer;

   lst:TStringList;
   vlSegF6:real;
begin
   // remove os registros duplicados c420
   // que são os produtos com substituição tributaria

   try
      qtRemovidos := 0;
      i:= 7172;
      while (i <  fl.Count-1) do
      begin
         if (getCp(1, fl[i]) = 'C420') and (getCp(2, fl[i]) = 'F6') then
         begin
            vlSegF6 := 0;
            f.gravaLog('Registro c420, linha: ' + intToStr(i) +' ->'+ fl[i] );

            c490_b1_i := i;
            c490_b2_i := -1;
            i2:= i+1;



            while (getCp(1, fl[i2]) <> 'C490') or (i2 <= fl.Count-1) do
            begin
               if {( getCp(1,aux) = 'C490') or} ( getCp(1,fl[i2]) = 'C420') and (getCp(2,fl[i2]) <> 'F6')  then
               begin c490_b2_i := -1; break; end;

               if ( getCp(1, fl[i2]) = 'C420') and (getCp(2, fl[i2]) = 'F6') then
               begin
                  vlSegF6 := getVlCampo(3, fl[i2]);
                  f.gravaLog('-- Segundo c420: ' + intToStr(i2) + ' -->'+ fl[i2] );

                  c490_b2_i := i2 +1; c490_b2_f := i2 +1;

                  while (getCp(1, fl[c490_b2_f  +1]) = 'C425') do
                     inc(c490_b2_f);

                  inc(i2);
               end;

               if ( c490_b2_i > 0 )then
               begin
                  f.gravaLog('Itens em: ' +intToStr(c490_b2_i) + ' a ' + intToStr(c490_b2_f) );

                  lst := TStringList.Create();

                  for i3:= c490_b2_i to c490_b2_f do
                     lst.add(fl[i3]);

                  f.gravaLog(lst);

                  f.gravaLog('Deletar');
                  f.gravaLog(c490_b2_i);
                  f.gravaLog(c490_b2_f);


                  for i3:= c490_b2_i to c490_b2_f do
                  begin
                     fl[i3] := fl[i3] + '  XXXXX';
//                     fl.delete(i3);
                  end;

                  for i3:= 1 to lst.Count -1 do
                     fl.Insert(c490_b1_i +1, lst[i3]+ '<-- ' );

                  inc(qtRemovidos);
                  lst.Free();

                  c490_b2_i := -1;

               end;

               inc(i2);
            end;
         end;
            if i >= 7255 then
            break;
      
         inc(i);
      end;
      //   fl.SaveToFile('d:\teste.txt');
      result := Fl;

   except
   on e:exception do
   begin
      f.gravaLog(fl[i]);
      f.gravalog(i);
   end;
end;



end;


function TfmAjustaSPED.ajRegC100(fl:Tstringlist):TstringList;
var
   i:integer;
   c12, c16:String;
begin
   for i:=0 to fl.Count - 1 do
   begin
      if (getCp(1, fl[i]) = 'C100') and (getCp(2, fl[i]) = '0') then
      begin
         c12 := getCp(12, fl[i] );
         c16 := getCp(16, fl[i] );

         fl[i] := updateCampo(fl[i], 12, c16);
         fl[i] := updateCampo(fl[i], 16, c12);
      end
      else if (getCp(1, fl[i]) = 'C400') then
         break;
   end;
   result := fl;
end;

function TfmAjustaSPED.getIdxCpDuplo(arq:Tstringlist; idxCampo1:integer; vlCampo1:String; idxCampo2:integer; vlCampo2:String):integer;
var
   i:integer;
   res:integer;
begin
   res := -1;
   for i:=0 to arq.Count -1 do
   begin
      if (getCp(idxCampo1, arq[i]) = vlCampo1) and
         (getCp(idxCampo2, arq[i]) = vlCampo2) then
      begin
         res := i;
         break;
      end;
   end;
   result := res;
end;

function TfmAjustaSPED.AjReg_C190_490(Fl:TStringlist): TStringlist;
var
	i, j:integer;
   v5, v6, v7, v11:real;
   idx9999, qt9999, qtC990 :integer;
   idxC490, qt490, qtRemC490:integer;
   idxC190, qt190, qtRemC190:integer;
   idxC990 :integer;
   vCampo:String;
   lstDeletados:Tstringlist;
begin
   lstDeletados:= TStringlist.create;

   memo.Lines.Add('Remove duplicados C190/C490');

   qtRemC490 := 0;
   qtRemC190 := 0;

   i:=7950;
   while i <= Fl.Count - 1 do
//	for i:=0 to fl.Count - 1 do
   begin
//         f.gravaLog(i);
//      if i = 7955 then
//         f.gravaLog('linha7955');

    	if (getCp(1, Fl[i]) = 'C190') or (getCp(1, Fl[i]) = 'C490') then
      begin
         vCampo := getCp(1, Fl[i]);
         j:= i+1;

         while (getCp(1, Fl[j]) = vCampo) do
         begin
            if (getCp(1, Fl[i]) = getCp(1, Fl[j])) and (getCp(2, Fl[i]) = getCp(2, Fl[j])) and(getCp(3, Fl[i]) = getCp(3, Fl[j])) then
            begin
               v5:= getVlCampo(5,Fl[i]) + getVlCampo(5,Fl[j]);

               v6:= getVlCampo(6,Fl[i]) + getVlCampo(6,Fl[j]);
               v7:= getVlCampo(7,Fl[i]) + getVlCampo(7,Fl[j]);
               v11:=getVlCampo(11,Fl[i]) + getVlCampo(11,Fl[j]);

               Fl[i] := updateCampo(Fl[i], 5, floatToStr(v5));
               Fl[i] := updateCampo(Fl[i], 6, floatToStr(v6));
               Fl[i] := updateCampo(Fl[i], 7, floatToStr(v7));
               Fl[i] := updateCampo(Fl[i],11, floatToStr(v11));


               if (getCp(1, Fl[i]) = 'C190') then inc(qtRemC190);

               if (getCp(1, Fl[i]) = 'C490') then inc(qtRemC490);

               Fl[j] := updateCampo(Fl[i], 1, 'Deletar');

               lstDeletados.Add( intToStr(j));
            end;
            inc(j);
         end;
      end;
      inc(i);
   end;

   // C990
   idxC990 := getIdxReg(FL, 'C990');
   qtC990 := getCpInt(2, Fl[idxC990]);
   qtC990 := qtC990 - (qtRemC490 + qtRemC190);
   fl[idxC990] := updateCampo(Fl[idxC990], 2, intToStr(qtC990));


   idxC490 := getIdxCpDuplo(Fl, 1, '9900', 2, 'C490');
   qt490 := getCpInt(3, Fl[idxC490]);
   Fl[idxC490] := updateCampo(Fl[idxC490], 3, intToStr( qt490 - qtRemC490));


   idxC190 := getIdxCpDuplo(Fl, 1, '9900', 2, 'C190');
   qt190 := getCpInt(3, Fl[idxC190]);
   Fl[idxC190] := updateCampo(Fl[idxC190], 3, intToStr( qt190 - qtRemC190) );


// pega o contador do reg 9999
   idx9999 := Fl.Count -1;
   qt9999 := getCpInt(2, Fl[idx9999]);

   Fl[idx9999] := updateCampo(Fl[idx9999], 2,  intToStr(qt9999-(qtRemC490 + qtRemC190)) );


   i:=0;
   while i< Fl.Count-1 do
   begin
      if (getCp(1, Fl[i]) = 'Deletar') then
      begin
         f.gravaLog(intToStr(i) + Fl[i]);
         Fl.Delete(i);
         dec(i);
      end;
      inc(i);
   end;
   result := Fl;
end;

function TfmAjustaSPED.ajIsrefFromcdref(Fl:TStringlist): TStringlist;
var
	i, cpIsReF:integer;
   is_ref, cd_reF:String;
   hash : Thash;
begin
   memo.Lines.Add('Muda o identificador dos produtos...');
	hash:= Thash.Create();

	for i:=0 to  fl.Count - 1 do
   begin
    	cpIsRef := -1;

   	if ( getCp(1, Fl[i]) = '0200') then
      	cpIsRef := 2
      else if (getCp(1, Fl[i]) ='C170') then
	      cpIsRef := 3
      else if (getCp(1, Fl[i]) ='C425')then
	      cpIsRef := 2;

		if (cpIsRef <> -1) then
      begin
      	is_ref := getCp(cpIsRef, Fl[i]);
      	cd_ref := hash.getValor(intToStr(hash.indexOf(is_ref)));

         if (cd_ref = '') then
         begin
         	cd_ref := uProd.getCp('is_ref', is_ref, 'codigo');
            hash.add(is_ref, cd_ref);
         end
         else
         begin
	         f.gravaLog('Pego do hash');
         end;

         Fl[i] := updateCampo(Fl[i], cpIsRef, cd_ref );
         f.gravaLog('is_ref: ' + is_ref + ' cd_ref:' + cd_ref);
      end;
   end;
   result := Fl;

   memo.lines.Delete(memo.Lines.Count-1);
   memo.Lines.Add('Muda o identificador dos produtos... ok');
end;

function TfmAjustaSPED.cpToDate(numCampo: integer; linha: String): Tdate;
var
  str:String;
begin
   str:= getCp(numCampo, linha);

   insert('/',str, 5);
   insert('/',str, 3);

   result := StrToDate(str);
end;

function TfmAjustaSPED.somaIntervalo(fl:Tstringlist; i, count, campo:integer):real;
var
  soma:real;
begin
   soma := 0;

   for i:=i to count do
      soma := soma + getVlCampo(campo, fl[i]);

   result := soma;
end;


function TfmAjustaSPED.updateCampoItensPisCofins(linha:String; diF:Real):String;
var
  imposto, aliquota, vlItem:real;
begin
   aliquota := getVlCampo(5, linha) / 100;

   vlItem := getVlCampo(2, linha);

   vlItem := vlItem + dif;

   linha := updateCampo(linha, 3, f.floatToStrFomatado(vlItem, true));
   linha := updateCampo(linha, 4, f.floatToStrFomatado(vlItem, true));

   imposto := vlItem * aliquota;

   linha := updateCampo(linha, 8, f.floatToStrFomatado(imposto, true));

   Result := linha;
end;

function TfmAjustaSPED.getIdx_fim_c481_C485(fl:TstringList; tpReg:String; inicio:integer):integer;
var
   i:integer;
begin
  // retorna o index no arquivo do ultimo regstro do campo c481 ou c485
   result := -1;
   for i:= inicio to fl.Count -1 do
      if ( getCp(1, fl[i]) = tpReg) then
         Result := i
      else
         break;
end;

function TfmAjustaSPED.getIdx_c405(fl:TstringList; idx_c400:integer; data:Tdate):integer;
var
   c405, i:integer;
   sData:String;
begin
   sData := fdt.dateToDDMMAAA(data);

   c405 := -1;
   for i:= idx_c400 to fl.Count -1 do
      if ( getCp(1, fl[i]) = 'C405') and (getCp(2, fl[i]) =  sData ) then
      begin
         c405 := i;
         break;
      end;
   result := C405;
end;

function TfmAjustaSPED.getIdx_c400(fl:TstringList; serie:String):integer;
var
   i, lC400:integer;
begin
   { // procurar o registro c400  da impressora.}
   lC400 := -1;
   for i:=0 to fl.Count - 1 do
      if ( getCp(1, fl[i]) = 'C400') and (getCp(4, fl[i]) = serie) then
      begin
         lC400 := i;
         break;
      end;
   result := lC400;
end;

function TfmAjustaSPED.getCp(numCampo:integer; linha:String): String;
var
   posInicio, tamanho:integer;
begin
   // retorna o conteúdo do campo
   // o primeiro campo é o indice 1

   tamanho := 1;

   posInicio := getPosInicio(numCampo, linha);

   while ((tamanho+posInicio) <= length(linha)) and (copy(linha, (posInicio+tamanho), 01) <> '|' ) do
      inc(tamanho);

   result := copy(linha, posInicio+1, tamanho-1);
end;

function TfmAjustaSPED.getC490(idxC405:integer; fl:TstringList):Tstringlist;
var
  i:integer;
  res:TStringlist;
begin
//   retorna as linhas dos registros c490 de uma impressora por dia;

   res := TStringlist.Create();
   for i:= (idxC405 +1) to fl.Count -1 do
   begin
      if (getCp(1, fl[i]) = 'C490') then
         res.Add( intToStr(i) );

      if (getCp(1, fl[i]) = 'C400') or
         (getCp(1, fl[i]) = 'C405') or
         (getCp(1, fl[i]) = 'C990') then
         break;
   end;
   result := res
end;


function TfmAjustaSPED.getC190Nf(idxC100:integer; fl:TstringList):Tstringlist;
var
   c190:TstringList;
begin
   c190:= TstringList.Create();

   inc(idxC100);
   while (idxC100 < fl.Count-1) do
   begin
      if (getCp(1, fl[idxc100]) = 'C190') then
         c190.Add(intToStr(idxC100));

     if (getCp(1, fl[idxc100]) = 'C100') or (getCp(1, fl[idxc100]) = 'C400') then
        break;
      inc(idxC100);
   end;
   result := c190;
end;

function TfmAjustaSPED.ajCfoItensNFEntrada(fl:TstringList):TStringList;
var
   i:integer;
   cfo:String;
begin
   f.gravaLog('ajCfoItensNFEntrada()');
   memo.Lines.Add('ajusta cfo de itens da nf entrada');

   for i:=0 to fl.Count - 1 do
   begin
      if ( getCp(1, fl[i]) = 'C100' ) and (getCp(2, fl[i]) = '0') then
      begin
         cfo := getCfoNf(i,fl);
         if ( cfo <> '') then
           trocaCfoItensNf(cfo, i, fl);
      end;
   end;

   result := fl;
end;

procedure TfmAjustaSPED.diminuiVlItens(var fl:TstringList; idxItemIni, idxItemFim, idxItemMaisCaro:integer; vlExcesso:real);
var
   is_reF:String;
   quant, vlCusto:real;
begin
   while (vlExcesso > 0) do
   begin
      f.gravaLog('Excesso a remover dos itens:' + floatToStr(vlExcesso) );

      is_ref := getCp(2, fl[idxItemIni]);

      vlCusto := strToFloat( uPreco.getPcProd(fmMain.getUOCD(), '', is_ref, '1'));
      vlCusto := vlCusto * 1.1;

      quant :=  strToFloat( getCp(3, fl[idxItemIni]));

      vlCusto := vlCusto * quant;

      if (vlExcesso > vlCusto) then
      begin
         fl[idxItemIni] :=  updateCampo(fl[idxItemIni], 05,  f.floatToStrFomatado(vlCusto, true));
         vlExcesso := vlExcesso - vlCusto;

         inc(idxItemIni);
      end
      else
      begin
         fl[idxItemIni] :=  updateCampo(fl[idxItemIni], 05,  f.floatToStrFomatado(({vlCusto - }vlExcesso), true));
         f.gravaLog('Justei :' + f.floatToStrFomatado(({vlCusto - }vlExcesso), true)) ;
         vlExcesso := 0;
      end;
   end;
end;


function TfmAjustaSPED.getIdxItemMaiorValor(var fl:TstringList; idxItemIni, idxItemFim:integer; codCampo:String): integer;
var
   j, idxMaiorItem:integer;
begin
   idxMaiorItem := idxItemIni;
   for j:= idxItemIni to idxItemFim do
      if (getNumReg(fl[j]) = codCampo) then
         if (getVlCampo(5, fl[j]) >  getVlCampo(5, fl[idxMaiorItem]) ) then
            idxMaiorItem := j;

   f.gravaLog(codCampo+': ' + intToStr(idxMaiorItem +1) {indice do item de maior valor] } );
   result := idxMaiorItem;
end;


function TfmAjustaSPED.getVlCampo(numCampo: integer; linha: String): Real;
var
  res:Real;
  aux: String;
begin
   try
      // retorna o conteudo da chave
      // os campos comecam a partir de 1
      aux := getCp(numCampo, linha);
      if (aux = '') then
      begin
         f.gravaLog('Campo Vazio, campo: ' + intToStr(numCampo) + ', linha:'+ linha);
         res := 0;
      end
      else
      begin
         res := strToFloat(aux);
      end;
   except
      res := 0;
      f.gravaLog('Campo: ' + intToStr(numCampo));
      f.gravaLog('Erro na linha:' + linha)
   end;
   result := res;
end;

function TfmAjustaSPED.updateCampo(linha:String; idCampo: integer; novoValor: String): String;
var
   lengthLinha, posInicio:integer;
begin
{   f.gravaLog('updateCampo() linha:' + linha +#13 +
      'campo: ' + intToStr(idCampo) +   ' Valor antigo: ' +
        getCp(idCampo, linha) +  '         Novo valor: '+ novoValor);
}
   posInicio := getPosInicio(idCampo, linha)+1;
   lengthLinha := length(linha);

   while  (copy(linha, posInicio, 01) <> '|') and (posInicio <= lengthLinha   )  do
      delete(linha, posInicio, 01);

   insert(novoValor, linha, posInicio);

   result := linha;
end;

function TfmAjustaSPED.ajustaValoresReducao_pisCofins(ds: TdataSet; Fl:TStringlist):TStringlist;
var
  lC400, lC405:integer;

  c481i, c481f, cDif481:integer;
  c485i, c485f, cDif485:integer;

  dif, vlMaiorItem, difVlCont, vlAux:real;
begin
   c481i := -1;
   c481f := -1;

   f.gravaLog('ajustaValoresReducao_pisCofins()' + ds.fieldByName('dt_mov').asString);
   addMemo('Loja:' + ds.FieldByName('ds_uo').AsString +
           ' EcF:' + ds.FieldByName('nr_ecf').AsString +
           ' Série:' + ds.FieldByName('ser_fab').AsString
   );

// pegando o registro inicial da impressora
   lC400 := getIdx_c400(fl, ds.fieldByName('ser_fab').AsString);

   if (lC400 > -1) then
   begin
      // pegando os dados da redução, por dia
      lC405 := getIdx_c405(fl, lC400, ds.fieldByName('dt_mov').AsDateTime);

      if (lC405 > -1) then
      begin
         // pegar os indices inicio e fim do c481 e c485;
         if (getCp(1, fl[lC405+1]) = 'C481') then
         begin
            c481i := lC405 + 1;
            c481f := getIdx_fim_c481_C485(fl,'C481', c481i);
         end
         else
            c481i := -1;

         if (getCp(1, fl[c481f+1]) = 'C485') then
         begin
            c485i := c481f +1;
            c485f := getIdx_fim_c481_C485(fl,'C485', c485i);
         end
         else
           c485i := -1;

         // calcule a diferenca entre o informado na reducao e o obtido
         dif := ds.fieldByName('vl_contabil').AsFloat - getVlCampo(7, fl[lc405]);

         if (dif > 0) then
         begin
             addMemo('Diferença:' + floatToStrFomatado(dif, false) );

            if (c481i > -1) and (c485i >-1) then
            begin
               // definir qual o item de maior valor no dia para ajustar na diferenca
               cDif481 :=  getIdxItemMaiorValor(fl, c481i, c481f, 'C481');

               cDif485 :=  getIdxItemMaiorValor(fl, c485i, c485f, 'C485');

               // atualiza o valor do  c405
               vlAux := dif + getVlCampo(7, fl[lc405]);
               fl[lC405] := updateCampo(fl[lC405], 7, f.FloatToStrFomatado(vlAux, true));

               // atualiza o valor do maior item c481
               fl[cDif481] := updateCampoItensPisCofins(fl[cDif481], dif);

               fl[cDif485] := updateCampoItensPisCofins(fl[cDif485], dif);
            end
            else
               addMemo('Erro: ');
               addMemo('Não achei o registro C481, C485 para o C405');
               addMemo('');
         end;
      end
      else
         msg.msgErro('Nao achei o C405 da impressora:'  +#13+
            'Data: ' + ds.fieldByName('ds_uo').AsString +#13+
            'Loja: ' + ds.fieldByName('ds_uo').AsString +#13+
            'EcF: ' + ds.fieldByName('nr_ecf').AsString + ' Série: ' + ds.fieldByName('ser_fab').AsString
         );
   end
   else
      msg.msgErro('Nao achei o C400 da impressora:'  +#13+
         'Data: ' + ds.fieldByName('dt_mov').AsString +#13+
         'Loja: ' + ds.fieldByName('ds_uo').AsString +#13+
         'EcF: ' + ds.fieldByName('nr_ecf').AsString + ' Série: ' + ds.fieldByName('ser_fab').AsString
      );
   result := fl;
end;


function TfmAjustaSPED.ajustaValoresReducao(ds: TdataSet; fl:TstringList):TStringlist;
var
  lC400, lC405, lC420, lC425, lC425Inicio, lC425Fim, lC490, i, j:integer;
  dif, vlMaiorItem, difC425, difC490:real;
begin
   lC425 := 0;
   lC425Inicio := 0;
   lC425Fim := 0;
   i:=0;

   f.gravaLog('');
   f.gravaLog('Buscando ECF '+ ds.FieldByName('nr_ECF').AsString  +' serie: '+ ds.FieldByName('ser_fab').AsString);

{   // procurar o registro c400  da impressora.}
   lC400 := 0;
   for i:=0 to fl.Count - 1 do
      if ( getCp(1, fl[i]) = 'C400') and (getCp(4, fl[i]) = ds.FieldByName('ser_fab').AsString ) then
      begin
         lC400 := i;
         break;
      end;

   // definir o numero da linha do registro c405 do dia
   lC405 := 0;
   if (lC400 > 0) then
      for i:= lC400 +1 to fl.Count - 1 do
         if (getCp(2, fl[i]) = f.SohNumeros(ds.FieldByName('dt_mov').AsString) ) then
         begin
            lC405 := i;
            break;
         end
         else if (getCp(1, fl[i]) = 'C400') then
         begin
           f.gravaLog('Nao achei C405 do ecF:' + ds.FieldByName('nr_ECF').AsString);
           break;
         end;

         // definir a linha do registro c420 tributado
   lC420 := 0;
   for i:= lC405 to fl.Count - 1 do
      if ( getCp(1, fl[i]) = 'C420') and ( getCp(2, fl[i]) = '01T1700' ) then
      begin
         lC420 := i;
         break;
      end;

   if (lC400 <> 0)  and (lC405 <> 0) then
   begin
      f.gravaLog('C400: '+ intToStr(lC400 +1));
      f.gravaLog('C405: '+ intToStr(lC405 +1));
      f.gravaLog('C420: '+ intToStr(lC420 +1));

      // ajusta a marca da impressora
      fl[lC400] := updateCampo(fl[lC400], 3, 'Daruma' );


      if (getVlCampo(7, fl[lC405]) <> ds.FieldByName('vl_contabil').AsFloat ) then
      begin
         dif := getVlCampo(7, fl[lC405]) - ds.FieldByName('vl_contabil').AsFloat ;


         memo.Lines.add(' ECF: ' + ds.FieldByName('nr_ecf').AsString  + ' Corrigir.' );

         f.gravaLog('divergencia do valor da venda para a redução, Valor no Arquivo:' + getCp(7, fl[lC405]) +  ' vl_contabil:' + ds.FieldByName('vl_contabil').AsString);

         // definir o indice inicial do c425
         for j:= lC420 to fl.Count -1 do
            if getCp(1, fl[j]) = 'C425' then
            begin
               lC425Inicio := j;
               break;
            end;

         // definir o indice final do c425
         for j:= lC425Inicio to fl.Count -1 do
            if (getCp(1, fl[j]) = 'C425') and (getCp(1, fl[j+1]) = 'C490')  then
            begin
               lC425Fim := j;
               break;
            end;
         f.gravaLog('Itens C425: '+ intToStr(lC425Inicio+1) + ':'+ intToStr(lC425Fim +1) );


         // pegar o item com maior valor agregado
         lC425 := getIdxItemMaiorValor(fl, lC425Inicio, lC425Fim, 'C425');

         lC490 := lC425Fim +1;

         f.gravaLog('C490: ' + intToStr(lC490 +1));


         fl[lC405] :=  updateCampo(fl[lC405], 7,  ds.FieldByName('vl_contabil').AsString );

         // pegar a diferenca no valor contabil para ratear nos itens
         difC425 := 0;
         difC425 := ds.FieldByName('base').AsFloat - getVlCampo( 3, fl[lC420]);


         // atualiza o campo do item

        if (getVlCampo(7, fl[lC405]) < ds.FieldByName('vl_contabil').AsFloat ) then
        begin
           // se o valor da reducao for maior que o do sistema

           // adicione a diferenca ao item com maior valor agregado
           difC425 :=  difC425 +   getVlCampo( 5, fl[lC425]);

           f.gravaLog('Atualizar o valor do item: de:' + getCp(5, fl[lc425]) + ' para:'+ f.FloatToStrFomatado(difC425, true)   );
           fl[lC425] := updateCampo( fl[lC425], 5,  f.FloatToStrFomatado(difC425, true) );
        end
        else
        begin
            f.gravaLog('Valor venda maior que a redução, diferença de : ' + floatToStr(dif)  );

            diminuiVlItens( fl, lC425Inicio, lC425Fim, 0, dif );
        end;

         // atualiza o campo  c420
         fl[lC420] := updateCampo(fl[lC420], 3, ds.FieldByName('Base').AsString );

         // atualiza o campo c490
         difC490 := ds.FieldByName('Base').AsFloat;

         fl[lC490] := updateCampo(fl[lC490], 5, f.FloatToStrFomatado(difC490, true) );
         fl[lC490] := updateCampo(fl[lC490], 6, f.FloatToStrFomatado(difC490, true) );
         fl[lC490] := updateCampo(fl[lC490], 7, f.FloatToStrFomatado(difC490 * 0.17, true) );
      end;

   end
   else
      f.gravaLog('Não achei os registros ' +  ds.FieldByName('ser_fab').AsString + ' de: '+ ds.FieldByName('dt_mov').AsString);

   result := fl;
end;

function TfmAjustaSPED.ajustaValoresECF_PisCofins(fl:TstringList):TStringlist;
var
   di, dF:Tdate;
   ds:TdataSet;
   serieECF:String;
begin
   try
      if (cbAjustaDia.Checked = true) then
      begin
         di:= data.Date;
         dF:= data.Date;
      end
      else
      begin
         di:=  fdt.dataDDMMAAAtoDate( getCp(6, fl[0]) );
         dF:=  fdt.dataDDMMAAAtoDate( getCp(7, fl[0]) );
      end;

      if (edECF.Text <> '') then
        serieECF := edECF.Text;

      addMemo('Dados do arquivo:' +#13+ dateToStr(di) + '  ' + dateToStr(df) );

      while (di <= df) do
      begin
         // lista as reducoes
         ds:= uFiscal.getDadosReducao('', di, di, serieECF, 'PFM');
         addMemo(' Data: ' + DateToStr(di));
         addMemo('-------------------------------------------------------------------');
         f.gravaLog('');
         f.gravaLog('');

         if (ds.IsEmpty = false) then
         begin
            ds.First();
            while ( ds.Eof = false ) do
            begin

               fl:= ajustaValoresReducao_pisCofins(ds, fl);
               ds.Next();
            end;
         end;
         ds.free();
         di := di+1;

         addMemo('-------------------------------------------------------------------');
      end;
      result := fl;
   except
      on e:Exception do
      begin
         msg.msgErro('Erro em ajustaValoresECF() na linha');
         result := fl;
      end;
  end;
end;


function TfmAjustaSPED.ajustaValoresECF(fl:TstringList):TStringlist;
var
   di, dF:Tdate;
   ds:TdataSet;
   uo, serieECF:String;
begin
   try
      f.gravaLog('ajustaValoresECF()' + #13);
      memo.Lines.Add('ajustaValoresECF()' + #13);

      uo := uLj.getIsUoFromCGF(getCp(10, fl[0]) );

      if (cbAjustaDia.Checked = true) then
      begin
         di:= data.Date;
         dF:= data.Date;
      end
      else
      begin
         di:=  fdt.dataDDMMAAAtoDate( getCp(4, fl[0]) );
         dF:=  fdt.dataDDMMAAAtoDate( getCp(5, fl[0]) );
      end;

      if (edECF.Text <> '') then
        serieECF := edECF.Text;

      f.gravaLog('Dados do arquivo, is_uo:' + uo +#13+ getCp(4, fl[0]) + '  ' + getCp(5, fl[0]));

      while (di <= df) do
      begin
         // lista as reducoes
         ds:= uFiscal.getDadosReducao(uo, di, di, serieECF);

         memo.Lines.add('Dia: ' +dateToStr(di));
         f.gravaLog('-------------------------------------------------------------------');

         if (ds.IsEmpty = false) then
         begin
            f.gravaLog('Dia: ' +ds.FieldByName('dt_mov').AsString);

            ds.First();
            while ( ds.Eof = false ) do
            begin
               Fl:= ajustaValoresReducao(ds, fl);
               ds.Next();
            end;
         end;
         ds.free();
         di := di+1;
      end;
      result := fl;
   except
      on e:Exception do
      begin
         msg.msgErro('Erro em ajustaValoresECF() na linha');
         result := fl;
      end;
  end;
end;

procedure TfmAjustaSPED.atualizaTotalLinhas(var arq: Tstringlist);
begin
   arq[arq.count-1] := updateCampo(arq[arq.count-1], 2, intToStr( arq.count));
end;

function TfmAjustaSPED.getIsRef(linha: String): String;
begin
   if ( getNumReg(linha) = 'C170')  then
      result := getCp(3, linha)
   else if (getNumReg(linha) = 'C425') or (getNumReg(linha) = 'H010')  then
      result := getCp(2, linha)
   else
      result := '';
end;

function TfmAjustaSPED.getNumNota(str: String): integer;
begin
   if (getCp(8, str) <> '') then
      result := strToInt( getCp(8, str) )
   else
      result := 0;
end;

function TfmAjustaSPED.getItensFaturados(arq: TstringList): TStringList;
var
   prodNotas :TStringList;
   i:integer;
   item:String;
begin //
   prodNotas := TStringList.Create();
   for i:=0 to arq.Count -1 do
   begin
      item := getIsRef(arq[i]);
      if (item <> '') then
         if ( prodNotas.IndexOf(item) = -1) then
            prodNotas.Add(item);
//      end;
   end;
   prodNotas.SaveToFile('c:\produtos.txt');
   result := prodNotas;
end;

function TfmAjustaSPED.getPosInicio(idCampo:integer; linha:String):integer;
var
  campoAtual, posInicio:integer;
begin
   posInicio := 0;
   campoAtual := 1;
   while ( (posInicio <= Length(linha)) and (campoAtual <= idCampo) ) do
   begin
      inc(posInicio);
      if copy(linha, posInicio,01) = '|' then
         inc(campoAtual);
   end;
   result := posInicio;
end;

function TfmAjustaSPED.getIndexReg(arq: TStringList; idRegistro: String; idxI, idxF:integer): integer;
var
   idx, i:integer;
begin
  // retorna o numero da linha de um registro.
   idx := -1;
   for i:=idxI to idxF do
      if  ( getNumReg(arq[i]) = idRegistro) then
      begin
         idx := i;
         break;
      end;
   result := idx;
end;

function TfmAjustaSPED.getIdxReg(arq: TStringList; idRegistro: String): integer;
begin
   result := getIndexReg(arq, idRegistro, 0, arq.Count-1);
end;

function TfmAjustaSPED.updateCampoArq(var arq:TStringlist; idRegistro:String; idCampo:integer; novoValor:String):boolean;
var
  i:integer;
begin
   Log('Atualizando registro '  + idRegistro +' campo: ' + IntToStr(idCampo) );

   if length(idRegistro) = 4 then
   begin
      for i:=0 to arq.Count-1 do
         if ( getNumReg(arq[i]) = idRegistro ) then
            arq[i] :=   updateCampo(arq[i], idCampo, novoValor);
   end
   else
   begin
      for i:=0 to arq.Count-1 do
         if ( getNumRegDuplo(arq[i]) = idRegistro ) then
            arq[i] :=   updateCampo(arq[i], idCampo, novoValor);
   end;
   result := true;
end;

function TfmAjustaSPED.getNumRegDuplo(linha:String):String;
begin
   result := copy(linha, 02, 09 );
end;

function TfmAjustaSPED.getNumReg(linha:String):String;
begin
   result := copy(linha, 02, 04 );
end;

function TfmAjustaSPED.getCpInt(indice: integer; str: String): integer;
begin
   result := strToInt(getCp(indice, str));
end;

procedure TfmAjustaSPED.Log(str: String);
begin
   f.gravaLog(str);
   memo.Lines.Add(str);
end;

procedure TfmAjustaSPED.removeItensSemNota(nArq: String);
var
   arq, dest,  prodNotas:TStringList;
   qtItens, i:integer;
   item:String;
begin
   log('Removendo itens que não tem movimentação fiscal...');

   arq := TStringList.Create();
   arq.LoadFromFile(nArq);
   prodNotas := TStringList.Create();

   dest := TStringList.Create();

// criando a lista de itens que tem notas de venda ou redução
   prodNotas := getItensFaturados(arq);

   qtItens := -1;
   for i:= 0 to arq.Count -1  do
   begin
      if ( getNumReg(arq[i]) = '0200' ) then
      begin
         inc(qtItens);
         item := getCp(2, arq[i]);

         if ( prodNotas.IndexOf(item) < 0 ) then
         begin
            qtItens := qtItens -1;
            gravaLog('Removido: '+ arq[i])
         end
         else
            dest.Add(arq[i]);
      end
      else
         dest.Add(arq[i]);
   end;

// Alterar a quantidade de registros de produtos
   f.gravaLog('Ajutando o registro 9900|0200 valor: '+ intToStr(qtItens) );
   updateCampoArq(dest, '9900|0200', 3, intToStr(qtItens+1) );


// Atualizar o numero de linhas do arquivo
   atualizaTotalLinhas(dest);

   i := getIdxReg(dest, '0990');
   dest[i] := updateCampo(dest[i], 2, intToStr(i+1));

   arq.Destroy();

   dest.SaveToFile(nArq);

   dest.Destroy();
end;


procedure TfmAjustaSPED.edArqDblClick(Sender: TObject);
begin
   edArq.Text := f.DialogAbrArq('txt','c:\');
end;

procedure TfmAjustaSPED.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   f.salvaCampos(fmAjustaSPED);
   action := Cafree;
   fmAjustaSPED := nil;
end;

procedure TfmAjustaSPED.FormCreate(Sender: TObject);
begin
   fmMain.getParametrosForm(fmAjustaSPED);
   memo.Lines.Clear();
   rgTpSped.ItemIndex := 1;
end;

procedure TfmAjustaSPED.pesqMovimentoItem(isReF: String);
var
   arq:TStringList;
   qtSai, qtEnt, idxNota, i:integer;
begin //
   qtSai := 0 ;
   qtEnt := 0 ;

   arq := TStringList.Create();
   arq.LoadFromFile(edArq.Text);

// registros das notas
   for i:= 0 to arq.Count-1 do
   begin
      if (getNumReg(arq[i]) = 'C170') then
         if ( getCp(3, arq[i]) =  isRef ) then
         begin
            idxNota := i- getCpInt(2, arq[i]) ;
            // verificar se e nota de entrada ou saida
            if ( getCp(2, arq[idxNota]) = '0') then
            begin
               log(' Entrada, nota : ' + getCp(7, arq[idxNota]) + '/'+ getCp(8, arq[idxNota]) + ' quantidade: ' +  getCp(5, arq[i]) +  ' linha:' + intToStr(i+1));
               qtEnt := qtEnt + getCpInt(5, arq[i])
            end
            else
            begin
               log(' saida, nota : ' + getCp(7, arq[idxNota]) + '/'+ getCp(8, arq[idxNota]) + ' quantidade: ' +  getCp(5, arq[i]) +  ' linha:' + intToStr(i+1) );
               qtSai := qtSai + getCpInt(5, arq[i]);
            end
         end;
   end;

// registros das reduções
   for i:= 0 to arq.Count-1 do
   begin
      if (getNumReg(arq[i]) = 'C425') then
         if (getCp(2, arq[i]) = isRef) then
         begin
             idxNota := i;
             while ( getNumReg(arq[idxNota]) <> 'C405' ) do
                idxNota := idxNota -1;

             log('Reducao, data:' + getCp(2, arq[idxNota])  + ' quantidade: ' + getCp(3, arq[i]));
             qtSai := qtSai + getCpInt(3, arq[i]);
         end;
   end;

   log('Saidas: ' + intToStr(qtSai) + ' Entradas: ' + intToStr(qtEnt));
   arq.Destroy();
end;

procedure TfmAjustaSPED.btOcoProdutoClick(Sender: TObject);
begin
{   screen.Cursor := crHourGlass;
   if (fileExists(edArq.Text) = true) and ( edRef.Text <> '' ) then
      pesqMovimentoItem(edRef.Text);
   screen.Cursor := crDefault;
}

  memo.Lines.add( getCp(5, edArq.Text));
end;


procedure TfmAjustaSPED.FormResize(Sender: TObject);
begin
   memo.Width :=   fmAjustaSPED.Width - 50;
   memo.height :=  fmAjustaSPED.height - (memo.Top + 50) ;
end;

procedure TfmAjustaSPED.ajustaEmissorNota(nmArquivo: String);
var
   itens,arq:TStringList;
   i:integer;
begin
   log('Ajustando a emissão das notas de entrada');
   arq := TStringList.Create();
   arq.LoadFromFile(nmArquivo);
   for i:=0 to arq.Count -1 do
   begin
      if( getNumReg(arq[i]) = 'C100') and ( getCp(2, arq[i]) = '0') then
         if ( ( getCp(11, arq[i+1]) = '1152') or ( getCp(11, arq[i+1]) = '2152') or ( getCp(11, arq[i+1]) = '1102') or ( getCp(11, arq[i+1]) = '2102') ) then
            if ( getCp(2, arq[i]) <> '1') then
            begin

               arq[i] := updateCampo(arq[i], 3, '1' );
            end;
   end;
   arq.SaveToFile(nmArquivo);
   arq.Destroy();
end;

procedure TfmAjustaSPED.ajustaNumeracoesNotas(nmArquivo:String);
var
   series,arq: TStringList;
   idNotas, i:integer;
   notas:TiniFile;
   arqNotas:String;
begin //
//   arqNotas :=  f.TempDir() + 'notas.txt'
   arqNotas :=  'c:\notas.txt';

   log('Ajustando o registro de inicio fim das notas...');
   arq :=  TStringList.Create();
   arq.LoadFromFile(nmArquivo);

    if FileExists(arqNotas) = true  then
       DeleteFile( arqNotas );

    notas := TIniFile.Create(arqNotas);


   for i:=0 to arq.Count -1 do
      if ( (getNumReg(arq[i]) = 'C100')  and  (getCp(3, arq[i] ) = '0')  )  then
      begin
         if (notas.ReadString(getCp(7,arq[i]), 'MAX' ,  '' ) = '') then
         begin
            notas.WriteString(getCp(7,arq[i]), 'MIN', getCp(8,arq[i])  );
            notas.WriteString(getCp(7,arq[i]), 'MAX', getCp(8,arq[i])  );
         end
         else
         begin
             if ( getNumNota(arq[i]) < notas.ReadInteger(getCp(7, arq[i]), 'MIN', 0)  ) then
                notas.WriteString(getCp(7,arq[i]), 'MIN', getCp(8,arq[i])  );

             if ( getNumNota(arq[i]) > notas.ReadInteger(getCp(7, arq[i]), 'MAX', 0) ) then
                notas.WriteString(getCp(7,arq[i]), 'MAX', getCp(8,arq[i])  );
         end;
      end;
   notas.UpdateFile();


// remver os registros antigos de inicio e fim das series
   for i:= arq.Count-1 downto 1 do
   begin
      if (getNumReg(arq[i]) = '1001') then
      begin
         idNotas := i;
         break;
      end;
      if (getNumReg(arq[i]) = '1700') then
         arq.Delete(i);
   end;

   series := TStringList.Create();
   notas.ReadSections(series);
//   series.SaveToFile('c:\series.txt');

// inserir as novas series
   for i:= 0 to series.Count-1 do
       arq.Insert(idNotas+i+1, '|1700|03|01|'+ series[i] +'||'+ f.preencheCampo(12,'0','E', notas.ReadString( series[i], 'MIN', '0')) +'|'+ f.preencheCampo(12,'0','E', notas.ReadString(series[i], 'MAX', '0')) +'||' );

// atualizar o registro 1990 - numero de registros 1700
   for i:= arq.Count-1 downto 1 do
      if (getNumReg(arq[i]) ='1990') then
      begin
         arq[i] := updateCampo(arq[i], 2, intToStr(series.count+2) );
         break;
      end;

// atualizar o registro 9900|1700 - numero de registros
   for i:= arq.Count-1 downto 1 do
      if (getNumRegDuplo(arq[i]) = '9900|1700') then
      begin
         arq[i] := updateCampo(arq[i], 3, intToStr(series.count) );
         break;
      end;

// atualizar o numero de linhas do arquivo
   atualizaTotalLinhas(arq);

   arq.SaveToFile(nmArquivo);
   arq.Free();

   notas.Free();
   log('Ajustando o registro de inicio fim das notas... ok ');
end;


procedure TfmAjustaSPED.insereItensReg200(var arq:TStringList; itensAInserir: TStringList);
var
   idxReg200, i:integer;
   descItem, regItem:String;
begin
   fmMain.MsgStatus('insereItensReg200');

   idxReg200 :=  getIdxReg(arq, '0200');

   for i :=0 to itensAInserir.Count -1 do
   begin
      descItem := copy(dm.openSQL('Select cd_ref from crefe where is_ref = ' + itensAInserir[i],'cd_ref') , 01, 50 ) ;
      regItem :=  '|0200|' + itensAInserir[i] +'|'+ descItem +    '|||000001|00|||||17|';
      arq.Insert(idxReg200, regItem);
   end;
end;


function TfmAjustaSPED.getItensReg0200(arq:TStringList): TStringList;
var
   itens:Tstringlist;
   i:integer;
begin
   itens := TStringlist.create();
   for i := 0 to arq.Count -1 do
      if  ( getNumReg(arq[i]) = '0200') then
         itens.Add( getCp(2, arq[i]) );
   itens.SaveToFile('c:\itensReg200.txt');
   result := itens;
end;


procedure TfmAjustaSPED.ajustaRegistroInventario(nmArquivo: String);
var
   arq, itens:TStringList;
   idxInv, idxCad:integer;
   i:integer;
begin
   arq :=  TStringList.Create();
   arq.LoadFromFile(nmArquivo);

   itens := getItensFaturados(arq);

   arq.SaveToFile('c:\itensFaturados.txt');
   arq.Free();
end;

procedure TfmAjustaSPED.incluirItensFaturados(nmArquivo: String);
var
   ItensNovos, itensReg200, itens, arq:TStringlist;
   i:integer;
   codItem:String;
begin
   log('Inserir itens faturados na lista de itens');

   fmMain.MsgStatus('IncluirItensFaturados');

   arq := TStringlist.create();
   arq.LoadFromFile(nmArquivo);

   itens := TStringlist.create();
   ItensNovos := TStringlist.create();

   itens := getItensFaturados(arq);
   itensReg200 :=  getItensReg0200(arq);

   for i:=0 to itens.Count-1 do
     if (itensReg200.IndexOf(itens[i]) < 0) then
        ItensNovos.add(itens[i]);

   if (ItensNovos.Count > 0) then
   begin
      ItensNovos.SaveToFile('c:\ItensAInserirReg200.txt');
      insereItensReg200( arq, ItensNovos );

      updateCampoArq(arq, '0990', 2, intToStr(ItensNovos.Count + itens.Count) );

      atualizaTotalLinhas(arq);
      arq.SaveToFile(nmArquivo);
      arq.Free();
   end
   else
     Log('Sem itens para inserir no registro 0200');
end;

procedure TfmAjustaSPED.ajustaRegC425(nArq: String);
var
   dest, arq:TStringList;
   vc990, vC490, idxAtual, j, i:integer;
   vContabil, vBase, vICMS:real;
   linha:String;
begin
   vC490 := 0;

   arq := TStringlist.Create();
   dest:= TStringlist.Create();
   arq.LoadFromFile(nArq);
   i:=0;
   while (i <= arq.Count -1 ) do
   begin
      vContabil := 0;
      vBase := 0 ;
      vICMS := 0 ;


     if ( getNumReg(arq[i]) = 'C490') then
      begin
         inc(vC490);
         linha := arq[i];  log('achei c490');
         idxAtual := i;

         if ( getCp(5, linha) <> '') then  vContabil :=  strTofloat( ( getCp(5, linha)));
         if ( getCp(6, arq[i]) <> '') then vBase :=  strTofloat( ( getCp(6, linha)));
         if ( getCp(7, linha) <> '') then  vICMS :=  strTofloat( ( getCp(7, linha)));

         j:= idxAtual+1;
         if ( getNumReg(arq[j]) = 'C490') then
         begin
            inc(i);
            Log('reg duplicado ' + intTostr(j) );
            if ( getCp(5, arq[j]) <> '') then vContabil := vContabil +   strTofloat(  getCp(5, arq[j]));
            if ( getCp(6, arq[j]) <> '') then vBase :=  vBase + StrToFloat(  getCp(6, arq[j]));
            if ( getCp(7, arq[j]) <> '') then vICMS :=  vICMS + strTofloat(  getCp(7, arq[j]));
         end;

         j:= idxAtual+2;
         if ( getNumReg(arq[j]) = 'C490') then
         begin
            inc(i);
            Log('reg duplicado ' + intTostr(j) );
            if ( getCp(5, arq[j]) <> '') then vContabil := vContabil +   strTofloat(  getCp(5, arq[j]));
            if ( getCp(6, arq[j]) <> '') then vBase :=  vBase + StrToFloat(  getCp(6, arq[j]));
            if ( getCp(7, arq[j]) <> '') then vICMS :=  vICMS + strTofloat(  getCp(7, arq[j]));
         end;

         linha := updateCampo(linha, 5, FloatToStr(vContabil)  ); linha := updateCampo(linha, 6, FloatToStr(vBase)  ); linha := updateCampo(linha, 7, FloatToStr(vICMS)  );
         dest.Add(linha);
         inc(i);
      end
      else
      begin
         dest.Add(arq[i]);
         inc(i);
      end;

      if i mod 10 = 0 then
         fmMain.MsgStatus(intToStr(i));
   end;
   arq.Free();

   atualizaTotalLinhas(dest);

// atualiza o numeo de registros c490
   updateCampoArq( dest, '9900|C490', 3, intTostr(vC490) );

// atualiza o numeo de registros c990
   updateCampoArq( dest, 'C990|', 2, intTostr(vc990) );


   vc990:=0;
   for i:=0 to dest.Count -1 do
      if (copy(getNumReg(dest[i]),01,01) = 'C') then
        inc(vc990);

   dest.SaveToFile(nArq);
   dest.Free();
end;

procedure TfmAjustaSPED.cbAjustaDiaClick(Sender: TObject);
begin
   data.Enabled := cbAjustaDia.Checked;
end;



function TfmAjustaSPED.getCfoNf(idx: integer; fl:TstringList): String;
  var
     i:integer;
begin

  for i:= idx +1 to fl.Count-1 do
  begin
     if ( getCp(1,fl[i]) = 'C100') then
     begin
        result :=  '';
        break;
     end;

     if ( getCp(1,fl[i]) = 'C190') then
     begin
        result := getCp(3, fl[i]);
        break;
     end;

  end;
end;

procedure TfmAjustaSPED.trocaCfoItensNf(cfoNovo:String; idx:integer; var fl:TstringList);
var
  i:integer;
begin
   inc(idx);
   while ( idx <= fl.Count-1) do
   begin
      if(getCp(1, fl[idx]) = 'C170') then
      begin
        fl[idx] := updateCampo(fl[idx], 11, cfoNovo );
//        memo.Lines.Add(intToStr(idx));
//        memo.Lines.Add(fl[idx] ) ;
      end;


      if (getCp(1, fl[idx]) = 'C100') or (getCp(1, fl[idx]) = 'C190') or (getCp(1, fl[idx]) = 'C400') then
           break;

      inc(idx);
   end;
end;

function TfmAjustaSPED.ajValorTotalNfEnt(fl:TstringList):TStringList;
var
   idOpr, i, i2:integer;
   vlOp, vlIPI, vlProd, vlNota, vlDesc:real;
   c170I, c170f:integer;
   idx190, c190f:integer;
   vCfoCst: THash3f;

begin
// Ajusta o valor total da nota de entrada acertando o valor total da nota para  (valor produtos + ipi - desconto);

   f.gravaLog('ajValorTotalNfEnt()');
   memo.Lines.Add('ajusta Totais de NF de entrada');

   for i:=0 to fl.Count - 1 do
   begin
      if (getCp(1, fl[i]) = 'C100' )and( getCp(2, fl[i]) = '0')and(getCp(3, fl[i])='1')then
      begin
         f.gravaLog(getCp(8, fl[i]));

// definir onde comeca e onde termina os registros C170
         if (getCp(1, fl[i+1]) = 'C170') then
         begin
            c170I := i+1;
            c170f := i+1;
         end;

         while (getCp(1, fl[c170f+1]) = 'C170') do
            inc(c170f);

         f.gravaLog('linhas c17o inicio e fim');
         f.gravaLog(c170I);
         f.gravaLog(c170f);

         vCfoCst := THash3f.Create();

         for i2:= c170I to c170f do
         begin
            vlIPI :=getVlCampo(24, fl[i2]);
            vlOp := getVlCampo(7, fl[i2]) - getVlCampo(8, fl[i2]) + vlIPI;


            idOpr := vCfoCst.indexOf( getCp(10, fl[i2]), getCp(11, fl[i2])   );

            if idOpr < 0 then
               vCfoCst.add(getCp(10, fl[i2]), getCp(11, fl[i2]), vlOp)
            else
               vCfoCst.somaAoValor(idOpr, vlOp, vlIPI);
         end;
//       07 - 08 + 24
         vCfoCst.saveParams();

         // ajustar
         i2:= c170f +1;
         while (getCp(1, fl[i2]) = 'C190') do
         begin
            idx190 := vCfoCst.indexOf( getCp(2, fl[i2]), getCp(3, fl[i2]));

            if (idx190 >= 0) then
            begin
               vCfoCst.getValor(idx190, vlOp, vlIPI);

               fl[i2] := updateCampo(fl[i2],  5, f.FloatToStrFomatado(vlOp, true));
               fl[i2] := updateCampo(fl[i2], 11, f.FloatToStrFomatado(vlIPI, true));
            end;
            inc(i2);
         end;


      end; // teste c100
   end;
     result := fl;
end;

procedure TfmAjustaSPED.verDirvgC405_C481_c485(fl:TstringList);
var
   i:integer;
   c481i, c481f :integer;
   vc405, vc481, vc485, diF:real;
   da, di, dF:Tdate;
   c400:String;
begin
   if (cbAjustaDia.Checked = true) then
   begin
      di:= data.Date;
      df := di;
   end
   else
   begin
      di := cpToDate(6, fl[0]);
      df := cpToDate(7, fl[0]);
   end;

   for i:=0 to fl.Count -1 do
   begin
      c481i := -1;
      vc405 := 0;
      vc481 := 0;

      if (getCp(1, fl[i]) = 'C400')then
         c400 := getCp(4, fl[i]);

      if (getCp(1, fl[i]) = 'C405')then
      begin
         da := cpToDate(2, fl[i]);

         if (fdt.datatNointerv(da, di, df) = true) then
         begin
            vc405 := getVlCampo(7, fl[i]);
            if (getCp(1, fl[i+1]) = 'C481') then
            begin
               c481i := i+1;
               c481f := getIdx_fim_c481_C485(fl, 'C481', c481i)
            end;

            if (c481i >-1 ) then
              vc481 := somaIntervalo(fl, c481i, c481f, 4)
            else
              addMemo('C481: - Sem registro');

            dif := (vc405 - vc481);

            if (dif < 0) then
              dif := dif * -1;


            if( dif >= edDicc481.Value + 0.01 ) then
            begin
               addMemo('C405: '+ fl[i] );
               addMemo('       Dirvegência:');
               addMemo('       c405: ' +  floatToStr(vc405));
               addMemo('       c481: ' +  floatToStr(vc481));

            end;
         end;
      end;
   end;
end;

procedure TfmAjustaSPED.verDirvgC100_c170(fl:TstringList);
var
  di, df, da:Tdate;
  i,j :integer;
  c100, c170i, c170F:integer;
  dif, vNota, vItem:real;
  is_uo, ds_uo, entSai:String;
begin
   addMemo('');
   addMemo('Verificar as divergências c100 e c170');
   addMemo('');

   if (cbdirvg_c100.Checked = true) then
   begin
      di:= data.Date;
      df := di;
   end
   else
   begin
      di := cpToDate(6, fl[0]);
      df := cpToDate(7, fl[0]);
   end;


   for i:= 1 to  fl.Count -1 do
   begin
      vNota := 0;
      vItem := 0;

      if getCp(1, fl[i]) = 'C010' then
      begin
         is_uo := getIsUoFromCNPJ(getCp(2, fl[i]));

         ds_uo := ulj.getDadosUo(is_uo, 'ds_uo');

      end;

      if getCp(1, fl[i]) = 'C100' then
      begin
         if  getCp(2, fl[i]) = '0' then
         	entSai := 'Entrada'
         else
         	entSai := 'Saida';
      
         c100 := i;
         j:= i;

         c170i := i+1;

         for j:= i+1 to fl.Count -1 do
            if getCp(1, fl[j]) = 'C170' then
               c170f := j
            else
               break;

         vNota := getVlCampo(16, fl[c100]); //+ getVlCampo(14, fl[i]);

         vItem :=  somaIntervalo(fl, c170i, c170f, 7)
                 - somaIntervalo(fl, c170i, c170f, 8)
                 + somaIntervalo(fl, c170i, c170f, 24);

         dif := vNota - vItem;

         if (dif < 0) then
           dif :=dif * -1;

         if (dif > edDifc100_170.Value + 0.01 ) then
         begin
            addMemo('Loja: ' + ds_uo +  ' '+entSai+  '   Nota:'
                    + getCp(7, fl[c100]) +'/'
                    + getCp(8, fl[c100]) + '   DiF:'
                    +  f.floatToStrFomatado (dif, true)
                    + '   linha: ' + intToStr(c100+1)
            );
         end;
      end;
   end;
end;

procedure TfmAjustaSPED.ajustarArqParaSPED_pis_cofins(nmArq: String);
var
   arq:TstringList;
begin
   arq:= TStringList.Create();
   arq.LoadFromFile(edArq.text);

   addMemo('Período do arquivo: '+ fdt.dataDDMMAAAtoData(getCp(6,arq[0])) + ' - ' + fdt.dataDDMMAAAtoData(getCp(7, arq[0])) );
   addMemo('-----------------------------');

   if (cbAjusEcfPISCofins.Checked = true) then
      ajustaValoresECF_PisCofins(arq);

   if ( cbVerDrgRedPisCofins.Checked = true) then
      verDirvgC405_C481_c485(arq);

   if ( cbdirvg_c100.Checked = true) then
      verDirvgC100_c170(arq);

   arq.SaveToFile(nmArq);
   arq.Free();
end;


procedure TfmAjustaSPED.ajustarArqParaSPED(nmArq: String);
var
   arq:TstringList;
begin
   arq:= TStringList.Create();
   arq.LoadFromFile(edArq.text);

   memo.Lines.add('Loja: '+ getCp(6, arq[0]) +' '+ getCp(4, arq[2]) );
   memo.Lines.add('CNPJ: '+ getCp(7, arq[0]) );
   memo.Lines.add('Data: '+ getCp(4, arq[0]) +' até '+ getCp(5, arq[0]));

   f.gravaLog('------------------------------------------------------------');
   f.gravaLog('Loja: '+ getCp(6, arq[0]) +' '+ getCp(4, arq[2]) );
   f.gravaLog('CNPJ: '+ getCp(7, arq[0]) );
   f.gravaLog('Data: '+ getCp(4, arq[0]) +' até '+ getCp(5, arq[0]));



   if (cbAjustaECF.Checked = true) then
      arq := ajustaValoresECF(arq);

   if (cbAjCfoEnt.Checked = true) then
      arq := ajCfoItensNFEntrada(arq);

   if (cb_c190_c490.Checked = true) then
      arq := AjReg_C190_490(arq);

   if (cbAjVlTotNota.Checked = true) then
      arq := ajValorTotalNfEnt(arq);

   if (cbAjTotTribEcf.Checked = true) then
      arq := ajVlTotTribEcf(arq);

	if ( cbAjCodProd.Checked = true) then
      arq := ajIsrefFromcdref(arq);

   if cbAjC100.Checked = true then
      arq := ajRegC100(arq);

   if (cbRem_C425_duplicado.Checked = true) then
      rem_C425_duplicado(arq);


// salva o novo arquivo, ja ajustado
   arq.SaveToFile(nmArq);
end;

function TfmAjustaSPED.ajVlTotTribEcf(Fl:TStringlist): TStringList;
var
   i:integer;
begin

   for i:= 1 to fl.Count -1 do
   begin
     if (getCp(1, fl[i])= 'C405') then
     begin
       f.gravaLog('');
       f.gravaLog(fl[i]);
       f.gravaLog(getC490(i, fl)   );
     end;

     if (getCp(1, fl[i])= 'C990') then
        break;

     result := fl;
   end;
end;

function TfmAjustaSPED.getIdxC490_cfo():integer;
begin
{   idxErr := -1;
   for i:= idxI to idxF  do
      if getCp(1, fl[i]) = 'C490') and getCp(2, fl[i]) = '5403');
      begin
         idxErr := i;
      end;
}
end;

procedure TfmAjustaSPED.rgTpSpedClick(Sender: TObject);
begin
   pnFiscal.Visible := false;
   pnPis.Visible := false;
   case rgTpSped.ItemIndex of
      0:pnFiscal.Visible := true;
   else
      pnPis.Visible := true;
   end;
end;

procedure TfmAjustaSPED.fsBitBtn1Click(Sender: TObject);
var
  arq:TStringList;
  nmArq : String;
begin
   screen.Cursor := crHourglass;
   memo.Lines.Clear();

   if ( fileExists(edArq.Text) = true) then
   begin
// cria um novo arquivo com a descicao "_ajustado"
      nmArq := edArq.Text;
      insert('_ajustado', nmArq, length(nmArq)-3);
      arq :=TStringList.Create();
      arq.LoadFromFile(edArq.Text);
      arq.SaveToFile(nmArq);
      arq.Free();

// chama as rotinas de ajuste
      if rgTpSped.ItemIndex = 0 then
         ajustarArqParaSPED(nmArq)
      else
         ajustarArqParaSPED_pis_cofins(nmArq);

      memo.Lines.add('OK');
   end
   else
      msg.msgErro('Escolha um arquivo');
   screen.Cursor := crDefault;
end;
     {
 C170 itens da nota
 C100 registro da nota
 c425 totalização dos itens  na redução
 h010 inventario
}

procedure TfmAjustaSPED.addMemo(msg: String);
begin
   memo.Lines.Add(msg);
   f.gravaLog(msg);
   memo.Refresh();
end;

procedure TfmAjustaSPED.cbdirvg_c100Click(Sender: TObject);
begin
   edDifc100_170.Visible := (cbdirvg_c100.Checked = true);
end;

procedure TfmAjustaSPED.cbVerDrgRedPisCofinsClick(Sender: TObject);
begin
   edDicc481.Visible := (cbVerDrgRedPisCofins.Checked = true);
end;



end.

