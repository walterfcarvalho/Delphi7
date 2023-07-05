unit Justificativas;
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons,
  ExtCtrls, Mask, Db, DBTables, ADODB, DBCtrls, Grids,  DBGrids, ComCtrls,
  Spin, fCtrls, adLabelComboBox, SoftDBGrid;
type
  TJustificativa = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    BitBtn2: TBitBtn;
    edHoraFim: TMaskEdit;
    edHoraInicio: TMaskEdit;
    cbOcorrencia: TComboBox;
    btGerajustificativa: TBitBtn;
    btCancela: TBitBtn;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label9: TLabel;
    btConsultaJust: TBitBtn;
    btRemoveJust: TBitBtn;
    edBusca: TEdit;
    edMesAno: TMaskEdit;
    Label11: TLabel;
    dsJust: TDataSource;
    dtp2: TDateTimePicker;
    DTP1: TDateTimePicker;
    sg1: TStringGrid;
    Label2: TLabel;
    Label10: TLabel;
    Edit2: TEdit;
    Label12: TLabel;
    cbLojas: TComboBox;
    cbEmp: TComboBox;
    SpinButton1: TSpinButton;
    dtRefFolga: TDateTimePicker;
    lbRefFolga: TLabel;
    cbJust: TadLabelComboBox;
    grid: TSoftDBGrid;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure RGroup1Click(Sender: TObject);
    procedure btGerajustificativaClick(Sender: TObject);
    procedure btCancelaClick(Sender: TObject);
    procedure btConsultaJustClick(Sender: TObject);
    procedure Consulta();
    procedure btRemoveJustClick(Sender: TObject);
    procedure cbOcorrenciaChange(Sender: TObject);
    procedure edBuscaChange(Sender: TObject);
    procedure edBuscaEnter(Sender: TObject);
    procedure dtp1Change(Sender: TObject);
    procedure Ajustasg1();
    procedure sg1DblClick(Sender: TObject);
    procedure sg1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure limpaSg1(sender:TObject);
    function haErros(matricula, cartao, nome:String):boolean;
    procedure incluiFuncionario(matricula, nome:String);
    procedure cbLojasClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure cbJustClick(Sender: TObject);
    procedure setAutorizador(aut:String);
    function isOcoParcial():boolean;
    function isJustMensal():boolean;

  private
      linhasg1:integer;

  public
    { Public declarations }
  end;
var
   Justificativa :TJustificativa;
	AUTORIZADOR, COD_FOLGA:String;

implementation

uses RelogioPonto, uUtil, f, fdt, msg, uDm;

{$R *.DFM}

function TJustificativa.isJustMensal(): boolean;
var
   res:boolean;
begin
   res := (trim(copy(cbJust.Items[cbJust.ItemIndex], 106, 05)) = '1');
   result := res;
end;

procedure TJustificativa.FormCreate(Sender: TObject);
begin
   fmMain.posicionarTela(Justificativa);
   cbLojas.Items :=  uUtil.getNomeLojasPonto(true, true);
   cbJust.Items := uUtil.getJustificativas();
   cbEmp.Items := uUtil.obterDadosFuncionarios('');
   edMesAno.Text := copy(dateToStr(now),04, 07);
	cbOcorrencia.Items := uUtil.getOcorrencias();
   COD_FOLGA := uUtil.lerParametroBD('ponto.CodJustFolga');

   cbLojasClick(nil);
end;


procedure TJustificativa.limpaSg1(sender: TObject);
var
   i:integer;
   j:integer;
begin
   for i:=0 to sg1.RowCount - 1 do
      for j:= 0 to sg1.ColCount - 1 do
         sg1.Cells[j,i] := '';
  sg1.RowCount := 2;
  ajustasg1();
end;

procedure TJustificativa.ajustasg1();
var
   i:integer;
