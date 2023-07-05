unit Uprecoswell;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, adLabelEdit, adLabelNumericEdit, StdCtrls, TFlatEditUnit,
  DBCtrls, Mask, adLabelDBEdit, DB, ADODB, ComCtrls,
  adLabelDBDateTimePicker, Grids, DBGrids, Clipbrd, adLabelDBComboBox,
  adLabelComboBox, TFlatGaugeUnit, Menus, TFlatButtonUnit,  CheckLst,
  adLabelCheckListBox, fCtrls, ExtCtrls,
  SoftDBGrid, TFlatCheckBoxUnit, ToolWin;

type
  TfmLancaPc = class(TForm)
    Panel1: TPanel;
    clbPc01: TadLabelCheckListBox;
    clbPc02: TadLabelCheckListBox;
    clbPc03: TadLabelCheckListBox;
    tb: TADOtable;
    DataSource1: TDataSource;
    grid: TSoftDBGrid;
    Bevel1: TBevel;
    FlatButton1: TFlatButton;
    dti: TfsDateTimePicker;
    Label1: TLabel;
    dtf: TfsDateTimePicker;
    Button2: TButton;
    Button1: TButton;
    cbDtExpPreco: TFlatCheckBox;
    Panel2: TPanel;
    gb01: TfsGroupBox;
    cbPc01: TadLabelComboBox;
    gb02: TfsGroupBox;
    edVlMrg02: TadLabelEdit;
    gb03: TfsGroupBox;
    edVlMrg03: TadLabelEdit;
    cbLoja: TadLabelComboBox;
    btNovo: TFlatButton;
    btImp: TFlatButton;
    btExporta: TFlatButton;
    edPcNovo: TadLabelNumericEdit;
    edDesc: TadLabelEdit;
    edCodigo: TadLabelEdit;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    cbArredonda: TfsCheckBox;
    cbPcFuturo: TfsCheckBox;
    ToolButton8: TToolButton;

    function getCodigoPreco():String;
    function AjustaPreco(valor,percentual:string;arredondar:boolean):string;
    function getLojasDeumPreco(itens: TadLabelCheckListBox):String;
    procedure addItemReajuste(cod, des, pcAtual :String; pc01:real;  is_ref, custo: string);
    procedure btExportaClick(Sender: TObject);
    procedure btImpClick(Sender: TObject);
    procedure btNovoClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CarregaListaLojas(sender:tobject);
    procedure cbDtExpPrecoClick(Sender: TObject);
    procedure cbPc01Change(Sender: TObject);
    procedure chamaLancamentoDePrecos();
    procedure clbPc01Click(Sender: TObject);
    procedure clbPc02Click(Sender: TObject);
    procedure clbPc03Click(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edDescKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edPcNovoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure getDadosItens(uo, cd_ref, preco:String);
    procedure getPrecosDeUmaNota(isNota:String);
    procedure gridDblClick(Sender: TObject);
    procedure limpaCampos(sender:tobject);
    procedure LimparTabela();
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);

    procedure importaPrecoFromExcel(arq:String);

  private

  public
    { Public declarations }
  end;

var
  fmLancaPc: TfmLancaPc;
  DS:TdataSet;
implementation

uses umain, uPrecoPorPedido, uReajuste, uListaItensPorNota, uCF, cf, uDm,
     uEstoque, uFiscal, uLj, uPreco, fdt, f, msg, uLstPcAlt, uProd;

{$R *.dfm}


function TfmLancaPc.getCodigoPreco: String;
begin
   result := f.SohNumeros(copy(cbPc01.Items[cbpc01.ItemIndex],50,08) );
end;

procedure TfmLancaPc.LimparTabela();
begin
   while (tb.IsEmpty = false) do
      tb.delete;

   gb01.Enabled := true;
   gb02.Enabled := true;
   gb03.Enabled := true;
end;

procedure TfmLancaPc.limpaCampos(sender: tobject);
begin
   edCodigo.text:= '';
   edDesc.text:= '';
   edPcNovo.text:= '';
   clipboard.AsText :='';
   edCodigo.SetFocus;
end;

