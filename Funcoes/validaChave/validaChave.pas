unit validaChave;

interface

   uses msg, classes, controls, fdt, funcoes, reg, sysUtils;


   function validaLicenca():boolean;
   function decodChave(key:String; var data:Tdate; var duracao:real):boolean;
   function isChaveValida(chave:String):boolean;
   function gravaChave(chave:String):boolean;

implementation

function gravaChave(chave:String):boolean;
begin
   funcoes.wParReg('xsof', 'lic', chave);
   result := true;
end;

function decodChave(key:String; var data:Tdate; var duracao:real):boolean;
const
   d1:String = 'XHLBZYWPMF';
   d2:String = 'BCFGOPYTUZ';
   d3:String = 'EHMOGZPFNX';
   d4:String = 'DHIMOQRUVX';
   d5:String = 'MOQRUVXAEB';
   d6:String = 'XHLBZYWPMF';
   d7:String = 'EHMOGZPFNX';
   d8:String = 'AXTOPQNLKJ';
   d9:String = 'EHMOGZPFNX';
var
  dt, qtDias, res:String;
begin
   funcoes.gravaLog('decodChave('+key + ')');
   try
      res:= res + intToStr(pos(key[1],d1)-1);
      res:= res + intToStr(pos(key[2],d2)-1);
      res:= res + intToStr(pos(key[3],d3)-1);
      res:= res + intToStr(pos(key[4],d4)-1);
      res:= res + intToStr(pos(key[5],d5)-1);
      res:= res + intToStr(pos(key[6],d6)-1);
      res:= res + intToStr(pos(key[7],d7)-1);
      res:= res + intToStr(pos(key[8],d8)-1);
      res:= res + intToStr(pos(key[9],d9)-1);

      dt := copy(res, 01, 06);
      Insert('/', dt, 03);
      Insert('/', dt, 06);

      data := strToDate(dt);
      qtDias :=  copy(res, 07, 07);

      duracao := strToint(qtDias);

      result := true;
   except
      funcoes.gravaLog('decodChave() exceção lançada');
      result := false;
   end;
end;

function isChaveValida(chave:String):boolean;
var
  dtBase:Tdate;
  interv, duracao:real;
begin
   funcoes.gravaLog('isChaveValida(' + chave + ')');

   if (decodChave(chave, dtBase, duracao) = true )then
   begin
      interv := Abs(now - dtBase);
      if ( interv > duracao) then
      begin
         funcoes.gravaLog('isChaveValida(' + chave + ') Chave expirada');
         Result := false;
      end
      else
      begin
         funcoes.gravaLog('isChaveValida(' + chave + ') Chave ok');
         Result := true;
      end
   end
   else
   begin
      funcoes.gravaLog('isChaveValida(' + chave + ') chave nao é valida');
      result := false;
   end
end;


function validaLicenca():boolean;
var
  dtBase:Tdate;
  duracao:smallint;
  foldReg, chReg, chave:String;
begin
   funcoes.gravaLog('validaLicenca()');
   foldReg:= '_xsof';
   chReg := 'lic';

 //  chave:=  uppercase('lgerobeoex');

   chave := funcoes.rParReg(foldReg, chReg );

   if (isChaveValida(chave) = true ) then
     result := true
   else
   begin
      chave := uppercase(msg.msgInput('informe a chave', ''));
      if (isChaveValida(chave) = false ) then
      begin
         funcoes.gravaLog('Chave digitada inválida');
         funcoes.wParReg(foldReg, chReg, '');
         result := false;
      end
      else
      begin
         funcoes.gravaLog('Chave digitada ok');
         funcoes.wParReg(foldReg, chReg, chave);
         result := false;
      end
   end;
end;


end.
