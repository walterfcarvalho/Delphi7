unit uComporEstoque;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, fCtrls, adLabelComboBox, DB, ADODB,
  TFlatButtonUnit, Grids, DBGrids, SoftDBGrid, adLabelEdit, Spin, Mask;
type
  TfmComporEstoque = class(TForm)
    cbLoja: TadLabelComboBox;
    GroupBox2: TGroupBox;
    FlatButton1: TFlatButton;
    tbNotas: TADOTable;
    tbItens: TADOTable;
    SoftDBGrid1: TSoftDBGrid;
    DataSource1: TDataSource;
    SoftDBGrid2: TSoftDBGrid;
    dsItens: TDataSource;
    SoftDBGrid3: TSoftDBGrid;
    qrResult: TADOQuery;
    dsREsult: TDataSource;
    edMesAtual: TadLabelEdit;
    edMesAnterior: TadLabelEdit;
    sBar: TStatusBar;
    Memo1: TMemo;
    edMesAno: TMaskEdit;
    SpinButton1: TSpinButton;
    gbAcoes: TGroupBox;
    cbGeraEstoque: TfsCheckBox;
    cbCalculaCusto: TfsCheckBox;
    procedure FlatButton1Click(Sender: TObject);
    procedure listarNotas(Sender:Tobject; dia,uo, EntSai:String);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure listarItens(Sender:Tobject; dia:Tdate);
    procedure SoftDBGrid2ColEnter(Sender: TObject);
    procedure SoftDBGrid1ColEnter(Sender: TObject);
    procedure agruparItens(Sender:Tobject; dia:Tdate);
    procedure SoftDBGrid2TitleClick(Column: TColumn);
    procedure atualizarSaldosSaidas(Sender:Tobject; sinal:String;  dia:Tdate );
    procedure dataiExit(Sender: TObject);
    procedure adicionarAoMeMo(Str:String);
    procedure comporVendaFiscal(Sender:Tobject);
    procedure cbLojaClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure ajustaData(sinal:String);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure MostraAtualizacaoDeitens(Sender:Tobject; item,Total:integer);
    procedure listarTotaisPorItem(Sender:Tobject; entSai:String);
    procedure atualizarSaldoFinal(Sender:Tobject);
    procedure obterPrecosDeCustoProdutosMes();
    procedure calculaMovimentacaoFiscal();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmComporEstoque: TfmComporEstoque;

implementation

uses uMain, f, funcsql, uCF, uDm, uLj, msg, fdt;

var
   PERFIL:String;
{$R *.dfm}

procedure TfmComporEstoque.SoftDBGrid2TitleClick(Column: TColumn);
begin
    funcsql.OrganizarTabela(tbItens,column);
end;

procedure TfmComporEstoque.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmComporEstoque := nil;
   action := cafree;
end;


procedure TfmComporEstoque.FormCreate(Sender: TObject);
begin
   fmMain.getParametrosForm(fmComporEstoque);

   uLj.getListaLojas(cbLoja, true, false, fmMain.getCdPesLogado(), '' );

   if pos(' ',edMesAno.text) > 0 then
      edMesAno.text:= '06/2013';

   Memo1.Lines.Clear();   
end;

procedure TfmComporEstoque.listarNotas(Sender: Tobject; dia, uo, EntSai: String);
var
  strOperacoes,cmd:String;
  ds:TDataSet;
  di,df:String;
