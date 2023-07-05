unit uRelatorioComissao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, ExtCtrls, ComCtrls, fCtrls,
  adLabelComboBox, DB, ADODB, Grids, DBGrids, SoftDBGrid,
  Buttons, Menus, StrUtils;

type
  TfmRelatorioComissao = class(TForm)
    GroupBox1: TGroupBox;
    cbLoja: TadLabelComboBox;
    FlatButton1: TFlatButton;
    FlatButton2: TFlatButton;
    GroupBox2: TGroupBox;
    datai: TfsDateTimePicker;
    dataf: TfsDateTimePicker;
    StaticText1: TStaticText;
    tb: TADOTable;
    grid: TSoftDBGrid;
    DataSource2: TDataSource;
    qrResult: TADOQuery;
    tbResult: TADOTable;
    cbTipoComissao: TadLabelComboBox;
    gbExporta: TGroupBox;
    FlatButton3: TFlatButton;
    cbComissFlores: TfsCheckBox;
    PopupMenu: TPopupMenu;
    N1: TMenuItem;
    cbNomeTb: TfsCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FlatButton2Click(Sender: TObject);
    procedure geraComissao();
    procedure ObterVendasPeriodo();
    procedure obterVendedoresDasVendasDoDia();
    procedure adicionarVendas();
    procedure prencheDadosVendedor();
    procedure incluirTotal();
    procedure criaTbResult();
    function getStrPreco():String;
	 procedure removeVendaDefloresDaComissao();

    procedure N1Click(Sender: TObject);

    function getStrclientes():String;
    procedure cbTipoComissaoChange(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRelatorioComissao: TfmRelatorioComissao;
  isAcessoRestrito:boolean;

implementation

uses uMain, f, funcsql, uCF, cf, uDm, uLj, fdt, uCaixa;

function TfmRelatorioComissao.getStrClientes():String;
var
   strCodCliConsumidor, cmd:String;

begin
   strCodCliConsumidor := dm.getParamBD('comum.codCliConsumidor', '0');

   case cbTipoComissao.ItemIndex of
      2,4: cmd := ' and cd_pes in ( '+strCodCliConsumidor +' ) ';
      3,5: cmd := ' and cd_pes not in ( '+strCodCliConsumidor +' ) ';
   else
      cmd := '';
   end;
   result := cmd;
end;

function TfmRelatorioComissao.getStrPreco(): String;
begin
{
Varejo - Completo
Atacado - Completo (*)
Varejo - Consumidor (*)
Varejo - Cliente cadastrado (*)
Atacado - Consumidor
Atacado - Cliente cadastrado
<Todos >
}

   case cbTipoComissao.ItemIndex of
      0, 2, 3: result := '101';
      1, 4, 5: result := '103';
   else
     result := '101, 103'
   end;
end;

procedure TfmRelatorioComissao.criaTbResult();
var
	nmTb:String;
begin
// cria a tabela de resultados finais que mostrara na tela
   dm.getTableComNome(tbResult,  dm.getCMD('Vendas', 'getTbComissaoRes'), '');

   f.ajGridCol( grid, tbResult, 'seq', -1, '' );
   f.ajGridCol( grid, tbResult, 'cd_vend', -1, '' );
   f.ajGridCol( grid, tbResult, 'Vendedor', 120, 'Vendedor');
   f.ajGridCol( grid, tbResult, 'faixa01', 75, '0 a 50 ');
   f.ajGridCol( grid, tbResult, 'faixa02', 75, '51 a 100');
   f.ajGridCol( grid, tbResult, 'faixa03', 75, '101 a 150');
   f.ajGridCol( grid, tbResult, 'faixa04', 75, '151 a 200');
   f.ajGridCol( grid, tbResult, 'faixa05', 75, 'Maior que 200');
   f.ajGridCol( grid, tbResult, 'Quant atendimentos', 100, 'Total Atendimentos');
end;

{$R *.dfm}

procedure TfmRelatorioComissao.FormClose(Sender: TObject;var Action: TCloseAction);
begin
   qrREsult.Free();
   tb.Close;
   tbResult.CLOSE();
   f.salvaCampos(fmRelatorioComissao);
   fmRelatorioComissao := nil;
   action := CaFree;
end;

procedure TfmRelatorioComissao.FormCreate(Sender: TObject);
begin
   isAcessoRestrito := fmMain.isGrupoRestrito(fmMain.RelatriodeComisso1.tag);

   uLj.getListaLojas(cbLoja, false, false, fmMain.getCdPesLogado(), '' );

   fmMain.getParametrosForm(fmRelatorioComissao);

   cbTipoComissao.Enabled := not(isAcessoRestrito);

   fmRelatorioComissao.Caption := fmMain.getCaptionNivelAcesso(fmRelatorioComissao.Caption, isAcessoRestrito);

  	cbNomeTb.Visible := (FmMain.isAcessoTotal(fmMain.RelatriodeComisso1.tag) = true);

	if (isAcessoRestrito = true) then
   begin
   	cbComissFlores.Visible := false;

		cbComissFlores.Checked := (dm.getParamBD('uoRemoveComissaoFlores', f.getCodUO(cbLoja)) = '1');
   end;
end;

procedure TfmRelatorioComissao.FlatButton2Click(Sender: TObject);
var
   lst:TStringList;
begin
   if (tbResult.IsEmpty = false) then
   begin
      lst := TstringList.Create();

      lst.Add(dateToStr(datai.date));
      lst.Add(dateToStr(dataf.date));

      lst.Add(fmMain.getNomeUsuario() );
      lst.Add(uLj.getNomeUO(cbTipoComissao));

      lst.Add(uLj.getNomeUO(cbLoja));
      lst.Add(grid.Columns[tbResult.FieldByName('faixa01').Index].Title.Caption);

      lst.Add(grid.Columns[tbResult.FieldByName('faixa02').Index].Title.Caption );
      lst.Add(grid.Columns[tbResult.FieldByName('faixa03').Index].Title.Caption );

      lst.Add(grid.Columns[tbResult.FieldByName('faixa04').Index].Title.Caption );
      lst.Add(grid.Columns[tbResult.FieldByName('faixa05').Index].Title.Caption );

      lst.Add(grid.Columns[tbResult.FieldByName('Quant atendimentos').Index].Title.Caption);

      if (isAcessoRestrito = false ) then
         lst.Add('Valor atendimento')
      else
         lst.Add('Valor base comissão');

      fmMain.imprimeRave(tbResult, nil, nil, nil, nil, 'rpComissao', lst);
      lst.free();
   end;
end;

procedure TfmRelatorioComissao.ObterVendasPeriodo();
var
   ds: TdataSet;
   dti, dtf: Tdate;

begin
   fmMain.msgStatus('Gerando vendas...');

// cria a tabela com os dados de todas das vendas
   dm.getTableComNome(tb, dm.getCMD('Vendas','getTbComissaoVendas'), '');

   while tb.IsEmpty = false do
      tb.Delete();

   dti := datai.Date;

   dtf := dataf.date;

   ds:= uCaixa.getPreviaGeralCaixa(f.getCodUo(cbLoja), '', dti, dtf, true, false, false, true);

   f.gravaLog('selecionar somente os registro de recebimento - inicio');

   screen.Cursor := crHourGlass;
   ds.First;
   while (ds.eof= false) do
   begin
     if (ds.fieldByName('fl_sinal').AsString = 'E') then
     begin
     // adiciona os registros na tabela temporaria
        tb.appendRecord([
           ds.fieldByName('is_oper').asInteger,
           ds.fieldByName('cd_mve').asInteger,
           ds.fieldByName('valor').asFloat,
           ds.fieldByName('tipoPrecoSugerido').AsString,
           ds.FieldByName('cd_vend').AsString,   {vendedor}
           ds.fieldByName('cd_pes').asInteger,
           ds.fieldByName('is_docv').asInteger,
           ds.fieldByName('vl_venda').asInteger,
           ds.fieldByName('dataSessaoCaixa').AsDateTime
        ]);
     end;
       ds.next;
   end;

   ds.free();
   screen.Cursor := crDefault;

   fmMain.msgStatus('ObterVendasDoDia() ok');
end;

procedure TfmRelatorioComissao.obterVendedoresDasVendasDoDia();
var
  cmd:String;
  ds:TdataSet;
  tpPcSugerido:String;
begin
{
   a consulta da previa ja traz boa parte dos vendedores, vou consultar somente
   os que nao traz
}

   f.gravaLog('obterVendedoresDasVendasDoDia() - inicio');
   fmMain.msgStatus('Classificando vendas...');

   tb.First;
   while (tb.Eof = false) do
   begin
      if ( tb.FieldByName('cd_vend').asInteger = 0) then
      begin
         cmd := 'Select top 01 cd_vend, TipoPrecoSugerido from dlanv (nolock) where is_oper = ' + tb.fieldByname('is_oper').asString;
         ds:= dm.getDataSetQ(cmd);

         if ds.fieldByName('tipoPrecoSugerido').AsString = '0' then
         begin
            tpPcSugerido := '101'
         end
         else
            tpPcSugerido := ds.fieldByName('tipoPrecoSugerido').AsString;

         tb.Edit;
         tb.FieldByName('TipoPrecoSugerido').AsString := tpPcSugerido; { ds.fieldByname('TipoPrecoSugerido').AsInteger; }
         tb.FieldByName('cd_vend').asInteger := ds.fieldByname('cd_vend').AsInteger;
         tb.post;

         ds.Free();
      end;
      tb.Next;
   end;

   f.gravaLog('obterVendedoresDasVendasDoDia() - fim');
   fmMain.msgStatus('');
end;

procedure TfmRelatorioComissao.adicionarVendas();
var
   strPreco, cmd, strCodCliConsumidor:String;
   i,codUo:integer;
   fxValor: array[1..6] of String;
begin
   f.gravaLog('Adicionando as vendas do dia ao total das vendas');

                 ///
   fxValor[1] := '-1';
   fxValor[2] := '50';
   fxValor[3] := '100';
   fxValor[4] := '150';
   fxValor[5] := '200';
   fxValor[6] := '999999';

   codUo := StrToInt(f.getNumUO(cbLoja));
   strCodCliConsumidor := dm.getParamBD('comum.codCliConsumidor', '0');

// *** incluir as faixas dos valores de venda nesse local

   strPreco := getStrPreco();

// Soma os valores de cada vendedor
   case cbTipoComissao.ItemIndex of
      0,1: cmd := ' Select cd_vend, sum(valor) as [ValorBaseComissao] from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' )  group by cd_vend ';
      2,4: cmd := ' Select cd_vend, sum(valor) as [ValorBaseComissao] from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' )  and cd_pes in ( '+strCodCliConsumidor +' ) group by cd_vend ';
      3,5: cmd := ' Select cd_vend, sum(valor) as [ValorBaseComissao] from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' )  and cd_pes not in ( '+strCodCliConsumidor +' ) group by cd_vend ';
   else
      cmd := ' Select cd_vend, sum(valor) as [ValorBaseComissao] from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) group by cd_vend ';
   end;

   qrResult.sql.clear();
   qrResult.sql.add(cmd);
   qrResult.Open();