procedure TfmLancaPc.carregaListaLojas(sender:tobject);
begin
   uCF.carregaListarUosPorPreco( clbPc01, 'Pc01');
   uCF.carregaListarUosPorPreco( clbPc02, 'Pc02');
   uCF.carregaListarUosPorPreco( clbPc03, 'Pc03');
end;

procedure TfmLancaPc.FormCreate(Sender: TObject);
var
  pc01, pc02,pc03:String;
begin
   pc01 := dm.GetParamBD('fmPrecos.DescPc01', '');
   pc02 := dm.GetParamBD('fmPrecos.DescPc02', '');
   pc03 := dm.GetParamBD('fmPrecos.DescPc03', '');

   begin
      if (fmMain.getGrupoLogado() = '13')  then
      begin
         Button1.Visible := true;
         Button2.Visible := true;
      end;

      tb.Close;

      CarregaListaLojas(sender);

      clbPc01.LabelDefs.Caption := 'Lojas '+ pc01;
      clbPc02.LabelDefs.Caption := 'Lojas '+ pc02;
      clbPc03.LabelDefs.Caption := 'Lojas '+ pc03;

      edPcNovo.LabelDefs.caption := '&'+ pc01;
      edVlMrg02.LabelDefs.caption := 'Perc ';
      edVlMrg03.LabelDefs.caption := 'Perc ';

      gb01.Caption := 'Pco 01 - '+ pc01;
      gb02.Caption := 'Pco 02 - '+ pc02;
      gb03.Caption := 'Pco 03 - '+ pc03;

      cbPc01.Items :=  uPreco.getListaPrecos(false, false, false, fmMain.getGrupoLogado());

      uLj.getListaLojas(cbLoja, false, false, '', fmMain.getUoLogada());

      fmMain.getParametrosForm(fmLancaPc);

      dti.Date := (now)+1;
      dtf.Date := dti.Date +1;

      cbPc01.LabelDefs.Caption := '';
  end;
end;


procedure TfmLancaPc.getDadosItens(uo, cd_ref, preco:String);
begin
   DS:= uProd.getDadosProd( uo, cd_ref, '', preco, true);
   if  (ds.IsEmpty = false)   then
   begin
      edDesc.text := DS.fieldByName('Descricao').asString;
      edPcNovo.setfocus;
   end
   else
      limpaCampos(nil);
end;

procedure TfmLancaPc.edCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key = vk_return then
      getDadosItens( f.getCodUO(cbLoja), edCodigo.Text, fmMain.getCodPreco(cbPc01));
end;

function TfmLancaPc.AjustaPreco(valor, percentual:string;arredondar:boolean):string;
var
   aux1,aux2,aux3:real;
begin
   while pos('.',valor) > 0 do
      delete(valor,pos('.',valor),01);

   aux1 := Strtofloat(valor);
   aux2 := Strtofloat(percentual);
   aux3:=  (aux1 * aux2);
   valor := FloatTostr( aux3  );

   if (arredondar = true) then
      AjustaPreco :=  FloatToStrF( f.ArredondarPreco(aux3), ffFixed, 18, 02)
   else
      AjustaPreco :=  FloatToStrF( aux3, ffFixed, 18, 02);
end;

procedure TfmLancaPc.chamaLancamentoDePrecos();
var
   pcNormal, PcCe, PcPI, PcMa:string;
begin
   try
      pcCe := f.getCodUo(cbpc01);
      pcPi := f.getCodUo(cbpc01);
      pcMa := f.getCodUo(cbpc01);

      screen.Cursor := crhourglass;

      tb.First;

      uPreco.lancaNovoPc(tb, clbPc01, f.getCodPc(cbPc01), fmMain.getCdPesLogado(), 'PRECO 01', dti.Date, dtf.Date, cbDtExpPreco.Checked, cbPcFuturo.Checked);
      uPreco.lancaNovoPc(tb, clbPc02, f.getCodPc(cbPc01), fmMain.getCdPesLogado(), 'PRECO 02', dti.Date, dtf.Date, cbDtExpPreco.Checked, cbPcFuturo.Checked);
      uPreco.lancaNovoPc(tb, clbPc03, f.getCodPc(cbPc01), fmMain.getCdPesLogado(), 'PRECO 03', dti.Date, dtf.Date, cbDtExpPreco.Checked, cbPcFuturo.Checked);

      f.gravaLog('Terminei de gravar os precos..');

      limparTabela();
      btNovo.Enabled := true;
      screen.Cursor :=crdefault;
   except
      on e:Exception do
      begin
         msgErro('Erro de chave duplicada, vou avançar os contadores, tente novamente !');
      end;
   end;