begin
   di:= '01/' + edMesAno.Text;
   df:= fdt.ultimoDisDoMes(di);


   if UpperCase(EntSai) = 'S' then
   begin
      adicionarAoMeMo('Obtendo as nota < Saída >  do dia: ' + dia );
      strOperacoes := ' ( 2,  6, 11, 23, 24, 25, 29, 41, 42, 44 ) '
   end
   else
   begin
      adicionarAoMeMo('Obtendo as nota < Entrada >  do dia: ' + dia );
      strOperacoes := ' ( 1,  3,  9, 10, 12, 26, 30, 33, 43, 45, 46 ) ';
   end;

   cmd :=
          ' Select dnota.is_nota, dnota.sr_docf, dnota.nr_docf from dnota with(NoLock) ' +
          ' inner join toper with(NoLock) on toper.is_oper = dnota.is_oper '  +
          ' where dnota.dt_emis between ' +  fdt.DateTimeToSqlDateTime(di,'') + ' and ' + fdt.DateTimeToSqlDateTime(df,'') +
          ' and dnota.is_estoque in (' + uo + ')'+
          ' and toper.codTransacao in ' + strOperacoes +
     	    ' and dnota.sr_docf in (''NF1'',''NF1'', ''3'', ''ECF'', ''1'', ''2'', ''3'', ''4'' ) ' +
    		  ' and DNOTA.st_NF = '''' '  ;


   ds := dm.getDataSetQ(cmd);

   ds.First;
   while ds.Eof = false do
   begin
      tbNotas.AppendRecord([ds.FieldByName('is_nota').AsString,
                           ds.FieldByName('sr_docf').AsString,
                           ds.FieldByName('nr_docf').AsString
                          ]);
      ds.Next;
   end;
   ds.Destroy();

   tbNotas.Open;
   tbNotas.First;
end;

procedure TfmComporEstoque.listarItens(Sender: Tobject; dia:Tdate );
var
   ds:TDataSet;
   cmd:String;
begin
   dm.getTable(tbItens, ' is_ref int, qt_mov int, seq int identity(0,1) primary key');

   adicionarAoMeMo('Obtendo os itens das notas do dia: '  + dateToStr(dia)  );
   while tbNotas.Eof = false do
   begin
      cmd := ' Select is_nota , is_ref, qt_mov from dmovi (nolock) where is_nota = ' +
              tbNotas.fieldByName('is_nota').asString  + ' and st_mov = '''' ' ;
      ds := dm.getDataSetQ(cmd);
      ds.First;
      while ds.Eof = false do
      begin
         tbItens.AppendRecord([ ds.FieldByName('is_ref').AsString,
                                ds.FieldByName('qt_mov').AsString
                              ]);
         ds.Next();
      end;
      tbNotas.Next();
      ds.Destroy();
   end;
end;



procedure TfmComporEstoque.SoftDBGrid2ColEnter(Sender: TObject);
begin
   adicionarAoMeMo('Quantidade de itens ' + inttostr(tbItens.RecordCount-1));
end;

procedure TfmComporEstoque.SoftDBGrid1ColEnter(Sender: TObject);
begin
   adicionarAoMeMo('Quantidade de notas  ' + inttostr(tbNotas.RecordCount-1));
end;

procedure TfmComporEstoque.agruparItens(Sender: Tobject; dia:Tdate);
var
  cmd:String;
begin
   adicionarAoMeMo('Agrupando os itens repetidos do dia : ' + DateToStr(dia) );
   qrResult.SQL.Clear;
   cmd := 'Select is_ref, sum(qt_mov) as qt_mov from ' + tbItens.TableName + ' group by is_ref ';
   qrREsult.SQL.Add(cmd);
   qrREsult.Open();
end;

procedure TfmComporEstoque.atualizarSaldosSaidas(Sender: Tobject; sinal:String; dia:Tdate );
var
   cmd:String;
