unit uPropostaLoja;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, SoftDBGrid, adLabelNumericEdit, adLabelSpinEdit,
  ComCtrls, fCtrls, ExtCtrls, TFlatButtonUnit, StdCtrls, adLabelEdit, Mask,
  adLabelMaskEdit, RpCon, RpConDS;

type
  TfmProposta = class(TForm)
    grid: TSoftDBGrid;
    Table: TADOTable;
    DataSource1: TDataSource;
    gb1: TGroupBox;
    edNmCli: TadLabelEdit;
    btDadosCliente: TFlatButton;
    edEnd: TadLabelEdit;
    edMsg: TadLabelEdit;
    edCidade: TadLabelEdit;
    EdNrCGC: TadLabelEdit;
    edFilCPFCGC: TadLabelEdit;
    edDgCGC: TadLabelEdit;
    sbar: TStatusBar;
    Panel1: TPanel;
    edFmPag: TadLabelEdit;
    edVendedor: TadLabelEdit;
    Label1: TLabel;
    dtProposta: TfsDateTimePicker;
    Label2: TLabel;
    TableDescricao: TStringField;
    TableQuant: TIntegerField;
    Tablecodigo: TStringField;
    Tableund: TBCDField;
    Tabletotal: TBCDField;
    edNova: TFlatButton;
    btImp: TFlatButton;
    edEmail: TFlatButton;
    edValidade: TadLabelSpinEdit;
    TableNCM_SH: TStringField;
    procedure CriarTabelaProposta(Sender:Tobject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure GetDadosProdutos(Sender:Tobject;cod:string);
    procedure gridColExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btDadosClienteClick(Sender: TObject);
    procedure TableAfterPost(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ImportaDadosPedido(Sender:TObject; numPedido:string);
    function  montaRelatorio():Tstringlist;
    procedure btImpClick(Sender: TObject);
    procedure edNovaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edEmailClick(Sender: TObject);
    procedure gridDblClick(Sender: TObject);
    procedure carregaDadosCliente(cd_pes:String);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  fmProposta: TfmProposta;
  PRECO:String;
  operacao:String;
implementation

uses uMain, uNovaProposta, f, uDm, uEstoque, fdt, msg, extenso,
     uLj, uProd, uPessoa;

{$R *.dfm}

{ TForm1 }

procedure TfmProposta.GetDadosProdutos(Sender: Tobject;cod:string);
var
  ds:TdataSet;
begin
   ds:= uProd.getDadosProd(fmMain.getUoLogada(), cod, '', PRECO, true );
   if (ds.IsEmpty = false) then
   begin
      table.FieldByName('Descricao').AsString := ds.fieldByName('descricao').AsString;
      table.FieldByName('Und').AsString := ds.fieldByName('preco').AsString;
      table.FieldByName('Total').AsString := ds.fieldByName('preco').AsString;
   end;
   ds.Free();
end;

procedure TfmProposta.carregaDadosCliente(cd_pes: String);
var
   ds:TdataSet;
begin
   f.gravaLog('carregaDadosCliente():' + cd_pes);

   ds:=  uPessoa.getDadosPessoa(cd_pes);

   edNrCGC.Text :=  f.preencheCampo(9, '0', 'E', ds.FieldByName('nr_cpfcgc').AsString);
   edFilCPFCGC.Text := f.preencheCampo(9, '0', 'E', ds.FieldByName('nr_filCGC').AsString);
   edDgCGC.text := ds.FieldByName('DG_CPFCGC').AsString;
   edNmCli.text := ds.FieldByName('NM_PES').AsString;
   edEnd.text :=  ds.FieldByName('TP_LOGRAD').AsString +' '+ ds.FieldByName('DS_END').AsString +' '+ ds.FieldByName('NR_END').AsString;
   edCidade.text := ds.FieldByName('ds_cid').AsString +' '+ds.FieldByName('CD_UF').AsString ;
   ds.free();
end;

procedure TfmProposta.CriarTabelaProposta(Sender: Tobject);
var
  i:integer;
begin
   if (table.IsEmpty = true) then
   begin
      dm.getTable(table, 'Codigo varchar(13), Descricao varchar(50), Quant int, Und money, Total money, NCM_SH varchar(10)');

      grid.Columns[0].Width := 100;
      grid.Columns[01].Width := 300;
      grid.Columns[02].Width := 60;
      grid.Columns[03].Width := 120;
      grid.Columns[04].Width := 120;


      for i:= 0 to grid.Columns.Count -1 do
         grid.Columns[i].Title.Font.Style := [fsBold];
   end
   else
   begin
     table.First;
     while table.IsEmpty = false do
        table.Delete;
    end;

   table.Open();
end;

procedure TfmProposta.FormCreate(Sender: TObject);
begin
   dtProposta.Date := now;
end;

procedure TfmProposta.BitBtn3Click(Sender: TObject);
begin
    Operacao := 'i';
end;

procedure TfmProposta.gridColExit(Sender: TObject);
begin
  if (grid.SelectedIndex = 0) and (table.Fields[1].asString = '' ) then
     GetDadosProdutos(Sender, grid.SelectedField.AsString );

  if (grid.SelectedIndex in [2,3]) and (table.Modified )then
     table.FieldByName('total').AsString :=   FloatToStr( Table.fieldByName('Und').asFloat * TAble.fieldByName('Quant').asFloat );
end;

procedure TfmProposta.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if Key = #13 then
   if not (ActiveControl is TDBGrid) then
   begin
      Key := #0;
      Perform(WM_NEXTDLGCTL, 0, 0);
  end
  else if (ActiveControl is TDBGrid) then
     with TDBGrid(ActiveControl) do

  if selectedindex < (fieldcount -1) then
     selectedindex := selectedindex +1
  else
     selectedindex := 0;
end;

procedure TfmProposta.btDadosClienteClick(Sender: TObject);
var
   cmd:String;
begin
   cmd := ' Select top 01 cd_pes from dspes with(nolock) where nr_cpfcgc = ' +  f.preencheCampo(9,'0','e', f.SohNumeros(EdNrCGC.Text) )
        + ' and dg_cpfcgc  = ' +  f.preencheCampo(2,'0','e',  f.SohNumeros(edDgCGC.Text));

   cmd := dm.openSQL(cmd, '');

   if ( cmd <> '' ) then
      carregaDadosCliente(cmd)
   else
      msg.msgErro('Esse CPF/CNPJ não é cadastrado');
end;

procedure TfmProposta.TableAfterPost(DataSet: TDataSet);
begin
   sbar.Panels[0].Text := 'Quant de itens : ' + inttoStr(table.RecordCount);
   sbar.Panels[1].Text := dm.SomaColTable(Table,'Total', true);
end;

procedure TfmProposta.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = vk_delete) and ( table.Modified = false) then
      table.Delete;
end;

procedure TfmProposta.ImportaDadosPedido(Sender: TObject; numPedido: string);
var
   DadosCliente:Tstrings;
   qr:TADOQuery;
   cmd:String;
begin
   DadosCliente := dm.getValoresSQL2('Select nr_cpfcgc, nr_filCGC, dg_cpfcgc from dspes with(NoLock) inner join pedidoCliente with(nolock) on dspes.cd_pes = pedidoCliente.cd_pes where pedidoCliente.Numpedido = '+ numPedido);
   EdNrCGC.Text := f.preencheCampo(9,'0','e', dadosCliente[0]);
   edFilCPFCGC.text := f.preencheCampo(4,'0','e', dadosCliente[1]);
   edDgCGC.text := f.preencheCampo(2,'0','e', dadosCliente[2]);
   btDadosClienteClick(Sender);

   cmd:=
   (' Select crefe.cd_ref, crefe.Ds_ref, QuantPedido, ValorPrecoSugerido , ValorTotal, dspes.nm_fon '+
              ' from itensPedidoCliente with(noLock) '+
              ' inner join crefe with(NoLock) on itenspedidocliente.seqproduto = crefe.is_ref  ' +
              ' inner join dspes with(nolock) on itenspedidocliente.codVendedor = dspes.cd_pes ' +
              ' where NumPedido = ' + numPedido
             );

   dm.getQuery(qr, cmd);

   edVendedor.text := qr.fieldByName('nm_fon').AsString;
   while qr.Eof = false do
   begin
      table.AppendRecord([
                           qr.FieldByName('cd_ref').AsString,
                           qr.FieldByName('ds_ref').AsString,
                           qr.FieldByName('QuantPedido').asInteger,
                           qr.FieldByName('ValorPrecoSugerido').AsString,
                           qr.FieldByName('ValorTotal').AsString
                         ]);
      qr.Next;
   end;
   qr.free();
end;

function TfmProposta.montaRelatorio():Tstringlist;
var
   params :Tstringlist;
   dadosLoja:Tstrings;
   cmd:string;
   totProposta:real;
begin
   totProposta := dm.somaColunaTable(table, 'total');

   cmd := uLj.getStrDadosUO(fmMain.getUoLogada());

   dadosLoja := dm.GetValoresSQL2(cmd);
   params := TStringlist.Create();

{0}params.add(dadosLoja[01] );
   params.add(dadosLoja[02] );
   params.add(dadosLoja[03] );
   params.add(dadosLoja[00] );
   params.add(dadosLoja[04] );
{5}params.add(EdNrCGC.text + '/'+ edFilCPFCGC.text +'-'+ edDgCGC.TEXT );
   params.add(edNmCli.Text );
   params.add(edEnd.Text);
   params.add(edMsg.Text );
   params.add(fmMain.getNomeLojaLogada()  );
{0}params.add(fmMain.getNomeUsuario());
   params.add(edFmPag.Text);
   params.add(edVendedor.Text);

   if ( dtProposta <> nil) then
{3}   params.add(fdt.dataPorExtenso(dtProposta.Date))
   else
      params.add('');

{4}params.add(edValidade.Text );
   params.add(extenso.getExtenso(totProposta) ); //15
{6}params.add(f.floatToStrFomatado(totProposta, false)); //16
{7}params.add( fmMain.getStrLogoEmpresa() {fmMain.converterJPegParaBmp(dm.getParamBD('comum.ArqLogoPadrao', '')) });
   dadosLoja.Free();

   result := params;
end;

procedure TfmProposta.edNovaClick(Sender: TObject);
begin
   Application.CreateForm(TfmNovaProposta, fmNovaProposta);
   fmNovaProposta.showModal
end;

procedure TfmProposta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmProposta := nil;
   Action := caFree;
end;

procedure TfmProposta.edEmailClick(Sender: TObject);
var
  arq:String;
  body:Tstringlist;
begin
   if table.IsEmpty = false then
   begin
      body := TStringList.Create();
      body.Add('proposta enviada pela loja ' );
      body.Add(fmMain.StatusBar1.Panels[0].Text);
      body.Add('Gerada em: ' + dateTimeToStr(now) );
      arq :=  f.getDirLogs() + 'Proposta_' + fmMain.StatusBar1.Panels[0].Text +'_'+ f.SohNumeros( dateToStr(now) ) + '.pdf';

      fmMain.impressaoRavePDF(Table, nil, 'rpProposta',  montaRelatorio(), arq );

      fmMain.enviarEmail('', 'Assunto - proposta ' +arq , arq, body, 'Enviando e-mail para cliente...' );

      if ( msg.msgQuestion('Deseja guardar uma cópia ?') = mrYes ) then
         fmMain.enviarEmail(dm.getEmail(fmMain.getUoLogada()), 'Assunto - proposta ' +arq , arq, body, 'Enviando copia do email  para a loja.. ');
      DeleteFile(arq);
   end;
end;

procedure TfmProposta.gridDblClick(Sender: TObject);
begin
   table.Delete;
end;
             
procedure TfmProposta.btImpClick(Sender: TObject);
begin
   if table.IsEmpty = false then
      fmMain.imprimeRave(Table, nil, nil, nil, nil, 'rpProposta', montaRelatorio() );
end;



end.
