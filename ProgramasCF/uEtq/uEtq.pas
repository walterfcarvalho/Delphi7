unit uEtq;

interface

	procedure impEtqBlocoCd();
	procedure impEtiqueta(arq:String);



implementation

uses f, windows, classes, sysutils, adodb, db, uDm, uMain, msg;


procedure impEtiqueta(arq:String);
var
	local:String;
begin
	local := dm.getParamBD( 'impCodBarras', fmMain.getUoLogada() );
   f.gravaLog( pchar('Print /d:'+ local +' '+arq) );
   f.imprimeArquivoPorta(arq, local );
end;



function getTbItensParaimpressao():Tadotable;
begin
end;


procedure impEtqBlocoCd();
var
	temperatura, arq:String;
   txt,cmd:String;

begin
   txt := msg.msgInput('Texto', 'BL-');

   arq:= f.getArqImpPorta();
   deleteFile(arq);

   temperatura := dm.getParamBD('impCodBarras.tempArgox', fmMain.getUoLogada() );

   f.writeFile(arq, 'F');
   f.writeFile(arq,'L');
   f.writeFile(arq,'H' + '14' );

   cmd := dm.getParamBD('impetq.argoxEtqBl', '0');

	dm.setParam(cmd, txt);

   f.writeFile(arq, cmd);

   f.writeFile(arq, 'E');
   impEtiqueta(arq);
end;



end.