begin
   adicionarAoMeMo('Atualizando a tabela de vendas para o dia: '+ dateToStr(dia) );
   qrResult.First;
   while qrResult.Eof = false do
   begin
      if sinal = 'S' then
      begin
         cmd := ' if exists( Select saidas from zcf_saldoFiscal where is_ref = '+ qrResult.fieldByname('is_ref').asString + ' and mes = '+ edMesAtual.text + ' and is_uo = ' + f.getNumUO(cbLoja) + '  ) ' +
                ' update zcf_saldoFiscal set saidas = saidas + ' +  qrResult.fieldByname('qt_mov').asString + ' where is_ref = '+ qrResult.fieldByname('is_ref').asString + ' and mes = '+ edMesAtual.text + ' and is_uo = ' + f.getNumUO(cbLoja) +
                ' else  ' +
                ' insert zcf_saldoFiscal (is_uo, is_ref, mes, saidas) values ( ' + f.getNumUO(cbLoja) +  ', ' + qrResult.fieldByname('is_ref').asString +  ', ' + edMesAtual.Text +  ', ' + qrResult.fieldByname('qt_mov').asString + ' )';
      end
      else
      begin
         cmd := ' if exists( Select entradas from zcf_saldoFiscal where is_ref = '+ qrResult.fieldByname('is_ref').asString + ' and mes = '+ edMesAtual.text + ' and is_uo = ' + f.getNumUO(cbLoja) + '  ) ' +
                ' update zcf_saldoFiscal set entradas = entradas + ' +  qrResult.fieldByname('qt_mov').asString + ' where is_ref = '+ qrResult.fieldByname('is_ref').asString + ' and mes = '+ edMesAtual.text + ' and is_uo = ' + f.getNumUO(cbLoja) +
                ' else  ' +
                ' insert zcf_saldoFiscal (is_uo, is_ref, mes, entradas) values ( ' + f.getNumUO(cbLoja) +  ', ' + qrResult.fieldByname('is_ref').asString +  ', ' + edMesAtual.Text +  ', ' + qrResult.fieldByname('qt_mov').asString + ' )';
      end;
      dm.execSQL(cmd);
      qrResult.Next;
      MostraAtualizacaoDeitens(nil, qrResult.RecNo , qrResult.RecordCount - 1   );
    end;
end;

procedure TfmComporEstoque.dataiExit(Sender: TObject);
begin
   edMesAtual.Text :=     fdt.getDatePart('a',strTodate('01/'+ edMesAno.text )) + fdt.getDatePart('m', strTodate('01/'+ edMesAno.text ) );       //getDatePart('a',datai.date) + getDatePart('m',datai.date);
   edMesAnterior.Text :=  fdt.getDatePart('a',strTodate('01/'+ edMesAno.text )-1) + fdt.getDatePart('m',strTodate('01/'+ edMesAno.text )-1);
end;

procedure TfmComporEstoque.adicionarAoMeMo(Str: String);
begin
   Memo1.Lines.add(str);
   memo1.Refresh();
   fmComporEstoque.Refresh();
end;

procedure TfmComporEstoque.cbLojaClick(Sender: TObject);
var
  i:integer;
  ds:Tdataset;
begin
  memo1.Lines.Clear();

  ds := dm.getDataSetQ('Select distinct mes, is_uo from zcf_saldoFiscal where is_uo = '+ f.getNumUO(cbLoja) + ' order by mes');

  while (ds.Eof = false) do
  begin
    Memo1.Lines.Add('Gerado: '+ ds.fieldByName('mes').asString);
    ds.Next
  end;
  ds.free();
end;

procedure TfmComporEstoque.ajustaData(sinal: String);
var
  m,a:integer;
begin
   m:= strToInt(copy(edMesAno.Text,01, 02));
   a:= strToInt(copy(edMesAno.Text,04, 04));
   if sinal = '-' then
      m:= m -1
   else
      m:= m +1;

   if m > 12 then
   begin
      a := a +1;
      m := 01;
   end;
   if m < 1 then
   begin
      a:= a-1;
      m:= 12;
   end;
   edMesAno.Text := f.preencheCampo(2,'0','e', intToStr(m) ) + '/' + intToStr(a);
   dataiExit(nil);
end;

procedure TfmComporEstoque.SpinButton1UpClick(Sender: TObject);
begin
   ajustaData('+');
end;

procedure TfmComporEstoque.MostraAtualizacaoDeitens(Sender: Tobject; item,Total:integer);
begin
  if (item mod 10 = 0 ) or (item = total)then
     fmMain.MsgStatus(inttoStr(item) +' de '+  IntToStr(total) );
