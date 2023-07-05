unit unClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB,  Grids,DBGrids, SoftDBGrid, RpCon, RpConDS, StdCtrls,
  ExtCtrls, Buttons, fCtrls,  ComCtrls, TFlatButtonUnit, adLabelComboBox, TFlatPanelUnit,
  TFlatEditUnit, TFlatSpinEditUnit, RpConBDE, Mask, adLabelEdit,
  adLabelNumericEdit, adLabelSpinEdit, Menus;

type
  TfmetqClientes = class(TForm)
    DataSource1: TDataSource;
    tbEtq: TADOTable;
    pnInicial: TPanel;
    rgTpPesquisa: TRadioGroup;
    pnPesquisaAvulsa: TPanel;
    edNmCliente: TfsEdit;
    Label1: TLabel;
    gRidResult: TSoftDBGrid;
    gridClientes: TSoftDBGrid;
    Label3: TLabel;
    Bevel1: TBevel;
    dsResult: TDataSource;
    dsClientes: TDataSource;
    qr: TADOQuery;
    conexaoL: TADOConnection;
    btPesquisa: TfsBitBtn;
    pnCompras: TPanel;
    cbLojas: TadLabelComboBox;
    datai: TfsDateTimePicker;
    dataf: TfsDateTimePicker;
    btAddCliente: TfsBitBtn;
    bdAddAll: TfsBitBtn;
    btRmCliente: TfsBitBtn;
    btRmAllCliente: TfsBitBtn;
    edVlVenda: TadLabelNumericEdit;
    Label2: TLabel;
    pnNascimento: TPanel;
    cbMeses: TadLabelComboBox;
    pnListas: TPanel;
    cbListas: TadLabelComboBox;
    dtl01: TfsDateTimePicker;
    dtl02: TfsDateTimePicker;
    fsBitBtn1: TfsBitBtn;
    cbLojaAniversarios: TadLabelComboBox;
    Label5: TLabel;
    pnDados: TPanel;
    pnImpressao: TPanel;
    PopupMenu1: TPopupMenu;
    Exportarlista1: TMenuItem;
    rgTpPesqCliente: TRadioGroup;
    Edit1: TEdit;
    Label6: TLabel;
    Label4: TLabel;
    lbSave: TLabel;
    lbLoad: TLabel;
    Label7: TLabel;
    EdLocalImp: TadLabelEdit;
    btSave: TButton;
    btLoad: TButton;
    PopupMenu2: TPopupMenu;
    IrParaoRegistro1: TMenuItem;
    CarregaTabela1: TMenuItem;
    SalvaTabela1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure rgTpPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure escondePaineis(Sender:Tobject);
    procedure criarTabela(Sender:Tobject);
    procedure FormActivate(Sender: TObject);
    procedure LimpaQuery(Sender:TObject);
    procedure btAddClienteClick(Sender: TObject);
    procedure FlatButton6Click(Sender: TObject);
    procedure organizaColunaPorNumero(Sender:Tobject);
    procedure btAniversariantesClick();
    procedure conexaoWExecuteComplete(Connection: TADOConnection; RecordsAffected: Integer; const Error: Error;var EventStatus: TEventStatus; const Command: _Command;          const Recordset: _Recordset);
    procedure gRidResultTitleClick(Column: TColumn);
    procedure listasProVEncimento(Sender:Tobject);
    procedure FlatButton8Click(Sender: TObject);
    procedure verificaCEPinvalido(Sender:TObject);
    procedure pesquisarClientes(Sender:Tobject; pesquisaCliente:Boolean);
    procedure btPesquisaClick(Sender: TObject);
    procedure listaClientesporCompra();
    procedure bdAddAllClick(Sender: TObject);
    procedure btRmClienteClick(Sender: TObject);
    procedure btRmAllClienteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gridClientesTitleClick(Column: TColumn);
    procedure listarClientes(str:String );
    procedure Exportarlista1Click(Sender: TObject);

    procedure imprimebobina();
    procedure gRidResultDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure lbSaveClick(Sender: TObject);
    procedure lbLoadClick(Sender: TObject);
    procedure btSaveClick(Sender: TObject);
    procedure btLoadClick(Sender: TObject);
    procedure insereCliente();
    procedure gridClientesDblClick(Sender: TObject);
    procedure IrParaoRegistro1Click(Sender: TObject);
    procedure SalvaTabela1Click(Sender: TObject);
    procedure CarregaTabela1Click(Sender: TObject);



  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  fmetqClientes: TfmetqClientes;
