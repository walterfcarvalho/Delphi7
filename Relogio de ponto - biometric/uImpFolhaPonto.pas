unit uImpFolhaPonto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fCtrls, ExtCtrls, Buttons, adLabelComboBox, DB, ADODB, Spin, Mask ;

type
  TfmImpFolhaPonto = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edEmp: TEdit;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    cbLojas: TadLabelComboBox;
    cbEmp: TadLabelComboBox;
    qrEmp: TADOQuery;
    GroupBox3: TGroupBox;
    edMesAno: TMaskEdit;
    SpinButton1: TSpinButton;
    tbDias: TADOTable;
    tbBatidas: TADOTable;
    DataSource1: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbLojasClick(Sender: TObject);
    procedure cbEmpChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edEmpChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure cbLojasChange(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure getDadosDias();
    procedure setPerfil(p:integer);
    procedure imprimeFolhaPonto();
    procedure imprimeResumoBatidas();



  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmImpFolhaPonto: TfmImpFolhaPonto;
  PERFIL:integer;
implementation

uses RelogioPonto, msg, funcoes, funcsql, fdt, uUtil;

{$R *.dfm}

procedure TfmImpFolhaPonto.FormClose(Sender: TObject;var Action: TCloseAction);
begin
   action := caFree;
   fmMain.Show;
   fmMain.habilitaItens(Sender);
   action := cafree;
   fmImpFolhaPonto := nil;
end;

procedure TfmImpFolhaPonto.FormCreate(Sender: TObject);
begin
   cbLojas.items := uUtil.getNomeLojasPonto(false, false);
   cbEmp.items := uUtil.obterDadosFuncionarios('');

   edMesAno.text := copy( dateToStr(now), 04, 07);
end;

procedure TfmImpFolhaPonto.cbLojasClick(Sender: TObject);
begin
   cbEmp.ItemIndex := -1;
end;

procedure TfmImpFolhaPonto.cbEmpChange(Sender: TObject);
begin
   cbLojas.ItemIndex := -1;
end;

procedure TfmImpFolhaPonto.FormShow(Sender: TObject);
begin
   fmMain.posicionarTela(fmImpFolhaPonto);
   edEmp.SetFocus();
end;

procedure TfmImpFolhaPonto.edEmpChange(Sender: TObject);
begin
   cbEmp.ItemIndex := fmMain.buscaEmComboBox(cbEmp.Items, edEmp.Text);
end;

procedure TfmImpFolhaPonto.imprimeFolhaPonto;
var
   cmd:String;
   paramRel:Tstringlist;
   ds:TdataSet;
begin
   cmd := '';
   if (cbEmp.itemIndex > -1) then
      cmd :=  ' e.cartaoPonto = ' + fmMAin.getCartaoPonto(cbEmp)
   else if (cbLojas.ItemIndex > -1) then
          cmd :=  ' e.localizacao =   '  + fmMain.getCodLocalizacaoLoja(cbLojas) +' order by e.nome';

   if (cmd <> '')then
   begin
      cmd := ' select uo.nm_razsoc, uo.tp_lograd + '' '' + uo.ds_end, ' +
             ' nm_bai = (select top 1 nm_bai from tbai where cd_bai = uo.cd_bai and cd_cid = uo.cd_cid), '+
             ' cd_cid = (select top 1 nm_cid from tcid where cd_cid = uo.cd_cid), '+
             ' nr_cgc, sr_cgc, dg_cgc, '+
             ' e.*, h.* from zcf_PontoEmpregados E (nolock) '+
             ' inner join zcf_PontoLocalizacao l (nolock) on ( e.localizacao = l.localizacao) ' +
             ' inner join zcf_tbuo uo (nolock) on l.is_uo = uo.is_uo ' +
             ' inner join zcf_pontoHorarios h on h.num = e.horario_num  ' +
             ' where ' + cmd;

      ds :=  uUtil.getDataSetQ(cmd);


      getDadosDias();

      paramRel := TStringList.Create();
      paramRel.Add('01/' + edMesAno.Text + ' a ' +  fdt.getUltimoDiaMes( strToDate('01/'+edMesAno.Text))   );
      fmMain.impressaoRave(ds, tbDias, 'rpPontoFolha', paramRel);
   end
   else
      msg.msgErro('Escolha loja ou empregado');
end;

procedure TfmImpFolhaPonto.cbLojasChange(Sender: TObject);
begin
   cbEmp.ItemIndex := -1;
end;

procedure TfmImpFolhaPonto.SpinButton1DownClick(Sender: TObject);
begin
   edMesAno.Text :=  fdt.ajustaDataMes(edMesAno.Text, '-');
end;

procedure TfmImpFolhaPonto.SpinButton1UpClick(Sender: TObject);
begin
   edMesAno.Text :=  fdt.ajustaDataMes(edMesAno.Text, '+');
end;

procedure TfmImpFolhaPonto.getDadosDias();
var
  dataI,dataF:Tdate;
  aux:String;
begin
   datai := strToDate('01/' + edMesAno.Text);
   dataf := strToDate(fdt.getUltimoDiaMes(datai));

   if (tbDias.TableName = '') then
      uUtil.getTable(tbDias, ' DIA VARCHAR(05), DESCRICAO VARCHAR(10) , seq int identity (0,1) ')
   else
      while (tbDias.Eof = false) do tbDias.Delete();
   tbDias.Open();
   while (datai <= dataf) do
   begin
      aux := dateToStr(datai);
      tbDias.AppendRecord([ copy(aux,01,05),  getDescricaoDia(datai,false)]);
      datai := dataI+1
   end;
end;

procedure TfmImpFolhaPonto.setPerfil(p: integer);
begin
   PERFIL := p;
   cbLojas.LabelDefs.Caption := '';
   if (perfil = 2) then
   begin
      edEmp.Enabled := false;
      cbEmp.Enabled := false;
      GroupBox1.Enabled := false;
   end;
end;

procedure TfmImpFolhaPonto.imprimeResumoBatidas;
var
  params:TStringlist;
begin
    Params := TStringList.Create();

    uUtil.getEmpParaRelatorioBatidas(tbBatidas, fmMain.getCodLocalizacaoLoja(cbLojas), edMesAno.Text);

    params.Add(funcoes. getNomeUO(cbLojas)  );
    params.Add(edMesAno.Text);

    fmMain.impressaoRave(tbBatidas, nil, 'rpPontoBatidasPeriodoGrupo', params );
end;

procedure TfmImpFolhaPonto.BitBtn1Click(Sender: TObject);
begin
    case perfil of
       1:imprimeFolhaPonto();
       2:imprimeResumoBatidas();
    end;
end;


end.
