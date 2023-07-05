unit uConsultarBatidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, SoftDBGrid, ComCtrls, StdCtrls,
  fCtrls, Buttons, ExtCtrls, Menus, TFlatButtonUnit;

type
  TfmBatidas = class(TForm)
    conexao: TADOConnection;
    Grid: TSoftDBGrid;
    table: TADOTable;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Label2: TLabel;
    lbHTrabalhadas: TLabel;
    Label4: TLabel;
    lbAtrasoAut: TLabel;
    Label6: TLabel;
    lbAtrasoJust: TLabel;
    Label3: TLabel;
    lbDiferencas: TLabel;
    Label10: TLabel;
    lbHorasPrevstas: TLabel;
    Label5: TLabel;
    lbBatInc: TLabel;
    lbBatIncJust: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    lbFalta: TLabel;
    Label11: TLabel;
    LbFaltaJ: TLabel;
    PopupMenu: TPopupMenu;
    Visualizarbatidasdestedia1: TMenuItem;
    Label8: TLabel;
    lbAtrAlmoco: TLabel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    Edit2: TEdit;
    cbEmp: TComboBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    dti: TDateTimePicker;
    dtf: TDateTimePicker;
    BitBtn7: TBitBtn;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn7Click(Sender: TObject);
    procedure CarregaRegistroBatidas(cartaoPonto:String);
    procedure Edit2Change(Sender: TObject);
    procedure calcularTotaisHoras();
    procedure PopupMenuPopup(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Visualizarbatidasdestedia1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure cbEmpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmBatidas: TfmBatidas;

implementation

uses RelogioPonto , uVisualizarBatidas, uUtil, funcsql, f, msg, uDm, fdt;

{$R *.dfm}

procedure TfmBatidas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmMain.habilitaItens(sender);
   Edit2.Text := '';
   f.salvaCampos(fmBatidas);
   fmMain.Show();
   Action := caFree;
   fmBatidas:= nil;
end;

procedure TfmBatidas.Edit2Change(Sender: TObject);
begin
  cbEmp.ItemIndex := f.buscaEmComboBox(edit2.Text, cbEmp);
end;

procedure TfmBatidas.calcularTotaisHoras();
var
   tHorasPrev, tHorasTrab, tAtrasJus, tAtrasAut,
   tHorasDif, batIncJ, batInc, falta, faltaJ, tAtrAlmoco:smallInt;
   emp:string;
begin
   emp := cbEmp.Items[cbEmp.itemIndex];

// calcula as ocorrencias
   fmMain.calcHorastotais(
      table,  tHorasPrev, tHorasTrab, tAtrasJus, tAtrasAut, tHorasDif,  batIncJ,
      batInc, falta, faltaJ, tAtrAlmoco, fmMain.getMat(cbEmp), fmMain.getCartaoPontoStr(emp),
      dti.Date
   );

   f.gravaLog(tAtrAlmoco);


   lbHorasPrevstas.Caption :=  intToHora(tHorasPrev);
   lbHTrabalhadas.Caption :=  intToHora(tHorasTrab);

   lbDiferencas.caption  := intToHora(tHorasDif);

   lbAtrasoAut.Caption :=  intToHora(tAtrasAut);
   lbAtrasoJust.Caption :=   intToHora(tAtrasJus);

   lbBatInc.Caption := intToStr(batInc);
   lbBatIncJust.Caption := intToStr(batIncJ);

   LbFaltaJ.Caption := intToStr(faltaJ);
   LbFalta.Caption := intToStr(falta);

   lbAtrAlmoco.Caption := intToHora(tAtrAlmoco);
end;

procedure TfmBatidas.FormActivate(Sender: TObject);
begin
   fmMain.posicionarTela(fmBatidas);
   Edit2.SetFocus;
end;

procedure TfmBatidas.CarregaRegistroBatidas(cartaoPonto:String);
begin
   gravaLog('--------------------Consulta batidas Inicio');

   if (table.Active = true ) then
      table.Close();

   uUtil.criaTbResumo(table);

   fmMain.getDadosEmpregado( cartaoPonto );

   uUtil.PreencheListaDosDias(table, dti.Date, dtf.Date);

   fmMain.PreencherListaBatidas( table, dti.Date, dtf.Date, cartaoPonto);


   f.ajGridCol(Grid, table, 'dia', 50, 'Dia');
   f.ajGridCol(Grid, table, 'ehFeriado', 30, 'Feriado');
   f.ajGridCol(Grid, table, 'TPrevisto', 0, '');
   f.ajGridCol(Grid, table, 'Intervalo', 0, '');
   f.ajGridCol(Grid, table, 'cartaoPonto', 0, '');
end;

procedure TfmBatidas.BitBtn7Click(Sender: TObject);
var
   erro:String;
begin
   screen.cursor := crHourGlass;
   grid.Visible := false;

   erro := '';
   if cbEmp.ItemIndex < 0 then
     erro := dm.getMsg('errEmpNaoInf');
   if dtf.Date < dti.Date then
     erro := erro + dm.getMsg('errData');
   if (dtf.Date - dti.Date) > 31 then
     erro := erro + dm.getMsg('errInterv');
   if erro <> '' then
      msg.msgErro(' Corrija antes esses erros:               '+#13+ erro)
   else
   begin
      carregaRegistroBatidas(fmMain.getCartaoPonto(cbEmp));

// calcula as ocorr�ncias aqui
      calcularTotaisHoras();
   end;

   grid.Visible := true;
   screen.cursor := crDefault;
end;



procedure TfmBatidas.PopupMenuPopup(Sender: TObject);
begin
   if table.IsEmpty = false then
      Visualizarbatidasdestedia1.Enabled  := true
   else
      Visualizarbatidasdestedia1.Enabled  := false;
end;

procedure TfmBatidas.FormCreate(Sender: TObject);
begin
   fmMain.hide;
   carregaCampos(fmBatidas);
   cbEmp.Items := uUtil.ObterDadosFuncionarios('');

   label4.hint := 'Atrasos acumulados pela entrada ap�s hor�rio e dentro da toler�ncia.';
   label3.hint := 'Total hor�rio realizado menos o previsto, para os dias trabalhados.';
   label10.hint := 'Horas previstas no per�odo independente de ter trabalhado ou n�o.';
   label2.hint := 'Somat�rio das horas trabalhadas dia a dia.';
end;

procedure TfmBatidas.Visualizarbatidasdestedia1Click(Sender: TObject);
begin
   Application.CreateForm(TfmVisbatidas, fmVisbatidas);
   fmVisbatidas.Show;
   fmVisbatidas.Label1.Caption := fmMain.getCartaoPonto(cbEmp); //copy(cbEmp.Items[cbEmp.itemIndex],35,08);
   fmVisbatidas.dti.Date := fmBatidas.dti.Date;
end;

procedure TfmBatidas.BitBtn1Click(Sender: TObject);
var
   lst:TstringList;
begin
    lst := TStringList.Create();
    lst.Add(dateToStr(dti.Date) + ' a  ' + dateToStr(dtf.Date) );
    lst.Add(lbHTrabalhadas.Caption);
    lst.Add(lbHorasPrevstas.Caption);
    lst.Add(lbDiferencas.Caption);
    lst.Add(lbAtrasoJust.Caption);
    lst.Add(lbAtrasoAut.Caption);
    lst.Add(lbBatInc.Caption);
    lst.Add(lbBatIncJust.Caption);
    lst.Add(lbFalta.Caption);
    lst.Add(LbFaltaJ.Caption);
    lst.Add(lbAtrAlmoco.caption);

    fmMain.impressaoRave(table, fmMain.DS_EMP ,'rpPontoBatidasPeriodo', lst );
end;

procedure TfmBatidas.cbEmpClick(Sender: TObject);
begin
   if (table.Active = true) then
      table.Close();
end;

end.