implementation

uses math, uMain, uCF, f, uDm, funcSQL, uLj, msg, fdt;

{$R *.dfm}

procedure TfmetqClientes.escondePaineis(Sender: Tobject);
begin
    pnPesquisaAvulsa.Visible     := false;
    pnCompras.Visible := false;
    pnNascimento.Visible := false;
    pnListas.Visible := false;
end;


procedure TfmetqClientes.FormCreate(Sender: TObject);
begin
   pnPesquisaAvulsa.Top :=1;

   uLj.getListaLojas(cbLojas, false, false, '', fmMain.getUoLogada() );
   cbLojaAniversarios.Items := cbLojas.Items;
   fmMain.getParametrosForm(fmetqClientes);


   if (fmMain.isAcessoTotal(fmMain.EtiquetasDeClientes1.Tag) = true ) then
   begin
      lbSave.Visible := true;
      lbLoad.Visible := true;
   end;

   EdLocalImp.Text :=  dm.getParamBD('impCodBarras', fmMain.getUoLogada());
end;

procedure TfmetqClientes.rgTpPesquisaClick(Sender: TObject);
begin
   escondePaineis(nil);
   case rgTpPesquisa.ItemIndex of
      0:begin
           pnPesquisaAvulsa.Visible := true;
           edNmCliente.SetFocus;
        end;
      1:begin
            pnCompras.Visible := true;
            if cbLojas.Items.Count = 0 then
            begin
               cbLojas.ItemIndex :=0;
               dataf.date := now;
               datai.Date := dataf.Date;
            end;
        end;
      2:begin
           pnNascimento.Visible := true;
           cbMeses.SetFocus;
        end;
      3:begin
           pnListas.Visible := true;
           dtl01.Date := now;
           dtl02.Date := now;
        end;
   end;
end;

procedure TfmetqClientes.FormShow(Sender: TObject);
begin
   pnCompras.Top := pnPesquisaAvulsa.Top;
   pnCOmpras.Left := pnPesquisaAvulsa.Left;

   pnNascimento.Top :=  pnPesquisaAvulsa.Top;
   pnNascimento.left := pnPesquisaAvulsa.left;

   pnlistas.Left := pnPesquisaAvulsa.Left;
   pnlistas.top := pnPesquisaAvulsa.top;

   rgTpPesquisaClick(nil);
end;


procedure TfmetqClientes.criarTabela(Sender: Tobject);
begin
   dm.getTable(tbetq,  dm.getCMD('Vendas', 'getTbEtqCliente') );

   gridClientes.DataSource := dsClientes;

   f.ajGridCol(gridClientes, tbEtq, 'Nome', 185, '');
   f.ajGridCol(gridClientes, tbEtq, 'Endereco', 159, '');
   f.ajGridCol(gridClientes, tbEtq, 'numero', 40, '');
   f.ajGridCol(gridClientes, tbEtq, 'compEndereco', 75, '');
   f.ajGridCol(gridClientes, tbEtq, 'Bairro', 98, '');
   f.ajGridCol(gridClientes, tbEtq, 'Cidade', 99, '');
   f.ajGridCol(gridClientes, tbEtq, 'CEP', 58, '');
   f.ajGridCol(gridClientes, tbEtq, 'num', 25, '');
   f.ajGridCol(gridClientes, tbEtq, 'SEQ', 64, '');
end;

procedure TfmetqClientes.FormActivate(Sender: TObject);
begin
   criarTabela(nil);
   btLoad.Visible := fmMain.isAcessoTotal( fmMain.EtiquetasDeClientes1.Tag);
   btSave.Visible := btLoad.Visible;
end;

procedure TfmetqClientes.organizaColunaPorNumero(Sender: Tobject);
var
  coluna:Tcolumn;
begin
   coluna := TColumn.Create(nil);
   coluna.Field := tbEtq.FieldByName('nome');
   dm.OrganizarTabela(tbetq, gridClientes, coluna );
end;

procedure TfmetqClientes.listarClientes(str: String);
var
   cmd : String;
