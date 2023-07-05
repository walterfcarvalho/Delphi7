unit UOcorrencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, Buttons, f, DB, ADODB, DBGrids,
  TFlatCheckBoxUnit, ExtCtrls, fCtrls, fDBCtrls;
type
  TFmOcorrencia = class(TForm)
    sg1: TStringGrid;
    Memo1: TMemo;
    Panel1: TPanel;
    Label2: TLabel;
    tbImpOco: TADOTable;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    cbEmp: TComboBox;
    GroupBox2: TGroupBox;
    cbLojas: TComboBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    GroupBox4: TGroupBox;
    Flatbatidas: TFlatCheckBox;
    FlatFaltas: TFlatCheckBox;
    FlatAtrasos: TFlatCheckBox;
    cbAntecSaida: TFlatCheckBox;
    BitBtn2: TBitBtn;
    cbShowOcoJust: TFlatCheckBox;
    cbAtrAlmoco: TFlatCheckBox;
    dti: TDateTimePicker;
    dtf: TDateTimePicker;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbLojasChange(Sender: TObject);
    procedure bitBtn2Click(Sender: TObject);
    procedure calcOcorrenciaLoja();
    procedure calcOcorrenciaEmpregado(nome, matricula, cartaoPonto:String);
    procedure FormCreate(Sender: TObject);
    procedure LimparStringGrid();
    procedure PreparaParaReceberBatidas();
    procedure CapturaBatidas(cartaoPonto:String);
    procedure Edit1Change(Sender: TObject);
    procedure verOcorQtBatIncompativel(nome, matricula, cartaoPonto:String);
    procedure verOcorFaltas(nome, mat, cart:String);
    procedure verOcorAtrasos(nome, matricula, cartaoPonto:String);
    procedure insereNomeEmpregadoNaOcorrencia(nome, matricula, cartaoPonto:String);
    function  cod_just(Mat,data,ocorrencia:string;MostraJus:smallint):String;
    function  EhFeriado(data,cartaoPonto:String):boolean;
    function  calculaAtraso(cartao, batida,data,horarios:String):integer;
    procedure ImprimirOcorrencias(sender:TObject);
    procedure mostraPainel(empregado, mensagem:String; tsleep, empAtual,totalEmp:integer);
    procedure selecionaBatidasDoDia(cartaoPonto, dia:string; Batidas:TStringList; indice:smallInt);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    function  carregaCbox(edit3:string):integer;
    procedure FormShow(Sender: TObject);
    procedure Memo1Enter(Sender: TObject);
    procedure cbEmpChange(Sender: TObject);
    function  EstaAtivo(mat, data: string): boolean;
    procedure verOcorAntecSaida(nome, matricula, cartaoPonto:String);
	 procedure verOcoAtrAlmoco(nome, matricula, cartaoPonto:String);
    function getbatEnt(i:smallint):String;
 	 function getDiaCompl(i: smallint): String;
	 function getbatSai(i: smallint): String;
    function getBatSaiAlmoco(i:integer):String;
    function getBatEntAlmoco(i:integer):String;
    function getDtBat(i:smallInt):String;

  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FmOcorrencia: TFmOcorrencia;
  OpenDialog: TOpenDialog;
  arqBatidas:string;
  INSERIU_NOME:boolean;

implementation

uses RelogioPonto, uUtil, fdt, msg, uEmpregado, uBatida;

{$R *.dfm}

function TFmOcorrencia.getBatSaiAlmoco(i:integer):String;
begin //
   result := copy(sg1.Cells[2,i],01,10);
end;

function TFmOcorrencia.getBatEntAlmoco(i:integer):String;
begin //
   result := copy(sg1.Cells[3,i],01,10);
end;

function TFmOcorrencia.getDtBat(i: smallInt): String;
begin //
   result := copy(sg1.Cells[0,i],01,10);
end;

function TFmOcorrencia.getbatEnt(i: smallint): String;
begin
	result :=  sg1.Cells[1, i];
end;

function TFmOcorrencia.getbatSai(i: smallint): String;
begin
	result :=  sg1.Cells[4, i];
end;




function TFmOcorrencia.getDiaCompl(i: smallint): String;
begin
	result :=  sg1.Cells[0,i];
end;