begin
   sg1.ColWidths[0] := 10;
   sg1.RowHeights[0]:= 15;
   sg1.Cells[00,0] := 'Matricula';
   sg1.Cells[01,0] := 'Nome';
   sg1.Cells[02,0] := 'Data';
   sg1.Cells[03,0] := '';
   sg1.Cells[04,0] := 'Tipo';
   sg1.Cells[05,0] := 'Hora';
   sg1.Cells[06,0] := '';
   sg1.Cells[07,0] := 'Ocorrencia';
   sg1.Cells[08,0] := 'Justificativa';
   sg1.Cells[10,0] := 'Observa��o';

   for i:=1 to sg1.RowCount -1 do
      sg1.RowHeights[i]  := 15;

   sg1.ColWidths[0] := 57;
   sg1.ColWidths[1] := 150;
   sg1.ColWidths[2] := 65;
   sg1.ColWidths[3] := 65;
   sg1.ColWidths[4] := 63;
   sg1.ColWidths[5] := 34;
   sg1.ColWidths[6] := 34;
   sg1.ColWidths[7] := 135;
   sg1.ColWidths[8] := 152;
   sg1.ColWidths[9] := -1;
   sg1.ColWidths[10] := 152;
   sg1.FixedRows := 1;
   sg1.ColWidths[11] := -1;
   sg1.ColWidths[12] := -1;

   edBusca.Enabled :=true;
   cbEmp.Enabled := true;
   cbEmp.itemindex := -1;
   edBusca.SetFocus;
end;

function ValorDaHora(Hora:String):integer;
begin
   ValordaHora := ( StrToInt(copy(hora,01,02)) * 60 ) + StrToInt(copy(hora,04,02))
end;

function TJustificativa.haErros(matricula, cartao, nome:String ):boolean;
var
   erro:String;
   i:integer;
begin

   erro := '';
   for i:= 1 to sg1.RowCount - 1 do
      if (copy(sg1.Cells[0,i],01,08) = matricula ) and
         (copy(sg1.Cells[7,i],01,03) = copy(cbOcorrencia.items[cbOcorrencia.itemindex], 01, 03) ) and
         (DateToStr(dtp1.date) = sg1.Cells[2,i])   then
            erro := erro + ' - J� existe justificativa desta ocorr�ncia para este empregado neste per�odo. '+#13+#13;

   if ( uUtil.getCodJust(cbJust) = COD_FOLGA) and ( dtp1.Date <> dtp2.Date ) then
      erro:= erro + ' - S� posso gerar justificativa de folga para per�odos de 01 dia' +#13;

   if (COD_FOLGA = uUtil.getCodJust(cbJust)) then
      if (uUtil.isDiaBaseFolga(matricula, dtRefFolga.Date) = false) then
         erro:= erro + ' - J� Existem duas folgas refenciadas p/ ' +trim(nome)+ ' nesse dia. '  +#13;

   if (COD_FOLGA = uUtil.getCodJust(cbJust)) then
      if (uUtil.isHaveBatida(dtRefFolga.Date, fmMain.getCartaoPonto(cbEmp)) = false ) then
         erro:= erro + ' - N�o existe registro no dia '+ dateToStr(dtRefFolga.date) +' referenciado p/ '  +copy(nome,01,20) +'...'  +#13;

   if CbLojas.ItemIndex <= 0 then
      if cbEmp.ItemIndex < 0 then
         erro:= erro + ' - Selecione um empregado' +#13;

   if (dtp1.Date) > (dtp2.date) then
      erro:= erro + ' - A data inical n�o pode ser menor que a data final.' +#13;

//
   if ((dtp2.Date - dtp1.date) > 14) and (isJustMensal() = false)  then
      erro:= erro +  dm.getMsg('jusQtTmp');

   if ( isOcoParcial() = true ) then
      if (edHoraFim.text =  '  :  ' )or (edHoraInicio.text='  :  ' ) or ( EhhoraValida(edHoraInicio.text) = false)   or ( EhHoraValida(edHoraFim.text)=false) or ( valorDaHora ( edHoraInicio.text) > ValordaHora( edHoraFim.text) )then
         erro:= erro + ' - Preencha corretamente o intervalo do horario.' + #13 ;

   if ( isOcoParcial() = true ) and ( (edHoraInicio.text = '  :  ') or (edHoraFim.text = BATIDA_VAZIA)) then
      erro:= erro + ' - Se a ocorr�ncia � atraso ou antecipa��o da saida, ent�o deve haver hora inicial e final'+#13;

   if cbOcorrencia.ItemIndex = -1 then
      erro:= erro + ' - Falta a ocorr�ncia.'+ #13;
   if cbJust.ItemIndex = -1 then
      erro:= erro + ' - Falta a justificativa para essa ocorr�ncia.'+ #13;

   if  length(edit2.text) < 10 then
      erro:= erro + ' - � preciso informar a observa��o.'+ #13;

   if ((DTP1.Date - dtRefFolga.date) > 30) and (uUtil.getCodJust(cbJust) = COD_FOLGA) then
      erro:= erro + ' - A diferen�a entre data folga e data refefenciada � maior que trinta dias. '+ #13;

   if (erro <> '' )then
   begin
      erro := '  Corrija antes o(s) seguinte(s) campo(s): '+#13+#13 + erro;
      msg.msgErro(erro);
   end;
   result := (erro <> '');
