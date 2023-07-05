unit uPessoa;

interface

uses  Controls, DB, SysUtils, ADODB, Classes, adLabelComboBox,Extctrls,
      ulj, fdt, uMain, uDm, f, DBGrids, ucf, jpeg, adm, msg, uReq, QForms;

	function getDadosCliente(cd_pes, nm_pes:String):TDataSet;
	function getDadosFornecedor(cd_pes, nm_pes:String):TDataSet;
   function getDadosPessoa(cd_pes:String):TdataSet;
   function getUfPessoa(cd_pes:String):String;

	procedure listaCreditos(tb:TAdotable; is_uo:string; di:Tdate; vlMin:string);
   procedure removeCidadeinvalida(cidOld, cidNew:String);


implementation


function getDadosPessoa(cd_pes:String):TdataSet;
begin
   result := dm.getDataSetQ('Exec stoConsultarPessoa '+ cd_pes);
end;

function getUfPessoa(cd_pes:String):String;
begin
   result := getDadosPessoa(cd_pes).fieldByName('CD_UF').AsString
end;

function getDadosFornecedor(cd_pes, nm_pes:String):TDataSet;
var
   cmd:String;
begin
   if (cd_pes = '') then
      cmd := 'Select top 50 is_cred, cd_pes as codigo, nm_razsoc as nome from dscre where  nm_razsoc like ' + quotedstr( nm_pes +'%') + ' order by nome'
   else
      cmd := 'Select top 50 is_cred, cd_pes as codigo, nm_razsoc as nome from dscre where  is_cred = ' +  cd_pes + ' or cd_pes = ' + cd_pes + ' order by nome';
   result := dm.getDataSetQ(cmd);
end;

function getDadosCliente(cd_pes, nm_pes:String):TDataSet;
var
  cmd:String;
begin
   if (cd_pes = '') then
      cmd := '/*busca pelo nome*/ select top 50 cd_pes as codigo, nm_pes as nome, tp_lograd +'' ''+ rtrim(ds_end) +'' ''+ nr_end +'' ''+ ds_bai +'' ''+  ds_cid as endereco  from dspes ' +
             ' where nm_pes like ' + quotedstr( nm_pes +'%') + 'order by nome'
   else
      cmd := '/*busca pelo cd_ref*/ select top 50 cd_pes as codigo, nm_pes as nome, tp_lograd +'' ''+ rtrim(ds_end) +'' ''+ nr_end +'' ''+ ds_bai +'' ''+  ds_cid as endereco  from dspes ' +
             ' where cd_pes= ' + quotedstr( cd_pes ) + ' order by nome';
   result := dm.getDataSetQ(cmd);
end;


procedure listaCreditos(tb:TAdotable; is_uo:string; di:Tdate; vlMin:string);
var
	dt, sValor, dtCredAnt, cd_uo, cmd:String;
begin
   if (is_uo = '999') then
	 	cd_uo := ''
   else
		cd_uo := dm.getCMD1('Vendas', 'relAdiAberto.uo',  ulj.getCdUoFromIsUo(is_uo));

	dm.getTable(tb, dm.getCMD('vendas', 'getTbRelAdi') );

   tb.Close();

   sValor := dm.getCMD1('Vendas', 'relAdiAberto.Valor', f.valorSql(vlMin) );

   dt :=  dm.getCMD1('Vendas', 'relAdiAberto.data', fdt.dateToIntSQL(di) );

   cmd :=
	dm.getCMD4('vendas', 'relAdiAberto', tb.TableName, sValor, dt, cd_uo);

   f.gravaLog(cmd);

   dm.execSQL(cmd);


	tb.Open();

   tb.First();
   while (tb.Eof = false) do
   begin
   	cmd :=
      dm.getCMD3('vendas', 'getDtPrimCred', tb.fieldByName('num_cli').asString, fdt.dateToIntSQL(di), cd_uo);

      dtCredAnt := dm.openSQL(cmd, '');

      if (dtCredAnt <> '') then
      begin
        	tb.Edit();
         tb.FieldByName('credMaisantigo').AsDateTime := fdt.dataIntWelltoData(dtCredAnt);
         tb.Post();
		end;
      tb.Next();
   end;
   tb.First();
end;

procedure removeCidadeinvalida(cidOld, cidNew:String);
begin
   dm.execSQL(
      dm.getCMD2('sql', 'ajCadCidCli', cidOld, cidNew)
   );
end;


end.