end;

procedure TfmComporEstoque.listarTotaisPorItem(Sender: Tobject; entSai: String);
var
  ds:TdataSet;
  UoAListar,loja,cmd : String;
begin
   entSai := UpperCase(entSai);
   adicionarAoMeMo('Obtendo notas, tipo ' +  entSai );

   UoAListar := dm.GetParamBD('uosPorVisao', f.getNumUO(cbLoja) );

   cmd := 'exec zcf_quantFaturadaFiscal ' +
          '@Uo=' + quotedStr(UoAListar) + ', ' +
          '@di=' + fdt.StrToSqlDate('01/'+edMesAno.Text) +', '+
          '@df=' + fdt.StrToSqlDate(fdt.ultimoDisDoMes('01/'+edMesAno.text)) +', '+
          '@isEnt = ' + quotedStr(entSai);

  loja := f.getNumUO(cbLoja);

  ds := TdataSet.Create(nil);
  ds := dm.getDataSetQ(cmd);

  adicionarAoMeMo('Listando notas ' +  entSai );

  ds.First();
  while ds.Eof = false  do
  begin
     if entSai = 'S' then
     begin
         cmd := ' if exists( Select saidas from zcf_saldoFiscal where is_ref = '+ ds.fieldByname('is_ref').asString + ' and mes = '+ edMesAtual.text + ' and is_uo = ' + loja + '  ) ' +
                ' update zcf_saldoFiscal set saidas = saidas + ' +  ds.fieldByname('qt_mov').asString + ' where is_ref = '+ ds.fieldByname('is_ref').asString + ' and mes = '+ edMesAtual.text + ' and is_uo = ' + f.getNumUO(cbLoja) +
                ' else  ' +
                ' insert zcf_saldoFiscal (is_uo, is_ref, mes, saidas) values ( ' + loja +  ', ' + ds.fieldByname('is_ref').asString +  ', ' + edMesAtual.Text +  ', ' + ds.fieldByname('qt_mov').asString + ' )';
      end
      else
      begin
         cmd := ' if exists( Select entradas from zcf_saldoFiscal where is_ref = '+ ds.fieldByname('is_ref').asString + ' and mes = '+ edMesAtual.text + ' and is_uo = ' + loja + '  ) ' +
             ' update zcf_saldoFiscal set entradas = entradas + ' +  ds.fieldByname('qt_mov').asString + ' where is_ref = '+ ds.fieldByname('is_ref').asString + ' and mes = '+ edMesAtual.text + ' and is_uo = ' + loja +
             ' else  ' +
             ' insert zcf_saldoFiscal (is_uo, is_ref, mes, entradas) values ( ' + loja +  ', ' + ds.fieldByname('is_ref').asString +  ', ' + edMesAtual.Text +  ', ' + ds.fieldByname('qt_mov').asString + ' )';
      end;
      dm.execSQL(cmd);
      MostraAtualizacaoDeitens(nil, ds.RecNo , ds.RecordCount);
      ds.Next();
  end
end;

procedure TfmComporEstoque.atualizarSaldoFinal(Sender: Tobject);
var
   cmd :String;
begin
   adicionarAoMeMo('Atualizando saldos fiscais...');
   cmd := 'exec zcf_atualizaSaldosQuantFaturadaFiscal '+
          '@uo = ' + f.getNumUO(cbLoja)  + ', '+
          '@mes= ' + edMesAtual.text  + ', ' +
          '@mesAnterior = '+edMesAnterior.Text;
   dm.execSQL(cmd);
end;

procedure TfmComporEstoque.obterPrecosDeCustoProdutosMes;
var
   itens:TStringList;
   i:integer;
   data,cmd, valor:String;
   isCustoZerado:boolean;
