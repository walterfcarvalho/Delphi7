unit uCartoes;

interface
   uses ADODB, ComCtrls, QForms, uCaixa;

   procedure cargaDadosConciliacao(tb:TADOTable; dti, dtf: TDateTimePicker);



implementation


uses uCF, uMain, fdt, f, uDm, msg;

procedure cargaDadosConciliacao(tb:TADOTable; dti, dtf: TDateTimePicker);
var
  cmd:String;
  nmTbTemp:String;
begin
   uCaixa.listaRecebimentosCaixa( tb, '', '', dti, dtf, true, false, false, false);


   screen.cursor := -11;
   if (tb.IsEmpty = false) then
   begin
      fmMain.msgStatus( dm.getMsg('tef.VerCarga') );

      // remove o antigo
      cmd := dm.getCMD1('tef', 'expVdConcRemAntigo', fdt.dateToSqlDate(dti.Date));
      dm.execSQl(cmd);
      dm.execSQL('if exists (select * from sysobjects where name = ''tbcarga'') drop table tbCarga');


      dm.execSQL('select * into tbcarga from ' + tb.TableName);


      // remove o antigo da totvs
      cmd := dm.getCMD1('tef', 'expVdConcRemAntigoTotvs', fdt.dateToSqlDate(dti.Date));
      dm.execSQl(cmd);


      fmMain.msgStatus( dm.getMsg('tef.expDados'));


      // insere os dados da conciliacao no conciliacao do well
      cmd := dm.getCMD1('tef', 'expVdConc', tb.TableName);


      // tenta executar o remover do dia
      if (dm.execSQl(cmd) = false) then
      begin
         msg.msgErro( dm.getMsg('tef.errExp'))
      end
      else
      begin
         cmd := dm.getCMD1('tef', 'expVdConcTotvs', 'tbCarga');
         dm.execSQl(cmd);

         msg.msgExclamation(dm.getMsg('tef.ExpOk'));

         dm.execSQL('if exists (select * from sysobjects where name = ''tbcarga'') drop table tbCarga');
      end;
   end;
   tb.close();
   screen.cursor :=0;
end;


end.
