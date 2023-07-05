unit fmAbrirAvarias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, adLabelComboBox, TFlatButtonUnit, ExtCtrls,
  Grids, DBGrids, SoftDBGrid, fCtrls, DB, ADODB, RpBase,
  RpSystem, RpCon, RpConDS, RpDefine, RpRave;

type
  TfmAbrirAvaria = class(TForm)
    dbgrid: TSoftDBGrid;
    cbLojas: TadLabelComboBox;
    dti: TDateTimePicker;
    btBusca: TFlatButton;
    dtf: TDateTimePicker;
    cBoxIntervalo: TfsCheckBox;
    Bevel1: TBevel;
    Label1: TLabel;
    QrBusca: TADOQuery;
    DataSource1: TDataSource;
    pnConfirma: TPanel;
    btOk: TFlatButton;
    btFechar: TFlatButton;
    qrCabeca: TADOQuery;
    qrCorpo: TADOQuery;
    FlatButton3: TFlatButton;
    cbStatus: TadLabelComboBox;
    cbImpCustoAvaria: TfsCheckBox;
    cbTipoImpresao: TadLabelComboBox;
    procedure FormCreate(Sender: TObject);
    procedure btBuscaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btOkClick(Sender: TObject);
    procedure btFecharClick(Sender: TObject);
    procedure dbgridDblClick(Sender: TObject);
    procedure FlatButton3Click(Sender: TObject);
    procedure preparaParaListarMapa(Sender:Tobject);
    procedure dbgridTitleClick(Column: TColumn);
    procedure preparaParaListarAvaria(tag:Integer);
    procedure AbrirAvaria(Sender:Tobject);
    procedure imprimirAvaria(Sender:Tobject);
    procedure abrirMapa(Sender:Tobject);
    procedure pesquisaAvarias(di,df:Tdate);
    procedure pesquisaMapa(Sender:Tobject; di,df:Tdate);
    procedure deletarAvaria();
    procedure deletarMapa(Sender:Tobject);
    procedure preparaimpressaoAvarias();
    procedure transfereAvaria();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAbrirAvaria: TfmAbrirAvaria;
  tipoConsulta:smallInt;
implementation
uses uAvarias, umain, uMapa, uCF, uDm, uUsuarios, uLj, FuncSQL, f, msg, fdt;
{$R *.dfm}

procedure TfmAbrirAvaria.FormCreate(Sender: TObject);
begin
   uLj.getListaLojas(cbLojas, true, false, '', fmMain.getUoLogada() );
   dti.Date :=  strToDate('01/' + copy(dateToStr(now),04,07));
   dtf.Date := now;
end;

procedure TfmAbrirAvaria.pesquisaMapa(Sender: Tobject; di, df: Tdate);
begin
   qrBusca.SQL.Clear;
   qrBusca.sql.add('exec zcf_stolistarMapasSep ' + fdt.DateTimeToSqlDateTime(di,'') +' , '+ fdt.DateTimeToSqlDateTime(df,'') +' , '+  intToStr(cbStatus.itemIndex-1) );
   qrBusca.Open;
   dbgrid.Columns[0].width :=  80;
   dbgrid.Columns[01].width :=  200;
   dbgrid.Columns[02].width :=  70;
   dbgrid.Columns[03].width :=  100;
   dbgrid.Columns[04].width :=  70;
end;

procedure TfmAbrirAvaria.pesquisaAvarias(di, df: Tdate);
var
   status,uo:string;
begin
   uo := '';
   status := '';
   if cbStatus.ItemIndex >0 then
      status := intToStr(cbStatus.ItemIndex -1);
   if cbLojas.ItemIndex > 0 then
      uo := f.getCodUO(cbLojas);

   qrbusca.SQL.Clear;
   if cBoxIntervalo.Checked = false then
      qrBusca.SQL.Add(' Exec zcf_ListarAvaria @numAvaria='''' ' +' , @uo='+ QuotedStr(uo) +' , @dti= '''' '+ ' , @dtf = '''' , @ehAprovada = ' + quotedStr(status) )
   else
      qrBusca.SQL.Add(' Exec zcf_ListarAvaria @numAvaria='''' ' +' , @uo='+ QuotedStr(uo) +' , @dti='+ fdt.dateToSqlDate(dti.date) +' , @dtf =  '+ fdt.dateToSqlDate(dtf.date) + '  , @ehAprovada = ' + quotedStr(status)) ;

   qrBusca.Open;

   dbgrid.Columns[0].width :=  70;
   dbgrid.Columns[01].width :=  90;
   dbgrid.Columns[02].width :=  120;
   dbgrid.Columns[03].width :=  64;
   dbgrid.Columns[04].width :=  100;
   dbgrid.Columns[05].width :=  100;
   dbgrid.Columns[06].visible := false;
   dbgrid.Columns[ QrBusca.FieldByName('uo').Index ].visible := false;
   dbgrid.Columns[ dbgrid.Columns.Count-1].Visible := false;
