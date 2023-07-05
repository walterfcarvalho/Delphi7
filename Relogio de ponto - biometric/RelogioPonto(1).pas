{
perfil 1  ponto biometrico
perfil 2  ponto digitado
perfil 3  nao captura
}

unit RelogioPonto;
interface
uses
  shellapi, Windows, Messages, SysUtils, Menus, Classes,  Mask,Controls, Buttons,
  ComCtrls,Forms, Dialogs, ExtCtrls, StdCtrls, DBCtrls,mxOneInstance,
  AppEvnts, ADODB, DB, OleCtrls,  GrFingerXLib_TLB, TFlatEditUnit,
  GrFinger, RpBase, RpSystem, RpRave, RpCon, RpConDS, RpDefine,
  adLabelMaskEdit;


type
  TfmMain = class(TForm)
    MainMenu1: TMainMenu;
    Consultas1: TMenuItem;
    Justificativas1: TMenuItem;
    Timer2: TTimer;
    mxOneInstance1: TmxOneInstance;
    ApplicationEvents1: TApplicationEvents;
    Batidas1: TMenuItem;
    Ocorrncias1: TMenuItem;
    pnBatidaRec: TPanel;
    Label25: TLabel;
    lbDadosCartao: TLabel;
    lbDataHoraPonto: TLabel;
    Label31: TLabel;
    Label36: TLabel;
    lbNome: TLabel;
    Panel3: TPanel;
    lbData: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lbHora: TLabel;
    Bevel2: TBevel;
    Image1: TImage;
    BitBtn3: TBitBtn;
    StatusBar1: TStatusBar;
    GrFingerXCtrl1: TGrFingerXCtrl;
    RvProject: TRvProject;
    dsConn1: TRvDataSetConnection;
    dsConn2: TRvDataSetConnection;
    RvSystem: TRvSystem;
    FolhaPonto1: TMenuItem;
    pnPontoDig: TPanel;
    edPontodig: TadLabelMaskEdit;
    Bevel1: TBevel;
    Cadastrodedigitais1: TMenuItem;
    Batidasporlocalizacao1: TMenuItem;
    function  getCartaoPonto(cb: TCustomComboBox): String;
    function  getCartaoPontoStr(str:String): String;
    function  getCodLocalizacaoLoja(cb: TCustomComboBox): String;
    function  HoraPrev(data, cartaoPonto: string; isSaida, isIntervalo:boolean): string;
    function  r1(n:string):string;
    function  VerificaHorario( data, hora, cartaoPonto:String): String;
    function calculaAtraso(cartao:String; data:Tdate;batida:String):integer;
    function ExisteBatida(cartao:String):boolean;
    function existsFormOpen(Dender:Tobject):boolean;
    function getCampoDia(data:String; ehSaida, isIntervalo:boolean):String;
    function getDadosEmpregado(nCartao: String): boolean;
    function getLocalizacaoLoja(cb:TCustomComboBox):String;
    function getNome(DadosEmp:String):String;
    function getNomeCB(cb:TCustomComboBox):String;
    function isAntecipacaoSaida(cartao, data, batida:String):integer;
    function isFaltaNoDia(cartaoPonto, batEnt, batSai, data, isFeriado:String):boolean;
    function selecionaBatidasDoDia(dia, cartaoPonto:String; Batidas: TStringList):TStringlist;
    function isFalta(cart, batEnt, batSai, dt, diaCompl:String):boolean;
    procedure ajustarItensNaTela(Sender:Tobject);
    procedure AppException(Sender: TObject; E: Exception);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure ativaReceberPontoBiometrico();
    procedure ativaReceberPontoDigitado();
    procedure ativarLabelsDataHora();
    procedure Batidas1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure calcHorasTotais(var table: TADOTable; var tHorasPrev, tHorasTrab , tAtrasJus, tAtrasAut, tHorasDif, batIncJ, batInc , falta, faltaJ, tAtrsAlmo:smallint; matricula, cartao:string; dataInicial:Tdate);
    procedure closeDataSet();
    procedure ConfiguraMenus();
    procedure digitarPonto(cartaoPonto:String);
    procedure edPontodigKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure exibeBatida(data,hora:String);
    procedure FolhaPonto1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure GrFingerXCtrl1ImageAcquired(ASender: TObject; const idSensor: WideString; width, height: Integer;var rawImage: OleVariant; res: Integer);
    procedure GrFingerXCtrl1SensorPlug(ASender: TObject; const idSensor: WideString);
    procedure habilitaItens(Sender: Tobject);
    procedure impressaoRave(dataSet1,DataSet2:TdataSet; nomeRelatorio:String;Parametros:TStringlist);
    procedure Justificativas1Click(Sender: TObject);
    procedure mxOneInstance1InstanceExists(Sender: TObject);
    procedure Ocorrncias1Click(Sender: TObject);
    procedure posicionarTela(form:Tform);
    procedure preencherListaBatidas(var table:TadoTable; dti,dtf:Tdate; cartao:String);
    procedure ReceberCartaoDePonto(cartaoPonto:String);
    procedure RegistraPonto(data,hora,cartaoPonto:string);
    procedure registraPontoWalter(data:string);
    procedure Timer2Timer(Sender: TObject);
    procedure verificaAtualizacaoDoLancador();
    procedure Cadastrodedigitais1Click(Sender: TObject);
    procedure Batidasporlocalizacao1Click(Sender: TObject);
    procedure AbrefmFolhaPonto(perfil:integer);
    function getUserAutorizador(isAutBat:boolean):String;
    procedure getAutorizJustificado(var user, codJust, obs:String);
    function getMat(cb:TCustomComboBox):String;
	 function atrasoDeAlmoco(cartao, data, saiAlmoco, entAlmoco: String ): integer;
    function avancaHora(hora:String):String;
    procedure iniciaHorario();
  private
    function getMatricula(DadosEmp:String):String;

    { Private declarations }
  public
     DS_EMP:TdataSet;

    { Public declarations }
  end;

const
   VERSAO = '15.04.01 001';
   TITULO = ' Vers�o: ' + VERSAO;
   CH_REG = 'ProgramasCF\Relogio';
   BATIDA_VAZIA = '  :  ';
   SEM_HORA = '00:00';
