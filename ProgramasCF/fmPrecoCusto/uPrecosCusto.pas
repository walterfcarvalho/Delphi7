unit uPrecosCusto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, DB, ADODB, Grids,
  DBGrids, SoftDBGrid, adLabelEdit, adLabelNumericEdit, TFlatButtonUnit,
  TFlatCheckBoxUnit, fCtrls, adLabelSpinEdit,  ExtCtrls, Buttons;

type
  TfmPrecoCustos = class(TForm)
    edCodigo: TadLabelEdit;
    query: TADOQuery;
    Grid: TSoftDBGrid;
    DataSource1: TDataSource;
    edPcNovo: TadLabelNumericEdit;
    btAjustaPreco: TFlatButton;
    btConsultaProduto: TFlatButton;
    cbCustoFiscal: TFlatCheckBox;
    cbCustoMedioUnico: TFlatCheckBox;
    cbLoja: TadLabelComboBox;
    memoItens: TMemo;
    Button1: TButton;
    Label1: TLabel;
    edNome: TadLabelEdit;
    GroupBox1: TGroupBox;
    FlatButton1: TFlatButton;
    edAjustaCusto: TadLabelSpinEdit;
    FlatButton2: TFlatButton;
    Label3: TLabel;
    fsBitBtn1: TfsBitBtn;
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure btAjustaPrecoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    function AjustaPreco(valor, percentual: string): string;
    procedure btConsultaProdutoClick(Sender: TObject);
    procedure cbCustoMedioUnicoClick(Sender: TObject);
    procedure ajustaPrecoCusto(is_ref:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Label1DblClick(Sender: TObject);
    procedure LimparMemo(var memo:Tmemo);
    procedure Label1Click(Sender: TObject);
    procedure custosPorNota(is_nota:String);
    procedure efetuaAjustDeNota(TipoAjuste:String);
    procedure recalcularCmuNota(isNota:String);
    procedure btRecalculaCMUItensNotaClick(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure cbAcertoRelativoClick(Sender: TObject);
    procedure acertaCustosItens();
    procedure fsBitBtn1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPrecoCustos: TfmPrecoCustos;

implementation

uses uMain, uCF, cf, uDm, uFiscal, uLj, uPreco, uEstoque, f, msg, uProd ;

{$R *.dfm}

function TfmPrecoCustos.AjustaPreco(valor, percentual: string): string;
var
   aux1,aux2,aux3:real;
begin
   while pos('.',valor) > 0 do
      delete(valor,pos('.',valor),01);

   aux1 := Strtofloat(valor);
   aux2 := Strtofloat(percentual);
   aux3:=  (aux1 * aux2);
   valor := FloatTostr( aux3  );
   AjustaPreco :=  FloatToStrF( aux3 ,ffFixed,18,02);
end;


procedure TfmPrecoCustos.btConsultaProdutoClick(Sender: TObject);
var
  ds:TdataSet;
  cmd:String;
begin
   ds:= uProd.getDadosProd(fmMain.getUoLogada(), edCodigo.Text, '', '101', true);

   if ( DS.IsEmpty = false ) then
   begin
      edNome.text := '';
      edNome.text :=  ds.fieldByName('codigo').AsString + ' ' + ds.fieldByName('descricao').AsString;

      cmd := dm.getCMD1('Preco', 'getCustosToAjuste', ds.fieldByName('is_ref').AsString );

      if (f.getCodUO(cbLoja) <> '999') then
        cmd := cmd + dm.getCMD3('Preco', 'getCustosToAjuste.uo', f.getCodUO(cbLoja), fmMain.getUOCD(), '' );

      cmd := cmd + dm.getCMD('Preco', 'getCustosToAjuste.order');

      dm.getQuery(query, cmd );

      f.ajGridCol(Grid, query, 'is_uo', -1, '');
      f.ajGridCol(Grid, query, 'ds_uo', 150, 'Loja');
      f.ajGridCol(Grid, query, 'VlCusto', 100, 'Custo fiscal');
      f.ajGridCol(Grid, query, 'VlCMU', 100, 'CMU');
      f.ajGridCol(Grid, query, 'VlAtacado', 100, 'Pc atacado');
      f.ajGridCol(Grid, query, '70% de VlAtacado', 100, '70% atacado');
   end;
   ds.free();
   edPcNovo.SetFocus;
end;

procedure TfmPrecoCustos.edCodigoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
   if key = VK_Return then
   begin
      btConsultaProdutoClick(SENDER);
   end;
end;

procedure TfmPrecoCustos.ajustaPrecoCusto(is_ref:String);
begin
   if (cbLoja.ItemIndex > 0) then
   begin
      if cbCustoFiscal.Checked = true then
         uPreco.setPrecoCusto( f.getCodUO(cbLoja), is_ref, 'custoUnitario', edPcNovo.Value, fmMain.getCdPesLogado(), '1');

      if cbCustoMedioUnico.Checked = true then
         uPreco.setPrecoCusto(f.getCodUO(cbLoja), is_ref, 'CustoMedioUnitarioUnico', edPcNovo.Value, fmMain.getCdPesLogado(), '5');
   end
   else
     msgErro(dm.getMsg('MSG_ERR_LJ'));
end;

procedure TfmPrecoCustos.FormActivate(Sender: TObject);
begin
   uLj.getListaLojas(cbLoja, true , false, '', fmMain.getUoLogada());
   edCodigo.SetFocus;
end;

procedure TfmPrecoCustos.cbCustoMedioUnicoClick(Sender: TObject);
begin
   if (query.IsEmpty = false) then
      if (cbCustoFiscal.Checked = false) and ( cbCustoMedioUnico.Checked= false )then
      begin
         msg.msgErro(dm.getMsg('errNumOpc'));
         cbCustoFiscal.Checked :=true;
      end;
end;

procedure TfmPrecoCustos.btAjustaPrecoClick(Sender: TObject);
var
   erro:string;
begin
   erro := '';
   if edPcNovo.Text = '0,00' then
      erro:= erro + 'Falta o valor'+ #13;

   if erro <> '' then
   begin
      erro :=  dm.getMsg('MSG_TIT') +#13+ erro;
      msg.msgErro(erro);
   end
   else
   begin
      ajustaPrecoCusto(query.fieldByName('is_ref').AsString);
   end;
   edNome.text := '';
   edCodigo.SetFocus;
end;


procedure TfmPrecoCustos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   memoItens.lines.clear();
   edNome.Text := '';
   edCodigo.Text := '';
   edPcNovo.Text := '';

   action := CaFree;
   fmPrecoCustos := nil;
end;

{
function getQuant(linha:String):String;
var
  posInicio:integer;
begin
  if Pos(' ', linha) > 0 then
    posInicio:= Pos(' ', linha)
  else
    posInicio:= 999;

  Result := '0'+trim(copy(linha, posInicio, 20));
end;
}


procedure TfmPrecoCustos.Label1DblClick(Sender: TObject);
begin
   memoItens.Lines.Clear;
end;

procedure TfmPrecoCustos.LimparMemo(var memo: Tmemo);
begin
   memo.Lines.Clear
end;

procedure TfmPrecoCustos.Label1Click(Sender: TObject);
begin
  LimparMemo( memoitens );
end;

procedure TfmPrecoCustos.acertaCustosItens;
var
   i:integer;
begin
  for i:=0 to memoItens.Lines.Count -1 do
  begin
     if  (f.extractCdref(memoItens.lines[i]) <> '') then
     begin
        edCodigo.Text := f.extractCdref(memoItens.lines[i]);

        btConsultaProdutoClick(nil);

        if (edNome.text <> '') then
        begin
           edPcNovo.Text := f.getQuant(memoItens.Lines[i]);
           btAjustaPrecoClick(nil);
        end;

     end;
  end;
end;


procedure TfmPrecoCustos.custosPorNota(is_nota:String);
var
  ds:TDataSEt;
  cmd: String;
  begin
   cmd := '/* pegando os custo fiscal dos itens de uma nota */ ' +#13+
          '  select p.cd_ref, dbo.z_cf_funObterPrecoProduto_CF(1, p.is_ref, i.is_estoque, 0) as custo ' +
          ' from dmovi i (nolock) inner join crefe p (nolock) on i.is_ref = p.is_ref  where i.is_nota = '  + is_nota;
   ds := dm.getDataSetQ(cmd);

   ds.First();
   while ds.Eof = false do
   begin
      edCodigo.Text := ds.fieldByName('cd_ref').AsString;
      btConsultaProdutoClick(nil);

      cmd := f.floatToMoney(ds.FieldByName('custo').AsFloat);
      if (edAjustaCusto.Value <> 0) then
         edPcNovo.Value :=  ds.FieldByName('custo').AsFloat + ds.FieldByName('custo').AsFloat * (edAjustaCusto.Value / 100)
      else
         edPcNovo.Value :=  ds.FieldByName('custo').AsFloat;

      btAjustaPrecoClick(nil);
      ds.Next();
   end;
   ds.free();
end;

procedure TfmPrecoCustos.recalcularCmuNota(isNota: String);
var
  ds:TdataSet;
begin
   showmessage('fazer de novo');
{   ds := uFiscal.getItensNota(isNota);

   cbCustoMedioUnico.Checked := true;
   cbCustoFiscal.Checked := false;

   while (ds.Eof = false) do
   begin
      edCodigo.Text := ds.fieldByName('cd_ref').asString;
      btConsultaProdutoClick(nil);
      edPcNovo.Text :=  uEstoque.recalcCMUItem(ds.fieldByName('is_ref').asString, now);
      edCodigo.SetFocus();
      btAjustaPrecoClick(nil);
      ds.Next();
   end;
}
end;


procedure TfmPrecoCustos.efetuaAjustDeNota(TipoAjuste: String);
var
  cmd:String;
begin
   cmd := '';
   cmd := uFiscal.getIsNota();
   if cmd <> '' then
   begin
      if (TipoAjuste = '1') then
         custosPorNota(cmd)
      else
         recalcularCmuNota(cmd);
   end;
end;


procedure TfmPrecoCustos.btRecalculaCMUItensNotaClick(Sender: TObject);
begin
// recalcular o CMU dos itens de uma nota.
   efetuaAjustDeNota('2');
end;

procedure TfmPrecoCustos.FlatButton1Click(Sender: TObject);
begin
   efetuaAjustDeNota('1');
end;

procedure TfmPrecoCustos.cbAcertoRelativoClick(Sender: TObject);
begin
//   rgTpAcerto.Visible := not(cbAcertoRelativo.Checked);
end;


procedure TfmPrecoCustos.fsBitBtn1Click(Sender: TObject);
begin
   acertaCustosItens();
end;

end.
