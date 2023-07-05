unit Unit3;

interface

uses
  f, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, ComCtrls, ADODB, DB, Menus,
  SoftDBGrid, adLabelNumericEdit, adLabelDBNumericEdit, DBCtrls,
  adLabelDBLookupComboBox, Mask, adLabelDBEdit, adLabelEdit, ExtCtrls,
  TFlatButtonUnit,  adLabelDBComboBox, adLabelComboBox, RpCon,
  RpConDS, RpSystem, fCtrls,  adLabelSpinEdit;

type
  TForm3 = class(TForm)
    MainMenu3: TMainMenu;
    Abrirumalista1: TMenuItem;
    Imprimirumalista1: TMenuItem;
    Panel1: TPanel;
    edNmNoiva: TadLabelEdit;
    edNmNoivo: TadLabelEdit;
    Panel2: TPanel;
    DBEdit1: TadLabelDBEdit;
    DBEdit2: TadLabelDBEdit;
    DBEdit3: TadLabelDBEdit;
    Bevel1: TBevel;
    Panel3: TPanel;
    lbNumLista: TLabel;
    DsProdutos: TDataSource;
    dbeditnum: TadLabelDBEdit;
    btIncluir: TFlatButton;
    btAltera: TFlatButton;
    btComprador: TFlatButton;
    btExclui: TFlatButton;
    BitBtn1: TFlatButton;
    btCancela: TFlatButton;
    PdQuery: TADOQuery;
    DBLCBox: TadLabelDBLookupComboBox;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    DBGrid1: TSoftDBGrid;
    DBEdit7: TadLabelDBEdit;
    Label2: TLabel;
    PopupMenu1: TPopupMenu;
    GerarGuiadeentrega1: TMenuItem;
    lbComprados: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lbTotalComprado: TLabel;
    Label9: TLabel;
    lbdtEvento: TLabel;
    edCodProd: TadLabelEdit;
    Devolveramercadoria1: TMenuItem;
    Baixaavulsa1: TMenuItem;
    lbNumCli: TLabel;
    btVoltar: TfsBitBtn;
    edDesc: TadLabelSpinEdit;
    edPcProduto: TadLabelNumericEdit;
    FlatButton1: TFlatButton;
    lbtotaisTitulo: TLabel;
    lbTotaisLista: TLabel;
    cbIsEntrega: TfsCheckBox;
    Verdatadaentrega1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Abrirumalista1Click(Sender: TObject);
    procedure edNmNoivaEnter(Sender: TObject);
    procedure Carregalista(num:String);
    procedure BitBtn1Click(Sender: TObject);
    procedure btIncluirClick(Sender: TObject);
    procedure btCompradorClick(Sender: TObject);
    procedure btCancelaClick(Sender: TObject);
    procedure btExcluiClick(Sender: TObject);
    function  ErroAoIncluirLista(Sender:Tobject):string;
    procedure Imprimirumalista1Click(Sender: TObject);
    procedure btAlteraClick(Sender: TObject);
    procedure PdQueryBeforeClose(DataSet: TDataSet);
    procedure DBEdit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GerarGuiadeentrega1Click(Sender: TObject);
    procedure CarregarResumoLista(numLista:string);
    procedure DBEdit1Change(Sender: TObject);
    procedure GetDadosProduto();
    procedure DBGrid1TitleClick(Column: TColumn);
    function ehProdutoDevolvido():Boolean;
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ConexaoWellWillExecute(Connection: TADOConnection; var CommandText: WideString; var CursorType: TCursorType;   var LockType: TADOLockType; var CommandType: TCommandType;      var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;      const Command: _Command; const Recordset: _Recordset);
    procedure ConexaoWellExecuteComplete(Connection: TADOConnection;  RecordsAffected: Integer; const Error: Error; var EventStatus: TEventStatus; const Command: _Command;      const Recordset: _Recordset);
    procedure Baixaavulsa1Click(Sender: TObject);
    procedure preparaParaBaixaAvulsa(Sender:Tobject);
    procedure fecharLista();
    procedure incluirProduto(Sender:Tobject);
    procedure incluirProdutoAvulso(Sender:Tobject);
    procedure geraGuiaListaNormal();
    procedure btVoltarClick(Sender: TObject);
    procedure chamaCarregamentoDeLista(num:String);
    procedure FlatButton1Click(Sender: TObject);

    function getParamscomanda():TStringlist;

    procedure impGuiaEntMatricial(qr: TADOQuery; params:TStringList);
    procedure Verdatadaentrega1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  mostraCampoDesc, EHCOMPRA:boolean;

