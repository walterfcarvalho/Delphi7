unit uCriaMapa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,  adLabelEdit, ADODB, adLabelComboBox,
  CheckLst, adLabelCheckListBox, fCtrls, Buttons, TFlatButtonUnit, db;

type
  TfmCriarMapa = class(TForm)
    rg: TRadioGroup;
    cbPreco: TadLabelComboBox;
    cbLoja: TadLabelComboBox;
    edCod: TadLabelEdit;
    clb1: TadLabelCheckListBox;
    fsCheckBox1: TfsCheckBox;
    edNome: TadLabelEdit;
    cbEstoque: TfsCheckBox;
    btForn: TBitBtn;
    btOk: TBitBtn;
    bitBtn3: TBitBtn;
    edIsNota: TadLabelEdit;
    lbIsNota: TLabel;
    cbLjReq: TadLabelComboBox;
    procedure rgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure fsCheckBox1Click(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure insereItensMapa(nMapa, uoDest:String; comEstoque:boolean; uos:Tstringlist);
    procedure btFornClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure edIsNotaEnter(Sender: TObject);
    function criarMapa(var uoDest:String):String;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCriarMapa: TfmCriarMapa;

implementation

uses uMain, uMapa, ufornACriticar, cf, uListaFornecedores, uDm, uFiscal, funcoes,
     msg, uLj, uPreco, uMapaSep, fdt;

{$R *.dfm}


procedure TfmCriarMapa.rgClick(Sender: TObject);
begin
   Case rg.ItemIndex of
   0:begin
        edCod.LabelDefs.Caption := 'Pedido de compra ';
        cbLoja.Visible := false;
        btForn.Visible := false;
        edIsNota.Visible:= false;
     end;
   1:begin
        edCod.LabelDefs.Caption := 'Faixa de codigo ';
        edCod.Visible := true;
        cbLoja.Visible := true;
        btForn.Visible := false;
        edIsNota.Visible:= false;
     end;
   2:begin
        edCod.visible := false;
        cbLoja.Visible := true;
        btForn.Visible := true;
        edIsNota.Visible:= true;
     end;
   end
end;

procedure TfmCriarMapa.FormCreate(Sender: TObject);
begin
   uLj.getListaLojas(cbLoja, false, false, fmMain.getCdPesLogado(), '' );
   cbPreco.Items := uPreco.getListaPrecos(true,true,false, fmMain.getGrupoLogado());
   cbPreco.ItemIndex :=0;
   clb1.Items.Clear;
   clb1.Items := dm.getListagem( dm.getCMD('fmMapa', 'getUos')  );

   ulj.getComboBoxLjMapa(cbLjReq);

   fsCheckBox1Click(nil);
   rgClick(nil);
   lbIsNota.Caption := '';
end;

procedure TfmCriarMapa.fsCheckBox1Click(Sender: TObject);
var
  i:integer;
begin
   for i:=0 to clb1.Items.Count -1 do
      clb1.Checked[i] := not(clb1.Checked[i]);
end;

function TfmCriarMapa.criarMapa(var uoDest:String):String;
var
  strLojas, tipo, numMapa, cmd:String;
  i:integer;
  ds:TdataSet;
begin
   uoDest := funcoes.getCodUO(cbLjReq);

   if (rg.ItemIndex = 0) then
     numMapa := edCod.Text
   else if (rg.ItemIndex = 2) then
      numMapa := funcoes.SohNumerosPositivos(edIsNota.Text)
   else if rg.ItemIndex = 1 then
   begin
       tipo := 'N';
       dm.execSQl( 'update zcf_mapaSeparacaoN set num = num + 1 where tipo = ' + quotedStr(tipo));
       numMapa := dm.openSQL('Select num from zcf_mapaSeparacaoN where tipo = ' + quotedStr(tipo), 'num' );
   end;

// vou verificar se ja existe um mapa
   ds := uMapaSep.getDadosMapa(numMapa);

   if (ds.isEmpty = true) then
   begin
     // criar no bd o mapa separacao
      for i:=0 to clb1.Items.Count - 1 do
         if clb1.Checked[i] = true then
            strLojas := strLojas +', l' + copy(clb1.Items[i], 01, 02);

      cmd := 'begin Insert zcf_mapaSeparacao(uo, nome, data, ehfinalizada, criador, pco, criticaEstoque, num '+ strLojas + ')';

      cmd := cmd + ' values ( '+ uoDest  +', '+
                                 quotedStr(edNome.Text)  +' , '+
                                 fdt.DateTimeToSqlDateTime(now,'') +' , 0, '+
                                 fmMain.getUserLogado()   +' , '+
                                 funcoes.getCodPc(cbPreco);

      if (cbEstoque.Checked = true) then
        cmd := cmd +', 1 '
      else
        cmd := cmd +', 2 ';

      cmd := cmd + ', ' + numMapa ;

      for i:=0 to clb1.Items.Count - 1 do
         if clb1.Checked[i] = true then
            cmd := cmd +', 1';

       cmd := cmd +' ) end';

       if (dm.execSQL(cmd) = true) then
          result := numMapa
       else
          result := '';
    end
    else
    begin
       cmd := dm.getCMD2('msg', 'fmMapa.errRep',  ds.fieldByName('data').AsString, ds.fieldByName('nm_usu').AsString);
       msg.msgErro(cmd);
       result := '';
    end;
    ds.free();
end;

procedure TfmCriarMapa.insereItensMapa(nMapa, uoDest: String; comEstoque:boolean; uos:Tstringlist);
var
   c, cEst:string;
   cmd:String;
strEstoque,   cmdItens:String;
   qrItens:TADOQuery;
begin
   qrItens := TADOQuery.Create(nil);

   if (comEstoque = true) then
      cEst := dm.getcmd1('fmMapa', 'getItEst', uoDest)
   else
      cEst :=  ' ';

   if rg.ItemIndex = 0 then
      cmdItens := 'Select is_ref from dsipe with(nolock) where is_pedf= '+  edCod.Text
   else if rg.ItemIndex = 1 then
      cmdItens := ' Select is_ref from crefe with(nolock) where cd_ref like ' + quotedStr(edCod.Text + '%') + cEst
   else if rg.ItemIndex = 2 then
   begin
      cmdItens :=  ' Select is_ref from dmovi with(nolock) where is_nota= ' + lbIsNota.Caption ;
   end;

   dm.getQuery(qrItens, cmdItens);

   if (qrItens.RecordCount > 0) then
   begin
      if rg.ItemIndex = 0 then
      begin
         c := ' Insert zcf_mapaSeparacaoI( num, is_ref, estI, saldo, pco, caixa ) '+
                ' Select '+ nMapa+ ' , dsipe.is_ref, '+
                ' dsipe.qt_ped, '+
                ' dsipe.qt_ped, '+
                ' dbo.z_cf_funObterPrecoProduto_CF( 101, dsipe.is_Ref, '+ uoDest +', 0), '+
                ' crefe.qt_emb ' +
                ' from dsipe (nolock) inner join crefe (nolock) on dsipe.is_ref = crefe.is_ref ' +
                ' where dsipe.is_pedf = ' + nMapa  +  ' Order by dsipe.is_ref' ;
      end
      else if rg.ItemIndex = 2 then
      begin
          cmd := ' Insert zcf_mapaSeparacaoI( num, is_ref, estI, saldo, pco, caixa ) '+
                 ' Select '+ nMapa+ ', dmovi.is_ref, dmovi.qt_mov, dmovi.qt_mov,  '+
                 ' dbo.z_cf_funObterPrecoProduto_CF( '+ fmMain.getCodPreco(cbPreco)  +   ', crefe.is_Ref, ' + fmMain.getUOCD() + ', 0), crefe.qt_emb '+
                 ' from dmovi inner join crefe (nolock) on dmovi.is_ref = crefe.is_ref ' +
                 ' where dmovi.is_nota= ' + lbIsNota.caption ;
      end
      else
      begin
         cmd := ' Insert zcf_mapaSeparacaoI( num, is_ref, estI, saldo, pco, caixa ) '+
                ' Select '+ nMapa+ ' , is_ref, '+
                ' dbo.z_cf_EstoqueNaLoja( is_ref, '+ uoDest +', 1), '+
                ' dbo.z_cf_EstoqueNaLoja( is_ref, '+ uoDest +', 1), '+
                ' dbo.z_cf_funObterPrecoProduto_CF( 101, is_Ref, '+ uoDest +', 0), '+
                ' crefe.qt_emb ' +
                ' from crefe where is_ref in ( ' + cmdItens + ' ) ' + strEstoque  + ' Order by is_ref' ;
      end;

      if (dm.execSQL(cmd) = true ) then
      begin
          msg.msgExclamation('Criada o mapa de número: ' +nMapa+ #13+ 'O mapa será carregado.');
          fmMapa.CarregaMapa(nMapa);
          BitBtn3.Click;
      end;
   end
   else
   begin
      dm.execSQL('delete from zcf_mapaSeparacao where num = ' +nMapa);
      msg.msgErro('A opção que você escolheu não encontrou nenhum item para a seleção') ;
   end;
end;

procedure TfmCriarMapa.btOkClick(Sender: TObject);
var
  tipo, numero, uoDest, nMapa, erro:String;
  i:integer;

begin
   gravaLog('------------------------- criacao do mapa de separacao:');

    for i:= 0 to clb1.Items.Count -1 do
      if (clb1.Checked[i] = true) and (ulj.getIsUo( copy(clb1.Items[i], 01, 02)) = funcoes.getCodUO(cbLjReq) )  then
         erro := erro+  dm.msg('fmMapa.conflitoLj');

   if (length(edNome.text) < 3) then
      erro := erro+  dm.msg('fmMapa.errNome');

   if (rg.ItemIndex = 0) then
      if (edCod.Text = '') then
         erro := erro+ dm.msg('fmMapa.errNumPed');

   if (rg.ItemIndex = 1) then
      if (length(edCod.Text) < 3 ) then
         erro := erro+ dm.msg('fmMapa.errFxCod');

   if  (rg.ItemIndex = 2) then
     if (lbIsNota.Caption = '') then
        erro := erro+ dm.msg('fiscal.srNumNF');

   if (erro = '') then
   begin
      case rg.ItemIndex of
         0:begin
              tipo := 'P';
              numero := edCod.Text;
           end;
         1:begin
              tipo := 'C';
              numero := edCod.Text;
           end;
         2:begin
              tipo := 'N';
              numero := lbIsNota.Caption;
           end;
      end;

      nMapa :=
      uMapaSep.criarMapa(tipo, numero, edNome.Text, funcoes.getCodUO(cbLjReq),
                         fmMain.getCdPesLogado(), funcoes.getCodUO(cbPreco),
                         funcoes.getUos(clb1), not(cbEstoque.Checked)
      );

      if (nMapa <> '-1') then
      begin
         btOk.ModalResult := mrOk;
      end
      else
         msg.msgExclamation('ok');
   end
   else
   begin
      msg.msgErro(dm.msg('MSG_ERRO_TIT') + erro);
      btOk.ModalResult := mrNone;
   end;
end;

procedure TfmCriarMapa.btFornClick(Sender: TObject);
var
  isNota:String;
  ds:TdataSet;
begin
   isNota := uFiscal.getIsNota();
   if ( isNota <> '') then
   begin
      ds:= uFiscal.getDadosNota(isNota, '', '', '');
      edIsNota.text :=
      trim(ds.fieldByname('serie').asString) + '-' +
      trim(ds.fieldByname('num').asString) + ' '+
      trim(ds.fieldByname('Emissor/Destino').asString);
      lbIsNota.Caption := ds.fieldByname('is_nota').asString;
      ds.free();
   end
   else
      lbIsNota.Caption := '';
end;

procedure TfmCriarMapa.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
   if (ModalResult  = mrAbort) then
     canClose := false;
end;

procedure TfmCriarMapa.edIsNotaEnter(Sender: TObject);
begin
   btForn.SetFocus();
end;

procedure TfmCriarMapa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := CaFree;
   fmCriarMapa := nil;
end;

end.
