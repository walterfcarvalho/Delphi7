unit uCredCli;

interface
   uses SysUtils, adoDB;

   function gerarCreditoDecliente(cod_emp, usAutorizador, num_cli, loja, valor:String; conexao:TADOConnection ):Boolean;

implementation

uses f, uDm, fdt, db, DateUtils;

function gerarCreditoDecliente(cod_emp, usAutorizador, num_cli, loja, valor :String; conexao:TADOConnection ):Boolean;
var
  strData, cmd: String;
  dsAut:TADOQuery;
begin
   try
       f.gravaLog(conexao.ConnectionString);

       conexao.Connected := true;

      // pegar a data do bd
       strData := fdt.dataToSqlInt(dm.getDateBd);

      // pegar os dados do usuario autorizador
     dsAut := TADOQuery.Create(nil);

      With (dsAut) do
      begin
         Connection := conexao;
         CommandTimeout := 0;
         cmd :=  'Select nm_usu, p_cod_usu from dsusu where cd_usu = ' + usAutorizador;
         SQL.Add(cmd);
         Open;
      end;

      f.gravaLog(cmd);



      cmd := ' exec [SP_INC_DSADI] ' +
             '  @COD_EMP= ' + cod_emp  +
             ', @COD_EST=1, @CONTABILIZ= '''' '  +
             ', @DAT_ADI = ' + strData +
             ', @DAT_PRE= 0' +
             ', @HISTORICO = ' +  quotedStr('Gerado por ' + dsAut.fieldByName('nm_usu').AsString ) +
             ', @ID_ADI = '''' ' +
             ', @NUM_CLI = ' + num_cli +
             ', @OPC_CTADEB = '''' ' +
             ', @TIP_ADI = ''D'' ' +
             ', @VAL_ADI = ' + valor +
             ', @CTA_CREDIT = ''0'' ' +
             ', @CTA_DEBITO = ''0'' ' +
             ', @INTERV_CRE = ''0'' ' +
             ', @INTERV_DEB = ''0'' ' +
             ', @CTA_GFI = ''0'' '    +
             ', @LOJA_ORIGEM = ' + loja +
             ', @VAL_CALC = ' + valor +
             ', @IS_OPER = 0 '+
             ', @IS_DOC = 0 ' +
             ', @COD_USU = ' + quotedstr(dsAut.fieldByName('p_cod_usu').AsString) +
             ', @COD_USU_AUTOR = '''' ' +
             ', @VAL_DESP  = 0.00 ';

      f.gravaLog(cmd);
      dsAut.Close();
      dsAut.SQL.Clear();
      dsAut.SQL.Add(cmd);
      dsAut.ExecSQL();



      dsAut.Free;
      conexao.Free();

      result := true;
   except
      on e:exception do
      begin
         result := false;
      end;
   end;


end;



end.