end;

procedure TJustificativa.FormShow(Sender: TObject);
begin
   left := 1;
   pagecontrol1.Align:= alclient;
   dtp1.MaxDate := now + 30;
   dtp1.date := now;
   dtp2.MaxDate := now + 30;
   dtp2.date := now;
   edMesAno.text := copy(datetoStr(now),04,02) +'/'+ copy(datetoStr(now),07,04);

   PageControl1.ActivePageIndex := 0;
   Ajustasg1();
   edBusca.SetFocus;
end;

procedure TJustificativa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmMain.Show;
   action := cafree;
   Justificativa := nil;
end;

procedure TJustificativa.RGroup1Click(Sender: TObject);
begin
   edHoraFim.visible := NOT(edHoraFim.visible);
   label4.visible := NOT(label4.visible);
   edHoraInicio.visible := NOT(edHoraInicio.visiblE);
   label8.visible := not(label8.visible);
end;

Function ValidaData(data:string):boolean;
begin
   ValidaData:=true;

   try
      StrToDate(data)
   except
      on e:exception do
         ValidaData := false;
   end;
end;

procedure TJustificativa.btGeraJustificativaClick(Sender: TObject);
var
   err:String;
   i:integer;
   diaGeradorFolga:String;
begin
  if  sg1.RowCount -1 > 1 then
  begin
     for i:=1 to sg1.RowCount -2 do
     begin
        err:= uUtil.Justificar(copy(sg1.Cells[0,i],01,08), sg1.Cells[8,i], sg1.Cells[2,i], sg1.Cells[3,i], copy(sg1.Cells[4,i],02,01), f.SohNumeros(sg1.Cells[5,i])  , f.SohNumeros(sg1.Cells[6,i]), copy(sg1.Cells[7,i],01,03), sg1.Cells[9,i], dateToStr(now) +' '+timetoStr(now) ,sg1.Cells[10,i], sg1.Cells[11,i], sg1.Cells[12,i], LOJA, sg1.Cells[13,i], AUTORIZADOR)
     end;
     btCancelaClick(Sender);
   end;
   edBusca.setfocus;
end;

procedure TJustificativa.btCancelaClick(Sender: TObject);
begin
   cbEmp.itemindex:= -1;
   cbOcorrencia.itemindex:= -1;
   cbJust.itemindex:= -1;
   cbOcorrencia.itemIndex:=-1;
   edHoraInicio.text:='';
   edHoraFim.text:='';
   edBusca.setfocus;
   dtRefFolga.Visible := false;
   lbRefFolga.Visible := false;   
   limpaSg1(sender);
end;

procedure TJustificativa.Consulta();
var
  i:smallint;
  data:String;
