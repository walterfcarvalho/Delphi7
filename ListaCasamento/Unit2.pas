unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DB, ADODB, Mask, DBCtrls,
  adLabelDBEdit, adLabelComboBox, adLabelMaskEdit, adLabelListBox,
  ExtCtrls,  TFlatButtonUnit, SoftDBGrid, adLabelDBLookupComboBox, ComCtrls,
  adLabelDBDateTimePicker, adLabelDBComboBox, adLabelEdit, Menus,
  fCtrls;

type
  TForm2 = class(TForm)
    DataSource1: TDataSource;
    DBEdit1: TadLabelDBEdit;
    DBEdit2: TadLabelDBEdit;
    DBEdit5: TadLabelDBEdit;
    DBedit6: TadLabelDBEdit;
    DBedit7: TadLabelDBEdit;
    Dbedit8: TadLabelDBEdit;
    Dbedit11: TadLabelDBEdit;
    dbEdNumLista: TadLabelDBEdit;
    pnIncluiItens: TPanel;
    Lb1: TadLabelListBox;
    lb2: TadLabelListBox;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn3: TFlatButton;
    BitBtn4: TFlatButton;
    BitBtn5: TFlatButton;
    BitBtn6: TFlatButton;
    bitBtn1: TFlatButton;
    bitbtn2: TFlatButton;
    DBGrid1: TSoftDBGrid;
    dBDT1: TadLabelDBDateTimePicker;
    DBText1: TDBText;
    dbedit13: TadLabelDBEdit;
    PopupMenu1: TPopupMenu;
    Abrirestalista1: TMenuItem;
    ImprimirEstalista1: TMenuItem;
    cbTpLista: TadLabelComboBox;
    dbEdTpLista: TadLabelDBEdit;
    edCEP: TadLabelDBEdit;
    edCodWell: TadLabelDBEdit;
    Imprimirotermodeconcordncia1: TMenuItem;
    edCPF: TadLabelDBEdit;
    pnBusca: TPanel;
    cb1: TComboBox;
    edit1: TadLabelEdit;
    cbLojas: TadLabelComboBox;
    btBusca: TfsBitBtn;
    Adicionarpessoasrelacioandas1: TMenuItem;
    Incluirosprodutosnalista1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bitBtn1Click(Sender: TObject);
    function verificaPreenchimento():string;
    procedure desabilitaEdits(sender:tobject);
    procedure HabilitaEdits(sender:tobject);
    procedure BitBtn2Click(Sender: TObject);
    procedure buyytClick(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure chamaInclusaiDeItens();
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure Dbedit11Exit(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CarregaDadosdaslistas(sender:tobject);
    procedure cbLojasSelect(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Abrirestalista1Click(Sender: TObject);
    procedure ImprimirEstalista1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure imprimeTermo(nRelatorio,numLista: String);
    procedure dbEdNumListaEnter(Sender: TObject);
    procedure cbTpListaChange(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Imprimirotermodeconcordncia1Click(Sender: TObject);
    procedure btBuscaClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Adicionarpessoasrelacioandas1Click(Sender: TObject);
    procedure ajustaComboTipoLista();
    procedure abreJanelaInclusaoItens();
    procedure Incluirosprodutosnalista1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  Form2: TForm2;
  EHINCLUSAODELISTA:boolean;
  NUMERO_LISTA, TIPO_LISTA:string[10];
implementation

{$R *.dfm}
uses unit1, unit4, uPRelacionadas, uDm, msg, uLista, f;

procedure TForm2.abreJanelaInclusaoItens();
var
   ds:TdataSet;
begin
   ds:= dm.getDataSetQ('Select numLista from produtos where numLista = '+ NUMERO_LISTA);
   if (ds.RecordCount < 5) then
   begin
      ds:= dm.getDataSetQ('exec stoListaSugestao '+ TIPO_LISTA);
      while (ds.Eof = false) do
      begin
         lb1.Items.Add(' ' + trim(ds.Fields[0].AsString) + ' - '+  copy(ds.Fields[1].AsString, 01, 25) );
         ds.Next;
      end;
      pnIncluiItens.Visible := true;
   end
   else
      msg.msgErro('Os itens da lista já foram incluídos' +#13+
                      'Se quiser editar a lista, vc pode abrir a lista e editá-la.');
   ds.free();
end;


procedure TForm2.CarregaDadosdaslistas(sender: tobject);
var
   cmd:String;
begin
   desabilitaEdits(sender);
   fmMain.query1.sql.Clear;
   cmd :=  ('exec stoObterCadastroDeListas2  @dtinicio = ' + fmMain.InVencLista()+ ' , '+
            '@dtFim =' +  fmMain.FimVencLista()  + ' , '+
            '@ListaLoja = '+ quotedStr( f.SohNumeros(cblojas.Items[cblojas.ItemIndex])) +' , '+
            '@loja = ' + QuotedStr(fmMain.RParReg('Loja'))
            );
   fmMain.query1.sql.add(cmd);
   fmMain.query1.Open;
   pnIncluiItens.top:= 03;
   pnIncluiItens.Left := form2.Width - pnIncluiItens.Width - 10;

   dbedit1.DataField := 'noiva';
   dbedit2.DataField := 'noivo';
   dbedit5.DataField := 'endEntrega';
   dbedit6.DataField := 'bairro';
   dbedit7.DataField := 'endreferencia';
   dbedit8.DataField := 'observacao';
   dbedit11.DataField := 'foneRes';
   dbEdNumLista.DataField := 'numlista';
   edCEP.DataField := 'CEP';
   dbEdTpLista.DataField :=  'Tipo';
   edCodWell.DataField := 'codWell';
   edCPF.DataField := 'cpf';

   dbedit13.DataField := 'loja';
   dbtext1.DataField := 'Tipo';
   DBDT1.DataField := 'DataCasamento' ;
   DBDT1.MinDate :=  fmMain.dp1.mindate;

   if (fmMain.RParReg('loja') = '00') then
      dbedit13.visible := true;

    // pegar os valores dos tipos de listas
    cbTpLista.Items := fmMain.GetTiposListas(false, '');
    cbTpLista.ItemIndex := 0;

    fmMain.LerColunasDbgrid(form2.name,Dbgrid1);
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
	f.gravaLog('-----------------------------------------------------------------');
	f.gravaLog('Form2');

   cbLojas.items := fmMain.GetNumLojas( fmMain.RParReg('Loja'));
   cbLojas.ItemIndex := 0;
   CarregaDadosdaslistas(sender);
end;

procedure TForm2.desabilitaEdits(sender: tobject);
begin
   dbedit1.enabled := false;
   dbedit2.enabled := false;
   cbTpLista.Enabled := false;
   dbdt1.Enabled :=false;
   dbedit5.enabled := false;
   dbedit6.enabled := false;
   dbedit7.enabled := false;
   dbedit8.enabled := false;
   dbedit11.enabled := false;
   dbedit13.enabled := false;
   dbEdNumLista.Enabled := false;
   edCEP.Enabled := false;
   bitbtn1.Visible := false;
   bitbtn2.Visible := false;
   bitbtn3.Visible := true;
   bitbtn4.Visible := true;
   bitbtn5.Visible := true;
   edCodWell.Enabled := false;
   edCPF.Enabled := false;

   pnBusca.Visible := true;
   dbgrid1.Enabled:= true;
end;

procedure TForm2.HabilitaEdits(sender: tobject);
begin
   dbdt1.DateTime := now;
   dbedit1.enabled := true;
   dbedit2.enabled := true;
   cbTpLista.Enabled := true;
   dbdt1.Enabled := true;
   dbedit5.enabled := true;
   dbedit6.enabled := true;
   dbedit7.enabled := true;
   dbedit8.enabled := true;
   dbedit11.enabled := true;
   dbedit13.enabled := true;
   dbEdNumLista.Enabled := true;
   edCEP.Enabled := true;
   dbEdNumLista.Enabled := true;
   bitbtn1.Visible := true;
   bitbtn2.Visible := true;
   bitbtn3.Visible := false;
   bitbtn4.Visible := false;
   bitbtn5.Visible := false;
   edcodWell.Enabled := true;
   cbTpLista.ItemIndex := -1;
   edCPF.Enabled := true;
   dbedit1.setfocus;
   pnBusca.Visible := false;
end;

function TForm2.verificaPreenchimento(): string;
var
   aux,
   l:string;
begin
   if length(dbedit13.Text) < 2 then
       dbedit13.Text := '0'+ dbedit13.Text;
   l:='';

   if (f.RemAcentos(dbedit1.Text) <> dbedit1.Text  ) or (f.RemAcentos(dbedit2.Text) <> dbedit2.Text)  = true then
      l := l + ' - Por favor, não use acentuação no nome da noiva ou do noivo.          ' + #13;
   if cbTpLista.ItemIndex < 0 then l := l+ ' - Falta o tipo da lista.          ' + #13;
   if dbedit1.text = '' then l := l+ ' - Nome da noiva está faltando.          ' + #13;
   if dbedit2.text = '' then l := l+ ' - Nome do noivo está faltando.          ' + #13;
   if pos(' ',dbedit1.text) = 0 then  l := l+ ' - O nome da noiva deve ter ao menos nome e sobrenome.'+ #13;
   if dbedit5.text = '' then  l := l+ ' - Endereço de entrega.'+#13;
   if dbedit6.text = '' then  l := l+ ' - Bairro.'+#13;
   if dbedit7.text = '' then  l := l+ ' - Ponto de referencia. '+#13;
   if dbedit11.text = '' then l := l+ ' - Número do telefone.'+#13;
   if dbedit8.text = '' then  l := l+ ' - Observação é obrigatória.'+#13;
   if length(edCPF.Text) < 11 then l:= l+ ' - É obrigatório preencher o CPF da noiva. '+#13;


   aux := dm.openSQL('Select cast(numlista as varchar(10))+'' ''+noiva as dados from listas where ehAtivo = 1 and cpf = ' + quotedstr(edCPF.Text) +' and tipo = ' + dbEdTpLista.Text, 'dados');
   if (aux <> '') and ( EhInclusaoDeLista = true) then
      l := l+ ' - Já exite uma lista desse tipo cadastrada para esse CPF.'+#13 +' '+ aux;

   if l <> '' then
      l := ' Alguns campos estão errados ou incompletos, verifique:    '+#13 + l;

   if f.RParReg('listas','loja') = '00' then
     if  msg.msgQuestion ('Há erros na lista, ignorar erros? ') = mrYes then
         l := '';
   verificaPreenchimento := l;
end;


procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   FormStyle := fsMDIForm;
   fmMain.mostraMenu(sender);
   action := Cafree;
end;

procedure TForm2.BitBtn4Click(Sender: TObject);
begin
   if fmMain.EhlistaDaloja(dbgrid1.fields[0].asString,true)  = true then
   begin
      fmMain.query1.Edit;
      habilitaEdits(sender);
      dbgrid1.Enabled := false;
      ajustaComboTipoLista();
   end
end;

procedure TForm2.buyytClick(Sender: TObject);
begin
  if (fmMain.EhlistaDaloja(dbgrid1.fields[0].asString,true)  = true) then
     if( msg.msgQuestion('Deseja relmente excluir essa Lista ?? '+#13 + ' Se houver itens nessa lista eles serão excluídos também.') = mrYes) then
     begin
        dm.execSQL('Exec stoDeletaLista ' + quotedStr(dbEdNumLista.text));
        form2.Activate;
     end;
end;

procedure TForm2.BitBtn6Click(Sender: TObject);
begin
   fmMain.SalvaColDbgrid(form2.name,Dbgrid1);
   Form2.Close;
end;

procedure TForm2.chamaInclusaiDeItens();
begin
   if (msg.msgQuestion(dm.getMsg('incItlstnova')) = mrYes )then
      abreJanelaInclusaoItens()
   else
      BitBtn2Click(nil);
end;

procedure TForm2.BitBtn7Click(Sender: TObject);
var
   i:integer;
begin
    i := LB1.itemindex;
    if lb1.itemindex > -1 then
    begin
       lb2.Items.add(lb1.items[lb1.itemindex]);
       lb1.items.delete(i);
    end;
    lb1.itemindex := i;
    lb1.setfocus;
end;


procedure TForm2.BitBtn8Click(Sender: TObject);
var
   i:integer;
begin
   for i := 0 to lb1.items.count - 1 do
      lb2.Items.add(lb1.items[i]);
   lb1.items.clear;
   lb1.setfocus;
end;

procedure TForm2.BitBtn9Click(Sender: TObject);
var
   i:integer;
begin
    i := lb2.itemindex;
    if lb2.itemindex > -1 then
    begin
       lb1.Items.add(lb2.items[lb2.itemindex]);
       lb2.items.delete(i);
    end;
    lb2.itemindex := i;
    lb2.setfocus;
end;

procedure TForm2.BitBtn10Click(Sender: TObject);
var
   i:integer;
begin
   for i := 0 to lb2.items.count - 1 do
      lb1.Items.add(lb2.items[i]);
   lb2.items.clear;
   lb2.setfocus;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
   desabilitaEdits(sender);
   ehinclusaodelista:= false;
   fmMain.query1.Cancel;
end;

procedure TForm2.BitBtn12Click(Sender: TObject);
begin
   lb1.Items.Clear;
   lb2.Items.Clear;
   pnIncluiItens.Visible := false;
   BitBtn2Click(Sender);
end;

procedure TForm2.BitBtn11Click(Sender: TObject);
var
  aux:string;
  i:integer;
  comandos:TStringlist;
begin
   comandos := TSTringlist.create();

   for i:=0 to lb2.items.count - 1 do
   begin
       aux := lb2.items[i];
       comandos.add('insert into produtos(numlista, codigo, nomeProduto, Tipo,convidado, isPromocao ) values( '  + quotedStr(NUMERO_LISTA) + ' ,  ' +quotedStr('0000000')         + ' ,  ' + quotedStr(copy(aux,pos(' - ',aux)+3,length(aux)))  + ' ,  ' + quotedStr( copy(aux,pos(' ',aux)+1,pos(' - ',aux)-pos(' ',aux)-1 ) ) + ' ,  ' +quotedstr('')+ ', 0 )');
   end;

   if (comandos.Count  > 0) then
      for i:=0 to comandos.Count -1 do
         dm.execSQL(comandos[i]);

   fmMain.atualizaDadosItensLista( inttostr(lb2.items.count),'0','0', NUMERO_LISTA);
   msg.msgExclamation('Itens incluidos com Sucesso...');
   BitBtn12Click(Sender);
end;

procedure TForm2.Dbedit11Exit(Sender: TObject);
begin
    dbedit11.Text := f.FiltraNum(dbedit11.Text,0);
end;

procedure TForm2.cbLojasSelect(Sender: TObject);
begin
   form2.CarregaDadosdaslistas(Sender);
end;

procedure TForm2.FormResize(Sender: TObject);
begin
   fmMain.PosicaoBotoes(form2);
   bitbtn1.Left := form2.Width - bitbtn1.Width - bitbtn2.Width - 12;
   dbgrid1.Height :=  form2.Height - DBEDIT8.Top - DBEDIT8.Height - 35;
end;

procedure TForm2.Abrirestalista1Click(Sender: TObject);
begin
   if msg.msgQuestion('Deseja fechar essa janela e abrir a lista?') = MrYes then
      fmMain.AbrirLista(dbEdNumLista.text);
end;

procedure TForm2.ImprimirEstalista1Click(Sender: TObject);
var
  Numero:String;
begin
   numero := dbEdNumLista.Text;
   fmMain.AbreFormPesquisa(sender,1); {1 é abrir lista}
   form4.Hide;
   form4.MontaListaEmArquivo('Impressao', numero );
   form4.Close;
end;

procedure TForm2.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if (gdSelected in State) then
      DBGrid1.Canvas.Brush.Color := clAqua;
end;

procedure TForm2.dbEdNumListaEnter(Sender: TObject);
begin
   bitbtn6.SetFocus;
end;

procedure TForm2.cbTpListaChange(Sender: TObject);
begin
   fmMain.query1.FieldByName('tipo').AsString :=
   f.SohNumeros( COPY(cbTpLista.Items[cbTplista.itemIndex], 42, 05));
end;

procedure TForm2.DBGrid1TitleClick(Column: TColumn);
begin
   dm.OrganizarQuery(fmMain.query1, DBGrid1, column);
end;

procedure TForm2.imprimeTermo(nRelatorio,numLista: String);
var
   qr:TAdoQuery;
   param:TStringList;
begin
   dm.getQuery(qr, 'Select top 01 * from listas where numLista = '  + numLista ) ;

   param := TStringList.Create();
   param.Add( trim(fmMain.GetParamBD('horarioTrocas', fmMain.RParReg('loja'))));
   param.Add( qr.fieldByName('cpf').asString  );
   param.Add( qr.fieldByName('cep').asString  );
   param.Add( qr.fieldByName('cep').asString  );
   param.Add( trim(fmMain.GetParamBD('endLoja', fmMain.RParReg('loja'))));

   fmMain.imprimeRave(qr, nil, nil, nRelatorio, param );
   qr.free();
end;


procedure TForm2.Imprimirotermodeconcordncia1Click(Sender: TObject);
begin
   if fmMain.EhlistaDaloja(fmMain.Query1.fieldbyName('loja').asString, true) = true then
		if  uLista.isPodeImprimirTermo(dbEdTpLista.Text) = true then
      begin
      	if fmMain.GetParamBD('imprimelistaMaison', fmMain.RParReg('loja')) = '1' then
			begin
         	if (fmMain.Query1.fieldbyName('dataCasamento').AsDateTime < strToDate('31/12/2014')) then
	            imprimeTermo('rpTermoMaison', fmMain.Query1.fieldbyName('numLista').asString  )
            else
	            imprimeTermo('rpTermoMaison2', fmMain.Query1.fieldbyName('numLista').asString  )
			end
         else
				imprimeTermo('rpTermo', fmMain.Query1.fieldbyName('numLista').asString );
      end
      else
         msg.msgErro( dm.getMsg('errTpNaoImpTermo'));
end;

procedure TForm2.btBuscaClick(Sender: TObject);
var
  campo:string;
begin
  case cb1.itemindex of
     0:campo := 'noiva';
     1:campo := 'noivo';
     2:campo := 'numlista';
  end;
   fmMain.Query1.Locate(campo, edit1.text,[loPartialKey]);
   edit1.Clear;
   edit1.setfocus;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
   EhInclusaoDeLista := true;
   fmMain.query1.Append;
   habilitaEdits(sender);
   dbgrid1.Fields[0].AsString := f.RParReg('listas','loja');
   dbgrid1.Fields[5].AsString := DateToStr(now);
   dbgrid1.Fields[4].AsString := dateToStr(dbdt1.DateTime);
   dbedit1.SetFocus;
   dbgrid1.Enabled:= false;
end;

procedure TForm2.Adicionarpessoasrelacioandas1Click(Sender: TObject);
begin
   Application.CreateForm( TfmPRelacionadas, fmPRelacionadas);
   fmPRelacionadas.CarregaPessoasRelacionadas(nil, fmMain.Query1.fieldByname('numLista').asString);
   fmPRelacionadas.ShowModal();
end;

procedure TForm2.ajustaComboTipoLista;
var
  i:integer;
begin
   for i:=0 to cbTpLista.Items.Count-1 do
      if (trim(copy(cbTpLista.Items[i], 42, 10)) = dbEdTpLista.Text) then
      begin
         cbTpLista.ItemIndex := i;
         break;
      end;
end;

procedure TForm2.bitBtn1Click(Sender: TObject);
begin
   screen.Cursor := crHourGlass;
   if (EHINCLUSAODELISTA=true) then
   begin
      if verificaPreenchimento() = '' then
      begin
         TIPO_lISTA := dbEdTpLista.Text;
         fmMain.query1.Post;
         NUMERO_LISTA := dbEdNumLista.text;
         dbgrid1.Enabled := false;
         chamaInclusaiDeItens();
         carregaDadosdaslistas(Sender);
      end
      else
         msg.msgErro(verificaPreenchimento());
   end
   else
   begin
      if verificaPreenchimento() = '' then
      begin
         fmMain.query1.Post;
         desabilitaEdits(sender);
      end
      else
         msg.MsgErro(verificaPreenchimento())
   end;
   screen.Cursor := crDefault;
end;

procedure TForm2.Incluirosprodutosnalista1Click(Sender: TObject);
begin
   NUMERO_LISTA := fmMain.Query1.fieldByName('numLista').asString;
   TIPO_LISTA := fmMain.Query1.fieldByName('tipo').asString;
   abreJanelaInclusaoItens();
end;

end.