function TFmOcorrencia.EstaAtivo(mat, data: string): boolean;
begin
   result := uUtil.isAtivo(data, mat);
end;


procedure TFmOcorrencia.mostraPainel(empregado, mensagem:String; tsleep, empAtual,totalEmp:integer);
var
   aux:string;
begin
   f.gravaLog('');
   f.gravaLog(mensagem + ' ' + empregado );

   panel1.Visible := true;
   aux:='';
   if totalEmp > 0 then
     aux := inttostr(empAtual) + ' de ' + inttostr(totalEmp);

   label2.caption:= aux +' - '+ empregado +' '+ mensagem;
   panel1.refresh;
   fmOcorrencia.Refresh;
   sleep(tsleep);
end;


function TFmOcorrencia.calculaAtraso(cartao, batida,data,horarios:String):integer;
var
  dif, prev:integer;
begin
   f.gravaLog('uOcorrencia.calculaAtraso() batida:'+ batida + ' data:'+data + ' horarios:'+ horarios);

   dif :=0;
   prev :=  horaToInt( fmMain.horaPrev( data, cartao, false, false ) );
   if batida  <> BATIDA_VAZIA then
      if (horaToInt(batida) > prev) then
         dif :=  horaToInt(batida) - prev;
   result := dif;
end;

procedure TFmOcorrencia.InsereNomeEmpregadoNaocorrencia(nome, matricula, cartaoPonto:String);
begin
   if (INSERIU_NOME = false) then
   begin
      INSERIU_NOME := true;
      memo1.Lines.Add('Empregado: '+ nome +
                      ' Mat: '+ matricula  +
                      ' Cartao: '+ cartaoPonto  );
   end;
end;

function TFmOcorrencia.EhFeriado(data,cartaoPonto:String):boolean;
begin
	result := uUtil.isFeriado(data, cartaoPonto);
end;

function TFmOcorrencia.cod_just(Mat, data, ocorrencia: string;MostraJus:smallint): String;
var
 jusUsuario, msgJust, tpJust, ljDaJust:String;
 aux:String;
begin
   gravaLog('Verificando justificativa:' + mat + ' dia:'+ data + ' ocorrencia:' + ocorrencia + ' MostraJus?:' + intToStr(MostraJus));
   aux := uUtil.isJustificado( mat, ocorrencia, strToDate(data),  tpJust, msgJust, jusUsuario, ljDaJust);
   if ( aux <> '') then
   begin
      if mostraJus = 1 then
      begin
          memo1.Lines.Add('      Just: '+ tpJust + 'Aut: ' + jusUsuario );
          memo1.Lines.Add('      Observação: '+ msgJust );
          memo1.Lines.Add('');
      end;
   end;
   result := aux;
end;

procedure TFmOcorrencia.verOcorQtBatIncompativel(nome, matricula, cartaoPonto:String);
var
  i:smallint;
begin
   gravaLog('verOcorQtBatIncompativel');

   for i := 1 to sg1.RowCount -1 do
   begin
      if (pos ('DOM', sg1.Cells[0,i]) = 0 ) and  ( (( sg1.Cells[1,i] = BATIDA_VAZIA ) and ( sg1.Cells[4,i] <> BATIDA_VAZIA )) or (( sg1.Cells[4,i] = BATIDA_VAZIA ) and ( sg1.Cells[1,i] <> BATIDA_VAZIA ))  )   then
      begin
         if EstaAtivo( matricula, copy(sg1.Cells[0,i],01,10) ) = true then
         begin
            if ( cod_just( matricula,  copy(sg1.Cells[0,i],01,10), 'E01',0) <> '') then
            begin
               InsereNomeEmpregadoNaOcorrencia(nome, matricula, cartaoPonto);
               memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Quantidade de batidas incompatíveis' );
               memo1.Lines.Add('           ' + 'Entrada: ' + sg1.Cells[1,i] + '      Saida: ' + sg1.Cells[4,i]);
               memo1.Lines.Add('          ');
            end
            else
            begin
               if cbShowOcoJust.Checked = true then
               begin
                  InsereNomeEmpregadoNaocorrencia(nome, matricula, cartaoPonto );
                  memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Quantidade de batidas incompatíveis' );

                  if cod_just( matricula, copy(sg1.Cells[0,i],01,10), 'E01',1) <> '' then
                     memo1.Lines.Add('          ');
                end;
            end;
         end;
      end;
   end;