begin
   isCustoZerado := false;
   itens := TStringList.Create();
   itens := dm.getListagem('Select distinct is_ref from zcf_saldoFiscal where mes = '+ edMesAtual.Text + ' and is_uo = ' + f.getCodUO(cbLoja) + ' and (custo is Null or custo = 0) and saldoFIm > 0 ', 0);

   adicionarAoMeMo('Calculando custos...:' + intToStr(itens.Count -1) + ' itens.' );

   data := fdt.getUltimoDiaMes('01/' + copy(edMesAtual.Text,05,02) + '/'+ copy(edMesAtual.Text,01,04));

   for i:=0 to itens.Count -1 do
   begin
      fmMain.MsgStatus('Items número: ' + intToStr(i) +' de ' + intToStr(itens.Count -1) + '  is_ref: ' + itens[i]  );

      if ( dm.openSQL('Select custo from zcf_saldoFiscal where is_uo = ' + f.getCodUO(cbLoja) +' and mes > ' + edMesAtual.Text + ' and is_ref = ' + itens[i] + ' and custo is not null', 'custo') <> '') then
      begin
         fmMain.MsgStatus(itens[i]   + ' Ja tem custo em mes posterior');
         continue;
      end;

      valor := dm.getCustoPorData(f.getCodUO(cbLoja), itens[i], data);
      if (valor = '0') then
         valor := dm.openSQL('select top 01 custoUnitario from dlest where is_ref = ' +itens[i]+ ' and custounitario > 0 order by is_movi desc', 'custoUnitario');

      if ( (valor = '0') or (valor = '') or (valor = '0,00') ) then
      begin
         isCustoZerado := true;
         adicionarAoMeMo( itens[i]   + ' com preço de custo zero')
      end
      else
      begin
         cmd := ' update zcf_saldofiscal set custo = ' + f.valorSql(valor) + ' where is_ref = ' + itens[i] + ' and mes = ' + edMesAtual.Text;
         dm.execSQL(cmd);
      end;
   end;
   adicionarAoMeMo('Calcular Custo, finalizado');
   fmMain.MsgStatus('');
   if (isCustoZerado = true )then
      msg.msgErro('Exitem produtos com custo zerado !');
end;


procedure TfmComporEstoque.calculaMovimentacaoFiscal;
begin
   memo1.lines.Clear();
   adicionarAoMeMo('Calcular venda do mes ' + edMesAno.Text + '  -  ' + DateTimeToStr(now));

   listarTotaisPorItem(nil, 'S');
   listarTotaisPorItem(nil, 'E');

   atualizarSaldoFinal(nil);
   fmMain.msgStatus('');
   adicionarAoMeMo('Terminei de calcular os saldos do mes ' + edMesAno.Text + '  -  ' + DateTimeToStr(now) );
end;

procedure TfmComporEstoque.comporVendaFiscal(Sender: Tobject);
begin
// Verifica se a loja faz parte de uma visao, se fizer ela nao permite  que seja gerada  por ela mas pelo uo da visao
   if dm.GetParamBD('uosPorVisao', f.getNumUO(cbLoja)) <> '' then
   begin
      if (cbGeraEstoque.Checked = true) then
         calculaMovimentacaoFiscal();
   end
   else
      msg.msgErro('Essa loja não gerar estoque fiscal, ou é agrupada com outra loja');
end;

procedure TfmComporEstoque.FlatButton1Click(Sender: TObject);
var
   cmd:String;
begin
   cmd := ' select top 01 * from zcf_saldoFiscal where is_uo = ' + f.getCodUO(cbLoja)  + ' and mes = ' + edMesAtual.Text;
   if (dm.openSQL(cmd, 'is_ref') <> '') then
      msg.msgErro('Já foi gerado esse periodo. ')
   else
      comporVendaFiscal(nil);

    if (cbCalculaCusto.Checked = true) then
         obterPrecosDeCustoProdutosMes();
end;

procedure TfmComporEstoque.SpinButton1DownClick(Sender: TObject);
begin
   ajustaData('-' );
end;



end.