end;

procedure TfmLancaPc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   limpaCampos(nil);
   f.salvaCampos(fmLancaPc);
   fmLancaPc := NIL;
   Action := CaFree;
end;

procedure TfmLancaPc.btImpClick(Sender: TObject);
var
   itens:tstringlist;
begin
   if (tb.TableName <> '') then
      if msg.msgQuestion('Após imprimir nao posso alterar, confirma?') = mrYes then
      begin
         itens := tstringlist.Create;
         itens.add(DateToStr(dti.Date));
         itens.add(fmMain.StatusBar1.Panels[1].Text);
         itens.add(Copy(cbLoja.Items[cbLoja.ItemIndex], 01, 30));
         itens.add(getLojasDeumPreco(clbPc01));
         itens.add(getLojasDeumPreco(clbPc02));
         itens.add(getLojasDeumPreco(clbPc03));

         fmMain.imprimeRave(Tb, nil, nil, nil, nil, 'rpPrecosAReajustar', itens);

         btNovo.Enabled := false;
         Bevel1.Enabled := false;
         grid.Enabled := false;
         itens.Free();
      end;
end;


procedure TfmLancaPc.clbPc01Click(Sender: TObject);
begin
   dm.setParamBD( 'fmPrecos.UosPc01', f.getCodUO(clbPc01),  BoolToStr(clbPc01.Checked[clbPc01.ItemIndex]) );
end;

procedure TfmLancaPc.clbPc02Click(Sender: TObject);
begin
   dm.setParamBD( 'fmPrecos.UosPc02', f.getCodUO(clbPc02),  BoolToStr(clbPc02.Checked[clbPc02.ItemIndex]) );
end;

procedure TfmLancaPc.clbPc03Click(Sender: TObject);
begin
   dm.setParamBD( 'fmPrecos.UosPc03', f.getCodUO(clbPc03),  BoolToStr(clbPc03.Checked[clbPc03.ItemIndex]) );
end;


procedure TfmLancaPc.FormShow(Sender: TObject);
var
   i:smallint;
begin
   if (tb.tableName  = '') then
   begin
      dm.getTable(tb, dm.getCMD('preco', 'getTbReajuste'));

      grid.Columns[0].Width := 70;
      grid.Columns[1].Width := 200;
      grid.Columns[2].Width := 100;
      for i:= 3 to grid.Columns.Count -1 do
         grid.Columns[i].Width := 120;

      // esconder a coluna de precos
      grid.Columns[grid.Columns.Count -2 ].Visible := false;

      for i:=0 to grid.Columns.Count -1 do
        grid.Columns[i].Title.Font.Style := [fsBold];
   end;
end;

procedure TfmLancaPc.addItemReajuste(cod, des, pcAtual:String; pc01:real; is_ref, custo: string);
var
   isCadastrado:boolean;
   pc02, pc03:Real;