end;

procedure TFMOcorrencia.verOcorAtrasos(nome, matricula, cartaoPonto:String);
var
  i:smallint;
  nTotAtz, nTotAtzJ :integer;
  cCodJus:String;
  nhTot, nhTotJ:integer;
  sHrPrev, sHrFeito:String;
  sHrPrevJ, sHrFeitoJ:String;
/// rotina atrasos
begin
   nTotAtz := 0;
   nTotAtzJ := 0;

   f.gravaLog('verOcorAtrasos() ' + nome + '  Matricula:' + matricula + '  Cartao:' + cartaoPonto);

   for i := 1 to sg1.RowCount -1 do
   begin
      if (pos ('DOM', sg1.Cells[0,i]) = 0 ) and (calculaAtraso(cartaoPonto, sg1.Cells[1,i], copy( sg1.Cells[0,i],01,10), copy(cbEmp.items[cbEmp.itemindex],49,24)) > 5 ) then
      begin
         if (EstaAtivo(matricula, copy(sg1.Cells[0,i],01,10) ) = true ) then
         begin
            if ( cod_just( matricula,  copy(sg1.Cells[0,i],01,10), 'A02',0) = '') then
            begin
               sHrPrev := fmMain.horaPrev( copy(sg1.Cells[0,i],01,10), cartaoPonto, false, false );
               sHrFeito:= sg1.Cells[1,i];

               insereNomeEmpregadoNaocorrencia(nome, matricula, cartaoPonto);
               memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Atraso na entrada.      Previsto: ' + sHrPrev+ '      Batida: ' + sHrFeito );
               memo1.Lines.Add('          ');

               nTotAtz := nTotAtz + (  f.horaToInt(sHrFeito) -   f.horaToInt(sHrPrev) );
            end
            else
            begin
               if cbShowOcoJust.Checked = true  then
               begin
                  sHrPrevJ  := fmMain.horaPrev( copy(sg1.Cells[0,i],01,10), cartaoPonto, false, false );
                  sHrFeitoJ := sg1.Cells[1,i];

                   insereNomeEmpregadoNaocorrencia(nome, matricula, cartaoPonto);
                   memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Atraso na entrada.      Previsto: ' + sHrPrevJ + '      Batida: ' + sHrFeitoJ  );

                   cCodJus := cod_just( matricula,  copy(sg1.Cells[0,i],01,10), 'A02',1);

                   if cCodJus <> '' then
                   begin
                      memo1.Lines.Add('          ');

                      if uUtil.isAtzAbn(cCodJus) = true then
                         nTotAtzJ := nTotAtzJ + (  f.horaToInt(sHrFeitoJ) -   f.horaToInt(sHrPrevJ) )
                      else
                         nTotAtz := nTotAtz + (  f.horaToInt(sHrFeitoJ) -   f.horaToInt(sHrPrevJ) );
                   end
                   else
                      nTotAtz := nTotAtz + (  f.horaToInt(sHrFeitoJ) -   f.horaToInt(sHrPrevJ) )
               end;
            end;
         end;
      end;
   end;
   if (nTotAtz > 0) or  (nTotAtzJ > 0) then
      memo1.Lines.Add('Atraso período: ' + f.intToHora(nTotAtz) + '    Atraso abonados período: ' + f.intToHora(nTotAtZJ)  );
end;


procedure TFMOcorrencia.verOcorAntecSaida(nome, matricula, cartaoPonto:String);
var
  antecSaida, i:smallint;
