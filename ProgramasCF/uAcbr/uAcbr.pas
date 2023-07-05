unit uAcbr;

interface

   uses classes, Forms, windows, DB, xmlDoc, XMLintf, dbClient, Xmlxform;

   function getChaveNFeSaida(is_uo, is_nota:String):String;
   function getDaDosXml(arqXml, arqXtr:String):TdataSet;
   function getDirRemoto(uo, dataEmissao:String):String;
   function getFileFromACBR(server, dirRemoto, dirLocal, arquivo: String): boolean;
   function getIPServer(uo:String):String;
   function getPDFNFe(isNota: String):String;
   function getSubPastaXML(strDataEmissao:String): String;
   function redirectAutorizadorNFE(uo:String; isContingencia:boolean):boolean;
   function putFile(servidor, dirRemoto, arqLocal:String):boolean;
   function xmlExists(arq:String; var server, dirRemoto:String):boolean;
   function gerarPDF(isuo,  dirRemotoAcbr, nmArquivo:String ):String;
   function getArqFromACBR(isuo, nmArquivo:String  ):String;
   procedure impDANFE(dsNf:TdataSet);
   procedure setPastasAcr(var dirRemotoAcbr, dirRemotoFtp:String; dsNf:TdataSet);


implementation

uses umain, uftp, f, sysutils, uDm, uTelnet, uFiscal, fdt, msg, uLj;

procedure setPastasAcr(var dirRemotoAcbr, dirRemotoFtp:String; dsNf:TdataSet);
var
  cd_trans, subDirFtp, subDirAcbr:String;
begin
   dirRemotoAcbr :=
      dm.getParamBD('ServerNFE.pastaBaseNFE', dsNf.FieldByName('is_estoque').AsString)  +
      dm.GetParamBD('ServerNFE.DirNFE', dsNf.fieldByName('is_estoque').asString);

   dirRemotoFtp := dm.GetParamBD('ServerNFE.DirNFE', dsNf.fieldByName('is_estoque').asString);

   cd_trans := dsNf.fieldByName('codTransacao').asString;
	if  ( cd_trans = '1') then
   begin
   	subdirAcbr := 'Entradas\';
      subDirFtp := 'Entradas\';
   end
   else
   begin
   	subDirAcbr := uAcbr.getSubPastaXML(dsNf.fieldByName('dt_emis').asString);
      subDirFtp :=  uAcbr.getSubPastaXML(dsNf.fieldByName('dt_emis').asString);
   end;


   dirRemotoAcbr := dirRemotoAcbr + subDirAcbr;
	dirRemotoFtp :=  dirRemotoFtp + subDirFtp;
end;

function getSubPastaXML(strDataEmissao:String): String;
begin
    if (dm.getParamBD('ServerNFE.XMLPorMes','0') <> '0') then
       strDataEmissao := fdt.getAnoMes(strDataEmissao)+'\'
    else
       strDataEmissao := '';

   f.gravaLog('getSubPastaXML():' + strDataEmissao);
   result := strDataEmissao;
end;

function getDirRemoto(uo, dataEmissao:String):String;
begin
   result :=
   dm.GetParamBD('ServerNFE.DirNFE', uo) + uAcbr.getSubPastaXML(dataEmissao);
end;

function getChaveNFeSaida(is_uo, is_nota:String):String;
var
   chNfe, cmd:String;
begin
   f.gravaLog('ajustaNotaEmDuplicidade(): is_uo:' + is_uo +' is_nota:' + is_nota);

   chNfe := uftp.existeArqXML(is_nota);

   if (chNfe  <> '') then
   begin
      cmd := 'NFE.ConsultarNFe("'+chNfe+'")';
//      uTelnet.executeTelnetCmd(is_uo, cmd);
      uTelnet.execCmdBool(is_uo, cmd);
   end
   else
      msg.msgErro('Nao achei o XML dessa nota no diretório do ACBRMonitor');

   result :=  f.SohNumerosPositivos(chNfe);
end;


function redirectAutorizadorNFE(uo:String; IsContingencia:boolean):boolean;
var
  cmd, cmdAcbr, tpEmissao:String;
  res:boolean;
begin
//   muda a serie das notas fiscais para contingncia ou tira da contingencia

   if (isContingencia = false) then
   begin
      tpEmissao :=  dm.getParamBD('ServerNFE.SrNfe', uo);
      cmdAcbr := 'NFe.SetFormaEmissao(1)'
   end
   else
   begin
      tpEmissao :=  dm.getParamBD('ServerNFE.SrNfeCont', uo);
      cmdAcbr := 'NFe.SetFormaEmissao(3)';
   end;

   if( dm.getParamBD('ServerNFE.ip', uo) <> '') then
   begin
      cmd :=
      ' update topsef set sr_nf=' + quotedStr(tpEmissao) +' where' +
      ' sq_opf in( select sq_opf  from topi where ds_res like ''nf%'') and' +
      ' is_loja= '+ uo;
      dm.execSQL(cmd);