// colocar o nome do vendedor na tabela de resultados
   qrResult.First;
   while qrResult.Eof = false do
   begin
      if dm.openSQL(' Select cd_vend from ' + tbResult.tableName + ' where cd_vend = ' + qrResult.fieldByName('cd_vend').AsString , 'cd_vend' ) = '' then
         tbResult.AppendRecord(['',
                               qrResult.FieldByName('cd_vend').AsString ,
                               qrResult.FieldByName('valorBaseComissao').AsString,
                               '0','0','0','0','0','0'])
      else
      begin
         cmd :=   ' Update ' + tbResult.tableName +
                  '  set ValorBaseComissao = ValorBaseComissao + ' +  f.ValorSql( qrResult.FieldByName('ValorBaseComissao').asString ) +
                  ' where cd_vend = ' + qrResult.FieldByName('cd_vend').asString ;
         dm.execSQL(cmd);
      end;
      qrResult.Next();
   end;

   fmMain.MsgStatus(' Calculando a quantidade de atendimentos...');

   for i:= 2 to 6 do
   begin
      case cbTipoComissao.ItemIndex of
         0: cmd :=   ' Select cd_vend, count(cd_vend) as NumAtendimentos from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' ) and valor between (' + fxValor[i-1] +'+1) and ' + fxValor[i] + ' group by cd_vend ';
         1: cmd :=   ' Select cd_vend, count(cd_vend) as NumAtendimentos from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' ) and valor between (' + fxValor[i-1] +'+1) and ' + fxValor[i] + ' group by cd_vend ';
         2,4: cmd := ' Select cd_vend, count(cd_vend) as NumAtendimentos from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' ) and valor between (' + fxValor[i-1] +'+1) and ' + fxValor[i] + ' and cd_pes in ( '+strCodCliConsumidor +' ) group by cd_vend ';
         3,5: cmd := ' Select cd_vend, count(cd_vend) as NumAtendimentos from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and tipoPrecoSugerido in ( ' + strPreco + ' ) and valor between (' + fxValor[i-1] +'+1) and ' + fxValor[i] + ' and cd_pes not in ( '+strCodCliConsumidor +'  ) group by cd_vend ';
       else
          cmd := ' Select cd_vend, count(cd_vend) as NumAtendimentos from ' +  tb.TableName + ' where cd_mve not in (68, 68+999) and valor between (' + fxValor[i-1] +' +1) and ' + fxValor[i] +  ' group by cd_vend' ;
       end;

      qrResult.sql.clear();
      qrResult.sql.add(cmd);
      qrResult.Open();
      qrResult.First();


      while (qrResult.Eof = false) do
      begin
          cmd :=   ' Update ' + tbResult.tableName +
                   ' set faixa0'+ intToStr(i-1) + ' = faixa0'+ intToStr(i-1) +' + '+
                   qrResult.FieldByName('NumAtendimentos').asString +
                   ' where cd_vend = ' + qrResult.FieldByName('cd_vend').asString;
          dm.execSQL(cmd);

          qrResult.Next();
      end;
   end;

   cmd := ' update ' + tbResult.TableName  + ' set [Quant atendimentos] =  faixa01 + faixa02 + faixa03 + faixa04 + faixa05 ';
   dm.execSQL(cmd);

   fmMain.msgstatus('');
   tbResult.Refresh();