end;


procedure TfmAbrirAvaria.btBuscaClick(Sender: TObject);
var
   di,df:Tdate;
begin
   if cBoxIntervalo.Checked = true then
   begin
     di := dti.Date;
     df := dtf.Date;
   end
   else
   begin
      di := strToDate('01/01/2000');
      df := strToDate('01/01/2050');
   end;
   case fmAbrirAvaria.Tag of
      1,2,4:pesquisaAvarias(di, df);
      3: pesquisaMapa(nil,di,df);
   end;
end;

procedure TfmAbrirAvaria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmAbrirAvaria := nil;
   action := CaFree;
end;

procedure TfmAbrirAvaria.btFecharClick(Sender: TObject);
begin
   fmAbrirAvaria.Close;
end;

procedure TfmAbrirAvaria.dbgridDblClick(Sender: TObject);
begin
   if qrBusca.IsEmpty = false then
      btOkClick(Sender);
end;

procedure TfmAbrirAvaria.deletarAvaria();
var
  numAvaria, ret:String;
begin
   numAvaria := qrBusca.FieldByname('Numero').AsString;

   ret := ' Deseja deletar essa avaria?                             '+#13+
           ' Loja: ' + numAvaria +#13+
           ' Remessa: ' + qrBusca.FieldByname('Numero').AsString +#13+#13+
           ' Para deletar essa remessa é necessário a senha de autorização.';

   if (msg.msgQuestion(ret) = mrYes) then
      if ( uUsuarios.getAutorizadorWell('', dm.GetParamBD('avarias.grupoQueDeleta', ''), '') <> '' )then
      begin
         ret :=
         ' update zcf_avarias set ehAtiva = 0 where numAvaria = ' +
         numAvaria + ' and Loja = ' + qrBusca.fieldByName('uo').AsString;

         dm.execSQL(ret);
         btBuscaClick(nil);
         msg.msgExclamation(' A remessa foi excluída... ');
      end;
end;

procedure TfmAbrirAvaria.deletarMapa(Sender:Tobject);
var
   ret:String;
begin
   ret := ' Deseja deletar esse mapa?                            '+#13+
          ' Numero: ' + qrBusca.FieldByname('Numero').AsString    +#13+
          ' Criador: ' + qrBusca.FieldByname('criador').AsString  +#13;

   if msg.msgQuestion(ret) = mrYes then
      if uUsuarios.getAutorizadorWell('', '13', dm.openSQL('Select criador from zcf_mapaSEparacao where num = ' +qrBusca.FieldByname('Numero').AsString, 'criador') ) <> '' then
      begin
         dm.ExecSQL('Delete from zcf_mapaSeparacao where num =  ' + qrBusca.FieldByname('Numero').AsString);
         btBuscaClick(sender);
         msg.msgExclamation(' O mapa foi excluido... ');
      end;
end;

procedure TfmAbrirAvaria.FlatButton3Click(Sender: TObject);
begin
   if (qrBusca.IsEmpty = false ) then
      case fmAbrirAvaria.Tag of
         1,2: deletarAvaria();
         3:deletarMapa(nil);
      end;
end;

procedure TfmAbrirAvaria.preparaParaListarMapa(Sender: Tobject);
begin
   cbLojas.Visible := false;
   fmAbrirAvaria.Caption := 'Pesquisa mapa separacao';
   fmAbrirAvaria.tag := 3;
end;

procedure TfmAbrirAvaria.preparaParaListarAvaria(tag:Integer);
begin
   cbLojas.Visible := true;
   FlatButton3.Visible := true;
   fmAbrirAvaria.Caption := 'Pesquisa avarias';
   fmAbrirAvaria.tag := tag;

   Case tag of
      2: preparaimpressaoAvarias();
   end;


   if ( pos(fmMain.getGrupoLogado(), dm.GetParamBD('avarias.grImpCusto','')) > 0 ) and (fmAbrirAvaria.Tag = 2) then
      cbImpCustoAvaria.Visible := true;