begin
   f.gravaLog('verOcorAtrasos() ' + nome + '  Matricula:' + matricula + '  Cartao:' + cartaoPonto);

   for i := 1 to sg1.RowCount -1 do
   begin
      antecSaida := fmMain.isAntecipacaoSaida( matricula, copy(sg1.Cells[0,i],01,10), sg1.Cells[4,i]);
      if (pos ('DOM', sg1.Cells[0,i]) = 0 ) and ( antecSaida > 0  ) then
      begin
         if (EstaAtivo( matricula , copy(sg1.Cells[0,i],01,10) ) = true ) then
         begin

            if ( cod_just( matricula, copy(sg1.Cells[0,i],01,10), 'A07',0) = '') then
            begin
               insereNomeEmpregadoNaocorrencia(nome, matricula, cartaoPonto);
               memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Antecipação Saida.      Previsto: ' +  fmMain.horaPrev( copy(sg1.Cells[0,i],01,10), cartaoPonto, true, false )+ '      Batida: ' + sg1.Cells[4,i]  );
               memo1.Lines.Add('          ');
            end
            else
            begin
               if cbShowOcoJust.Checked = true  then
               begin
                   insereNomeEmpregadoNaocorrencia(nome, matricula, cartaoPonto);
                   memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Antecipação Saida.      Previsto: ' +  fmMain.horaPrev( copy(sg1.Cells[0,i],01,10), cartaoPonto, true, false )+ '      Batida: ' + sg1.Cells[4,i]  );

                  if cod_just( matricula, copy(sg1.Cells[0,i],01,10), 'A07',1)  <> '' then
                     memo1.Lines.Add('          ');

               end;
            end;
         end;
      end;
   end;
end;

procedure TFmOcorrencia.verOcorFaltas(nome, mat, cart:String);
var
  i:smallint;
  dt:String;
  res:boolean;
begin
   f.gravaLog('verOcorAtrasos() ' + nome + '  Matricula:' + mat + '  Cartao:' + cart);

   for i := 1 to sg1.RowCount -1 do
   begin
		dt := getDtBat(i);

		res:= fmMain.isFalta(cart, getBatEnt(i), getbatSai(i), dt, getDiaCompl(i));

		if  (res = true) then
      begin
         if EstaAtivo( mat, copy(sg1.Cells[0,i],01,10) ) = true  then
         begin
            if cod_just( mat, dt, 'A01',0) = '' then
            begin
               InsereNomeEmpregadoNaOcorrencia(nome, mat, cart);
               memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Falta ' );
               memo1.Lines.Add('          ');
            end
            else
            begin
               if (cbShowOcoJust.Checked = true)  then
               begin
                  InsereNomeEmpregadoNaOcorrencia(nome, mat, cart);
                  memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' -  Falta ' );
                  if cod_just(mat, dt, 'A01',1) <> '' then
                     memo1.Lines.Add('          ');
               end;
            end;
         end;
      end;
   end;
end;

function TFmOcorrencia.carregaCbox(edit3:string):integer;
var
  i,j:integer;
begin
   j := -1 ;
   for i:=0 to cbEmp.Items.count do
      if pos(edit3,cbEmp.Items[i]) > 0 then
         j:=i;
   carregaCbox := j;
end;

procedure TFmOcorrencia.Edit1Change(Sender: TObject);
begin
  cbEmp.itemindex:= carregaCbox(edit1.text);
  cblojas.ItemIndex := -1;
end;

procedure TFmOcorrencia.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   deletefile( ExtractFilePath(ParamStr(0)) +'Imprime.bat');
   deletefile( ExtractFilePath(ParamStr(0)) +'Impressao.txt');
   deletefile( ExtractFilePath(ParamStr(0)) +'ocorrenciaPonto.txt');

   Edit1.Text := '';
   cbEmp.ItemIndex := -1;
   Memo1.Lines.Clear();
   f.salvaCampos(FmOcorrencia);
   fmMain.show;
   action:=CaFree;
   FmOcorrencia := nil;
end;

procedure TFmOcorrencia.cbLojasChange(Sender: TObject);
begin
    edit1.text:='';
    cbEmp.itemIndex := -1;
end;

procedure TFmOcorrencia.FormCreate(Sender: TObject);
begin
   cbEmp.Items := uUtil.obterDadosFuncionarios('');
   cbLojas.Items :=  uUtil.getNomeLojasPonto(false, true);
   f.carregaCampos(FmOcorrencia);

   fdt.formataIntervDatas( uUtil.getDate(),  dti, dtf);

end;

procedure TFmOcorrencia.PreparaParaReceberBatidas();
var
  i:SmallInt;
begin
   sg1.RowCount := 1;
   for i:=1 to 32 do // limpa  as batidas o stringGrid
   begin
       SG1.cells[1,i]:= '  :  ';
       SG1.cells[2,i]:= '  :  ';
       SG1.cells[3,i]:= '  :  ';
       SG1.cells[4,i]:= '  :  ';
       SG1.cells[5,i]:='';
   end;