begin
   Data:='01/' + edMesAno.text;
   dsJust.DataSet := uUtil.listaJustificativas( fmMain.getMat(cbEmp), data);

   for i:=0 to grid.Columns.Count-1 do
   begin
      grid.Columns[i].Title.alignment:=tacenter;
      grid.Columns[i].Title.Font.Style := [fsbold];
   end;
   with grid do
   begin
      f.ajGridCol( grid, dsJust.DataSet, 'jus_tipo', 60, 'Tipo'  );
      f.ajGridCol( grid, dsJust.DataSet, 'jus_data1', 70, 'de'  );
      f.ajGridCol( grid, dsJust.DataSet, 'jus_data2', 70, 'At�'  );
      f.ajGridCol( grid, dsJust.DataSet, 'jus_hora1', 50, 'Inicio'  );
      f.ajGridCol( grid, dsJust.DataSet, 'jus_hora2', 50, 'Fim'  );
      f.ajGridCol( grid, dsJust.DataSet, 'oco_descricao', 180, 'Ocorr�ncia');
      f.ajGridCol( grid, dsJust.DataSet, 'opc_descricao', 180, 'Jutificativa');
      f.ajGridCol( grid, dsJust.DataSet, 'jus_datahora', 70, 'Dt gera��o');
      f.ajGridCol( grid, dsJust.DataSet, 'jus_observacao', 150, 'Observa��o');
      f.ajGridCol( grid, dsJust.DataSet, 'Lj justificativa', 70, 'Lj justificativa');
      f.ajGridCol( grid, dsJust.DataSet, 'jus_referencia', 0, ''  );
      f.ajGridCol( grid, dsJust.DataSet, 'nm_usu', 100, 'Autorizador'  );



//      Columns[5].Width:=180;
//      Columns[6].Width:=180;
   end;
   edBusca.setfocus;
   grid.Enabled := true;
end;

procedure TJustificativa.btRemoveJustClick(Sender: TObject);
begin
   if (dsJust.DataSet.IsEmpty = false) then
      if (msg.msgQuestion('Voc� deseja realmente excluir essa Justificativa ??') = mryes) then
      begin
         uUtil.deletajustificativa(dsJust.DataSet.fieldByName('jus_referencia').AsString  );
         btConsultaJustClick(Sender);
      end;
end;


procedure TJustificativa.cbOcorrenciaChange(Sender: TObject);
begin
   if (  isOcoParcial() = false ) then
   begin
      label8.visible := false;
      label4.visible := false;
      edHoraInicio.visible := false;
      edHoraFim.visible := false;
      edHoraInicio.Text:='  :  ';
      edHoraFim.Text:='  :  ';
   end
   else
   begin
      label8.visible := true;
      label4.visible := true;
      edHoraInicio.visible:= true;
      edHoraFim.visible := true;
   end;
end;


procedure TJustificativa.edBuscaChange(Sender: TObject);
var
   i:integer;
begin
  for i:=cbEmp.items.count-1 downto 0 do
     if pos(edBusca.text, cbEmp.items[i])  > 0 then
        cbEmp.itemindex := i;
end;