var
  fmMain: TfmMain;
  TOLERANCIA:integer;
  PERFIL,  LOJA, PATH :String;
  VL_PRIM_PERIODO, VALOR_DEFAULT_TIME_OUT_PROGRAM, TIME_OUT_PROGRAM:integer;
  IS_CAPTURA_INICIADA:BOOLEAN;

implementation

uses  f, fdt, uUtil, UOcorrencia, Justificativas, uConsultarBatidas,
      uCad, uListaJust, uAutorizacao, msg, uDm, uEmpregado,
      uBatida, uUsuarios ;

  {$R *.DFM}

function TfmMain.isFaltaNoDia(cartaoPonto, batEnt, batSai, data, isFeriado:String):boolean;
begin
    result :=
    ( ( batEnt = BATIDA_VAZIA) and ( batSai = BATIDA_VAZIA) ) and
    ( horaPrev(data, cartaoPonto, false, false) <> BATIDA_VAZIA ) and
    ( isFeriado = 'N' );
end;

function TfmMain.getDadosEmpregado(nCartao: String): boolean;
begin
   f.gravaLog('TfmMain.getDadosEmpregado():' + nCartao );
   DS_EMP :=  uEmpregado.getEmpPorCartao(nCartao);
   result := not(DS_EMP.IsEmpty);
end;

function tfmMain.getUserAutorizador(isAutBat:boolean):String;
var
   usuariosAutorizadores:String;
begin
   timer2.Enabled := false;

   usuariosAutorizadores := uUsuarios.getListaAutPonto(isAutBat);

   if ( f.getIdxParam('-s') > -1 ) then
      result := '000'
   else
      result :=  uUsuarios.getAutorizadorWell( LOJA, '',  usuariosAutorizadores);

   timer2.Enabled := true;

   //quando o relogio para eu tenho que sincronizar de novo
   iniciaHorario();


   TIME_OUT_PROGRAM :=  VALOR_DEFAULT_TIME_OUT_PROGRAM
end;


procedure TfmMain.getAutorizJustificado(var user, codJust, obs: String);
begin
   user := getUserAutorizador(true);

	if (user <> '') then
   begin
	   Application.CreateForm(TfmListaJust, fmListaJust);

	   fmListaJust.ShowModal();

	   if (fmListaJust.ModalResult = mrOk) then
      begin
	      codJust := uUtil.getCodJust(fmListaJust.cbJust);
         obs := fmListaJust.edObs.Text;
      end
	   else
	      codJust := '';

	   fmListaJust := nil;
   end;
end;

procedure TfmMain.ApplicationEvents1Exception(Sender: TObject; E: Exception);
begin
	msg.msgErro('Ocorreu um erro na execu��o do programa!');
   f.gravaLog(' -  Erro: ' +  dateToStr(now)+ '  '+ timeToStr(now) + e.Message );
   msg.msgErro('Ocorreu o seguinte erro!!! Se ele persistir contate o suporte' +#13+
                   'O erro �: ' + e.Message);
end;

function TfmMain.getCampoDia(data:String; ehSaida, isIntervalo:boolean):String;
var
  strDia:String;
begin
   case dayOfWeek(f.strToData(data)) of
      2:strDia := 'hSeg';
      3:strDia := 'hTer';
      4:strDia := 'hQua';
      5:strDia := 'hQui';
      6:strDia := 'hSex';
      1:strDia := 'hDom';
      7:strDia := 'hSab';
   end;

   if isIntervalo = true then
      strDia := strDia + 'Int';
   if (ehSaida = false )then
      strDia := strDia + 'Ini'
   else
      strDia := strDia + 'Fim';
   result := strDia;
end;

function TfmMain.getCartaoPontoStr(str: String): String;
begin
   result := uUtil.getCartaoPontoStr(str)
end;


function TfmMain.getMatricula(dadosEmp:String):String;
begin
  // Se os dadosemp = matricula

  if (Length(DadosEmp) = 8 ) then
     result :=  uUtil.getMatricula( getCartaoPontoStr(copy(dadosEmp, 03, 06)), DS_EMP)
  else if (Length(DadosEmp) = 6 ) then
     result :=  uUtil.getMatricula( dadosEmp, DS_EMP)
  else
  begin
     f.gravaLog('uUTIl.getMatricula()');
     result :=  trim(uUtil.getMatricula(getCartaoPontoStr(dadosEmp), DS_EMP));
  end;
   f.gravaLog('getMatricula():'+Result)
end;

function TfmMain.getMat(cb:TCustomComboBox):String;
begin
   result := getMatricula( cb.Items[cb.itemIndex] );
end;


function TfmMain.getNome(DadosEmp:String):String;
begin
   result := copy(DadosEmp,01,30);
end;

function TfmMain.getNomeCB(cb: TCustomComboBox): String;
begin
   result := copy(cb.Items[cb.ItemIndex], 01, 30);
end;

function TfmMain.HoraPrev(data, cartaoPonto: string; isSaida, isIntervalo:boolean ): string;
begin
   if cartaoPonto = '' then showMessage('cartaoPonto vazio');
   cartaoPonto := uUtil.getHoraPrevista(cartaoPonto, fmMain.getCampoDia(data, isSaida, isIntervalo), DS_EMP );
   result := cartaoPonto;
end;


function TfmMain.calculaAtraso(cartao:String; data:Tdate;batida:String):integer;
var
  aux:integer;
begin
   aux := f.horaToInt( batida ) - f.horaToInt( uUtil.getHoraPrevista(cartao, fmMain.getCampoDia(dateToStr(data), false, false ),DS_EMP));
   f.gravaLog( 'Calculo de atraso do dia: '+  dateToStr(data) +' minutos:' + intTostr(aux) );
   if (aux > 0) then
      result := aux
   else
      result := 0;
end;

procedure TfmMain.calcHorasTotais(var table: TADOTable; var tHorasPrev, tHorasTrab ,
                                  tAtrasJus, tAtrasAut, tHorasDif, batIncJ, batInc, falta, faltaJ, tAtrsAlmo:smallint; matricula, cartao:string; dataInicial: Tdate);
var
   intervalo,horasDia:integer;
   dataAux:Tdate;
   msgJust,msgObs,codJust, jusUsuario, ljDaJust:String;
   PrevEnt,PrevSai, atrAlmoco:integer;
   strEstaAtivo:String;