implementation
uses Unit1, Unit4, Unit5, uBaixaAvulsa, msg, uDm, uProduto;

{}
{$R *.dfm}

procedure TForm3.getDadosProduto();
var
  qr:TdataSet;
  dmP:Tdm;

  cod, uo:String;
begin
   Application.CreateForm(Tdm, dmP);
   dmP.closeConnection();

   dmP.openConnection( f.getdirExe() + 'protheus.ini');
   dmP.loadCommandsBD(f.getdirExe() + 'cmdListas.dll');

   qr := dmP.getDataSetQ( dm.getQtCMD1('PRD', 'getCodProtheus', edCodProd.Text) );

   if (qr.IsEmpty = true) then
      msg.msgErro('Não cadastrado...')
   else
   begin
      cod := trim(qr.fieldByName('B1_COD').AsString);
      uo := fmMain.getParamBD('codFiltotvs', fmMain.RParReg('loja') );
      qr.Free();
      qr := dmP.getDataSetQ( dmP.getQtCMD2('PRD', 'getDadosProtheus', uo , cod));

      if (qr.IsEmpty = true) then
         msg.msgErro('Não cadastrado...')
      else
      begin
         dbEdit1.Text := qr.fieldByName('B1_COD').AsString;
         dbEdit2.Text := qr.fieldByName('B1_DESC').AsString;
         edPcProduto.text := qr.fieldByName('DA1_PRCVEN').AsString;

         if qr.fieldByName('DA1_PRCVEN').AsFloat = 0 then
           msg.msgErro('Este produto não tem preço.');
         qr.free();
      end;
   end;
   dmP.closeConnection();
   dmP.Free();
end;

function TForm3.ErroAoIncluirLista(Sender:Tobject): string;
var
  str:string;
begin
  if length(dbedit2.text) < 4 then
     str := str + '   - Falta a descrição.  '+ #13;

  if dblcbox.Text  = '' then
     str := str + '   - Escolha o tipo do item.  '+ #13;

  if (EhCompra = true) and ( fmMain.rParReg('IpServerWell') <> '')   then
  begin
     if (dbedit3.text = '') then
        str := str + '   - Falta o nome do comprador.  '+ #13;

     if (length( edCodProd.Text) < 7) then
        str := str + '   - É obrigatório informar o código da loja para o produto.  '+ #13;

     if  ( edPcProduto.Value < 1 )  then
         str := str + '   - Informe o valor do produto'+ #13;

  end;
  if str <> '' then
     ErroAoIncluirLista := ' Alguns campos estão errados ou incompletos, verifique:    '+#13 + str;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := Cafree;
   fmMain.mostraMenu(sender);
end;

procedure TForm3.ToolButton1Click(Sender: TObject);
begin
showmessage('');
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
   form3.Menu := mainmenu3;
   form3.Caption := ' Produtos das listas ';
   mostraCampoDesc := false;
end;


procedure TForm3.Abrirumalista1Click(Sender: TObject);
begin
   fecharLista();
   fmMain.AbreFormPesquisa(sender, 1); {1 é abrir lista}
end;

procedure TForm3.edNmNoivaEnter(Sender: TObject);
begin
   btVoltar.SetFocus
end;

procedure TForm3.Carregalista(num: string);
var
   cmd:String;
   nItensAvulsos:String;
   ds:TdataSet;
begin
   nItensAvulsos := fmMain.GetParamBD('numItensListaAvulsa','99');

   ds:= dm.getDataSetQ('Select noiva, noivo, loja , dataCasamento, codWell, dataCasamento, ehModelo from listas where numLista = ' + num);