end;

procedure TfmRelatorioComissao.prencheDadosVendedor();
var
   cmd:String;
begin
   tbResult.First;
   while tbResult.Eof = false do
   begin
      cmd := 'Select nm_usu from dsusu where cd_pes = ' + tbResult.fieldByname('cd_vend').asString;
      tbResult.edit();
      tbREsult.FieldByName('Vendedor').asString := dm.openSQL(cmd,'nm_usu');
      tbResult.post;
      tbResult.next();
   end;
   tbResult.Refresh();
end;

procedure TfmRelatorioComissao.incluirTotal;
begin
   tbResult.AppendRecord([
      'Total',
      '',
      funcsql.somaColunaTable(tbResult, 'valorBaseComissao'),
      funcsql.somaColunaTable(tbResult, 'faixa01'),
      funcsql.somaColunaTable(tbResult, 'faixa02'),
      funcsql.somaColunaTable(tbResult, 'faixa03'),
      funcsql.somaColunaTable(tbResult, 'faixa04'),
      funcsql.somaColunaTable(tbResult, 'faixa05'),
      funcsql.somaColunaTable(tbResult, 'Quant atendimentos')
         ]);
   tbResult.First();

//  dm.exportacaoDeTabelaExcel(tbResult);

end;

procedure TfmRelatorioComissao.removeVendaDefloresDaComissao();
var
  cmd:String;
  vlflores:real;