// Na primeira coluna coloca o dia a dia
   for i:=0 to StrToInt(FloatToStr(dtf.date - dti.date)) do
   begin
       sg1.RowCount := sg1.RowCount+1;
       SG1.cells[0,i+1]:= DateToStr(dti.date + i)  + ' - ' +  NomeDoDia( DateToStr(dti.date + i), true );
       if length(SG1.cells[0,i+1]) < 6 then
          SG1.cells[0,i+1]:='0'+SG1.cells[0,i+1];
   end;
end;

procedure TFmOcorrencia.LimparStringGrid();
var
  i:SmallInt;
begin
   for i:=1 to 32 do // limpa  as batidas o stringGrid
   begin
       SG1.cells[0,i]:= '';
       SG1.cells[1,i]:='';// '  :  ';
       SG1.cells[2,i]:='';// '  :  ';
       SG1.cells[3,i]:='';// '  :  ';
       SG1.cells[4,i]:='';// '  :  ';
       SG1.cells[5,i]:='';
   end;
end;

procedure TFmOcorrencia.selecionaBatidasDoDia(cartaoPonto, dia: string; Batidas: TStringList; indice:smallInt);
var
  BatDia:TstringList;
  i:integer;
begin
   gravaLog('selecionaBatidasDoDia' + dia);
   batDia := Tstringlist.Create();
   for i:= 0 to batidas.count-1 do
   begin
      if copy(batidas[i],01,10) = dia then
         BatDia.Add(batidas[i]);
   end;

// PREENCHER OS CAMPOS COM BATIDA VAZIA
   sg1.Cells[1, indice] := BATIDA_VAZIA;
   sg1.Cells[2, indice] := BATIDA_VAZIA;
   sg1.Cells[3, indice] := BATIDA_VAZIA;
   sg1.Cells[4, indice] := BATIDA_VAZIA;


   if batDia.Count = 1 then
   begin
      if horatoInt(copy(BatDia[0],12,05)) <= HoraToInt( fmMain.HoraPrev( copy(batDia[0],01,10), cartaoPonto, false, false)) + 240 then
         sg1.Cells[1, indice] := copy(BatDia[0],12,05)
      else
         sg1.Cells[4, indice] := copy(BatDia[0],12,05);
   end;

   if batDia.Count = 2 then
   begin
      sg1.Cells[1, indice] := copy(BatDia[0],12,05);
      sg1.Cells[4, indice] := copy(BatDia[1],12,05);
   end;

   if (batDia.Count = 3) then
   begin
      sg1.Cells[1, indice] := copy(BatDia[0], 12, 05);
      sg1.Cells[2, indice] := copy(BatDia[1], 12, 05);
      sg1.Cells[4, indice] := copy(BatDia[2], 12, 05);
   end;

   if batDia.Count > 3 then
   begin
      sg1.Cells[1, indice] := copy(BatDia[0],12,05);
      sg1.Cells[2, indice] := copy(BatDia[1],12,05);
      sg1.Cells[3, indice] := copy(BatDia[2],12,05);
      sg1.Cells[4, indice] := copy(BatDia[BatDia.count-1],12,05);
   end;
   BatDia.Destroy();
end;

procedure TFmOcorrencia.capturaBatidas(cartaoPonto:String);
var
  i :integer;
  bat:TStringList;
begin
   gravaLog('capturaBatidas(): ' + cartaoPonto + ' periodo ' +   DateToStr(dtI.Date) + '  '+ DateToStr(dtF.Date)  );

   bat := TstringList.create();

   bat :=  uBatida.getBatidas(DateToStr(dtI.Date), DateToStr(dtF.Date), cartaoPonto);

// grava no log as batidas encontradas
   for i:=0 to bat.Count-1 do
      GravaLog(bat[i]);

   for i:=1 to sg1.RowCount -1 do
      selecionaBatidasDoDia(cartaoPonto, getDtBat(i), bat, i );

   for i:=0 to sg1.RowCount -1 do
      GravaLog( sg1.Cells[0,i] + ',  '+sg1.Cells[1,i] + ',  '+sg1.Cells[2,i] + ',  '+ sg1.Cells[3,i] + ',  ' +sg1.Cells[4,i] );
