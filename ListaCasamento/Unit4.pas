unit Unit4;

interface

uses
  funcoes, Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, adLabelEdit, DB, ADODB, Grids, DBGrids,
  adLabelComboBox, TFlatButtonUnit, RpDefine, RpRave,
  RpCon, RpConDS, RpBase, RpSystem, SoftDBGrid, RpRender, RpRenderText,
  RpRenderPDF, mxExport, fCtrls;
type
  TForm4 = class(TForm)
    DataSource1: TDataSource;
    Edit1: TadLabelEdit;
    cbox1: TadLabelComboBox;
    BitBtn1: TFlatButton;
    BitBtn2: TFlatButton;
    btCancela: TFlatButton;
    CB1: TadLabelComboBox;
    qrCabeca: TADOQuery;
    DBGrid1: TSoftDBGrid;
    QueryImpressao: TADOQuery;
    cbBuscaNum: TfsCheckBox;
    qrCorpo: TADOQuery;
    procedure btCancelaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure CarregaDadosParaRelatorio(num: string);
    Function  AjustaFolhas(x:String):String;
    function  AjustaLinha(tp,cd,vl,ds,cv:string): string;
    procedure MontaListaEmArquivo(Acao: String; numlista:string);
    procedure MontarRelatorioImpressao(arquivo:string);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure configuraTela(acao:integer);
  private
    { Private declarations }
  public
    acao:integer;
    { Public declarations }
  end;

var
  Form4: TForm4;
  ACAO_FORM:integer;
implementation

uses unit1,unit3,unit2, uDm, msg, uProduto;

{$R *.dfm}

procedure TForm4.configuraTela(acao: integer);
begin
   cb1.Items := fmMain.GetTiposListas(true, '');
   cb1.itemIndex := 0;
   case acao of
      1:form4.caption := 'Abrir uma lista';
      2:begin
           form4.caption := 'Imprimir uma lista';
           cbox1.Visible:= true;
        end;
   end;
   ACAO_FORM := acao;
end;


function TForm4.AjustaLinha(tp,cd,vl,ds,cv:string): string;
var
   aux:string;
begin
   aux := aux + '       '+ funcoes.preencheCampo(20,' ','D',tp);
   if cd = '0000000' then
      aux := aux +  funcoes.preencheCampo(12,' ','D', ' ')
   else
      aux := aux + funcoes.preencheCampo(12,' ','D', cd );

   vl := funcoes.StrToMoney(vl);
   if  vl = '0,00' then
      vl :='';
   aux :=  aux + funcoes.preencheCampo(11,' ','D', vl);

   aux := aux +  funcoes.preencheCampo(35,' ','D', copy(DS,01,35) );

   if pos('____',cv) > 0 then
      aux := aux +'  '+ '_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ '
   else
      aux := aux +'  '+ cv;

   Ajustalinha := aux;
end;

Function tform4.AjustaFolhas(x:String):String;
begin
    while pos( ' ', x ) > 0 do delete( x ,pos(' ', x ),1);
    while length( x ) < 3 do insert('0', x, 1 );
    AjustaFolhas:= x;
end;

procedure TForm4.MontarRelatorioImpressao(arquivo:string); //sender:tobject);
var
   dest:TstringList;
   aux, linha:string;
   nLinPag,l,Fl:integer;
