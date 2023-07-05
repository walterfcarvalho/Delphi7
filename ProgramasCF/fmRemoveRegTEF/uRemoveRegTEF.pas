unit uRemoveRegTEF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, SoftDBGrid, DB, ADODB, ComCtrls,
  adLabelDBDateTimePicker, StdCtrls, adLabelComboBox, TFlatButtonUnit,
  fCtrls, Menus, adLabelEdit, adLabelNumericEdit;

type
  TfmRemRegTEF = class(TForm)
    cbLojas: TadLabelComboBox;
    DataSource1: TDataSource;
    grid: TSoftDBGrid;
    Label1: TLabel;
    btConsulta: TFlatButton;
    tb: TADOTable;
    dt: TfsDateTimePicker;
    PopupMenu1: TPopupMenu;
    Alteramodalidadedepagamento1: TMenuItem;
    GroupBox1: TGroupBox;
    cbModalidade: TadLabelComboBox;
    RemoveregistrodeTEF1: TMenuItem;
    Inseremodalidadepagamento1: TMenuItem;
    RemoveModalidaDedePagamento1: TMenuItem;
    edBusca: TadLabelNumericEdit;
    ConsultaroMAC1: TMenuItem;
    EF1: TMenuItem;
    ConsultaMACdeoperaoTEFcomNU1: TMenuItem;
    cbCaixas: TadLabelComboBox;
    FlatButton1: TFlatButton;
    procedure FormCreate(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridTitleClick(Column: TColumn);
    procedure Alteramodalidadedepagamento1Click(Sender: TObject);
    procedure alteraModalidadeDePagamento();
    procedure filtrarTable();
    procedure ajustacolunas();
    procedure RemoveregistrodeTEF1Click(Sender: TObject);
    procedure Inseremodalidadepagamento1Click(Sender: TObject);
    procedure chamaInsereModalidadePagamento1Click(Sender: TObject);
    procedure chamaRemoveRegistroDeTEF1Click(Sender: TObject);
    procedure removerModalidadePagamento();
    procedure RemoveModalidaDedePagamento1Click(Sender: TObject);
    procedure removeRegistroTEF();
    procedure edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cbLojasClick(Sender: TObject);
    procedure gridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ConsultaroMAC1Click(Sender: TObject);
    procedure ConsultaMACdeoperaoTEFcomNU1Click(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmRemRegTEF: TfmRemRegTEF;
  isAcessoRestrito:boolean;
implementation


{$R *.dfm}
uses uMain, f, uCF, uAlteraModalidadePagto, cf, uDm, uLj, msg, uCaixa, uModPag;


procedure TfmRemRegTEF.FormCreate(Sender: TObject);
begin
   tb.Connection := dm.con;

   f.carregaCampos(fmRemRegTEF);

   uLj.getListaLojas(cbLojas, false, false, fmMain.getCdPesLogado(), fmMain.getUoLogada() );

   cbCaixas.Items := uCaixa.getDescCaixas( f.getCodUO(cbLojas), true, false);

   dt.Date := now;

   isAcessoRestrito := fmMain.isGrupoRestrito(fmMain.DeletarRegistrodecartoTEF1.tag);

   cbModalidade.items := uModPag.getCodModPag(true, isAcessoRestrito);

   fmRemRegTEF.Caption := fmMain.getCaptionNivelAcesso(fmRemRegTEF.Caption, isAcessoRestrito);
end;

procedure TfmRemRegTEF.ajustaColunas;
var
   i:smallInt;
begin
   for i:=0 to grid.Columns.Count-1 do
      grid.Columns[i].Visible := false;

   grid.Columns[ tb.FieldByName('descEstacao').Index ].visible := true;
   grid.Columns[ tb.FieldByName('descEstacao').Index ].Title.Caption := 'Caixa';

   grid.Columns[ tb.FieldByName('ds_mveReal').Index ].visible := true;
   grid.Columns[ tb.FieldByName('ds_mveReal').Index ].Title.Caption := 'Modalidade';

   grid.Columns[ tb.FieldByName('valor').Index ].visible := true;
   grid.Columns[ tb.FieldByName('valor').Index ].Title.Caption := 'Valor';

   grid.Columns[ tb.FieldByName('numParcelas').Index ].visible := true;
   grid.Columns[ tb.FieldByName('numParcelas').Index ].Title.Caption := 'Parcelas';

   grid.Columns[ tb.FieldByName('seqTransacaoCaixa').Index ].visible := true;
   grid.Columns[ tb.FieldByName('seqTransacaoCaixa').Index ].Title.Caption := 'Transacao do caixa';


   f.ajGridCol(grid, tb, 'is_oper', 50, 'Operação integrada' );
{}
end;


procedure TfmRemRegTEF.btConsultaClick(Sender: TObject);
begin
// preenche a combo com as modalidades de pagamento
// sp preencher uma vez

   if (cbModalidade.Items.Count = 0) then
   begin
      cbModalidade.items :=  uModPag.getCodModPag(true, isAcessoRestrito);
      cbModalidade.ItemIndex := -1;
   end;

   uCaixa.listaRecebimentosCaixa( tb, f.getCodUO(cbLojas), '', dt, dt, false, true, false, false);

   tb.Close();
   tb.Open();
   ajustaColunas();
   filtrarTable();

   f.gravaLog(tb, 'tb');
end;

procedure TfmRemRegTEF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if (fmRemRegTEF <> nil) then
   begin
      edBusca.Value := 0;
      f.salvaCampos(fmRemRegTEF);
      action := caFree;
      fmRemRegTEF := nil;
   end;
end;

procedure TfmRemRegTEF.gridTitleClick(Column: TColumn);
begin
   dm.organizarTabela(tb, grid, Column);
end;

procedure TfmRemRegTEF.alteraModalidadeDePagamento;
var
   seqModalidade, valor, descMod, codMod, nParcelas:String;
   descModAnt, nParcelasAnt, valorAnt:String;
begin
   edbusca.Value := 0;

   application.CreateForm(TfmAlteraModPagto, fmAlteraModPagto);
   fmAlteraModPagto.ShowModal();
   if  (fmAlteraModPagto.ModalResult = mrOk) then
   begin
      descModAnt := tb.fieldByName('ds_mveReal').AsString;
      nParcelasAnt := tb.fieldByName('numParcelas').AsString;
      valorAnt := tb.fieldByName('valor').AsString;

      codMod := f.getCodModPagto( fmAlteraModPagto.cbModalidades );
      descMod := f.getNomeModPagto( fmAlteraModPagto.cbModalidades);
      nParcelas := fmAlteraModPagto.edNumParcelas.Text;
      valor := fmAlteraModPagto.edValor.Text;

      tb.Edit();
      tb.FieldByName('ds_mveReal').AsString := descMod;
      tb.FieldByName('numParcelas').AsString := nParcelas;
      tb.FieldByName('valor').AsString := valor;
      tb.Post();

      seqModalidade :=
      uCF.alterarModPagamento( tb.FieldByName('codLoja').AsString,
                               tb.FieldByName('seqtransacaoCaixa').AsString,
                               tb.FieldByName('SeqModPagtoPorTransCaixa').AsString,
                               codMod,
                               valor,
                               nParcelas,
                               tb.FieldByName('seqTefTransCaixa').AsString,
                               tb.FieldByName('dataSessaoCaixa').asString,
                             );
      if (seqModalidade <> '') then
      begin
         uModPag.gravaLogModalidades( tb.FieldByName('codLoja').AsString,
                                  tb.FieldByName('descEstacao').AsString,
                                  fmMain.getCdPesLogado(),
                                  tb.FieldByName('seqtransacaoCaixa').AsString,
                                  'A',
                                  tb.FieldByName('cd_mveReal').AsString,
                                  tb.FieldByName('numParcelas').AsString,
                                  codMod,
                                  nParcelas,
                                  valorAnt,
                                  valor,
                                  seqModalidade
                                );
         msg.msgExclamation('Dados alterados, para ver a alteração gere o dia novamente! ');
      end
      else
         msg.msgErro('Problemas ao alterar a modalidade de pagamento.');
   end;
end;

procedure TfmRemRegTEF.AlteraModalidadeDePagamento1Click(Sender: TObject);
begin
   if  (tb.TableName <> '') then
      alteraModalidadeDePagamento();
end;

procedure TfmRemRegTEF.filtrarTable();
var
  aux:String;
begin
   aux := '';
   if (tb.TableName <> '') then
   begin
      if (cbCaixas.ItemIndex > 0) then
         aux := ' descEstacao = ' + quotedStr(f.getNomeDoCx(cbCaixas));

      if (cbModalidade.itemIndex > 0) then
         if (aux <> '') then
            aux := aux + ' and cd_mve = ' + quotedStr(f.getCodModPagto(cbModalidade))
         else
            aux := ' cd_mveReal = ' + quotedStr(f.getCodModPagto(cbModalidade));

      if (edBusca.value > 0) then
         if (aux <> '') then
            aux := aux + ' and valor = ' + f.valorSql(edBusca.Text)
         else
            aux := ' valor = ' + f.valorSql(edBusca.Text)
   end;
   f.gravaLog('filtro: ' + aux);
   tb.Close();
   tb.Filter := (aux);
   tb.Filtered := true;
   tb.Open();
   ajustaColunas();
end;

procedure TfmRemRegTEF.removeRegistroDeTEF1Click(Sender: TObject);
var
   cmd:String;
begin
   if (tb.FieldByName('seqTefTransCaixa').AsString <> '0') then
   begin
      if (uCF.removeRegistroTef( tb.FieldByName('seqTefTransCaixa').AsString ) = true) then
      begin
         cmd := 'Remoção/TEF data: ' + tb.FieldByName('dataSessaoCaixa').asString +
                ' SeqModPagtoPorTransCaixa: '+ tb.FieldByName('SeqModPagtoPorTransCaixa').AsString ;
         ucf.logAlteracoesBD(fmRemRegTEF.Name, fmMain.getNomeUsuario(), cmd);
         msg.msgExclamation(' Registro TEF removido')
      end;
   end
   else
      msg.msgErro('  Sem Registro TEF associado a esse pagamento.');
end;

procedure TfmRemRegTEF.InsereModalidadePagamento1Click(Sender: TObject);
var
   seqModalidade, valor, descMod, codMod, nParcelas:String;
   cmd:String;
begin
   application.CreateForm(TfmAlteraModPagto, fmAlteraModPagto);
   fmAlteraModPagto.ShowModal();
   if  (fmAlteraModPagto.ModalResult = mrOk) then
   begin
      codMod := f.getCodModPagto( fmAlteraModPagto.cbModalidades );
      descMod := f.getNomeModPagto( fmAlteraModPagto.cbModalidades);
      nParcelas := fmAlteraModPagto.edNumParcelas.Text;
      valor := fmAlteraModPagto.edValor.Text;

      seqModalidade :=
      uCF.insereModPagamento( tb.FieldByName('codLoja').AsString,
                              tb.FieldByName('seqtransacaoCaixa').AsString,
                              codMod,
                              valor,
                              nParcelas,
                              tb.FieldByName('dataSessaoCaixa').asString
                            );
      if (seqModalidade <> '' ) then
      begin
         uModPag.gravaLogModalidades( tb.FieldByName('codLoja').AsString,
                                  tb.FieldByName('descEstacao').AsString,
                                  fmMain.getCdPesLogado(),
                                  tb.FieldByName('seqtransacaoCaixa').AsString,
                                  'I',
                                  '',
                                  '',
                                  codMod,
                                  nParcelas,
                                  '0',
                                  valor, seqModalidade
                                  );
         msg.msgExclamation('Dados inseridos, para ver a alteração gere o dia novamente! ');
      end
      else
         msg.msgErro('Problemas ao alterar a modalidade de pagamento.');
   end;
end;

procedure TfmRemRegTEF.chamaInsereModalidadePagamento1Click(Sender: TObject);
begin
   if  (tb.TableName <> '') then
      InsereModalidadePagamento1Click(nil);
end;


procedure TfmRemRegTEF.removerModalidadePagamento;
var
   seqModalidade, valor, descMod, codMod, nParcelas:String;
   cmd, descModAnt, nParcelasAnt, valorAnt:String;
begin
   f.gravaLog('procedure TfmRemRegTEF.removerModalidadePagamento');

   edbusca.Value := 0;

   descModAnt := tb.fieldByName('ds_mveReal').AsString;
   nParcelasAnt := tb.fieldByName('numParcelas').AsString;
   valorAnt := tb.fieldByName('valor').AsString;

   codMod := tb.fieldByName('cd_mveReal').AsString;;
   descMod := tb.fieldByName('ds_mveReal').AsString;
   nParcelas := '0';
   valor := '000';


   tb.Edit();
   tb.FieldByName('ds_mveReal').AsString := descMod;
   tb.FieldByName('numParcelas').AsString := nParcelas;
   tb.FieldByName('valor').AsString := valor;
   tb.Post();

   seqModalidade :=
   uCF.alterarModPagamento( tb.FieldByName('codLoja').AsString,
                            tb.FieldByName('seqTransacaoCaixa').AsString,
                            tb.FieldByName('SeqModPagtoPorTransCaixa').AsString,
                            codMod,
                            valor,
                            nParcelas,
                            tb.FieldByName('seqTefTransCaixa').AsString,
                            tb.FieldByName('dataSessaoCaixa').asString,
                          );
   if (seqModalidade <> '') then
   begin
      uModPag.gravaLogModalidades( tb.FieldByName('codLoja').AsString,
                               tb.FieldByName('descEstacao').AsString,
                               fmMain.getCdPesLogado(),
                               tb.FieldByName('seqtransacaoCaixa').AsString,
                               'E',
                               tb.FieldByName('cd_mveReal').AsString,
                               tb.FieldByName('numParcelas').AsString,
                               '',
                               '',
                               valorAnt,
                               '0', seqModalidade);
      ucf.logAlteracoesBD(fmRemRegTEF.Name, fmMain.getNomeUsuario(), cmd);
      msg.msgExclamation('Dados excluidos! ');
   end
   else
      msg.msgErro('Problemas ao excluir a modalidade de pagamento.');
{  }
end;

procedure TfmRemRegTEF.RemoveModalidaDedePagamento1Click(Sender: TObject);
begin
   if  (tb.TableName <> '') then
      removerModalidadePagamento();
end;

procedure TfmRemRegTEF.removeRegistroTEF;
begin
   uCF.removeRegistroTef( tb.FieldByName('seqTefTransCaixa').AsString);
end;

procedure TfmRemRegTEF.chamaRemoveregistrodeTEF1Click(Sender: TObject);
begin
   if  (tb.IsEmpty = false) then
      if ( tb.FieldByName('tefMagnetico').AsString = '1') then
         removeRegistroDeTEF1Click(nil);
end;

procedure TfmRemRegTEF.edBuscaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if (key = VK_RETURN) then
      filtrarTable();
end;


procedure TfmRemRegTEF.cbLojasClick(Sender: TObject);
begin
   cbCaixas.Items := uCaixa.getDescCaixas( f.getCodUO(cbLojas) , true, false);
end;

procedure TfmRemRegTEF.gridDrawColumnCell(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
begin
//   gravaLog (Column.FieldName);
   if ( Column.FieldName = 'Valor') then
      if (tb.fieldByname('tpAlteracao').AsString <> '') then
      begin
         grid.Canvas.Font.Color:= clRed; // coloque aqui a cor desejada
         grid.Canvas.Font.Style := [fsBold];
         grid.DefaultDrawDataCell(Rect, grid.columns[ tb.fieldByname('valor').index].field, State);
      end;
end;

procedure TfmRemRegTEF.PopupMenu1Popup(Sender: TObject);
begin
    if  (tb.IsEmpty = false ) then
    begin
      if ( tb.FieldByName('tefMagnetico').AsString = '1') then
      begin
         ConsultaroMAC1.Enabled := true;
         RemoveregistrodeTEF1.Enabled := true;
         ef1.Enabled := true
      end
      else
      begin
         ConsultaroMAC1.Enabled := false;
         RemoveregistrodeTEF1.Enabled := false;
         ef1.Enabled := true
      end
   end;
end;

procedure TfmRemRegTEF.ConsultaroMAC1Click(Sender: TObject);
begin
   if (tb.IsEmpty = false) then
      uModPag.getMacOprTef(dt.Date, tb.fieldByName('seqTefTransCaixa').AsString, '');
end;

procedure TfmRemRegTEF.ConsultaMACdeoperaoTEFcomNU1Click(Sender: TObject);
var
  nsu:String;
begin
   nsu := msg.msgInput( dm.getCMD1('MSG', 'tef.m12', dateToStr(dt.Date)), '');
   if (nsu <> '') then
      uModPag.getMacOprTef(dt.Date, '', nsu);
end;

procedure TfmRemRegTEF.FlatButton1Click(Sender: TObject);
begin
	filtrarTable();
end;

end.