end;


procedure TFmOcorrencia.CalcOcorrenciaEmpregado(nome, matricula, cartaoPonto:String);
begin
   gravaLog('----------- calcular empregado: ' + nome + ' matricula: ' + matricula + ' cartaoPonto: ' + cartaoPonto +'-------------');

   fmMain.getDadosEmpregado( cartaoPonto );

   memo1.enabled := false;
   INSERIU_NOME:= false;
   limparStringGrid();
   preparaParaReceberBatidas();
   mostraPainel( nome,'Capturar Batidas',200,0,0);

// capturar as batidas do dia
   capturaBatidas(cartaoPonto);

   if flatBatidas.Checked = true then
   begin
      mostraPainel(nome, 'Verificando batidas incompatíveis',200,0,0);
      verOcorQtBatIncompativel(nome, matricula, cartaoPonto);
   end;

   if flatFaltas.Checked = true then
   begin
      mostraPainel(nome, 'Verificando faltas',200,0,0);
      verOcorFaltas(nome, matricula, cartaoPonto);
   end;

   if flatAtrasos.Checked = true then
   begin
      mostraPainel(nome, 'Verificando atrasos', 200,0,0);
      verOcorAtrasos(nome, matricula, cartaoPonto);
   end;

   if cbAntecSaida.Checked = true then
   begin
      mostraPainel(nome, 'Verificando antecipação de saídas',200,0,0);
      verOcorAntecSaida( nome, matricula, cartaoPonto);
   end;

   if cbAtrAlmoco.Checked = true then
   begin
      mostraPainel(nome, 'Verificando atraso de almoço',200,0,0);
      verOcoAtrAlmoco( nome, matricula, cartaoPonto);
   end;

   Label2.Caption := '';
   memo1.enabled := true;
end;

procedure TFmOcorrencia.calcOcorrenciaLoja();
var
  numEmpregados, NumEmpAtual :integer;
  dsEmp:TdataSet;
begin
   numEmpregados := 0;
   NumEmpAtual := 0;

   dsEmp := uUtil.getNomeMatPorLocalizacao( fmMain.getLocalizacaoLoja(cbLojas) );

   numEmpregados := dsEmp.RecordCount-1;

   memo1.enabled := false;

   while( dsEmp.Eof = false) do
   begin
      f.gravaLog('');
      f.gravaLog('-------------Calcular ocorrências por localizazao-----------------');
      f.gravaLog('');

      INSERIU_NOME:= false;
      begin
         inc(NumEmpAtual);

         limparStringGrid();
         preparaParaReceberBatidas();
         mostraPainel( dsEmp.fieldByName('nome').AsString, ' Capturar Batidas',200, numEmpAtual, numEmpregados );

         capturaBatidas( dsEmp.fieldByName('cartaoPonto').AsString);
         mostraPainel('', 'Conectar ao BD',200, numEmpAtual, numEmpregados );

         if flatBatidas.Checked = true then
         begin
            mostraPainel(dsEmp.fieldByName('nome').AsString, 'Verificar batidas incompatíveis', 200, numEmpAtual, numEmpregados );
            verOcorQtBatIncompativel(dsEmp.fieldByName('nome').AsString,
                                     dsEmp.fieldByName('matricula').AsString,
                                     dsEmp.fieldByName('cartaoPonto').AsString
             );
         end;

         if flatFaltas.Checked = true then
         begin
            mostraPainel(dsEmp.fieldByName('nome').AsString, 'Verificar faltas. ',200, numEmpAtual, numEmpregados );
            verOcorFaltas(dsEmp.fieldByName('nome').AsString,
                          dsEmp.fieldByName('matricula').AsString,
                          dsEmp.fieldByName('cartaoPonto').AsString
             );
         end;

         if flatAtrasos.Checked = true then
         begin
            mostraPainel(dsEmp.fieldByName('nome').AsString, 'Verificar Atrasos',200, numEmpAtual, numEmpregados );
            verOcorAtrasos(dsEmp.fieldByName('nome').AsString,
                           dsEmp.fieldByName('matricula').AsString,
                           dsEmp.fieldByName('cartaoPonto').AsString
             );
         end;

         if (cbAntecSaida.Checked = true ) then
         begin
            mostraPainel(dsEmp.fieldByName('nome').AsString, 'Verificar antecipação de saída',200, numEmpAtual, numEmpregados );
            verOcorAntecSaida(dsEmp.fieldByName('nome').AsString,
                          dsEmp.fieldByName('matricula').AsString,
                          dsEmp.fieldByName('cartaoPonto').AsString
             );
         end;

         if (cbAtrAlmoco.Checked = true) then
         begin
            mostraPainel(dsEmp.fieldByName('nome').AsString, 'Verificar atraso de almoço. ',200, numEmpAtual, numEmpregados );
            verOcoAtrAlmoco(	dsEmp.fieldByName('nome').AsString,
                          		dsEmp.fieldByName('matricula').AsString,
                          		dsEmp.fieldByName('cartaoPonto').AsString
             );
         end;

         if INSERIU_NOME = true then
            memo1.lines.Add('--------------------------------------------------------------------------------');

         dsEmp.Next();
      end;
   end;
   dsEmp.Destroy();

   if (memo1.Lines.Count -1 < 1) then
      msg.msgExclamation('Nenhuma ocorrência. ');

   memo1.enabled := true;