begin
   dest:=  TStringList.create();
   Fl := 0;
   l := 0;
   nLinPag := 45;

   dest.Add(#15);

   qrCorpo.First;
   while qrCorpo.Eof = false do
   begin
      inc(fl);
      aux := fmMain.RParReg('TitRel');
//*********************** cabecalho     ******************************************************

      while length(linha) < (66 { meio da folha} - (length(aux) div 2 )) do
         linha := ' ' + linha;

      linha := linha + fmMain.RParReg('TitRel') + DateToStr(Now);
      while length(linha) < 132 do
      insert(' ',linha, pos(DateToStr(Now),linha) );
      dest.add(linha); linha:='';

      while length(linha) < (66   - (length(trim(qrCabeca.Fields[11].AsString) ) div 2 )) do
         linha := ' ' + linha;
      linha := linha + qrCabeca.Fields[11].AsString + 'PAGINA:'+AjustaFolhas( inttoStr(Fl) );
      while length(linha) < 132 do
          insert( ' ', linha, (pos('PAGINA:'+ AjustaFolhas(inttoStr(Fl)) ,linha)) );

      dest.Add(linha); linha := '';
      Dest.Add('');
      Dest.Add('ITEMS A SEREM IMPRESSOS: ' + cbox1.items[cbox1.itemindex] );
      Dest.Add('--------------------------------------------------------[ DADOS  DA LISTA ]---------------------------------------------------------');
      Dest.Add('LISTA NUM : ' + qrCabeca.FieldByName('NumLista').AsString );
      Dest.Add('NOIVA: ' + qrCabeca.Fields[1].AsString + '        NOIVO: ' + qrCabeca.Fields[2].AsString  + '   DATA DO EVENTO: '+ qrCabeca.Fields[6].AsString );
      Dest.Add('ENDERECO DE ENTREGA: '+qrCabeca.FieldByName('endEntrega').AsString + '     BAIRRO: '+  qrCabeca.Fields[4].AsString );
      Dest.Add('PONTO DE REFERENCIA: '+qrCabeca.Fields[8].AsString );
      Dest.Add('OBSERVACAO: ' + qrCabeca.fieldByName('Observacao').AsString);
      Dest.Add('-------------------------------------------------------[ DADOS DOS PRODUTOS ]-------------------------------------------------------');
      Dest.Add('         TIPO              CODIGO       VALOR     DESCRICAO                          CONVIDADO');
      Dest.Add('');

      while ( l < nLinPag ) and ( qrCorpo.eof = false ) do
      begin
         inc(l);
         Dest.Add(AjustaLinha(qrCorpo.FieldByname('tipo').AsString, qrCorpo.FieldByname('codigo').AsString, qrCorpo.FieldByname('valor').AsString, qrCorpo.FieldByname('nomeProduto').AsString, qrCorpo.FieldByname('convidado').AsString ));
         qrCorpo.next;
      end;
      if ( qrCorpo.eof = false ) then
      begin
         Dest.Add( '');
         Dest.Add('------------------------------------------------------------------------------------------------------------------------------------');
         Dest.Add('');
         l:=0
      end
      else
      begin
         while ( l < nLinPag ) do
         begin
            Dest.Add('');
            inc(l);
         end;
         Dest.Add('------------------------------------------------------------------------------------------------------------------------------------');
         Dest.Add('                                                                                                            GLC '+ fmMain.RParReg('Versao') +' Walter Carvalho');
         Dest.Add('');
      end;
   end;
   Dest.SaveToFile(ARQ_DE_IMPRESSAO);
end;

procedure TForm4.CarregaDadosParaRelatorio( num: string);
var
   cmd:String;
begin
// cabeça da lista
   qrCabeca.SQL.clear;
   qrCabeca.SQL.add('Select L.NumLista, L.Noiva, L.Noivo, L.EndEntrega, L.Bairro, L.FoneRes, L.DataCasamento, L.EndReferencia, L.DataLista, L.Loja, L.Observacao, T.Descricao from Listas L, TipoListas T where L.Tipo = CodLista and L.Numlista = ' + quotedStr(num) );
   qrCabeca.open;




   uProduto.getQrItensLst(qrCorpo, num, cbox1.ItemIndex);
end;

procedure TForm4.btCancelaClick(Sender: TObject);
begin
   fmMain.query1.sql.clear;
   dbgrid1.DataSource.destroy;
   form4.Close;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := CaFree;
   Form4 := nil;
end;

procedure TForm4.BitBtn1Click(Sender: TObject);
begin
   QueryImpressao.sql.clear;
   QueryImpressao.sql.Add('Exec stoObterCadastroDeListasResumo2 ' +
                           '@dtinicio = ' + fmMain.InVencLista() +' , '+
                           '@dtFim = '    + fmMain.fimVencLista() +' , '+
                           '@loja = '     + quotedStr(fmMain.RParReg('Loja')) +' , '+
                           '@tipo = '     + quotedStr(funcoes.tiraEspaco(copy(cb1.items[cb1.ItemIndex],40,20))) +' , '+
                           '@nome = '     + quotedStr(edit1.text)
                          );

    if cbBuscaNum.Checked= true then
       QueryImpressao.sql.Add(' , @NumLista = ' + Funcoes.SohNumeros(edit1.Text) );

   QueryImpressao.open;
   edit1.setfocus;
   dbgrid1.enabled:=true;
end;

procedure TForm4.MontaListaEmArquivo(Acao: String; numlista:string);
var
   arqImpressao:TstringList;
   params:TStringList;
   fileLogo, tpImp:String;

begin
  funcoes.gravaLog('MontaListaEmArquivo()');

// pegar os dados da lista
  CarregaDadosParaRelatorio(numlista);

   if qrCorpo.IsEmpty = true then
      msg.msgErro(' Não existe nenhum item cadastrado para esta lista.')
   else
   begin
      if acao = 'Impressao' then
      begin
         tpImp :=  fmMain.getPerfilImp();
         if ( tpImp = 'D' ) then
         begin
            params := TStringList.create();
            params.add(funcoes.RParReg('listas','TitRel')              ) ;
            params.add(trim(qrCabeca.Fields[11].AsString) ) ;
            params.add(Cbox1.Items[Cbox1.Itemindex]);
            params.add(funcoes.RParReg('listas','Versao')   );
            fileLogo := funcoes.RParReg('listas','ArqLogo');
            params.add( filelogo  );

            if fmMain.GetParamBD('imprimelistaMaison', fmMain.RParReg('loja')) = '1' then
               fmMain.imprimeRave(qrCabeca, qrCorpo, nil, 'rpEspelhoLista', params)
            else
               fmMain.imprimeRave(qrCabeca, qrCorpo, nil, 'rpEspelhoListaAg', params);
         end
         else
         begin
            MontarRelatorioImpressao(ARQ_DE_IMPRESSAO);

            if (fmMain.getPerfilImp() = 'I')  then
               winExec(pchar('prFile32.exe espelholista.txt'), sw_hide)
            else
               funcoes.imprimeArquivoPorta(ARQ_DE_IMPRESSAO, fmMain.RParReg('PortaImp') );
         end;
      end;
   end;
end;

procedure TForm4.BitBtn2Click(Sender: TObject);
begin
   if (QueryImpressao.IsEmpty = false ) then
   begin
      case ACAO_FORM of
         01:form3.chamaCarregamentoDeLista(dbgrid1.Fields[0].asString );
         02:MontaListaEmArquivo('Impressao', queryImpressao.fieldByname('NumLista').asString ); // 02 imprimir
      end;
      queryImpressao.Close;
      qrCorpo.Close;
      qrCabeca.Close;
      btCancelaClick(Sender);
   end
   else
      msg.msgErro('Escolha uma lista antes.');
end;

procedure TForm4.DBGrid1DblClick(Sender: TObject);
begin
   BitBtn2Click(Sender);
end;

procedure TForm4.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if key  = vk_return then
      BitBtn1Click(Sender)
end;

procedure TForm4.DBGrid1TitleClick(Column: TColumn);
begin
   dm.OrganizarQuery(Queryimpressao, DBGrid1, column);
end;


end.