//   Manda o comando para o ACBRMonitor para entrar ou sair do SCAN

      res:= uTelnet.execCmdBool(uo, cmdAcbr );
   end;
   result :=res;
end;

function getFileFromACBR(server, dirRemoto, dirLocal, arquivo: String): boolean;
begin
   result :=  uFTp.getFile(server, dirRemoto + arquivo);
   fmMain.MsgStatus('');
end;

function getArqFromACBR(isuo, nmArquivo:String):String;
var
   server, dirLocal, dirRemoto:String;
begin
   server := dm.GetParamBD('ServerNFE.ip',  isuo);
   dirLocal :=  ExtractFilePath(paramStr(0))+'logs';

   dirRemoto := dm.GetParamBD('ServerNFE.DirPDF', isuo);

   if (uACBR.getFileFromACBR(server, dirRemoto, dirLocal, nmArquivo ) = true) then
       result := dirLocal +'\'+ nmArquivo
   else
   begin
      msg.msgErro(' Não consegui fazer o download do arquivo PDF.');
      result := '';
   end;
end;

function gerarPDF(isuo,  dirRemotoAcbr, nmArquivo:String ):String;
var
   server, dirLocal:String;
begin
   server := dm.GetParamBD('ServerNFE.ip',  isuo);
   dirLocal :=  ExtractFilePath(paramStr(0))+'logs';

//   if (uTelnet.execCmdBool( isUo, 'NFe.ImprimirDANFEPDF("' + dirRemotoAcbr+ nmArquivo + '")'  ) = true) then
   nmArquivo := (uTelnet.geraArqPDF(isUo, 'NFe.ImprimirDANFEPDF("' + dirRemotoAcbr+ nmArquivo + '")'));

   if nmArquivo <> '' then
   begin
//      dirRemoto := dm.GetParamBD('ServerNFE.DirPDF', isuo );
//      fmMain.MsgStatus('Baixando arquivo PDF');
      result := nmArquivo;
   end
   else
   begin
      msg.msgErro(' Não existe o arquivo PDF no servidor.');
      result := '';
   end;

end;

function getPDFNFe(isNota: String):String;
var
  server, dirLocal, dirRemotoFtp, dirRemotoAcbr, arquivo, arqFtp, sufixoArq :String;
  ds:TdataSet;
begin
   screen.Cursor := -11;
   fmMain.msgStatus('Gerando arquivo PDF');

   ds:= uFiscal.getDadosNota(isNota, '', '', '');

   if (ds.IsEmpty = true ) or
   ( (ds.FieldByName('chave_acesso_nfe').asString = '') and (ds.FieldByName('nmArq').asString = '') ) then
   begin
      msg.msgErro( dm.getMsg('MSG_ERRO_CH_NFE'));
      result := '';
   end
   else
   begin
      try
         server := dm.GetParamBD('ServerNFE.ip',  ds.fieldByName('is_estoque').asString);
         dirLocal :=  ExtractFilePath(paramStr(0))+'logs';


         setPastasAcr(dirRemotoAcbr, dirRemotoFtp, ds);

{
         dirRemotoAcbr :=
            dm.getParamBD('ServerNFE.pastaBaseNFE', ds.FieldByName('is_estoque').AsString)  +
            dm.GetParamBD('ServerNFE.DirNFE', ds.fieldByName('is_estoque').asString) +
            uAcbr.getSubPastaXML(ds.fieldByName('dt_emis').asString);

         dirRemotoFtp :=
               dm.GetParamBD('ServerNFE.DirNFE', ds.fieldByName('is_estoque').asString)
             + uAcbr.getSubPastaXML(ds.fieldByName('dt_emis').asString);
}

			if (ds.FieldByName('codTransacao').asString <> '1') then
         begin
	         arquivo :=  ds.FieldByName('chave_acesso_nfe').asString;
            arqFtp := arquivo;
            sufixoArq := '-NFE.XML';
         end
         else
         begin
	         arquivo :=  ds.FieldByName('nmArq').asString;
            arqFtp :=  ds.FieldByName('chNfe').asString;
            sufixoArq := '';
         end;

         if (uTelnet.geraArqPDF( ds.fieldByName('is_estoque').asString, 'NFe.ImprimirDANFEPDF("' + dirRemotoAcbr+ arquivo + sufixoArq + '")'  ) <> '' ) then
         begin
            dirRemotoFtp := dm.GetParamBD('ServerNFE.DirPDF', ds.fieldByName('is_estoque').asString );
            fmMain.MsgStatus('Baixando arquivo PDF');

            if (uACBR.getFileFromACBR(server, dirRemotoFtp, dirLocal, arqFtp +'.pdf') = true) then
               result := dirLocal +'\'+ arqFtp +'.pdf'
            else
            begin
               msg.msgErro(' Não consegui fazer o download do arquivo PDF.');
               result := '';
            end
         end
         else
         begin
            msg.msgErro(' Não existe o arquivo PDF no servidor.');
            result := '';
         end;
      except
      on e:Exception do
      begin
         f.gravaLog('Erro ao baixar o pdf '+ e.Message);
         msg.msgErro('Houve um erro ao tentar obter o arquivo.');
         result := '';
      end
      end;
   end;
   screen.Cursor := 0;