end;

procedure TFmOcorrencia.BitBtn2Click(Sender: TObject);
var
   erro:string;
begin
   memo1.lines.Clear;
   if (Flatbatidas.Checked = false)    and
   	(FlatAtrasos.Checked = false) 	and
      (FlatFaltas.Checked = false) 		and
      (cbAntecSaida.Checked = false)	and
      (cbAtrAlmoco.Checked = false)    then
      erro := erro + '- Ao menos uma ocorrência deve ser verificada' + #13;

   if (dtf.Date - dti.Date) > 31 then
      erro := erro + '- Periodo maior que 31 dias ' + #13;

   if (dtf.Date < dti.Date) then
      erro := erro + '- A data final não pode ser menor que a inicial ' + #13;

   if (cbLojas.itemindex < 0) and (cbEmp.ItemIndex < 0 ) then
      erro := erro + '- Nenhum empregado ou loja escolhido';

   if (erro <> '' ) then
      msg.msgErro(erro)
   else
   begin
      GravaLog('-------------- Ocorrências Calculadas em ' + DateTimeToStr(now) );
      Screen.Cursor := crHourGlass;

      if cbLojas.ItemIndex <= 0 then
         calcOcorrenciaEmpregado(fmMain.getNome(cbEmp.Items[cbEmp.ItemIndex]), fmMain.getMat(cbEmp), fmMain.getCartaoPonto(cbEmp), )
      else
         calcOcorrenciaLoja();

      fmMain.closeDataSet();
      Screen.Cursor := CrDefault;
   end;
end;

procedure TFmOcorrencia.ImprimirOcorrencias(sender: TObject);
var
   origem, dest: textFile;
   linha:string;
   itemsPorPg,fl,l:integer;
   Param:TStringList;
begin
   memo1.lines.SaveToFile( ExtractFilePath(ParamStr(0))+'ocorrenciaPonto.txt' );
   ItemsPorPg := 45;
   fl:=0; l := 0;
   assignFile( origem, ExtractFilePath(ParamStr(0))+'ocorrenciaPonto.txt' );
   Reset(origem);
   assignFile( dest, ExtractFilePath(ParamStr(0))+ 'Impressao.txt' );
   rewrite( dest );

   while eof( origem ) = false do
   begin
      inc(fl);
      writeln(dest,'                         CONSULTA A OCORRENCIAS     '  );
      if cbLojas.ItemIndex <= 0 then
         writeln(dest,'Tipo de consulta : Por empregado. ')
      else
         writeln(dest,'Tipo de consulta : Por loja   Loja : ' +  copy(cbLojas.items[cbLojas.ItemIndex], 01, 30) );

      writeln(dest,'Data :' + DateToStr(now));
      writeln(dest,'Período : '+ DateToStr(dti.date) + ' ate ' + dateToStr(dtf.date) );
      writeln(dest,'------------------------------------------------------------------------------------------------------------------------');

      while ( l < ItemsPorPg ) and ( eof(origem) = false ) do
      begin
         inc(l);
         readln(origem, linha);
         writeln(dest, linha);
      end;
      if  eof(origem) = false  then
      begin
         l := 0;
         writeln(dest,'------------------------------------------------------------------------------------------------------------------------');
         writeln(dest,'');
      end
      else
      begin
         while  l < ItemsPorPg do
         begin
            inc(l);
            writeln(dest, '');
         end;
         writeln(dest,'------------------------------------------------------------------------------------------------------------------------');
         writeln(dest,'');
      end;
   end;
   closeFile(origem);
   closeFile(Dest);

   if (tbImpOco.TableName <> '') then
      tbImpOco.Close();

   uUtil.getTable(tbImpOco, ' linha varchar(100)' );