begin
   cmd := '?';
   LimpaQuery(nil);
   cmd := dm.getCMD('Vendas', 'getDsPessoa');
   dm.setParam(cmd, str);

   dm.getQuery(qr, cmd);
   gRidResult.Columns[0].Visible := false;
end;


procedure TfmetqClientes.pesquisarClientes(Sender:Tobject; pesquisaCliente:Boolean);
var
   cmd:String;
begin
   if (rgTpPesqCliente.ItemIndex = 0) then
      cmd := 'Select cd_pes from dspes (nolock) where dspes.nm_pes like ''' +  edNmCliente.Text  + '%'''
   else
      cmd := 'Select cd_pes from dspes (nolock) where dspes.cd_pes = ' + f.SohNumeros(edNmCliente.Text) ;
   listarClientes(cmd);
end;

procedure TfmetqClientes.LimpaQuery;
begin
   qr.Close;
   qr.SQL.Clear;
end;

procedure TfmetqClientes.insereCliente;
begin              {  *** }
   tbEtq.Append();
   tbEtq.FieldByName('nome').AsString := qr.FieldByName('nome').asString;
   tbEtq.FieldByName('endereco').AsString := qr.FieldByName('endereco').asString;
   tbEtq.FieldByName('numero').AsString := qr.FieldByName('numero').asString;
   tbEtq.FieldByName('compEndereco').AsString := qr.FieldByName('compEndereco').asString + ' '+ qr.FieldByName('apto').asString ;
   tbEtq.FieldByName('bairro').AsString := qr.FieldByName('bairro').asString;
   tbEtq.FieldByName('cidade').AsString := qr.FieldByName('cidade').asString;
   tbEtq.FieldByName('cep').AsString := qr.FieldByName('cep').asString;
   tbEtq.FieldByName('num').AsString := qr.FieldByName('num').asString;
   tbEtq.Post();
end;

procedure TfmetqClientes.btAddClienteClick(Sender: TObject);
begin
    insereCliente();
    tbEtq.First();
end;

procedure TfmetqClientes.btAniversariantesClick();
begin
   listarClientes(
      dm.getCMD3('Vendas', 'getClienteAniversariante', f.getCodUO(cbLojaAniversarios), intToStr(cbMeses.ItemIndex+1), '' )
   );
end;

procedure TfmetqClientes.conexaoWExecuteComplete(Connection: TADOConnection;  RecordsAffected: Integer; const Error: Error;  var EventStatus: TEventStatus; const Command: _Command;  const Recordset: _Recordset);
begin
   screen.Cursor := crDefault;
end;

procedure TfmetqClientes.gRidResultTitleClick(Column: TColumn);
begin
   dm.Organizarquery(qr, gRidResult, column);
end;

procedure TfmetqClientes.btRmClienteClick(Sender: TObject);
begin
   gRidResult.Visible:=false;
   gridClientes.Visible := false;
   while tbEtq.IsEmpty = false do
      btRmAllClienteClick(nil);
   gRidResult.Visible:=TRUE;
   gridClientes.Visible := true;
end;

procedure TfmetqClientes.btRmAllClienteClick(Sender: TObject);
begin
   if  tbEtq.IsEmpty = false then
      tbEtq.Delete;
end;

procedure TfmetqClientes.bdAddAllClick(Sender: TObject);
begin
    Cursor := crHourGlass;

    gRidResult.Visible:=false;
    gridClientes.Visible := false;
    qr.First;
    while qr.Eof = false do
    begin
       insereCliente();
       qr.Next;
       fmMain.msgStatus( intToStr( qr.RecNo)  );
    end;
    gRidResult.Visible:=true;
    gridClientes.Visible := true;
    tbEtq.First();

    Cursor := crDefault;
end;


procedure TfmetqClientes.listaClientesporCompra();
var
   uo, cmd:String;
begin
   uo := f.getCodUO(cbLojas);
   if ( uo <> '999') then
      uo := dm.getCMD1('Vendas', 'etqcdPescompra.uo', uo)
   else
      uo := '/*uo */';

   cmd :=
   dm.getCMD4('Vendas', 'etqcdPescompra',
      uo,
      fdt.dateToSqlDate(datai.Date),
      fdt.dateToSqlDate(dataf.Date),
      f.valorSql(edVlVenda.Value)
   );

   f.gravaLog('listaClientesporCompra() ');
   listarClientes(cmd);
end;