begin
   f.gravaLog('procedure calcHorasTotais');

   dataAux := dataInicial;

   f.gravaLog(table, 'Tabela de batidas');

   f.gravaLog(#13+#13+'Calcular  Horas totais e ocorrencias');

//  verificar os feriados no periodo e calcular o tempo previsto
   dataAux := dataInicial;

   table.First;
   while table.Eof = false do
   begin
      table.Edit;
      if ( uUtil.isFeriado( dateToStr(dataAux), cartao) = true ) then
      begin
         table.FieldByName('ehFeriado').asString := 'S';
         table.FieldByName('tPrevisto').asInteger := 0;
         table.FieldByName('intervalo').asInteger := 0;
      end
      else
      begin
         prevEnt := horaToInt( HoraPrev(dateToStr(dataAux), cartao, false, false ) ) ;
         PrevSai := horaToInt( HoraPrev(dateToStr(dataAux), cartao, true, false ) ) ;

         table.FieldByName('ehFeriado').asString := 'N';

         intervalo :=  horaToInt( horaPrev( dateToStr(dataAux), cartao, true, true ) ) - horaToInt( horaPrev( dateToStr(dataAux), cartao, false, true ) );

         if (prevEnt <> 0) and (prevSai <> 0 ) then
         begin
            table.FieldByName('intervalo').asInteger := intervalo;
            table.FieldByName('tPrevisto').asInteger := PrevSai  - (prevEnt + intervalo);
         end
         else
         begin
            table.FieldByName('intervalo').asInteger := 0;
            table.FieldByName('tPrevisto').asInteger := 0;
         end;

         // escrever no log os valores inteiros dos moinutos de entrada e saida
         f.gravaLog(' Dia : '+ dateToStr(dataAux) +#13+
                  ' Prev Entrada: ' +  intToStr(prevEnt) + #13+
                  ' Prev Saida: ' + intToStr(prevSai)+ #13+
                  ' Intevalo: ' + inttostr(intervalo) +' tprevisto '+ inttostr( PrevSai - (prevEnt + intervalo) )
                 );
         tHorasPrev := tHorasPrev  + (PrevSai - (prevEnt + intervalo)) ;
      end;

      table.post;
      table.Next;
      dataAux := dataAux +1;
   end;


// calcular  as batidas incompativeis
   f.gravaLog('------------------------Calcular  as batidas incompativeis: ' + matricula);

   batInc := 0;
   batIncJ := 0;
   dataAux := dataInicial;
   table.First;
   while (table.Eof = false) do
   begin
      gravaLog('verificar ocorrencias batidas incompativeis, data: ' +  table.fieldByName('dia').asString );
      table.edit;
      if ( ( (table.fieldByName('sai').asString = BATIDA_VAZIA) and (table.fieldByName('ent').asString <> BATIDA_VAZIA) ) or
         ( ( table.fieldByName('sai').asString <> BATIDA_VAZIA) and (table.fieldByName('ent').asString = BATIDA_VAZIA) ) ) and
         ( table.fieldByName('ehFeriado').asString = 'N'  ) then
      begin
         f.gravaLog('Ocorrencia encontrada, batidas incompativeis, data: ' +  table.fieldByName('dia').asString );
         if (uUtil.isAtivo( dateToStr(dataAux), matricula ) = true)  then
         begin
            table.fieldByName('Ocorrencia').asString := 'Bat incompativeis ';
            codjust := uUtil.isJustificado( matricula, 'E01', dataAux, msgJust, msgObs, jusUsuario, ljDaJust);
            if (codjust <> '') then
            begin
               inc(batIncJ);
               table.fieldByName('justificativa').asString := msgJust;
               table.fieldByName('observacao').asString := msgObs;
            end
            else
            begin
               inc(batInc);
               table.fieldByName('justificativa').asString := strEstaAtivo;
            end;
         end;
      end;
      table.post;
      dataAux:= dataAux +1 ;
      table.Next
   end;

// calcular os atrasos
   f.gravaLog('Inicio calculo de atrasos.'+#13);
   dataAux := dataInicial;
   table.First;
   while (table.Eof = false) do
   begin
      table.edit;
      if (table.fieldByName('ent').asString <> BATIDA_VAZIA)  and (table.fieldByName('ehFeriado').asString = 'N') then
      begin
         table.fieldByName('atraso').asString :=  f.intToHora(  calculaAtraso(cartao, dataAux, table.fieldByName('ent').asString) ) ;
         if horaToInt(table.fieldByName('atraso').asString) > 0 then
            if horaToInt( table.fieldByName('atraso').asString ) > TOLERANCIA then
            begin
               if ( uUtil.isAtivo( dateToStr(dataAux), matricula) = true ) and ( horaPrev(dateToStr(dataAux), cartao, false, false) <> '00:00' )  then
               begin
                  f.gravaLog('Ocorrencia encontrada, atraso, dia  '+ dateToStr(dataAux)  ) ;
                  table.fieldByName('ocorrencia').asString := ' - Atraso';

                  codJust := uUtil.isJustificado(Matricula , 'A02', dataAux,  msgJust, msgObs, jusUsuario, ljDaJust );

                  if  (codJust <> '') then
                  begin
                     table.fieldByName('justificativa').asString :=  msgJust;
                     table.fieldByName('observacao').asString := msgObs;
                     if  (uUtil.isJustAbonada(codJust) = true) then
                     begin
                        f.gravaLog('Atraso justificado');
                        table.fieldByName('AbonaAtraso').AsString := 'S' ;
                        tAtrasJus := tAtrasJus + horaToInt( table.fieldByName('atraso').asString );
                     end
                     else
                     begin
                        tAtrasAut := tAtrasAut + horaToInt( table.fieldByName('atraso').asString );
                        gravaLog('Atraso nao justificado');
                     end;
                  end
                  else
                  begin
                     tAtrasAut := tAtrasAut + horaToInt( table.fieldByName('atraso').asString );
                  end
               end
               else
               begin
                  table.fieldByName('justificativa').asString :=  strEstaAtivo;
               end
            end
            else
               tAtrasAut := tAtrasAut + horaToInt( table.fieldByName('atraso').asString );
      end;
      table.post;
      dataAux:= dataAux +1 ;
      table.Next
   end;


/// calcular as faltas
   f.gravaLog(#13+'Inicio calculo de Faltas.'+#13);

   falta:=0;
   faltaj:=0;
   dataAux := dataInicial;
   table.First;
   while table.Eof = false do
   begin
      table.edit;
      if ( isFaltaNoDia( cartao, table.fieldByName('ent').asString, table.fieldByName('sai').asString, dateToStr(dataAux), table.fieldByName('ehFeriado').asString) = true  ) then
      if (table.fieldByName('sai').asString = BATIDA_VAZIA) and (table.fieldByName('ent').asString = BATIDA_VAZIA) and( HoraPrev(dateToStr(dataAux), cartao,false, false) <> '00:00' ) and ( table.fieldByName('ehFeriado').asString = 'N' ) then
      begin
         if ( uUtil.isAtivo( dateToStr(dataAux), matricula ) = true ) then
         begin
            gravaLog('Ocorrencia encontrada, Falta, dia  '+ dateToStr(dataAux)  ) ;
            table.fieldByName('ocorrencia').asString := ' - Falta';
            codJust := uUtil.isJustificado( matricula, 'A01', dataAux,  msgJust, msgObs, jusUsuario, ljDaJust);

            if (codJust <> '') then
            begin
               table.fieldByName('justificativa').asString := msgJust;
               table.fieldByName('observacao').asString := msgObs;
               inc(faltaJ);
             end
             else
               inc(falta)
           end
           else
              table.fieldByName('justificativa').asString := msgJust;
      end
      else
         table.fieldByName('justificativa').asString := strEstaAtivo;

      table.post;
      dataAux:= dataAux +1 ;
      table.Next
   end;

// calcular horas trabalhadas diferenca
   tHorasTrab :=0;
   tHorasPrev := 0;
   tHorasDif := 0;
   dataAux := dataInicial;
   table.First;
   while table.Eof = false do
   begin
      table.Edit;
      tHorasPrev := tHorasPrev + table.fieldByName('tPrevisto').Asinteger;
      if (table.fieldByName('sai').asString <> BATIDA_VAZIA) AND (table.fieldByName('ent').asString <> BATIDA_VAZIA) then
      begin
         horasDia := horaToInt(table.fieldByName('sai').AsString)  - ( horaToInt(table.fieldByName('ent').AsString) +  table.fieldByName('intervalo').Asinteger ) ;
         table.fieldByName('totDia').AsString :=   intToHora(horasDia);

         if  (horasDia > table.fieldByName('tprevisto').Asinteger) then
         begin
            tHorasDif := tHorasDif + horasDia - table.fieldByName('tprevisto').Asinteger;
            table.fieldByName('sinal').AsString := '+';
            table.fieldByName('dif').AsString :=  intToHora( horasDia - table.fieldByName('tprevisto').Asinteger);
         end
         else
         begin
            tHorasDif := tHorasDif - ( table.fieldByName('tprevisto').Asinteger - horasDia );
            table.fieldByName('sinal').AsString := '-';
            table.fieldByName('dif').AsString :=  intToHora( table.fieldByName('tprevisto').Asinteger - horasDia );
         end;
         tHorasTrab := tHorasTrab + horasDia;
      end;
      table.post;
      table.next;
    end;
    f.gravaLog(' ' + IntToStr(tAtrasAut));

/// calcula as ocorr�ncias de almo�o

   f.gravaLog('------------------------Calcular os atrasos de almo�o: ' + matricula);
   dataAux := dataInicial;
   tAtrsAlmo := 0;
   table.First;
   while table.Eof = false do
   begin
      table.Edit;

      atrAlmoco :=
      fmMain.atrasoDeAlmoco(cartao, dateToStr(dataAux), table.fieldByName('int_sai').AsString, table.fieldByName('int_ent').AsString);

      if (atrAlmoco <> 0) then
      begin
         table.fieldByName('ocorrencia').asString := trim(table.fieldByName('ocorrencia').asString) + ' - Atraso de almo�o';
         tAtrsAlmo :=  tAtrsAlmo + atrAlmoco;
      end;

      dataAux := dataAux +1;
      table.post;
      table.next;
   end;
end;

function tfmMain.selecionaBatidasDoDia(dia, cartaoPonto:String; batidas: TStringList):TStringlist;
var
  aux,BatDia:TstringList;
  i:integer;
begin
   batDia := Tstringlist.Create();
   aux:= Tstringlist.Create();

   for i:= 0 to batidas.count-1 do
     if (copy(batidas[i],01,10) = dia) then
        BatDia.Add(batidas[i]);

// se so tiver uma batida decido se e na entrada ou saida
   if batDia.Count = 1 then
   begin
      if f.horaToInt(copy(BatDia[0],12,05)) <= horaToInt( fmMain.HoraPrev( copy(batDia[0],01,10), cartaoPonto, false, false )) + 240 then
      begin
         aux.add( copy(BatDia[0],12,05) + copy(BatDia[0],30,03) );
         for i:=1 to 3 do
            aux.add(BATIDA_VAZIA);
      end
      else
      begin
         for i:=1 to 3 do
            aux.add(BATIDA_VAZIA);
         aux.add( copy(BatDia[0],12,05)  + copy(BatDia[0],30,03) );
      end
   end;

// se so tiver duas batidas eu coloco uma na entrada e oura na saida
   if batDia.Count = 2 then
   begin
      aux.add( copy(BatDia[0],12,05) + copy(BatDia[0],30,03) );
      aux.add(BATIDA_VAZIA);
      aux.add(BATIDA_VAZIA);
      aux.add( copy(BatDia[1],12,05) + copy(BatDia[1],30,03) );
   end;


// SE TIVER 3 BATIDAS, eu coloco entrada, saida e saida para almoco
   if (batDia.Count = 3)then
   begin
      aux.add( copy(BatDia[0],12,05) +  copy(BatDia[0],30,03) );
      aux.add( copy(BatDia[1],12,05) +  copy(BatDia[1],30,03) );
      aux.add( BATIDA_VAZIA );
      aux.add( copy(BatDia[BatDia.count-1],12,05) + copy(BatDia[BatDia.count-1],30,03) );
   end;

   if (batDia.Count > 3) then
   begin
      aux.add( copy(BatDia[0],12,05) +  copy(BatDia[0],30,03) );
      aux.add( copy(BatDia[1],12,05) +  copy(BatDia[1],30,03) );
      aux.add( copy(BatDia[2],12,05) +  copy(BatDia[2],30,03) );
      aux.add( copy(BatDia[BatDia.count-1],12,05) + copy(BatDia[BatDia.count-1],30,03) );
   end;
   result := aux;
   BatDia.Destroy();
end;

procedure TfmMain.preencherListaBatidas(var table:TadoTable; dti,dtf:Tdate; cartao:String);
var
  BatDoDia, BatPeriodo:TstringList;
  i:integer;
begin
    f.gravaLog('Preenchendo Lista batidas :' + cartao );

    BatDoDia := Tstringlist.Create();
    batPeriodo := uBatida.getBatidas( dateToStr(dti), dateToStr(dtf), cartao );

    i:=0;
    table.First;

    f.gravaLog('Colocando as batidas na tabela: ' + cartao );
    while table.Eof = false do
    begin
       BatDoDia := fmMain.selecionaBatidasDoDia( dateToStr(dti+i), cartao, batPeriodo );

       if BatDoDia.Count > 0 then
       begin
          table.Edit;
          table.FieldByName('ent').asString := copy(BatDoDia[0],01,05);
          table.FieldByName('int_sai').asString := copy(BatDoDia[1],01, 05);
          table.FieldByName('int_ent').asString := copy(BatDoDia[2],01, 05);
          table.FieldByName('sai').asString := copy(BatDoDia[3],01,05);

          table.FieldByName('localEnt').asString := copy(BatDoDia[0],06,03);
          table.FieldByName('LocalSai').asString := copy(BatDoDia[3],06,03);
          table.post;
       end;
       inc(i);
       table.Next;
    end;
    f.GravaLog('Preenchendo Lista batidas na tabela, conclu�do :' + cartao );
end;


procedure TfmMain.habilitaItens(Sender: Tobject);
begin
   timer2.Enabled := true;
end;

function TfmMain.getCartaoPonto(cb: TCustomComboBox): String;
begin
   result :=  getCartaoPontoStr(cb.items[cb.itemIndex]);
end;

function TfmMain.getCodLocalizacaoLoja(cb: TCustomComboBox): String;
begin
   result := quotedStr( copy( cb.items[cb.itemIndex], 101, 03) );
end;

procedure TfmMain.ConfiguraMenus();
begin
   if (f.RParReg(CH_REG,'MostraMenu') <> '1')then
      fmMain.Menu := nil
   else
      fmMain.Menu := MainMenu1;

   if ( PERFIL = '1')then
     cadastroDeDigitais1.Enabled := true
   else
     cadastroDeDigitais1.Enabled := false;
end;

procedure TfmMain.ajustarItensNaTela(Sender: Tobject);
begin
   with fmMain do
   begin
      top:= 11;
      Height := 430;
      left := SCREEN.Width - fmMain.Width -50;
   end;
   pnBatidaRec.TOP := 15;
   pnBatidaRec.Left := 20;
end;


function tfmMain.r1(n:string):string;  //Funcao de inverter String;
var
   aux:string;
begin
   aux:= copy(n,7,4);          //ano
   aux:= aux + copy(n,4,2);    //mes
   aux:= aux + copy(n,1,2);    //dia
   aux:= aux + copy(n,12,2);   //hora
   aux:= aux + copy(n,15,2);   //min
   aux:= aux + copy(n,18,2);   //seg
   aux:= aux + copy(n,21,8);   //matricula
   r1:=aux;
end;

procedure TfmMain.registraPontoWalter(data:string);
var
  hora:integer;
begin
   hora := 477;
   randomize;
   hora := hora+ random(08);
   uUtil.registraPonto( data, f.intToHora(hora), '00010830', LOJA);
end;

procedure TfmMain.exibeBatida(data,hora:String);
begin
   lbDadosCartao.Caption := 'Cart�o: ' + DS_EMP.fieldByname('cartaoPonto').AsString +  '      '+
                            'Matricula:'+DS_EMP.fieldByname('matricula').AsString  +'/'+ LOJA;
   lbNome.Caption := trim(DS_EMP.fieldByname('nome').AsString);
   lbDataHoraPonto.Caption := data + ' as ' + hora;
   pnBatidaRec.Visible := true;
end;

procedure tfmMain.registraPonto(data, hora, cartaoPonto:String);
begin
   exibeBatida(data, hora);

  if (uUtil.registraPonto( data, hora, cartaoPonto, LOJA ) = false ) then
      msg.msgErro( dm.getMsg('erroGravPonto') )
  else
  timer2.Enabled := true;
end;

function tfmMain.ExisteBatida(cartao:String):boolean;
var
   i:integer;
begin
	f.gravaLog('TfmMain.ExisteBatida()');

   i :=  uBatida.getTimeUltBat(cartao);
   f.gravaLog('ultima Batida do cart�o: ' + cartao + ' foi h�: ' + intToStr(i) + ' minutos.' );

   if (i < 30) then
      msg.msgErro( dm.getCMD3('msg', 'batRecente', intToStr(i), uEmpregado.getNomeEmpregado(cartao), ''));

   result := (i < 30);
end;

function tfmMain.VerificaHorario( data, hora, cartaoPonto:String): String;
var
   aux:String;
   horaFeita, horaPrevista {, qtMinPriPeriodo}:integer;
begin
//	qtMinPriPeriodo := 180;

   f.gravaLog(' VerificaHorario() cartao:'+  cartaoPonto);

   horaPrevista :=  f.horaToInt( DS_EMP.fieldByName( fmMain.getCampoDia( data,false, false) ).AsString);
   horaFeita :=   f.horaToInt(hora);
   aux :=  'Ok';
   if ( DS_EMP.FieldByName('isHoraFlexivel').asString = '1' ) then
   begin
      if ( ( horaFeita - horaPrevista ) < VL_PRIM_PERIODO ) and ( ( horaFeita - horaPrevista ) > TOLERANCIA  ) then
         aux :=  'Fora de hora'
   end
   else
   begin
      if ( ( HoraFeita - HoraPrevista ) < VL_PRIM_PERIODO ) and ( ( HoraFeita - HoraPrevista ) > 0   ) then
         aux :=  'Nao permitido'
   end;
   result  := aux;
   f.gravaLog(' VerificaHorario() cartao:'+  cartaoPonto + ' Resultado: ' + aux);
end;

procedure TfmMain.BitBtn3Click(Sender: TObject);
begin
   fmMain.Close;
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if key  = vk_return then
    begin
       Perform (CM_DialogKey, VK_TAB, 0);
       key:= vk_Tab;
    end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
   f.gravaLog('----------------Inicando a aplica��o....-------------------');

	try

      TIME_OUT_PROGRAM := VALOR_DEFAULT_TIME_OUT_PROGRAM;

      Application.OnException := AppException;
      if  shortdateformat <> 'dd/MM/yyyy'  then
      begin
         msg.msgErro(dm.getMsg('errDateFormat'));
         application.Terminate
      end;
      LongTimeFormat  :='HH:mm:ss';

      dm.loadCommandsBD( f.getDirExe() + 'cmdPonto.dll');

      if f.RParReg(CH_REG,'loja') = '' then
      begin
         msg.msgErro(#13+'Antes de usar o programa � preciso configurar a loja. ');
         application.Terminate
      end
      else
      begin
         fmMain.caption := TITULO;

         PATH :=  ExtractFilePath(paramStr(0));
         LOJA := f.RParReg(CH_REG,'loja');
         VALOR_DEFAULT_TIME_OUT_PROGRAM := strToInt( uUtil.lerParametroBD('ponto.dataTimeoutDefault'));
         tolerancia := strToInt( uUtil.lerParametroBD('ponto.toleranciaDeEntrada'));
         TIME_OUT_PROGRAM := VALOR_DEFAULT_TIME_OUT_PROGRAM;
         VL_PRIM_PERIODO := strToInt( uUtil.lerParametroBD('ponto.tamPrimPeriodo'));


   // se nao existir parametro de captura de ponto, inicia com 2(digitado)
        if (f.RParReg( CH_REG, 'capturaPonto') = '') then
           f.WParReg(CH_REG,'capturaPonto','2');

         PERFIL := f.RParReg( CH_REG, 'capturaPonto');

         configuraMenus();

         // d� a partida do relogio.
         iniciaHorario();





      end
		except
   	on e:exception do
      	f.gravaLog('TfmMain.FormCreate()' + e.Message);
   end
{}
end;

procedure TfmMain.AppException(Sender: TObject; E: Exception);
begin
   f.gravaLog('Erro: - ' + DateToStr(now)+' - '+TimeToStr(now)+ ' - ' +  E.message +' Loja:'+ LOJA);
end;

procedure TfmMain.mxOneInstance1InstanceExists(Sender: TObject);
begin
   if f.ehParametroInicial('-one') = false then
   begin
      msg.msgErro('   J� existe uma tela desse programa aberta     ');
      application.terminate;
   end
   else
   begin
      mxOneInstance1.SwitchToPrevious := false;
      mxOneInstance1.Terminate := false;
   end;
end;

procedure TfmMain.ativaReceberPontoBiometrico();
begin
   f.gravaLog('a��o: ativaReceberPontoBiometrico');
   bevel2.Visible := true;
   ativarLabelsDataHora();

   lbData.caption := datetostr(now);

   fmMain.Caption := TITULO +  '    -  Iniciando Leitor.';

   if (uUtil.InitializeGrFinger(GrFingerXCtrl1) < 0) then
      application.Terminate;

   fmMain.Caption := TITULO +  '    -  Abrindo conex�o com o BD.';
   try
      f.gravaLog('Abrir a tabela de templates');
      uUtil.AbrirCadastroDigitais();
   except
      on e:Exception do
      begin
         msg.msgErro( dm.getMsg('errConexao'));
         gravaLog('Erro:' + e.Message);
         application.Terminate();
      end;
   end;
   statusbar1.Panels[0].Text := inttostr(uUtil.getNumeroRegistros()) + ' Digitais';
   fmMain.Caption := TITULO;
end;

procedure TfmMain.FormActivate(Sender: TObject);
begin
   screen.cursor := crhourglass;
   setForeGroundWindow(handle);
   ajustarItensNaTela(Sender);
   DS_EMP  := TDataSet.Create(nil);

   gravaLog('Iniciando perfil:' + PERFIL);

   if PERFIL = '1' then
      if ( IS_CAPTURA_INICIADA = false) then
      begin
         ativaReceberPontoBiometrico();
         IS_CAPTURA_INICIADA := true;
      end;

   if PERFIL = '2' then
   begin
      ativaReceberPontoDigitado();
      uUtil.InitializeGrFingerSemCaptura();
   end
   else
      uUtil.InitializeGrFingerSemCaptura();

   fmMain.Caption := TITULO ;
   statusbar1.Panels[1].Text := f.lerParam('ConexaoAoWell.ini', 3) +' - '+ f.lerParam('ConexaoAoWell.ini', 2);

   screen.Cursor := crDefault;
end;


procedure TfmMain.Ocorrncias1Click(Sender: TObject);
begin
   if ( fmMain.getUserAutorizador(false) <> '' ) then
   begin
      Application.CreateForm(TFmOcorrencia, FmOcorrencia);
      FmOcorrencia.show;
      fmMain.Hide;
   end;
end;

procedure TfmMain.Justificativas1Click(Sender: TObject);
var
	user:String;
begin
	user := fmMain.getUserAutorizador(false);
   if ( user <> '' ) then
   begin
      Application.CreateForm(TJustificativa, Justificativa);
      justificativa.Show;
		Justificativa.setAutorizador(user);
      fmMain.Hide;
   end;
end;


procedure TfmMain.FormShow(Sender: TObject);
begin
   if timer2.Enabled = false then
      timer2.Enabled:= true;
end;


function TfmMain.existsFormOpen(Dender: Tobject): boolean;
var
  i:integer;
  aux:String;
  erro : boolean;
begin
   erro:=false;
   for i:=0 to Application.ComponentCount -1 do
   begin
      aux := application.Components[i].ClassType.ClassName;
      if (pos('Tfm',aux) > 0) and ( aux <> 'TfmMain') then
         erro := true;
   end;
   result := erro;
end;

procedure TfmMain.Timer2Timer(Sender: TObject);
begin
   TIME_OUT_PROGRAM :=   TIME_OUT_PROGRAM - 1;

   if (TIME_OUT_PROGRAM <= 0) then
      if (fmBatidas <> nil) or ( FmOcorrencia <> nil) {or ( fmImpFolhaPonto <> nil)} or ( Justificativa <> nil) then
         TIME_OUT_PROGRAM := VALOR_DEFAULT_TIME_OUT_PROGRAM
       else
       begin
          f.gravaLog('Aplicativo encerrado por inatividade');
          Application.Terminate();
       end;

   lbData.caption := DateToStr(now);
//   lbHora.caption := '';
   lbHora.caption :=   avancaHora(lbHora.Caption); //   TimeToStr(now);

   if pnBatidaRec.visible then
   begin
      sleep(3000);
      pnBatidaRec.visible := false;
      fmMain.Caption := TITULO;
   end;
end;


procedure TfmMain.GrFingerXCtrl1SensorPlug(ASender: TObject;const idSensor: WideString);
begin
  GrFingerXCtrl1.CapStartCapture (idSensor);
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//   if PERFIL = '1' then
     GrFingerXCtrl1.Finalize();

   uUtil.FinalizeGrFinger(GrFingerXCtrl1);

     // tenta atualizar o prelogio.exe
   verificaAtualizacaoDoLancador();
   application.terminate;
end;


Procedure TfmMain.receberCartaoDePonto(cartaoPonto:string);
var
   verificacaoHorario,codJus, userAut, obs:String;
   dataHoraBD, dataBD, horaBD:String;
begin
   f.gravaLog('TfmMain.receberCartaoDePonto()'+ cartaoPonto );


//   dataHoraBD := '13/06/2014 08:05:11';

   dataHoraBD := lbData.Caption +' '+ lbHora.Caption;

   dataBD := fdt.extractFromGetDate('data', dataHoraBD);
   horaBD := fdt.extractFromGetDate('hora', dataHoraBD);


   if (existeBatida(cartaoPonto) = false) then
   begin
      verificacaoHorario := verificaHorario(dataBD, horaBD, cartaoPonto);

      fmMain.Caption := TITULO + '   Hor�rio-> ' + VerificacaoHorario; //;aux ;

      if (verificacaoHorario = 'Nao permitido') then
      begin
         msg.msgErro( dm.getMsg('errForaHora')) ;
      end
      else  if (verificacaoHorario  = 'Fora de hora') then
      begin // fora de hora
      	userAut := '';
         codJus := '';

         //pegar o autorizador e a justificativa
         fmMain.getAutorizJustificado(userAut, codJus, obs);

         if (codJus <> '') and (userAut <> '') and (Length(obs) > 10) then
         begin
            uUtil.justificar(fmMain.getMatricula(cartaoPonto),
               codJus, dataBD , dataBD, '1', '0800', f.SohNumeros(copy(horaBD, 01, 05)), 'A02',
               copy(lbDadosCartao.caption, 10, 08),
               dataHoraBD +' '+ horaBD, obs,
               copy(lbDadosCartao.caption,41,01), copy(lbDadosCartao.caption,43,03), LOJA, '', userAut
            );
            registraPonto(dataBD, horaBD, cartaoPonto);
         end
         else
            msg.msgErro(dm.getMsg('errBatSemJust'));
      end
      else
      begin
         registraPonto(dataBD , horaBD, cartaoPonto);
      end;
   end;
   timer2.Enabled := true;
end;


procedure TfmMain.digitarPonto(cartaoPonto: String);
begin
   f.gravaLog('-------------------------------TfmMain.digitarPonto() ' + cartaoPonto);

   if ( getDadosEmpregado(cartaoPonto) = true ) then
      receberCartaoDePonto(cartaoPonto)
   else
      msg.msgErro('Cart�o de ponto n�o cadastrado('+cartaoPonto+')');

   Image1.Picture := nil;
end;


procedure TfmMain.GrFingerXCtrl1ImageAcquired(ASender: TObject;const idSensor: WideString; width, height: Integer;  var rawImage: OleVariant; res: Integer);
var
   ret:integer;
   cartaoPonto:String;
begin
   timer2.Enabled := false;
   TIME_OUT_PROGRAM := VALOR_DEFAULT_TIME_OUT_PROGRAM;

//   Copying aquired image
   raw.height := height;
   raw.width := width;
   raw.res := res;
   raw.img := rawImage;

  // display fingerprint image
   begin
      uUtil.PrintBiometricDisplay(Image1, GrFingerXCtrl1, false, GR_DEFAULT_CONTEXT);
      uUtil.ExtractTemplate(fmMain.GrFingerXCtrl1);
      uUtil.PrintBiometricDisplay(Image1, GrFingerXCtrl1, true, GR_MEDIUM_QUALITY);
      image1.reFresh;
      sleep(300);
   end;

   ret := 10;
   cartaoPonto := IntToStr(uUtil.identify(fmMain.GrFingerXCtrl1, ret));

   cartaoPonto := f.preencheCampo(6, '0', 'e', cartaoPonto);

   if  ( cartaoPonto <> '000000') and (cartaoPonto <> '163758') then
      digitarPonto(cartaoPonto)
   else
      msg.msgErro(dm.getMsg('errDigNaoCad'));

   timer2.Enabled := true;
end;

procedure TfmMain.Batidas1Click(Sender: TObject);
begin
  if ( fmMain.getUserAutorizador(false) <> '' ) then
   begin
      Application.CreateForm(TfmBatidas, fmBatidas);
      fmBatidas.Show();
      fmMain.Hide();
    end;
end;

procedure TfmMain.impressaoRave(dataSet1, DataSet2: TdataSet; nomeRelatorio: String; parametros: TStringlist);
var
   i:integer;
begin
   if (parametros <> nil) then
      for i:=0 to parametros.Count-1 do
         RvProject.SetParam(intToStr(i), parametros[i]);

   RvProject.SetParam('versao', VERSAO);

   if (dataSet1 <> nil) then
      dsConn1.DataSet := dataSet1;
   if (dataSet2 <> nil) then
      dsConn2.DataSet := dataSet2;

   RvProject.ProjectFile := f.getdirExe()+ 'relogio.rav';

   msg.msgErro('');

   RvProject.ExecuteReport(nomeRelatorio);
end;


procedure TfmMain.AbrefmFolhaPonto(perfil: integer);
begin
{   Application.CreateForm(TfmImpFolhaPonto, fmImpFolhaPonto);
   fmImpFolhaPonto.Show;
   fmImpFolhaPonto.setPerfil(perfil);
   fmMain.Hide;
}
end;


procedure TfmMain.FolhaPonto1Click(Sender: TObject);
begin
   if ( fmMain.getUserAutorizador(false) <> '' ) then
      abrefmFolhaPonto(1);
end;

function TfmMain.isAntecipacaoSaida(cartao, data, batida: String): integer;
var
  prev:integer;
begin
   if (batida = BATIDA_VAZIA) then
     result := 0
   else
   begin
      prev := horaToInt( getHoraPrevista( cartao, getCampoDia(data, true, false), DS_EMP));
      if  prev > horaToInt(batida) then
        result := prev - horaToInt(batida)
      else
        result := 0;
   end;
end;

procedure TfmMain.ativaReceberPontoDigitado;
begin
   ativarLabelsDataHora();
   pnPontoDig.top := 55;
   pnPontoDig.left := 15;
   pnPontoDig.Visible := true;
   edPontodig.SetFocus();
end;

procedure TfmMain.edPontodigKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (length(edPontodig.Text) = 8 ) then
  begin
     timer2.Enabled := false;
     TIME_OUT_PROGRAM := VALOR_DEFAULT_TIME_OUT_PROGRAM;
     digitarPonto(copy(edPontodig.text, 03, 06));
     edPontodig.Text := '';
     timer2.Enabled := true;     
  end;
end;

procedure TfmMain.ativarLabelsDataHora();
begin
   label1.caption :='Data:';
   label1.visible := true;
   label2.caption :='Hora:';
   label2.visible := true;
   lbData.visible := true;
   lbHora.visible := true;

//   lbHora.caption := timetostr(now);
end;

function TfmMain.getLocalizacaoLoja(cb: TCustomComboBox): String;
begin
   result := trim(copy(cb.Items[cb.ItemIndex],101,05));
end;

procedure TfmMain.closeDataSet;
begin
   DS_EMP.Close();
end;

procedure TfmMain.posicionarTela(form: Tform);
begin
   form.Top := 1;
   form.Left := Screen.Width - form.Width -1;
end;

procedure TfmMain.verificaAtualizacaoDoLancador;
var
   acao:boolean;
begin
   if (FileExists(ExtractFilePath(ParamStr(0))+  'PRelogioNovo.exe') = true) then
   begin
      gravaLog('-----------------   Atualizacao do lancador    ------------------');
      deleteFile( ExtractFilePath(ParamStr(0))+  'PRelogio.exe');
      acao :=  RenameFile(ExtractFilePath(ParamStr(0))+  'PRelogioNovo.exe', ExtractFilePath(ParamStr(0))+'PRelogio.exe');
      gravaLog('resultado da atualizacao: ' + sysUtils.BoolToStr(acao, true) );
   end;
end;

procedure TfmMain.Cadastrodedigitais1Click(Sender: TObject);
var
  user:String;
begin
   user := fmMain.getUserAutorizador(false);
   if ( user <> '' ) then
   begin
      screen.Cursor := crHourGlass;
      uUtil.FinalizeGrFinger(GrFingerXCtrl1);
      fmMain.Hide;

      Application.CreateForm(TfmCad, fmCad);
      screen.Cursor := crDefault;
      fmCad.Show();
      fmCad.setUser(user);
   end;
end;


procedure TfmMain.Batidasporlocalizacao1Click(Sender: TObject);
begin
   if ( fmMain.getUserAutorizador(false) <> '' ) then
      abrefmFolhaPonto(2);
end;

function TfmMain.atrasoDeAlmoco(cartao, data, saiAlmoco, entAlmoco: String ): integer;
var
	cpEnt,cpSai:String;
   ds:TdataSet;
   intervalo:integer;
begin
	result := 0;
	if (saiAlmoco <> BATIDA_VAZIA) and (entAlmoco <> BATIDA_VAZIA) then
   begin
      ds := uEmpregado.getEmpPorCartao(cartao);

   	cpSai	:= fmMain.getCampoDia(data, true, true);
	   cpEnt := fmMain.getCampoDia(data, false, true);

		intervalo :=   horaToInt(ds.fieldByName(cpSai).AsString) -  horaToInt(ds.fieldByName(cpEnt).AsString);

      if ((horaToint(entAlmoco) - horaToInt(saiAlmoco)) > intervalo) then
      	result := (horaToint(entAlmoco) - horaToInt(saiAlmoco)) - intervalo
      else
   		result := 0;

      f.gravaLog(
         ' REsultado:' + intTostr(Result)+
         '    cartao:' + cartao +
         '      Data:' + data+
         '     Saida:'+ saiAlmoco+
         '   Entrada:'+ entAlmoco
      );

   end;
end;


function TfmMain.isFalta(cart, batEnt, batSai, dt, diaCompl:String):boolean;
begin  //
	result:=
      ( uBatida.isBatVaz(batSai) = true) 		  and
      ( uBatida.isBatVaz(batEnt) = true) 	     and
      ( pos ('DOM', diaCompl) <= 0 )           and
      ( uUtil.isFeriado(dt, cart) = false )    and
      ( (fmMain.HoraPrev(dt, cart, false, false ) <> BATIDA_VAZIA) AND (fmMain.HoraPrev(dt, cart, false, false ) <> SEM_HORA) );
end;

function TfmMain.avancaHora(hora: String): String;
var
	ss, mm, hh:integer;
   s,m,h:String;
begin
// '11:00:00';
	ss := strtoint( copy(hora, 07, 02));
   mm := strtoint( copy(hora, 04, 02));
	hh := strtoint( copy(hora, 01, 02));

   inc(ss);
   if (ss > 59) then
   begin
   	ss := 0;
      inc(mm);
   end;

   if (mm > 59) then
   begin
   	mm := 0;
      inc(hh);
   end;

   if (hh > 23) then
   begin
   	ss:= 0;
      mm:= 0;
      hh:= 0;
   end;

   s := f.preencheCampo(2,'0','E', intToStr(ss));
   m := f.preencheCampo(2,'0','E', intToStr(mm));
   h := f.preencheCampo(2,'0','E', intToStr(hh));

	result := h+':'+m+':'+s;
end;

procedure TfmMain.iniciaHorario();
var
	dh, h,d:String;
begin
	dh :=	dm.getDataHoraBD();

   d:= copy(dh, 01, 10);
   h:= copy(dh, 12, 08);

   lbData.Caption := d;
   lbHora.Caption := h;
end;


end.