begin
   tbResult.First();

   while (tbResult.Eof = false) do
   begin
      begin
         cmd := dm.getCMD('Vendas', 'getComis.totVdFlo');
         dm.setParams(cmd, f.getCodUO(cbLoja),  fdt.dateToSqlDate(datai.Date), fdt.dateToSqlDate(dataf.Date) );
         dm.setParams(cmd, fmRelatorioComissao.getStrPreco(), tbResult.fieldByName('cd_vend').AsString, '');

         if (tbResult.fieldByName('cd_vend').AsString <> '') then
            cmd := cmd + dm.getCMD2('Vendas', 'getComis.totVdFloVend', tbResult.fieldByName('cd_vend').AsString, getStrPreco() );

         cmd := cmd + getStrclientes();


         vlflores := StrToFloat(dm.openSQL(cmd, ''));

         f.gravaLog(' vendedor: '+ tbResult.fieldByName('cd_vend').AsString +
                          ' vl venda: '+ tbResult.FieldByName('ValorBaseComissao').AsString +
                          ' vl flores: ' + floatToStr( vlflores )
                         );

         tbResult.Edit();
         tbResult.FieldByName('ValorBaseComissao').AsFloat := (tbResult.FieldByName('ValorBaseComissao').AsFloat - vlflores);
         tbResult.Post();
         tbResult.Next();
      end;
   end;