end;

function getDaDosXml(arqXml, arqXtr:String):TdataSet;
var
   clientDataSet:TclientDataSet;
   xmlTransformProvider: TXMLTransformProvider;
begin
   // retorna um dataset de acordo com o arquivo XTR enviado
   f.gravaLog('uAcbr.getDaDosXml(arquivo Xml: ' +arqXml+ ', arquivo Xtr:' +arqXtr + ')' );

   xmlTransformProvider := TXMLTransformProvider.Create(nil);
   clientDataSet := TClientDataSet.Create(nil);

   try
     XMLTransformProvider := TXMLTransformProvider.Create(nil);
     XMLTransformProvider.TransformRead.TransformationFile := arqXtr;
     XMLTransformProvider.XMLDataFile := arqXml;

     clientDataSet.SetProvider(xmlTransformProvider);
     clientDataSet.Active := true;
   except
     on e:exception do
     begin
        f.gravaLinhaEmUmArquivo(f.getDirLogs() + 'XmlInvalidos.txt', arqXml);

        f.gravaLog(e.Message);
        msg.msgErro( dm.getCMD1('MSG', 'acbr.errFileFormat', arqXml)  );
        result := clientDataSet;
     end;
   end;

//   f.gravaLog(clientDataSet, 'DataSet da Nfe:' + arqXml);

   if (clientDataSet.IsEmpty = true) then
     msg.msgErro( dm.getCMD1('msg', 'nfArqInvalido', arqXml));


   result := clientDataSet;
end;

function xmlExists(arq:String; var server, dirRemoto:String):boolean;
var
  i:integer;
  ds:TdataSet;
  uoDest:String;
  dtNF, arqRemoto:String;

Begin
   ds:= getDaDosXml(arq, f.getDirExe() + 'nfeEnt.xtr');

   for i:=0 to ds.FieldCount -1 do
     f.gravaLog(ds.Fields[i].FieldName + ': '+  ds.fields[i].AsString);

   uoDest := uLj.getIsUoFromCNPJ(ds.fieldByName('dest_CNPJ').AsString);

   if (uoDest <> '') then
   begin
      f.gravaLog('XML para a loja:' + uoDest);

      server := dm.getParamBD('ServerNFE.ip', uoDest);

      dtNF := fdt.dataSqlToData(ds.fieldByName('dEMi').AsString);

      f.gravaLog('dtNF:' + dtNF);

      dirRemoto := getDirRemoto(uoDest, dtNF );

      f.gravaLog('Dir remoto:' + dirRemoto);

      arqRemoto :=
      '*'+ ds.fieldByName('emit_CNPJ').AsString + '*' +
      f.preencheCampo(3, '0', 'e', ds.fieldByName('serie').asSTring) +
      f.preencheCampo(9, '0', 'e', ds.fieldByName('nNF').asSTring) + '*';

      arq := uFtp.isArquivoExiste(server, dirRemoto + arqRemoto);

      f.gravaLog('chave no servidor:' + arq);

     result := (arq <> '');
   end
   else
   begin
      f.gravaLog('não achei a isUo do cnpj:'+  ds.fieldByName('dest_CNPJ').AsString);
      msg.msgErro(dm.getMsg('fiscal.XmlNaoeNosso'));
   end;

   ds.free();
end;

function putFile(servidor, dirRemoto, arqLocal:String):boolean;
begin
  result := uFtp.putFile(servidor, dirRemoto, arqLocal);
end;

function getIPServer(uo:String):String;
begin
   result := dm.getParamBD('ServerNFE.ip', uo);
end;

procedure impDANFE(dsNf:TdataSet);
var
  impressora, dirNfe, cmd:String;
begin
//   impressora:= uCF.getNomeImpressoraNFe();

   dirNFE := dm.getParamBD('ServerNFE.pastaBaseNFE', dsNf.FieldByName('is_estoque').AsString)
             + dm.getParamBD('ServerNFE.DirNFE', dsNf.FieldByName('is_estoque').AsString)
             + uAcbr.getSubPastaXML(dsNf.fieldByName('dt_emis').asString);

   cmd := 'NFE.ImprimirDANFE("' + dirNFE + dsNf.FieldByName('chave_acesso_nfe').AsString + '-nfe.xml","'+ impressora+'")';
end;




end.
