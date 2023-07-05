unit uTabela;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, adLabelComboBox, adLabelEdit,
  TFlatButtonUnit, Grids, DBGrids, SoftDBGrid, ExtCtrls, DBClient,
  Provider, clipbrd, ComCtrls, AppEvnts, comObj, mxExport, TFlatCheckBoxUnit,
  TFlatComboBoxUnit, mxOneInstance, RpBase, RpSystem, RpRave,
  RpDefine, RpCon, RpConDS, Buttons, fCtrls, Menus;

type
  TfmTabela = class(TForm)
    dbgrid: TSoftDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    btImprime: TFlatButton;
    cbTpImp: TadLabelComboBox;
    FlatButton3: TFlatButton;
    EdLocalImp: TadLabelEdit;
    Label1: TLabel;
    Label2: TLabel;
    lbTotal1: TLabel;
    lbTotal2: TLabel;
    pnTitulo: TPanel;
    edCodigo: TadLabelEdit;
    cbPreco01: TadLabelComboBox;
    cbPreco02: TadLabelComboBox;
    cbLoja: TadLabelComboBox;
    rgTpestoque: TadLabelComboBox;
    edDescricao: TadLabelEdit;
    cbItens: TRadioGroup;
    cbOrder: TFlatCheckBox;
    cbTotaliza: TFlatCheckBox;
    pnCategoria: TPanel;
    lbNivel: TLabel;
    lbVlCat: TLabel;
    lbClasse1: TLabel;
    lbClasse2: TLabel;
    lbClasse3: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    btGetCategorias: TFlatButton;
    FlatButton1: TFlatButton;
    Animate: TAnimate;
    pnPesqItem: TPanel;
    btOk: TfsBitBtn;
    btCancela: TfsBitBtn;
    cbContaEstoque: TadLabelComboBox;
    tb: TADOTable;
    tbImg: TADOTable;
    PopupMenu1: TPopupMenu;
    pmInsereItens: TMenuItem;
    SalvarTabela1: TMenuItem;
    CarregarTabela1: TMenuItem;
    procedure FlatButton1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbItensClick(Sender: TObject);
    procedure MontarRelatorioImpressao();
    procedure btImprimeClick(Sender: TObject);
    procedure dbgridCellClick(Column: TColumn);
    procedure PesquisaCodigos(sender:tobject);
    procedure cbTpImpChange(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure cbTotalizaClick(Sender: TObject);
    procedure CalculaTotais(Sender:Tobject);
    procedure dbgridTitleClick(Column: TColumn);
    procedure FormCreate(Sender: TObject);
    procedure btGetCategoriasClick(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btCancelaClick(Sender: TObject);

    procedure expTbImagens();
    procedure FormShow(Sender: TObject);
    procedure dbgridDblClick(Sender: TObject);
    procedure pmInsereItensClick(Sender: TObject);
    procedure insereItensNaTable();
    procedure SalvarTabela1Click(Sender: TObject);
    procedure salvarTabela(nmTb:String);
    procedure CarregarTabela1Click(Sender: TObject);
    procedure formataGrid();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTabela: TfmTabela;

implementation

uses uDm, uMain, cf, uLj, f, msg, uPreco, uTbPreco, uProd;

{$R *.dfm}
procedure tfmTabela.PesquisaCodigos(sender:tobject);
begin
   SCREEN.CURSOR := crhourglass;
   fmMain.MsgStatus('');
   animate.Visible:= true;
   Animate.Active:= true;

 	uPreco.getTbPreco(
   	tb,
   	cbItens.ItemIndex,
   	rgTpestoque.ItemIndex,
   	edDescricao.text,
   	trim(edCodigo.Text),
   	getCodUO(cbLoja),
   	getCodPc(cbPreco01),
   	getCodPc(cbPreco02),
   	lbNivel.caption,
   	lbVlCat.caption,
      cbContaEstoque.itemindex
   );

	formataGrid();

   SCREEN.CURSOR := crDefault;
//  fmMain.Conexao.CommandTimeout := 30;

   animate.Visible:= false;
   Animate.Active:= false;

end;

procedure TfmTabela.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = vk_f7 then
      FlatButton1Click(Sender);
end;

procedure TfmTabela.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   edCodigo.Text := '';
   salvaCampos(fmTabela);
   Action := Cafree;
   fmTabela := nil;
end;

procedure TfmTabela.cbItensClick(Sender: TObject);
begin
   if cbItens.ItemIndex >0 then
   begin
      edDescricao.Visible := true;
      edDescricao.SetFocus;
   end
   else
   begin
      edDescricao.Visible := false;
      edCodigo.SetFocus;
   end;
end;

procedure TfmTabela.montarRelatorioImpressao(); //sender:tobject);
var
   params, dest:TstringList;
   linha:string;
   l,Fl:integer;
   codForn:string;
   nLinPorPagina:integer;
begin
   dest:=  TStringList.create();
   Fl := 0; l := 0;

   nLinPorPagina := 50;

   dbgrid.visible := false;
   tb.First;
   while tb.Eof = false do
   begin
      inc(fl);
      Dest.Add('                          *** TABELA DE PRECOS  ***                                     FL:' + f.preencheCampo(03,'0','e',intToStr(fl)));
      Dest.Add('Loja: ' + copy(cbLoja.Items[cbLoja.itemindex],01,30) ) ;
      Dest.Add('Preco 01 : ' + copy(cbPreco01.items[cbPreco01.ItemIndex],01,30 )  +'   Preco 02 : ' + copy(cbPreco02.items[cbPreco02.ItemIndex],01,30 )  );
      Dest.Add('Codigo: ' + edCodigo.text);
      Dest.Add('------------------------------------------------------------------------------------------------');
      Dest.Add('CODIGO    DESCRICAO                                        ESTOQUE CAIXA  '+ copy(cbPreco01.items[cbPreco01.ItemIndex],01,10 )  +' '+ copy(cbPreco02.items[cbPreco02.ItemIndex],01,10) );
      Dest.Add('------------------------------------------------------------------------------------------------');
      Dest.Add('');

      while ( l < nLinPorPagina ) and ( tb.eof = false ) do
      begin
         if cbOrder.Checked = true then
            if codForn <> tb.fieldByname('cd_pes').AsString then
            begin
               dest.Add('');
               codForn := tb.fieldByname('cd_pes').AsString;
               inc(l);
               linha := 'Fornecedor :' + dm.getValorWell('O',' Select NM_FANTASI from dspes where cd_pes = ' + codForn, 'NM_FANTASI');
               dest.Add(linha );
            end;


         linha :=
            f.preencheCampo(10,' ', 'd', tb.fieldByname('codigo').Asstring) +
            f.preencheCampo(45,' ', 'd', copy(tb.fieldByname('descricao').Asstring,01,45 )) +
            f.preencheCampo(10,' ', 'e', tb.fieldByname('estoqueatual').Asstring)+
            f.preencheCampo(02,' ', 'e', ' ' ) +
            f.preencheCampo(06,' ', 'e', tb.fieldByname('QT_EMB').Asstring) +
            f.preencheCampo(12,' ', 'e', floattostrf(tb.fieldByname('preco 01').AsFloat,ffNumber,18,2)) +
            f.preencheCampo(12,' ', 'e', floattostrf(tb.fieldByname('preco 02').AsFloat,ffNumber,18,2));


         begin
            inc(l);
            dest.Add(linha );
         end;
         tb.next;
      end;
      if ( tb.eof = false ) then
      begin
         Dest.Add( '');
         Dest.Add('------------------------------------------------------------------------------------------------');
         Dest.Add('');
         l:=0
      end
      else
      begin
         while ( l < nLinPorPagina ) do
         begin
            Dest.Add('');
            inc(l);
         end;
      Dest.Add('------------------------------------------------------------------------------------------------');
      Dest.Add('                                                                             Por Walter Carvalho');
      end;
   end;
   Dest.SaveToFile( ExtractFilePath(ParamStr(0)) + '\Tabela.tmp');
   tb.First;

   dbgrid.visible := true;

   if cbtpImp.ItemIndex = 1 then
   begin
      linha :=  pchar('cmd.exe /c print /d:'+ EdLocalImp.Text +' '+ExtractFilePath(ParamStr(0)) + 'Tabela.tmp' );
      if Application.MessageBox('  Prepare a impressora imprimir.....    Confirma a impressão ?        ','', mb_iconquestion+mb_yesno) = mrYes then
         WinExec(pchar(linha),sw_normal);

   end
   else
   begin
      params := TStringList.Create();
      {0}params.Add( fmMain.getDescPreco(cbPreco01) );
      {1}params.Add( fmMain.getDescPreco(cbPreco02) );
      {2}params.Add(trim( edCodigo.text));
      {3}params.Add( cbContaEstoque.Items[cbContaEstoque.Itemindex]);
      {4}params.Add( fmMain.getDescUO(cbLoja) );
      fmMain.imprimeRave( tb, nil, nil, nil, nil, 'rpTabela', params );
   end;
end;


procedure TfmTabela.btImprimeClick(Sender: TObject);
begin
   if (tb.IsEmpty = false) then
      montarRelatorioImpressao();
end;


procedure TfmTabela.dbgridCellClick(Column: TColumn);
begin
   clipboard.AsText := tb.FieldByName('codigo').AsString;
end;

procedure TfmTabela.cbTpImpChange(Sender: TObject);
begin
   case  cbTpImp.ItemIndex of
      0,2: EdLocalImp.Visible := false
   else
     EdLocalImp.Visible := true;
   end;
end;


procedure TfmTabela.Timer1Timer(Sender: TObject);
begin
   if animate.Active = true then
      fmTabela.Refresh;
end;


procedure TfmTabela.FlatButton1Click(Sender: TObject);
begin
   if length(edCodigo.Text) >= 3 then
      PesquisaCodigos(sender)
   else
      if (msg.msgQuestion('Deseja mesmo gerar de todos os fornecedores ?')= mrYes) then
         PesquisaCodigos(sender)
end;


procedure TfmTabela.edCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key = vk_Return then
      FlatButton1Click(Sender)
end;

procedure TfmTabela.CalculaTotais(Sender: Tobject);
var
  t1,t2:real;
begin
   if (tb.IsEmpty = false)   then
   begin
      dbgrid.Visible := false;
      tb.First;
      if cbTotaliza.Checked = true then
      begin
         t1:=0;
         t2:=0;
         while tb.Eof = false do
         begin
            t1:= t1 + tb.fieldByname('Preco 01').asFloat * tb.fieldByname('estoqueAtual').asFloat ;
            t2:= t2 + tb.fieldByname('Preco 02').asFloat * tb.fieldByname('estoqueAtual').asFloat;
            tb.Next;
         end;
         lbTotal1.Caption := FloatToStrF( t1,ffnumber,18,02);
         lbTotal2.Caption := FloatToStrF( t2,ffnumber,18,02);
       end;
       dbgrid.Visible := true;
   end;
end;

procedure TfmTabela.cbTotalizaClick(Sender: TObject);
begin
  if (cbTotaliza.Checked = true) then
     calculaTotais(Sender);
end;
procedure TfmTabela.dbgridTitleClick(Column: TColumn);
begin
   screen.Cursor := crhourglass;
   dm.organizarTabela(tb, dbGrid, column);
   screen.Cursor := crDefault;
end;


procedure TfmTabela.FormCreate(Sender: TObject);
begin
   cbpreco01.Items := uPreco.getListaPrecos(  fmMain.isAcessoTotal(fmMain.abeladePreos2.Tag), true, true, fmMain.getGrupoLogado() );
   cbPreco02.Items := cbPreco01.Items;
   uLj.getListaLojas(cbLoja, false, false, '', fmMain.getUoLogada());

   f.carregaCampos(Self);

   dbgrid.Align := alClient;
   tb.Connection:= dm.con;
   tbImg.Connection:= dm.con;

   if (fmMain.isAcessoTotal(fmMain.abeladePreos2.Tag) = true ) then
   begin
   	dbgrid.PopupMenu := PopupMenu1;
  end;
end;

procedure TfmTabela.btGetCategoriasClick(Sender: TObject);
begin
   fmMain.ajustaValoresCategorias(lbClasse1, lbClasse2, lbClasse3, lbNivel, lbVlCat);
end;

procedure TfmTabela.btOkClick(Sender: TObject);
begin
   if (tb.IsEmpty = false) then
      self.ModalResult := mrOk
   else
     self.ModalResult := mrCancel;
end;

procedure TfmTabela.btCancelaClick(Sender: TObject);
begin
   fmTabela.ModalResult := mrCancel;
   fmTabela.Close();
end;

procedure TfmTabela.expTbImagens();
var
   arq:String;
   params:TStringlist;

begin
   params := TStringList.Create();
   params.add( uLj.getNomeUO(cbLoja) );
   params.add( f.getNomePc(cbContaEstoque) );
   params.add( f.getNomePc(cbPreco01) );


   arq:= f.getDirLogs() +'Tabela_' + f.getNomeDoMicro()+'.pdf';

   uTbPreco.getTbPcImagens(tb, tbImg);

   fmMain.impressaoRavePDF(tbImg, nil, 'rpTbImg', params, arq);

   fmMain.enviarEmail( '', 'Tabela com imagens.', arq, nil, 'Tabela de preços com imagens');

   params.free();
end;

procedure TfmTabela.FormShow(Sender: TObject);
begin
   cbPreco01.ItemIndex := 0;
   cbPreco02.ItemIndex := 0;
   cbLoja.ItemIndex := 0;
   cbTpImp.ItemIndex :=0;
   cbTpImpChange(nil);
end;

procedure TfmTabela.dbgridDblClick(Sender: TObject);
begin
	f.salvaColunasDbGrid(dbgrid, tb);
end;

procedure TfmTabela.FlatButton3Click(Sender: TObject);
begin
   if (tb.IsEmpty = false) then
   begin
      case fmMain.getTpImpressao() of
         0:fmMain.exportaDataSet(tb, nil);
         1:expTbImagens();
      end;
   end;
end;

procedure TfmTabela.insereItensNaTable();
var
  cd_ref:String;
  i:integer;
  ds, dsPc2, dsPc1:tdataset;
  nivel, codCat:String;
begin
    nivel := lbNivel.Caption;
    codCat := lbVlCat.Caption;

    ds := uProd.getIsrefPorFaixaCodigo(cd_ref, nivel, codCat, f.getCodUO(cbLoja), false, true);

    ds.First();
    while ds.Eof = false do
    begin
      dspc1 := uProd.getDadosProd(f.getCodUO(cbLoja), '', ds.fieldByName('is_Ref').asString, f.getCodPc(cbPreco01), false);
      dsPc2 := uProd.getDadosProd(f.getCodUO(cbLoja), '', ds.fieldByName('is_Ref').asString, f.getCodPc(cbPreco02), false);

      tb.Append();
      tb.FieldByName('codigo').Assign(dsPc1.FieldByName('codigo'));
      tb.FieldByName('descricao').Assign(dsPc1.FieldByName('descricao'));
      tb.FieldByName('qt_emb').Assign(dsPc1.FieldByName('embalagem'));
      tb.FieldByName('estoqueAtual').Assign(dsPc1.FieldByName('estoque'));
      tb.FieldByName('preco 01').Assign(dsPc1.FieldByName('preco'));
      tb.FieldByName('preco 02').Assign(dsPc2.FieldByName('preco'));
      tb.FieldByName('cd_pes').Assign(dsPc1.FieldByName('fornecedor'));
      tb.FieldByName('is_ref').Assign(dsPc1.FieldByName('is_ref'));
      tb.Post();
      ds.Next();

      dsPc2.Free();
      dsPc1.Free();

   end;
   ds.Free();
end;

procedure TfmTabela.pmInsereItensClick(Sender: TObject);
begin
	if (tb.IsEmpty = false) then
		insereItensNaTable();
end;


procedure TfmTabela.SalvarTabela1Click(Sender: TObject);
var
	nmTb:String;
begin
	if (tb.IsEmpty = false) then
   begin
	  	nmtb:= f.dialogSalvaArq(f.getDirExe(), 'tbPc', '' );

      if (nmTb <> '') then
			salvarTabela(nmTb);
	end;
end;

procedure TfmTabela.salvarTabela(nmTb:String);
begin
   tb.SaveToFile(nmTb);
end;

procedure TfmTabela.CarregarTabela1Click(Sender: TObject);
var
	nmTb:String;
begin
	nmTb := f.dialogAbrArq('tbPc', f.getDirExe());
   if (nmTb<> '') then
   begin
   	tb.LoadFromFile(nmTb);
		formataGrid();
   end;
end;

procedure TfmTabela.formataGrid();
begin
   cbTotalizaClick(nil);

   edCodigo.SetFocus;
   cbpreco01.SetFocus;
   edCodigo.SetFocus;

   f.ajGridCol(dbgrid, tb, 'codigo', 70, 'Código');
   f.ajGridCol(dbgrid, tb, 'descricao', 450, 'Descrição');
   f.ajGridCol(dbgrid, tb, 'qt_emb', 60, 'Embalagem');
   f.ajGridCol(dbgrid, tb, 'estoqueAtual', 67, 'Estoque');
   f.ajGridCol(dbgrid, tb, 'Preco 01', 100, f.getNomePc(cbPreco01));
   f.ajGridCol(dbgrid, tb, 'Preco 02', 100, f.getNomePc(cbPreco02));
   f.ajGridCol(dbgrid, tb, 'cd_pes', 0, '');
   f.ajGridCol(dbgrid, tb, 'is_ref', 0, '');
   f.ajGridCol(dbgrid, tb, 'nm_pes', 0, '');
   f.ajGridCol(dbgrid, tb, 'seq', 0, '');



   if (tb.IsEmpty = false) then
      if tb.RecordCount = 1 then
          fmMain.MsgStatus( inttostr(tb.RecordCount) + ' Item')
      else
          fmMain.MsgStatus(inttostr(tb.RecordCount) + ' Itens');

end;

end.
                                            o
