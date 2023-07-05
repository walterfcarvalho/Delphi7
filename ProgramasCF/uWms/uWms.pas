unit uWms;

interface

uses sysutils, messages, forms, controls, classes, ADODb;

   procedure finalizarDocSeparacao(cd_pes:String);
   procedure finalizarInternacaoNf(cd_pes:String);

   procedure listaDrvWellWms(tb:TADOTable; codigo:String; tpRelatorio:integer);
   procedure zerarPickingNegativos();
   procedure retornaOs();

implementation

uses db, uDm, f, msg;

procedure finalizarInternacaoNf(cd_pes:String);
var
   nf:String;
   ds:TdataSet;
   ask, cmd:String;
begin
   nf := '0'+f.sohNumeros(msg.msgInput(dm.getMsg('wmsGetNumNfEnt'), ''));

   ds := dm.getDataSetQ(dm.getCMD1('wms', 'getNfEntrada', nf));

   if (ds.IsEmpty = false) then
   begin
      ask := ds.fieldByName('int_numero_nfe').AsString +' '+ds.fieldByName('STR_RAZAOSOCIAL_PESSOA').AsString;

      if ( msg.msgQuestion( dm.getCMD1('msg', 'wmsConfIntNfEnt', ask)) = mrYes) then
         dm.execSQL(dm.getCMD2('wms', 'finNfEntrada', nf, cd_pes));
   end
   else
      msg.msgErro(dm.getMsg('wmsConfIntNfEntErr1'));
   ds.free();
end;

procedure finalizarDocSeparacao(cd_pes:String);
var
   nf:String;
   ds:TdataSet;
   cmd:String;
begin
   nf := '0'+f.sohNumeros( msg.msgInput(dm.getMsg('wmsGetNumDocSep'), ''));

   if nf <> '0' then
   begin
      ds := dm.getDataSetQ(dm.getCMD1('wms', 'getOS', nf));

      if (ds.IsEmpty = false) then
      begin
         cmd := ds.fieldByName('nm_pes').AsString ;
         if ( msg.msgQuestion( dm.getCMD1('msg', 'wmsConfIntDocSep', cmd)) = mrYes) then
         begin
            dm.execSQL(dm.getCMD2('wms', 'finOS', nf, cd_pes));
            msg.msgExclamation(dm.getMsg('wmsIntNfEntOk'));
         end
      end
      else
         msg.msgErro(dm.getMsg('wmsConfIntDocSEpErr1'));
      ds.free();
   end;
end;


procedure listaDrvWellWms(tb:TADOTable; codigo:String; tpRelatorio:integer);
var
   tipoRel, cmd:String;
begin
   if ( tb.TableName <> '') then
      tb.Close();

   dm.getTable(tb, dm.getCMD('wms', 'getTBLstDvgWellWms'));
   tb.Close();

   cmd := dm.getCMD('wms', 'getLstDvgWellWms');

   if (codigo <> '' )then
      codigo := dm.getQtCMD1('wms', 'getLstDvgWellWms.cod', codigo + '%')
   else
      codigo := '';

   case tpRelatorio of
   	0: tipoRel := dm.getQtCMD1('wms', 'getLstDvgWellWms.WellPos', '');
      1: tipoRel := dm.getQtCMD1('wms', 'getLstDvgWellWms.WellNeg', '');
      2: tipoRel := dm.getQtCMD1('wms', 'getLstDvgWellWms.WmsNeg' , '');
   else
      tipoRel :=  ''
   end;

   dm.setParams(cmd, tb.TableName, codigo, tipoRel, );

   dm.execSQL(cmd);

   tb.Open();

   tb.First();
   while ( tb.Eof = false) do
   begin
      if (tb.FieldByName('EstoqueWMS').AsInteger = tb.FieldByName('EstoqueWell').AsInteger) then
         tb.Delete()
      else
         tb.Next;
   end;
end;

procedure zerarPickingNegativos();
begin
   if (msg.msgQuestion(dm.getMsg('wms_Conf_zeraPick')) = mrYes) then
   begin
      dm.execSQL( dm.getCMD('wms', 'zeraQtPickingNegativo'));
      msg.msgExclamation(dm.getMsg('MSG_FIM'))
   end;
end;


procedure retornaOs();
var
	cmd, os:String;
begin
	os := trim(msg.msgInput('Informe o número da OS',''));

   if (os = '') then
   	os := '0';

   cmd := dm.getCMD1('wms', 'rec_os_p1', os);
	dm.execSQL(cmd);

   cmd := dm.getCMD1('wms', 'rec_os_p2', os);
	dm.execSQL(cmd);

   cmd := dm.getCMD1('wms', 'rec_os_p3', os);
	dm.execSQL(cmd);

   cmd := dm.getCMD1('wms', 'rec_os_p4', os);
	dm.execSQL(cmd);

   cmd := dm.getCMD1('wms', 'rec_os_p5', os);
	dm.execSQL(cmd);

   if (dm.getDataSetQ( dm.getCMD1('wms', 'getOS', os)).IsEmpty = false) then
   	msg.msgExclamation('OS recuperada com sucesso.')
   else
		msg.msgErro('Os não encontrada');
end;




end.
