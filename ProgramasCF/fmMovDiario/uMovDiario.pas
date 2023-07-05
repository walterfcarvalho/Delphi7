unit uMovDiario;

interface

   uses adoDb, classes, controls, db, forms, f, fdt, msg, sysUtils,
        uAbreMovDiario, uDM, uMain;

   function abreMov(seqMov:String; tbItens, tbDesp: TADOTable):TdataSet;
   function criaMov(uo, cdPes:String; data:Tdate):String;
   function movJaCriado(uo:String; data:Tdate):boolean;
   function getDadosMov(seqMov:String):TdataSet;
   function salvaMov(tbItens, tbDesp: TADOTable ):boolean;
   function getSeqMov(uo:String; data:Tdate):String;
   function validaPreenchimento(tbItens, tbDesp: TADOTable ):boolean;
   function imprimeMov(tbItens, tbDesp: TADOTable):boolean;
   function alteraStatus(seqMov:String):boolean;
   function enviaEmail(seqMov:String):boolean;


implementation

function validaPreenchimento(tbItens, tbDesp: TADOTable ):boolean;
var
  itSangria, sangria:Real;
  venda, itVenda, itSobras:Real;
  erro:String;
  ds:TdataSet;
begin
   erro := '';
   ds :=   getDadosMov( tbItens.fieldByName('seqMov').AsString);

   if (ds.FieldByName('finalizado').AsBoolean = true) then
      erro :=  dm.getMsg('fmMovdiario.errMovFin');

   ds.free();

// validando o valor das sangrias
  tbItens.Locate('tpMov', '-7', [loCaseInsensitive]);
  itSangria := tbItens.fieldByName('valor').AsFloat;

  sangria := dm.somaColunaTable(tbDesp, 'valor');
  if (itSangria <> sangria) then
     erro := erro + dm.getMsg('fmMovdiario.errSang') +#13;

// valor da venda do dia
  tbItens.Locate('tpMov', '1', [loCaseInsensitive]);
  itVenda := tbItens.fieldByName('valor').AsFloat;


// sobras/ faltas
  tbItens.Locate('tpMov', '-8', [loCaseInsensitive]);
  itSobras := tbItens.fieldByName('valor').AsFloat;


   venda := dm.somaColunaTable(tbItens, 'valor');

   venda := venda - ( itVenda + itSangria + itSobras);

   if ( abs(itVenda -  venda)  <>  abs(itSobras) ) then
   begin
      erro := erro + dm.getMsg('fmMovdiario.errSomas');
      dm.setParams(erro, floatToStrFomatado(itVenda, false), floatToStrFomatado(venda, false),  floatToStrFomatado(itSobras, false)) ;
   end;

   if erro <> '' then
      msg.msgErro(erro);

   f.gravaLog('validaPreenchimento() resultado: ' + boolToStr( ( erro = ''), true   ));

   result := ( erro = '');


end;

function getSeqMov(uo:String; data:Tdate):String;
var
   cmd:String;
begin
   cmd := dm.getCMD3('movDiario', 'pesqMovDiario', uo, fdt.dateToSqlDate(data), '');
   result := dm.openSQL( cmd, '');
end;

function getDadosMov(seqMov:String):TdataSet;
begin
   result := dm.getDataSetQ( dm.getCMD1('movDiario', 'getDadosMovDiario', seqMov) );
end;


function  movJaCriado(uo:String; data:Tdate):boolean;
begin
   result := (getSeqMov(uo, data) <> '');
end;

function criaMov(uo, cdPes:String; data:Tdate):String;
var
   num, cmd:String;
begin
   num := '';
   if (data > -1) then
      if (movJaCriado(uo, data) = false)  then
      begin
      // insere o registro do novo movimento
         cmd := dm.getCMD3('movDiario', 'novoMov', uo, fdt.dateToSqlDate(data), cdPes);
         num := dm.openSQL(cmd, '@@identity');

      // insere os itens na tabela dos itens.
         cmd := dm.getCMD3('movDiario', 'novoMov.Itens',    num, '', '');
         dm.execSQL(cmd)
      end
      else
         msg.msgErro( dm.getMsg('fmMovdiario.errMovExiste'));

   result := num;
end;


function abreMov(seqMov:String; tbItens, tbDesp: TADOTable):TdataSet;
var
   cmd:String;
   ds:TdataSet;