// se for lista a vulsa carrega os  ultimos 50 itens se nao carrega a lista.   
   if (form3.tag = 0) then
       cmd :=(' Exec ListaProdDeUmaLista_02 ' + quotedstr(num) )
   else
       cmd :=(' select top '+ nItensAvulsos +' * from produtos (nolock) where numlista = ' + quotedstr(num) + ' and ljBaixa = ' + fmMain.RParReg('loja') + ' order by ref desc ' );


   dm.getQuery(pdquery, cmd);
   dsprodutos.DataSet := PdQuery;

   fmMain.sb.Panels[0].text := inttoStr(pdquery.RecordCount) + ' Item(s).';
   edNmNoiva.text := ds.FieldByname('noiva').AsString;
   edNmNoivo.text := ds.FieldByname('noivo').AsString;
   label2.caption := ds.FieldByname('loja').AsString;
   lbNumCli.Caption := ds.FieldByname('codWell').AsString;

   dbeditnum.DataField := 'NumLista';
   dbedit1.DataField := 'codigo';
   dbedit2.DataField := 'nomeProduto';
   dbedit3.DataField := 'convidado';

   dbedit7.DataField := 'obsItem';

   DBLCBox.DataField := 'tipo';
   adotable1.Active := true;
   panel1.visible:= true;
   lbNumLista.caption := num;
   panel3.visible:= true;

   fmMain.LerColunasDbgrid('form3',dbgrid1);

  if fmMain.EhlistaDaloja(label2.caption,false) = false then
  begin
     btIncluir.Enabled := false;
     btExclui.Enabled := false;
     btAltera.Enabled := false;
  end
  else
  begin
     btIncluir.Enabled := true;
     btExclui.Enabled := true;
     btAltera.Enabled := true;
  end;

  CarregarResumoLista(num);

   lbdtEvento.Visible := false;
   if ds.FieldByName('dataCasamento').AsString <> '' then
   begin
      lbdtevento.Caption := ds.FieldValues['dataCasamento'];
      if ds.FieldValues['dataCasamento'] < now then
         lbdtevento.Font.Color := clREd
      else
         lbdtevento.Font.Color := clBlack;
      lbdtEvento.Visible := true;
   end;

   DBGrid1.Columns[3].Visible := ( fmMain.GetParamBD('CampoDesconto', fmMain.RParReg('Loja') ) = '1' );

   dbgrid1.Visible := true;

   ds.Destroy();
end;

procedure TForm3.BitBtn1Click(Sender: TObject);
begin
   if ErroAoIncluirLista(Sender) = '' then
   begin
      if (EHCOMPRA = true) then
      begin
         if (edDesc.Value <> 0 ) then
            PdQuery.FieldByName('isPromocao').AsString := '1'
         else
            PdQuery.FieldByName('isPromocao').AsString := '0';

         PdQuery.FieldByName('ljBaixa').AsString := fmMain.RParReg('loja');
         PdQuery.FieldByName('dtCompra').AsString := DateToStr(now);
         PdQuery.FieldByName('desconto').AsString := edDesc.Text;
         PdQuery.FieldByName('valor').AsFloat := edPcProduto.Value;

         //ajusta os dados da entrega do caminhão
         uProduto.ajustaEntCaminhao(cbIsEntrega.Checked, PdQuery.fieldByName('ref').AsString);

      end;
      pdQuery.Post;
      carregarResumoLista(lbNumLista.Caption);
      btCancelaClick(Sender);
   end
   else
      msg.msgErro( ErroAoIncluirLista(Nil) );
end;

procedure TForm3.btCompradorClick(Sender: TObject);
var
  isJaBaixado:boolean;