procedure TfmetqClientes.listasProVEncimento(Sender: Tobject);
var
   host, db, user, password, cmd:String;

begin
   host := dm.GetParamBD('ConexaoLista.host','');
   db := dm.GetParamBD('ConexaoLista.bd','');
   user := dm.GetParamBD('ConexaoLista.user','');
   password := dm.GetParamBD('ConexaoLista.password','');

   conexaoL.close;
   conexaoL.ConnectionString := 'Provider=SQLOLEDB.1;Password='+ password +';Persist Security Info=True;User ID='+ user +';Initial Catalog=' + db +
                                ' ;Data Source='+host+ ';Workstation ID='+ f.getNomeDaEstacao();
   qr.Close;
   qr.Connection := conexaoL;

   cmd := ' select  ' +
          ' numLista as num ' +
          ',noiva as nome ' +
          ',endEntrega as endereco ' +
          ', '''' as numero '+
          ', '' '' as apto ' +
          ', '' '' as compEndereco,  bairro ' +
          ', ''Fortaleza Ce'' as cidade, CEP  '+
          ' from listas '+
          ' where dataCasamento between ' + fdt.DateTimeToSqlDateTime(dtl01.date,'') + ' and ' + fdt.DateTimeToSqlDateTime(dtl02.date,'') +
          ' and loja = ' + cbListas.items[cblistas.itemIndex];

   qr.Connection := conexaoL;

//   funcSQL.AbrirQuery(qr, conexaoL , cmd);
end;

procedure TfmetqClientes.FlatButton8Click(Sender: TObject);
begin
   listasProVencimento(Sender);
end;

procedure TfmetqClientes.verificaCEPinvalido(Sender: TObject);
begin
    tbEtq.First;
    while tbEtq.Eof = false do
    begin
       if tbetq.FieldByName('cep').asString = '0' then
       begin
          msg.msgErro('Existem CEP''s em branco, por favor preencha os CEP''S. '+#13 );
          break;
       end;
       tbEtq.Next
    end;
end;

procedure TfmetqClientes.btPesquisaClick(Sender: TObject);
begin
   case rgTpPesquisa.ItemIndex of
      0: pesquisarClientes(nil, true);
      1: listaClientesporCompra();
      2: btAniversariantesClick();
      3: listasProVEncimento(nil);
      4: listarClientes('Select cd_pes from dspes where codinome = ''Maison''  /*and cd_lojCad in ( 10037736, 10068438) */ and cd_cid in (120041, 12149, 11622, 13358, 12394, 13960, 11568, 10561, 104969) and nr_cep > 0');
      5: listarClientes(msg.msgInput('Comando SQL para listar os is_ref pretendido.'));
   end;

   if (qr.IsEmpty = false) then
   begin
      f.ajGridCol(gRidResult, qr, 'num', -1, '');
      f.ajGridCol(gRidResult, qr, 'NOME', 239, '');
      f.ajGridCol(gRidResult, qr, 'Endereco', 137, '');
      f.ajGridCol(gRidResult, qr, 'numero', 40, '');
      f.ajGridCol(gRidResult, qr, 'apto', 45, '');
      f.ajGridCol(gRidResult, qr, 'CompEndereco', 76, '');
      f.ajGridCol(gRidResult, qr, 'Bairro', 86, '');
      f.ajGridCol(gRidResult, qr, 'Cidade', 127, '');
      f.ajGridCol(gRidResult, qr, 'CEP', 64, '');
   end;
end;

procedure TfmetqClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   if (tbEtq.TableName <> '') then
      tbEtq.Close();

   f.salvaCampos(fmetqClientes);
   fmetqClientes := nil;
   action := caFree;
end;

procedure TfmetqClientes.gridClientesTitleClick(Column: TColumn);
begin
   funcsql.OrganizarTabela(tbEtq, column);
end;

procedure TfmetqClientes.Exportarlista1Click(Sender: TObject);
begin
   fmMain.exportaDataSet(qr, fmMain.getTextGeradorEmail());
end;

procedure TfmetqClientes.imprimeBobina;
var
  i:integer;
  arq:string;
  tempImpr, x01, x02, y01, y02:string;
  lst:Tstringlist;
begin
   lst := tSTringlist.Create();

   arq:=   f.getArqImpPorta();
   DeleteFile(arq);

   x01 := '0380';//'0020';
//   x02 := '0005';
//   y01 := '0085';
 //  y02 := '0050';

   tempImpr := dm.getParamBD('impCodBarras.tempArgox', fmMain.getUoLogada() );

   for i:=0 to strToInt(Edit1.Text)-1 do
   begin
      lst.Add('L');
      lst.Add('H'+ tempImpr);
//                                           +----- Orientacao
//                                           |+-----Fonte
//                                           ||+-----multiplicador horzontal
//                                           |||+----- mult verticcal
//                                           |||| +---subtipo da fonte
//                                           ||||_|__
      lst.Add('311100000150380'+ tbEtq.fieldByName('nome').asString  ); // descricao
      lst.Add('311100000300380'+ tbEtq.fieldByName('endereco').asString + '  ');
      lst.Add('311100000450380'+ 'Nº' + tbEtq.fieldByName('numero').asString + '  ' +tbEtq.fieldByName('compEndereco').asString );
      lst.Add('311100000600380'+ tbEtq.fieldByName('bairro').asString );
      lst.Add('311100000750380'+ tbEtq.fieldByName('cidade').asString );
      lst.Add('311100000900380'+ 'CEP: '+ tbEtq.fieldByName('CEP').asString );
      lst.Add('210000000800070'+ tbEtq.fieldByName('seq').asString  ); // codigo da loja no cantinho
      lst.Add('E');

      if (tbEtq.Eof = true) then
         break
      else
         tbEtq.Next();

   end;
   lst.SaveToFile(arq);
   f.imprimeArquivoPorta(arq, EdLocalImp.Text, true);
   sleep(30);
   lst.Clear();
end;

procedure TfmetqClientes.FlatButton6Click(Sender: TObject);
begin
   imprimebobina();
end;

procedure TfmetqClientes.gRidResultDblClick(Sender: TObject);
var
   i:integer;
begin
   for i:=0 to gRidResult.Columns.Count -1 do
     f.gravaLog(gRidResult.Name + '  '+ gRidResult.Columns[i].Field.FieldName +': '+ intToStr(gRidResult.Columns[i].width) );
end;

procedure TfmetqClientes.FormResize(Sender: TObject);
begin
   pndados.Width := fmetqClientes.Width - 30;
end;

procedure TfmetqClientes.lbSaveClick(Sender: TObject);
begin
   if (tbEtq.IsEmpty = false) then
   begin
      tbEtq.SaveToFile( f.DialogSalvaArq('c:\','tb','tbEtiquetas.tb') );
      msg.msgExclamation('Salvo no arquivo:' + f.DialogSalvaArq('c:\','tb','tbEtiquetas.tb') );
   end;
end;

procedure TfmetqClientes.lbLoadClick(Sender: TObject);
begin
   tbEtq.LoadFromFile( f.dialogAbrArq('tb','c:\'));
end;

procedure TfmetqClientes.btSaveClick(Sender: TObject);
begin
   tbEtq.SaveToFile(f.getDirLogs() + 'etiquetas.tb');
end;

procedure TfmetqClientes.btLoadClick(Sender: TObject);
begin
if   (fileExists(f.getDirLogs() + 'etiquetas.tb') = true) then
   tbEtq.LoadFromFile(f.getDirLogs() + 'etiquetas.tb');
end;


procedure TfmetqClientes.gridClientesDblClick(Sender: TObject);
begin
   tbEtq.First();

   while ( tbEtq.Eof = false) do
   begin
     dm.execSQL('insert tbEtq values( '+ tbEtq.fieldBYName('num').AsString  + ')');
     tbEtq.Next();
   end;
end;

procedure TfmetqClientes.IrParaoRegistro1Click(Sender: TObject);
begin
  if (tbEtq.IsEmpty = false) then
    tbEtq.Locate('seq', msg.msgInput('Sequencial', '0'), []);
end;

procedure TfmetqClientes.SalvaTabela1Click(Sender: TObject);
begin
   tbEtq.SaveToFile(f.getDirLogs() + f.getNomeDaEstacao() + '_tb_etq.tb');
end;

procedure TfmetqClientes.CarregaTabela1Click(Sender: TObject);
begin
   tbEtq.LoadFromFile(f.getDirLogs() + f.getNomeDaEstacao() + '_tb_etq.tb');
end;

end.