begin
   if (seqMov = '' ) then
   begin
      msg.msgErro( dm.getMsg('fmMovdiario.errSemMov'));
      result := nil;
   end
   else
   begin
      ds:= uMovDiario.getDadosMov(seqMov);

   //cria a tabela
      cmd := dm.getCMD('movDiario', 'getTbMovDiario');

      dm.getTable(tbItens, cmd );
      tbItens.Close();

      cmd := dm.getCMD3('movDiario', 'getItensMovDiario', tbItens.TableName, seqMov, seqMov);
      dm.execSQL(cmd);


   //cria a tabela temporaria das despesas
      cmd := dm.getCMD('movDiario', 'getTbMovDiarioDesp');
      dm.getTable(tbDesp, cmd );
      tbDesp.Close();

   // carregar a tabela das despesas

      cmd := dm.getCMD3('movDiario', 'getDesp', tbDesp.TableName,  seqMov, '');
      dm.execSQL(cmd);

      f.gravaLog('Tabela de itens');
      tbItens.Open();
      f.gravaLog('Tabela de detalhes das despesas');
      tbDesp.open();
      result := ds;
   end;
end;


function salvaMov(tbItens, tbDesp: TADOTable ):boolean;
var
   cmd:String;
begin
   if (validaPreenchimento(tbItens, tbDesp) = true) then
   begin
      f.gravaLog(' validacao ok, salvando');

      tbItens.First();

   // remove os registros que ja tem na tabela de itens do movimento
      cmd := dm.getCMD1('movDiario', 'delItensTbMov', tbItens.fieldByName('seqMov').asString );
      dm.execSQL(cmd);

   // insere os novos itens
      cmd := dm.getCMD1('movDiario', 'salvaItensTbMov', tbItens.TableName);
      dm.execSQL(cmd);


   // salvar as despesas
      cmd := dm.getCMD1('movDiario', 'delDespTbMov', tbItens.fieldByName('seqMov').asString );
      dm.execSQL(cmd);


   // inserir as despesas novas
      cmd := dm.getCMD3('movDiario', 'salvaDespTbMov', tbItens.fieldByName('seqMov').asString, tbDesp.TableName, '');
      result := dm.execSQL(cmd);
   end
   else
      result := false;

//   f.gravaLog(BoolToStr(result));
end;

function imprimeMov(tbItens, tbDesp: TADOTable):boolean;
var
  ds:TdataSet;
begin
//   if (tbItens.IsEmpty = false) then
   begin
      ds:= getDadosMov(tbItens.fieldByName('seqMov').AsString);

      f.gravaLog( intToStr(tbItens.RecordCount) + '  ' + intToStr(tbDesp.RecordCount)  ) ;

      fmMain.imprimeRave(tbItens, tbDesp, ds, nil, nil, 'rpMovDiario', nil);
      ds.Free();
   end;
end;


function alteraStatus(seqMov:String):boolean;
var
  ds:TdataSet;
  cmd:String;
begin
   f.gravaLog('alteraStatus(seqmov: ' + seqMov +' )');

   ds:= getDadosMov(seqMov);

   cmd:=  dm.getCMD('movDiario', 'changeStatus');

   if ( ds.FieldByName('finalizado').AsBoolean = false) then
      dm.setParams(cmd, '1', seqMov, '' )
   else
      dm.setParams(cmd, '0', seqMov, '' );

   result := dm.execSQL(cmd);

   ds.free();
end;

function enviaEmail(seqMov:String):boolean;
var
  ds:TdataSet;
  subject:String;
  mailBody:TStringList;
begin//
   ds:= getDadosMov(seqMov);

   mailBody := TStringList.Create();

   mailBody.Add(subject);
   mailBody.Add('');

   subject :=  dm.getMsg('fmMovDiario.Mail');
   dm.setParams(subject,
                ds.fieldByName('ds_uo').asString,
                ds.fieldByName('data').asString,
                ds.fieldByName('nm_usu').asString
               );

    mailBody.Add('');
    mailBody.Add(subject);

    fmMain.enviarEmail( dm.getParamBD('fmMovDiario.mailConferente', ''),
                        subject,
                        '',
                        mailBody,
                        dm.getMsg('fmMovDiario.mailTitle') );

   ds.Free();
//   mailBody.SaveToFile('c:\teste.txt');
   mailBody.Free();
end;



end.