//Adiciona o povo na tabela para impressao
   for l:=0 to memo1.Lines.Count -1 do
      tbImpOco.AppendRecord([memo1.lines[l]]);


   Param := TStringList.Create();
   if (cbLojas.ItemIndex > 0) then
      Param.Add('Por loja:' + cbLojas.Items[cbLojas.itemIndex])
   else
      Param.Add('Por empregado.');

   Param.Add(dateToStr(DTI.Date) + ' até '+ dateToStr(DTF.Date) );

   if (Flatbatidas.Checked = true) then  Param.Add(Flatbatidas.Caption);
   if (FlatFaltas.Checked = true) then  Param.Add(FlatFaltas.Caption);
   if (FlatAtrasos.Checked = true) then  Param.Add(FlatAtrasos.Caption);
   while (Param.Count < 6) do param.Add('');

   if (cbShowOcoJust.Checked = true ) then
      Param.Add('Sim.')
   else
      Param.Add('Não.');

   fmMain.impressaoRave(tbImpOco, nil, 'rpPontoOcorrencias', Param);
   tbImpOco.Close();
end;

procedure TFmOcorrencia.BitBtn6Click(Sender: TObject);
begin
   FmOcorrencia.Close;
end;

procedure TFmOcorrencia.FormShow(Sender: TObject);
begin
   fmMain.posicionarTela(FmOcorrencia);
   edit1.SetFocus;
end;

procedure TFmOcorrencia.BitBtn1Click(Sender: TObject);
begin
   if memo1.Lines.Count -1 > 1 then
      imprimirOcorrencias(sender);
end;

procedure TFmOcorrencia.Memo1Enter(Sender: TObject);
begin
   edit1.setFocus;
end;

procedure TFmOcorrencia.cbEmpChange(Sender: TObject);
begin
   cblojas.ItemIndex :=  -1;
end;

procedure TFmOcorrencia.verOcoAtrAlmoco(nome, matricula, cartaoPonto:String);
var
  i:smallint;
  atrAlmoco, tmpAlmoco:integer;
begin
   f.gravaLog('verOcoAtrAlmoco() ' + nome + '  Matricula:' + matricula + '  Cartao:' + cartaoPonto);

//   tmpAlmoco :=  strToInt(uUtil.lerParametroBD('ponto.qtMinIntAlmoco'));

   for i := 1 to sg1.RowCount -1 do
   begin
   	atrAlmoco := fmMain.atrasoDeAlmoco(cartaoPonto, getDtBat(i), getBatSaiAlmoco(i), getBatEntAlmoco(i));

      if  (atrAlmoco > 0) then
      begin
         if EstaAtivo( matricula, copy(sg1.Cells[0,i],01,10) ) = true  then
         begin
            if cod_just( matricula, copy(sg1.Cells[0,i],01,10), 'E02', 0) = ''  then
            begin
               InsereNomeEmpregadoNaOcorrencia(nome, matricula, cartaoPonto);
               memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' - Atraso de almoço: ' + intTohora(atrAlmoco) );
               memo1.Lines.Add('          ');
            end
            else
            begin
               if (cbShowOcoJust.Checked = true)  then
               begin
                  InsereNomeEmpregadoNaOcorrencia(nome, matricula, cartaoPonto);
                  memo1.Lines.Add('   -- Dia: ' + sg1.Cells[0,i] + ' -  Atraso de almoço' );
                  if cod_just(matricula,  copy(sg1.Cells[0,i],01,10), 'E02', 1) = '' then
                     memo1.Lines.Add('          ');
               end;
            end;
         end;
      end;
   end;
end;

end.