end;

procedure TfmAbrirAvaria.dbgridTitleClick(Column: TColumn);
begin
   funcsql.OrganizarQuery(qrBusca, Column);
end;

procedure TfmAbrirAvaria.AbrirAvaria(Sender: Tobject);
begin
   fmCadAvarias.CarregarCabecalhoAvarias(qrBusca.fieldByName('numero').AsString, qrBusca.fieldByName('uo').AsString );
   fmCadAvarias.CarregaItensAvarias(qrBusca.fieldByName('numero').AsString, qrBusca.fieldByName('uo').AsString );
   fmAbrirAvaria.Hide;
end;

procedure TfmAbrirAvaria.imprimirAvaria(Sender: Tobject);
var
   params:TStringlist;
   cmd:String;
begin
   params := TStringList.Create();
   qrCabeca.SQL.Clear;
   qrCabeca.SQL.Add(' Exec zcf_ListarAvaria @numAvaria = '+ qrBusca.fieldByName('numero').AsString +' , @uo = '+ quotedStr( qrBusca.fieldByName('uo').AsString)+ ' , @dtI= '''' , @dtF = '''' ');
   qrCorpo.sql.Clear;
   cmd :=         (' select ava.numAvaria, crefe.cd_ref as CODIGO, crefe.ds_ref AS DESCRICAO, ava.*, dspes.nm_fantasi, ' +
                   ' case ava.origem when ''0'' then ''Cliente'' when ''1'' then ''Funcionario'' when ''2'' then ''CD'' when ''3'' then ''Gerente/SubGerente'' end as DescOrigem ' +
                   ' from zcf_AvariasItens ava with(noLock)' +
                   ' inner join crefe with(noLock) on ava.is_ref = crefe.is_ref '+
                   ' inner join dspes on crefe.cd_pes = dspes.cd_pes ' +
                   ' where ava.numAvaria =' + qrBusca.fieldByName('numero').AsString +
                   ' and ava.loja = ' + QuotedStr(qrBusca.fieldByName('uo').AsString) ) ;

                   if ( cbTipoImpresao.itemIndex = 0) then
                      cmd := cmd + ' order by crefe.ds_ref'
                   else
                      cmd := cmd + ' order by crefe.cd_ref' ;


                  qrCorpo.SQL.Add(cmd );
   qrCabeca.open;
   qrCorpo.Open;
   params.Add(sysutils.boolToStr(cbImpCustoAvaria.Checked, true));
   fmMain.imprimeRave(qrCabeca, qrCorpo, nil, nil, nil, 'rpAvarias', params )
end;

procedure TfmAbrirAvaria.abrirMapa(Sender: Tobject);
begin
   fmMapa.CarregaMapa(QrBusca.FieldByName('numero').AsString );
   fmAbrirAvaria.Close;
end;

procedure TfmAbrirAvaria.btOkClick(Sender: TObject);
begin
   Screen.cursor := CrHourGlass;
   if QrBusca.IsEmpty = false then
      case fmAbrirAvaria.Tag of
          1:AbrirAvaria(nil);
          2:imprimirAvaria(nil);
          3:abrirMapa(nil);
          4:transfereAvaria();
      end;
   btFecharClick(nil);
   Screen.cursor := Crdefault;
end;


procedure TfmAbrirAvaria.preparaimpressaoAvarias;
begin
   cbTipoImpresao.Visible := true;
end;

procedure TfmAbrirAvaria.transfereAvaria;
var
   cmd, uo:String;
begin
   uo := uLj.getIsUo(false);
   if (uo <> '') and (uo <> '999')  then
      if (qrBusca.fieldByName('dataAprovacao').AsString <> '') then
      begin
         if ( msg.msgQuestion('Deseja setar a loja para desconto dessa avaria ?') = mrYes) then
         begin
            cmd := ' update zcf_avarias set codLojaDesconto = ' + uo  +
                   ' where numAvaria= ' + qrBusca.fieldByName('numero').AsString + ' and  loja = '+ qrBusca.fieldByName('uo').AsString;
            dm.execSQL(cmd);
            cmd := ' update zcf_avariasItens set codLojaDesconto = ' + uo  +
                   ' where numAvaria= ' + qrBusca.fieldByName('numero').AsString +  ' and  loja = '+ qrBusca.fieldByName('uo').AsString ;
            dm.execSQL(cmd);
            msg.msgExclamation(dm.getMsg('MSG_SUCESSO'));
         end
      end;
end;

end.