begin
   f.gravaLog('addItemReajuste: ' + cod);

   isCadastrado := false;
   grid.Visible := false;
   tb.First;

   if Tb.Locate('is_ref', is_ref,[]) = true then
      isCadastrado := true;

   if (isCadastrado = false)then
   begin
      pc02 :=  uPreco.reajustaPc(pc01, strToFloat(edVlMrg02.text ));
      pc03 :=  uPreco.reajustaPc(pc01, strToFloat(edVlMrg03.text ));

      f.gravaLog(cod);

      if (cbArredonda.Checked = true ) then
      begin
         pc01 := f.arredondarPreco(pc01);
         pc02 := f.arredondarPreco(pc02);
         pc03 := f.arredondarPreco(pc03);
      end;

      tb.AppendRecord([cod, des, pcAtual, FloatToStrF(pc01, ffFixed, 18,02), FloatToStrF(pc02, ffFixed, 18,02), FloatToStrF(pc03, ffFixed,18, 02), is_ref, custo])
   end
   else
      msg.msgErro(' O item :  ' +Cod + ' '+ des +#13+ ' já foi adicionado !');

   tb.Last();
   grid.Visible := true;
end;


procedure TfmLancaPc.btNovoClick(Sender: TObject);
begin
   LimparTabela();
   grid.Enabled := true;
end;

procedure TfmLancaPc.edPcNovoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
    if (key = vk_return)  then
    begin
       addItemReajuste(
            edCodigo.text
          , edDesc.text
          , ds.fieldByname('Preco').asString
          , edPcNovo.Value
          , DS.FieldByName('is_ref').AsString
          , ''
       );

       limpaCampos(sender);
       ds.free();

       btNovo.Enabled := true;
       Bevel1.Enabled := true;
       grid.Enabled := true;
    end;

    if tb.IsEmpty = false then
    begin
       gb01.Enabled := false;
       gb02.Enabled := false;
       gb03.Enabled := false;
    end;
end;

procedure TfmLancaPc.gridDblClick(Sender: TObject);
begin
   tb.Delete;
end;

procedure TfmLancaPc.Button2Click(Sender: TObject);
var
  ds:TDataset;
  cmd:String;
begin
   cmd := msg.msgInput('Query, Obrigatorios campos CODIGO, PRECO');

   ds := dm.getDataSetQ(cmd);

   ds.First();
   while ds.Eof = false do
   begin
      tb.AppendRecord([
                            ds.FieldByName('codigo').AsString,
                            ds.FieldByName('DESCRICAO').AsString,
                            '0',
                            FloatToStr(ds.FieldByName('pc1').AsFloat) ,
                            FloatToStr(ds.FieldByName('pc2').AsFloat) ,
                            FloatToStr(ds.FieldByName('pc3').AsFloat) ,
                            ds.FieldByName('is_ref').AsString,
                            '0'
      ]);
      edCodigo.Text :=ds.FieldByName('is_ref').AsString;
      edPcNovo.Refresh;
      ds.Next;
   end;
   ds.Free();
   grid.Visible := true
end;


function TfmLancaPc.getLojasDeumPreco(itens: TadLabelCheckListBox): String;
var
  i:integer;
  aux:String;
begin
   for i := 0 to itens.Items.Count - 1 do
      if itens.Checked[i] = true then
         aux := Aux + trim(copy(itens.Items[i], 01, 20)) + ' , ';
   result := aux;
end;

procedure TfmLancaPc.btExportaClick(Sender: TObject);
begin
   Clipboard.AsText := '';

   Clipboard.AsText := 'CODIGO  DESCRICAO                                  PC ANTIGO    PC NOVO' + #13;
   tb.First();
   while (tb.Eof = false) do
   begin
      Clipboard.AsText := Clipboard.AsText +
      tb.fieldByname('codigo').AsString + ' ' +
      copy(tb.fieldByname('Descricao').AsString,01,40) + ' ' +
      f.preencheCampo(12,' ','D', floattostrf( tb.fieldByname('preco atual').asFloat ,ffNumber,18,2) ) + ' ' +
      f.preencheCampo(12,' ','D', floattostrf( tb.fieldByname('preco 01').asFloat ,ffNumber,18,2)  ) +#13;
      tb.Next();
   end;
   tb.First();
end;

procedure TfmLancaPc.cbDtExpPrecoClick(Sender: TObject);
begin
   dtf.Enabled := cbDtExpPreco.Checked;
end;


procedure TfmLancaPc.getPrecosDeUmaNota(isNota:String);
var
   preco:String;
   ds:TdataSet;
begin
   ds:= uFiscal.getItensNota(isNota);
   if ds.IsEmpty = false then
   begin
      ds.First;
      while ds.Eof = false do
      begin
         preco:= uPreco.getPcProd( f.getCodUO(cbLoja), ds.fieldByName('cd_ref').asString,  '', f.getCodPc(cbPc01) );

         addItemReajuste(
              ds.fieldByName('cd_ref').asString
            , ds.fieldByName('ds_ref').asString
            , uPreco.getPcProd( ds.fieldByName('is_estoque').asString, '', ds.fieldByName('is_ref').asString, f.getCodPc(cbPc01))
            , strToFloat(preco)
            , ds.fieldByName('is_ref').asString
            , '0'
         );
         ds.next();
      end;
      ds.free();
   end
end;


procedure TfmLancaPc.FlatButton1Click(Sender: TObject);
var
   erro:String;
begin
   erro:='';
   if (f.getCodPc(cbPc01) = '') then
      erro := erro + dm.getMsg('msgPcSemTipo');

   if (tb.IsEmpty = true) then
      erro := erro +  dm.getMsg('msgPcSemItens');

   if (cbDtExpPreco.Checked = true )then
      if (dtf.Date < dti.Date) then
         erro := dm.getMsg('tb_err_dt_exp');

   if (erro = '') then
   begin
      if ( msg.msgQuestion( dm.getMsg('msgPcConf')  ) = mrYes) then
         chamaLancamentoDePrecos();
   end
   else
      msg.msgErro (dm.getMsg('MSG_ERRO_TIT'));
end;


procedure TfmLancaPc.ToolButton1Click(Sender: TObject);
begin
   Application.CreateForm(TfmPcporPedido, fmPcporPedido);
   fmPcporPedido.Show;
end;

procedure TfmLancaPc.ToolButton3Click(Sender: TObject);
begin
   if (fmReajuste = nil) then
   begin
      Application.CreateForm(TfmReajuste, fmReajuste);
      fmReajuste.Show;
   end;
end;

procedure TfmLancaPc.ToolButton5Click(Sender: TObject);
var
   cmd:String;
begin
   cmd := uFiscal.getIsNota();
   if (cmd <> '') then
      getPrecosDeUmaNota(cmd);
end;

procedure TfmLancaPc.ToolButton7Click(Sender: TObject);
begin
   application.CreateForm(TfmLstPcAlt, fmLstPcAlt);
   fmLstPcAlt.Show();
end;

procedure TfmLancaPc.cbPc01Change(Sender: TObject);
begin
   if (tb.tableName <> '') then
   begin
     grid.Columns[tb.FieldByName('PRECO 01').Index].Title.Caption := f.getNomePc(cbPc01) + '(1)';
     grid.Columns[tb.FieldByName('PRECO 02').Index].Title.Caption := f.getNomePc(cbPc01) + '(2)';
     grid.Columns[tb.FieldByName('PRECO 03').Index].Title.Caption := f.getNomePc(cbPc01) + '(3)';
   end;
end;

procedure TfmLancaPc.edDescKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if (key = vk_return)  then
       edPcNovo.SetFocus();
end;

procedure TfmLancaPc.importaPrecoFromExcel(arq:String);
var
   key:word;
   Shift: TShiftState;
   tb:TADOTable;
begin
   try
      screen.Cursor := crHourGlass;

      grid.Visible := false;
      tb := TADOTable.Create(nil);
      tb.Connection := dm.con;
      tb.TableName := dm.getDsFromExcel(arq);
      tb.open();

      f.gravaLog(tb, '');

      key := VK_RETURN;
      tb.First();
      while(tb.Eof = false) do
      begin
         edCodigo.Text := trim(tb.fieldBYName('codigo').AsString);
         edPcNovo.Text := trim(tb.fieldBYName('preco').AsString);

         // consultar o item
         edCodigoKeyDown(nil, key, Shift );

         // incluir na grid de alterações
         edPcNovoKeyDown(nil, key, shift);

         tb.Next();
      end;
      grid.Visible := true;
   except
      grid.Visible := true;
   end;
   screen.Cursor := crDefault;
   tb.Free();
end;

procedure TfmLancaPc.ToolButton8Click(Sender: TObject);
var
   arq:String;
begin
   msg.msgWarning(dm.getMsg('ImportaPcXls'));
   arq:= f.dialogAbrArq('xls', 'c:\');
   if (arq <> '') then
      importaPrecoFromExcel(arq);
end;


end.