end;

procedure TfmRelatorioComissao.N1Click(Sender: TObject);
var
  ds:TdataSet;
  strCodCliConsumidor, codPc, cmd:String;
begin
   cmd := dm.getCMD1('Vendas', 'analComVend', tb.TableName {, {tbResult.fieldByName('cd_vend').AsString });

   codPc:= getStrPreco();

// processa o codigo do preco
   if (codPc <> '') then
      cmd := cmd + dm.getCMD1('Vendas', 'analComVend.pc', codPc );


   strCodCliConsumidor := dm.getParamBD('comum.codCliConsumidor', '0');

   case cbTipoComissao.ItemIndex of
      2, 4: cmd := cmd +  dm.getCMD1('Vendas', 'analComVend.cliCons', strCodCliConsumidor );
      3, 5: cmd := cmd +  dm.getCMD1('Vendas', 'analComVend.semCliCons', strCodCliConsumidor );
   end;

   ds := dm.getDataSetQ(cmd);

   fmMain.exportaDataSet(ds, nil);
end;

procedure TfmRelatorioComissao.geraComissao();
begin
  f.gravaLog('');
   f.gravaLog('--------------------------geraComissao()');
   f.gravaLog('tipo: ' + cbTipoComissao.Items[cbTipoComissao.itemindex ]);

// griar as tabelas de resultado
   criaTbResult();
// limpa a tabela de Resultados
   while tbResult.IsEmpty = false do
      tbResult.Delete();

   fmMain.MsgStatus(' Obter Vendas...');

// lista a previa  de caixa para obter as vendas...
   ObterVendasPeriodo();

// colocar os dados do vendedor de cada venda
   fmMain.MsgStatus(' Obter atendente das vendas...');
   obterVendedoresDasVendasDoDia();

   fmMain.MsgStatus(' Somar os resultados...');

   adicionarVendas();
//   dataAux:= dataAux +1;
//   inc(inicio);

// coloca na tabela de resultados o nome do vendedor
   prencheDadosVendedor();

// incluir na tabela de totais o total dos atendimentos
   incluirTotal();
{}

	if (isAcessoRestrito = true) then
   begin
	   if (dm.getParamBD('uoRemoveComissaoFlores', f.getCodUO(cbLoja)) = '1') then
	      removeVendaDefloresDaComissao()
   end
   else if (cbComissFlores.Checked = true) then
   begin
   	removeVendaDefloresDaComissao();
   end;
end;


procedure TfmRelatorioComissao.FlatButton1Click(Sender: TObject);
var
  canExecute:boolean;
begin
   canExecute := true;

   if (fdt.isIntervDataValido(datai, dataf, true) = false ) then
      canExecute := false
   else if (f.faltaLoja(cbLoja) = true ) then
      canExecute := false
   else if (isAcessoRestrito=true) then
      if (uCF.permiteExecutarRelatorio(fmMain.RelatriodeComisso1.tag, fmMain.getUoLogada()) = false) then
         canExecute := false;

   if (canExecute = true) then
      geraComissao();
end;

procedure TfmRelatorioComissao.cbTipoComissaoChange(Sender: TObject);
begin
	if (isAcessoRestrito = true) then
   begin
   	cbComissFlores.Visible := false;

		cbComissFlores.Checked := (dm.getParamBD('uoRemoveComissaoFlores', f.getCodUO(cbLoja)) = '1');
   end;
end;

end.