procedure TJustificativa.btConsultaJustClick(Sender: TObject);
begin
  if cbEmp.itemindex < 0 then
   begin
      msg.msgWarning('Selecione um empregado.      '+#13);
      cbEmp.SetFocus;
   end
   else
      consulta();
end;

procedure TJustificativa.edBuscaEnter(Sender: TObject);
begin
   edBusca.text := '';
end;

procedure TJustificativa.dtp1Change(Sender: TObject);
begin
   dtp2.DateTime := dtp1.DateTime;
end;

procedure TJustificativa.incluiFuncionario(matricula, nome:String);
var
  dataFolga:String;
begin
{ LAYOUT DO CADASTRO
  NOME INICIO-01 TAM-30
  CARTAO I-42 T-08
  HORARIOS I-55 T-24
  MAT I-84 T-08
  BD I-92 T-01
  LOCAL I-93 T-02
  eSTABELECIMENTO I-95 T-03
 }
   sg1.Cells[0,sg1.RowCount-1] :=  matricula;
   sg1.Cells[1,sg1.RowCount-1] := nome;
   sg1.Cells[2,sg1.RowCount-1] := datetostr(dtp1.Date);
   sg1.Cells[3,sg1.RowCount-1] := datetostr(dtp2.Date);

   if pos('  ',edHoraInicio.Text) <> 0 then
      sg1.Cells[4,sg1.RowCount-1] := '02 - Dia todo'
   else
     sg1.Cells[4,sg1.RowCount-1] :=  '01 - Parcial ';

   sg1.Cells[5,sg1.RowCount-1] := edHoraInicio.Text;
   sg1.Cells[6,sg1.RowCount-1] := edHoraFim.Text;

   sg1.Cells[7,sg1.RowCount-1] := copy(cbOcorrencia.items[cbOcorrencia.itemindex],01,30);
   sg1.Cells[8,sg1.RowCount-1] := uUtil.getCodJust((cbJust) as TadLabelComboBox);


   sg1.Cells[10,sg1.RowCount-1] := edit2.Text; // OBSERVACAO


   if ( uUtil.getCodJust(cbJust) = COD_FOLGA) then
      sg1.Cells[13, sg1.RowCount-1] := dateToStr(dtRefFolga.Date)
   else
      sg1.Cells[13, sg1.RowCount-1] := ''; 

   SG1.RowCount :=    SG1.RowCount+1;
end;

procedure TJustificativa.BitBtn2Click(Sender: TObject);
var
   ds:TdataSet;
begin
   if (cbLojas.ItemIndex <= 0) or ((cbLojas.ItemIndex = 1)) then
   begin
      if (haErros(fmMain.getMat(cbEMp),  fmMain.getCartaoPonto(cbEmp), fmMain.getNomeCB(cbEmp)) = false) then
         incluiFuncionario( fmMain.getMat(cbEmp), fmMain.getNome(cbEmp.items[cbEMp.itemIndex]) );
   end
   else
   begin
      ds := uUtil.getNomeMatPorLocalizacao(fmMain.getLocalizacaoLoja(cbLojas));
      while (ds.Eof = false) do
      begin
         if (haErros(ds.fieldByName('matricula').AsString, ds.fieldByName('matricula').AsString, ds.fieldByName('nome').AsString  ) = false) then
            incluiFuncionario(ds.fieldByName('matricula').asString, ds.fieldByName('nome').asString);
         ds.Next();
      end;
      ds.Destroy();
   end;
   Ajustasg1();
end;

procedure TJustificativa.sg1DblClick(Sender: TObject);
var
  J,i:integer;
begin
   if (linhasg1 > 0) then
   begin
      if (sg1.Cells[1,LinhaSg1] <>'')then
      begin
         for i:=0 to sg1.ColCount-1 do
            sg1.Cells[i,linhasg1] := '';
      end;
      for i:=LinhaSg1 to sg1.RowCount - 1 do
         for j:=0 to sg1.ColCount-1 do
            sg1.cells[j,i ] := sg1.cells[j,i+1 ];

      for i:=LinhaSg1 to sg1.rowcount-1  do
         if sg1.Cells[1,i] = '' then
            sg1.RowCount := sg1.RowCount - 1;

      sg1.rowcount := sg1.rowcount +1;
      ajustasg1();
   end;
end;

procedure TJustificativa.sg1SelectCell(Sender: TObject; ACol,ARow: Integer; var CanSelect: Boolean);
begin
  LinhaSg1:= arow;
end;

procedure TJustificativa.cbLojasClick(Sender: TObject);
begin
   edBusca.Visible := (cbLojas.ItemIndex <= 1);
   cbEmp.Visible :=  (cbLojas.ItemIndex <= 1);
end;

procedure TJustificativa.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
   if sg1.rowcount-1 > 1 then
      CanClose := ( msg.msgQuestion('  Deseja abandonar a inclus�o das justificativas ?  ') = MrYes);
end;

procedure TJustificativa.SpinButton1DownClick(Sender: TObject);
begin
   edMesAno.text:= fdt.ajustaDataMes(edMesAno.Text, '-');
end;

procedure TJustificativa.SpinButton1UpClick(Sender: TObject);
begin
   edMesAno.text:= fdt.ajustaDataMes(edMesAno.Text, '+');
end;

procedure TJustificativa.cbJustClick(Sender: TObject);
begin
   dtRefFolga.Visible :=  (uUtil.getCodJust(cbJust) = COD_FOLGA );
   lbRefFolga.Visible := dtRefFolga.Visible;

   if (isJustMensal() = true) then
      Edit2.Text := 'Referente a ' + copy(cbJust.Items[cbJust.ItemIndex], 01, 30);
end;

procedure TJustificativa.setAutorizador(aut: String);
begin
	AUTORIZADOR := aut;
end;

function TJustificativa.isOcoParcial():boolean;
var
	res:boolean;
begin

	res := (trim(f.getCodUO(cbOcorrencia)) = 'True');
   result := res;
end;


end.