begin
   if (fmMain.RParReg('Loja') <> '00') or (fmMain.RParReg('Loja') <> '0') then
   begin
      isJaBaixado := true;
      if length(dbedit3.text) > 3 then
         if msg.msgQuestion(' Já existe comprador para esse produto. '+ #13 + '    Deseja alterar o item ou incluir outro comprador?  ') = mrNo then
            isJaBaixado := false;

      if isJaBaixado = true then
      begin
         EhCompra := true;
         PdQuery.Edit;
         panel2.visible := true;
         panel3.visible := false;
         bitbtn1.Visible := true;
         btCancela.Visible := true;
         dbedit3.Enabled:= true;

         edCodProd.SetFocus;
         dbgrid1.enabled:= false;
         dbedit1.Text := '';
         dbedit2.Enabled:= false;
         edPcProduto.Enabled:= true;
         dblcbox.Enabled := false;
         edDesc.Visible := ( fmMain.GetParamBD('CampoDesconto', fmMain.RParReg('Loja') ) = '1' );
      end;
   end
   else
      msg.msgErro('Essa loja não pode registrar compras');
end;

procedure TForm3.btCancelaClick(Sender: TObject);
begin
   EhCompra:= false;
   pdquery.Cancel;
   panel2.visible := false;
   panel3.visible := true;
   bitbtn1.Visible := false;
   btCancela.Visible := false;

   dbgrid1.enabled:=true;
   dbedit1.Enabled:= true;
   dbedit2.Enabled:= true;
   edPcProduto.Enabled:= true;
   dblcbox.Enabled := true;

   dbedit3.Enabled := false;
   edDesc.Text := '0';
end;

procedure TForm3.btExcluiClick(Sender: TObject);
var
   usrAut:String;
   canRemove:boolean;
begin
   canRemove := (PdQuery.IsEmpty = false);

   if (canRemove = true) then
      if length(dbedit3.text) > 3 then
         if msg.msgquestion(' Já existe comprador para esse produto. '+ #13 +
                                ' Produtos comprados não podem ser excluídos sem autorização do gerente.'+#13+
                                ' Deseja excluir mesmo?') = mrYes then
   if (fmMain.getAutorizadorWell(fmMain.GetParamBD('gruposAutorizadores','99'), '' ) = '') then
      canRemove := false;

   if ( canRemove = true) then 
   pdquery.Delete;
end;

procedure TForm3.Imprimirumalista1Click(Sender: TObject);
begin
   fecharLista();
   fmMain.AbreFormPesquisa(sender, 2); //2 é imprime lista
end;

procedure TForm3.btAlteraClick(Sender: TObject);
var
  PodeEditar:boolean;
begin
   PodeEditar := true;
   if (length(dbedit3.Text) > 3) and (msg.msgQuestion(inttoStr(length(dbedit3.Text))+ ' Ja existe comprador para esse produto. '+ #13 + '    Deseja alterar o item ?  ') = mrNo )then
     PodeEditar := false;

   if (uProduto.isEntregue(PdQuery.fieldByName('ref').AsString) = true ) then
   begin
      msg.msgErro( dm.getMsg('err.prdEntregue') );
      PodeEditar := false;
   end;


   if (PodeEditar = true) then
   begin
      PdQuery.Edit;
      panel2.visible := true;
      panel3.visible := false;
      bitbtn1.Visible := true;
      btCancela.Visible := true;
      dbedit2.SetFocus;
      dbgrid1.enabled:= false;
      dbedit3.Enabled := false;
   end;
end;

procedure TForm3.PdQueryBeforeClose(DataSet: TDataSet);
begin
   dbgrid1.Visible := false;
end;

procedure TForm3.DBEdit1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
var
  pode:boolean;
  nomeProduto:string;
begin
   nomeproduto := '';
   if key = VK_Return then
   begin
      Pode := true;
      if fmMain.RParReg('IpServerWell') = '' then
         Pode := false
      else
      begin
         if (dbedit2.text <> '') and ( EhCompra = true ) and  ( fmMain.RParReg('IpServerWell') = '' )  then
            if msg.msgQuestion('Você já informou o produto. '+#13+' Deseja mudar a descrição para a descricao do Well???') = MrNo then
               Pode := false;
         if Pode = true then
            GetDadosProduto();
      end;
   end;
end;

procedure TForm3.CarregarResumoLista(numLista:string);
var
  itensPromo, itensComprados: integer;
  totalPromo, totalComprado:real;
begin
   itensComprados := 0;
   totalComprado := 0;

   itensPromo := 0 ;
   totalPromo := 0 ;

   pdQuery.First;
   while not(pdQuery.Eof) do
   begin
      if( pdQuery.fieldByName('valor').asFloat <> 0) and  ( pdQuery.fieldByName('ljbaixa').asString <> '') then
      begin
         if (pdQuery.fieldByName('isPromocao').AsString = '0') then
         begin
            inc(itensComprados);
            totalComprado := totalComprado + pdQuery.fieldByName('valor').asfloat;
         end
         else
         begin
            inc(itensPromo);
            totalPromo := totalPromo + pdQuery.fieldByName('valor').asfloat;
         end;
      end;
        pdQuery.Next;
   end;

   lbComprados.Caption := f.preencheCampo(03,'0','e', inttostr(itensComprados));

   lbTotalComprado.Caption := floattostrf( totalComprado ,ffNumber,18,2);

   lbTotaisLista.Caption :=
   f.preencheCampo(03,'0','e', inttostr(itensComprados + itensPromo)) + ' - '+
   floattostrf( totalComprado + totalPromo ,ffNumber,18,2);

   // atualizar o cadastro da lista
   fmMain.atualizaDadosItensLista(intToStr( pdQuery.RecordCount),  intToStr(itensComprados ),  f.ValorSql( floattostr(totalComprado) ) , numlista );
   pdQuery.First;
end;


procedure TForm3.DBEdit1Change(Sender: TObject);
begin
   edcodprod.Text := dbedit1.Text;
end;


procedure TForm3.DBGrid1TitleClick(Column: TColumn);
begin
   dm.organizarQuery(pdQuery, DBGrid1, column);
end;

function TForm3.ehProdutoDevolvido: Boolean;
begin
  if dm.openSQL('Select ref from devolucoes where ref = '+ PdQuery.fieldByName('ref').asString, 'ref') = '' then
     result := false
  else
     result := true;
end;

procedure TForm3.PopupMenu1Popup(Sender: TObject);
var
   i:integer;
   active:boolean;
begin
   if PdQuery.FieldByName('ljBaixa').asString <> '' then
       active :=true;
    for i:=0 to PopupMenu1.Items.Count-1 do
       PopupMenu1.Items[i].Enabled := active
end;

procedure TForm3.ConexaoWellWillExecute(Connection: TADOConnection;  var CommandText: WideString; var CursorType: TCursorType;  var LockType: TADOLockType; var CommandType: TCommandType;  var ExecuteOptions: TExecuteOptions; var EventStatus: TEventStatus;  const Command: _Command; const Recordset: _Recordset);
begin
   screen.cursor := crHourGlass;
   f.gravaLog(CommandText);
end;

procedure TForm3.ConexaoWellExecuteComplete(Connection: TADOConnection; RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
   screen.cursor := crDefault;
end;
procedure TForm3.fecharLista();
begin
   edNmNoiva.Text:='';
   edNmNoivo.Text:='';
   panel1.Visible  := false;
   panel2.Visible := false;
   panel3.Visible := false;
   PdQuery.Close();
   adotable1.Close();
   DBGrid1.Visible := false;
end;

procedure TForm3.preparaParaBaixaAvulsa(Sender: Tobject);
var
  nListaAvulsa:String;
begin
   fecharLista();
   nListaAvulsa := dm.openSQL( 'Select valor from configuracoes where loja = '''' and param = ''NumeroDaListaAvulsa'' ', 'valor');
   form3.tag := 1;
   Carregalista(nListaAvulsa);
   btIncluir.Enabled := true;
   btAltera.Enabled := false;
   btComprador.Enabled := false;
   form3.tag := 1;
   cbIsEntrega.Checked := true;
end;

procedure TForm3.incluirProdutoAvulso(Sender:Tobject);
begin
   Application.CreateForm(TfmBaixaAvulsa, fmBaixaAvulsa);
   fmBaixaAvulsa.show;
end;

procedure TForm3.incluirProduto(Sender:Tobject);
begin
   pdquery.Append;
   pdquery.Fields[0].AsString := lbNumLista.Caption;
   dbedit3.text := ' ';
   panel2.visible := true;
   panel3.visible := false;
   bitbtn1.Visible := true;
   btCancela.Visible := true;
   edCodProd.SetFocus;
   dbedit1.Text:= '';
   dbgrid1.enabled:= false;
end;


procedure TForm3.btIncluirClick(Sender: TObject);
begin
   case form3.Tag of
     0:incluirProduto(nil);
     1:incluirProdutoAvulso(nil);
   end;
end;
procedure TForm3.Baixaavulsa1Click(Sender: TObject);
begin
   preparaParaBaixaAvulsa(nil);
end;

function TForm3.getParamscomanda: TStringlist;
var
  params:TStringList;
begin
   params := TStringList.Create();
   Params.add( fmMain.RParReg('ArqLogo')  );
   Params.add( fmMain.GetParamBD('horarioTrocas',  fmMain.RParReg('loja'))   );
   Params.add( fmMain.GetParamBD('horarioTrocas',  fmMain.RParReg('loja'))   );
   Params.add( fmMain.RParReg('titRel') );
   result := params;
end;


procedure TForm3.impGuiaEntMatricial(qr: TADOQuery; params:TStringList);
var
  arq:TStringlist;
  titulo2, titulo, titulo3:String;
  i,j,numLinhas:integer;
begin
  arq:= TStringList.Create();
  titulo := UpperCase(fmMain.RParReg('titRel'));
  titulo := f.preencheCampo(110, ' ', 'D', titulo);

  titulo2 := f.preencheCampo(110, ' ', 'D','CONTROLE DE ENTREGA');


  arq.Add('  '+ titulo + 'CONTROLE:' +  qr.fieldByName('ref').asString);
  arq.Add('  '+ titulo2 +   'LISTA:' +  qr.fieldByName('numLista').asString);


  titulo3 :=  f.preencheCampo(110, ' ', 'D', 'GUIA GERADA EM: ' + dm.getDataHoraBD );

  arq.Add('  '+ titulo3 +'LOJA:' + qr.fieldByName('ljBaixa').asString     );
  arq.Add('--------------------------------------------------------[ DADOS DA ENTREGA ]---------------------------------------------------------');
  arq.Add(' ');
  arq.add('  ITEM: (' + pdQuery.fieldByName('codigo').asString +') - '+ pdQuery.fieldByName('NomeProduto').asString);
  arq.Add('  CONVIDADO: ' + qr.fieldByName('convidado').asString + '                  DATA DO EVENTO: ' +  qr.fieldByName('dataCasamento').asString           );
  arq.add('  PARA: ' + qr.fieldByName('noiva').asString  + '   NOIVO: ' + qr.fieldByName('noivo').asString );
  arq.add('  ENDERECO DE ENTREGA: ' + qr.fieldByName('endEntrega').asString + ' '+ qr.fieldByName('bairro').asString );
  arq.add('  REFERENCIA: ' + qr.fieldByName('endReferencia').asString + ' FONE: '+ qr.fieldByName('foneRes').asString );
  arq.add('  OBSERVACAO ITEM: ' + qr.fieldByName('ObsItem').asString );
  arq.add('  ');
  arq.add('  ');
  arq.add('  _______________________________       ___________________________________             _________________________________________');
  arq.add('       Recebedor do presente                       Data e Hora                                            Assinatura');
  arq.add('  ');
  arq.add('   Para sua comodidade, as trocas de presentes serão feitas, preferencialmente, de segunda a sexta de 09:00h até 18:00h');
  arq.add('  ');
  arq.Add('-------------------------------------------------------------------------------------------------------------------------------------');
  arq.add('  ');
  arq.add('  ');

  numLinhas := arq.Count;

  // criar a segunda e terceira via

  for j:= 1 to 2 do
     for i:=0 to numLinhas-1 do
        arq.add(arq[i]);


   titulo := f.getDirLogs() + 'EspelhoEntrega.txt';

   arq.SaveToFile(titulo);

   f.imprimeArquivoPorta(titulo,  fmMain.RParReg('PortaImp'));
end;

procedure TForm3.geraGuiaListaNormal();
var
  qr:TADOQuery;
begin
   dm.getQuery( qr, 'Exec stoComandaEntregaDeProduto '+ pdQuery.fieldByName('ref').AsString + ' , '+  intTostr(form3.Tag) );

   if ( fmMain.getPerfilImp() = 'D' ) then
      fmMain.imprimeRave(qr, nil, nil, 'ComandaDeEntrega', getParamscomanda())
   else
      impGuiaEntMatricial(qr, getParamscomanda());

   qr.free();
end;

procedure TForm3.GerarGuiadeentrega1Click(Sender: TObject);
begin
   geraGuiaListaNormal()
end;

procedure TForm3.btVoltarClick(Sender: TObject);
begin
   fmMain.SalvaColDbgrid('form3',dbgrid1);
   form3.close;
end;

procedure TForm3.chamaCarregamentoDeLista(num: String);
begin
   if dm.openSQL('Select gerouCredito from listas where numLista = ' + num, 'gerouCredito')  <> '' then
      msg.msgErro('Essa lista já gerou crédito e não pode ser editada')
   else
      carregalista(num);
//   form4 := nil;   
end;


procedure TForm3.FlatButton1Click(Sender: TObject);
begin
   lbtotaisTitulo.Visible := not (lbtotaisTitulo.Visible);
   lbTotaisLista.Visible := not(lbTotaisLista.Visible);
end;


procedure TForm3.Verdatadaentrega1Click(Sender: TObject);
var
   ds:TdataSet;
   cmd:String;
begin
   ds:= uProduto.getDadosEntProduto( PdQuery.fieldBYName('ref').AsString);

   if ds.IsEmpty = true then
      msg.msgErro('Esse item não foi encaminhado para entrega.')
   else
   begin
      cmd := dm.getCMD('MSG', 'DadoEnt');
      dm.setParams(cmd, ds.fieldByName('dtcompra').AsString, ds.fieldByName('ljBaixa').AsString, ds.fieldByName('dtSaida').AsString );
      dm.setParams(cmd, ds.fieldByName('recebedor').AsString, ds.fieldByName('dtEntrega').AsString, ds.fieldByName('entregador').AsString );

      msg.msgExclamation(cmd);
   end;
end;

end.


