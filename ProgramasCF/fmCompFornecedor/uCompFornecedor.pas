unit uCompFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  DB, ADODB, TFlatButtonUnit, ComCtrls, fCtrls, StdCtrls, adLabelComboBox,
  Dialogs, Grids, DBGrids, adLabelEdit;

type
  TfmCompFornecedor = class(TForm)
    FlatButton1: TFlatButton;
    qrCredores: TADOQuery;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    cbEmpresa: TadLabelComboBox;
    cbTpRel: TadLabelComboBox;
    GroupBox1: TGroupBox;
    dti: TfsDateTimePicker;
    dtf: TfsDateTimePicker;
    Label1: TLabel;
    edCodForn: TadLabelEdit;
    lbCred: TLabel;
    tbFichas: TADOTable;
    tbFichasdt_entsai: TDateTimeField;
    tbFichascd_cred: TStringField;
    tbFichasnm_razsoc: TStringField;
    tbFichasserie: TStringField;
    tbFichasnumNota: TStringField;
    tbFichasficha: TIntegerField;
    tbFichascd_loja: TStringField;
    tbFichasnumPar: TStringField;
    tbFichasdataVencimento: TDateTimeField;
    tbFichasvalPar: TBCDField;
    tbFichassitPar: TStringField;
    tbFichasdatPag: TDateTimeField;
    tbFichasvalpag: TBCDField;
    procedure FlatButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure listarFichas();
    procedure carregaCodfornecedor(cod:String);
    procedure edCodFornDblClick(Sender: TObject);
    procedure FlatButton1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCompFornecedor: TfmCompFornecedor;

implementation

{$R *.dfm}
uses uMain, cf, uDm, funcsql, f, fdt, msg, uLj, uPessoa;

procedure TfmCompFornecedor.FormCreate(Sender: TObject);
begin
   uLj.getListaEmpresas(cbEmpresa);
   fmMain.getParametrosForm(self);
   fdt.formataIntervDatas( dm.getDateBd(), dti, dtf);
   cbTpRel.Free();
end;

procedure TfmCompFornecedor.listarFichas;
var
  strIntDatas, strIsGerencial, strCredor, cmd:String;
  params:Tstringlist;
begin
   strIntDatas := ' ( dspar.datven between ' + fdt.dataToSqlInt(dti.Date)  +' and '+ fdt.dataToSqlInt(dtf.Date) + ') ';

   if tbFichas.TableName <> '' then
      tbFichas.Close();

   strCredor := '';
   if (edCodForn.Text <> '') then
      strCredor := ' and dscre.cd_cred = ' + quotedStr(edCodForn.Text);

   strIsGerencial := '';
   if (cbTpRel.ItemIndex = 0) then
      strIsGerencial :=  ' and dsdct.serie <> ''PF'' ';

   cmd :=
         ' dt_entsai smallDateTime, cd_cred varchar(05), nm_razsoc varchar(60), serie varchar(03),' +
         ' numNota varchar (08), ficha int, cd_loja varchar(02), numPar varchar(01), dataVencimento smallDateTime, valPar money, ' +
         ' sitPar varchar(01), datPag smallDateTime, valpag money ';

   dm.getTable(tbFichas, cmd);
   DataSource2.DataSet := tbFichas;

   cmd :=
   ' insert '+ tbFichas.TableName +
   ' select ' + #13+
   ' dnota.dt_entsai, ' + #13+
   ' dscre.cd_cred, dscre.nm_razsoc,' + #13+
   ' dsdct.serie, dsdct.docume as numNota, dsdct.numDoc as ficha, dsdct.cd_loja, '+#13+
   ' dspar.numPar, dbo.dateIntTodate(dspar.datven) as dataVencimento ,dspar.valPar, case dspar.sitPar when '''' then ''A'' else dspar.sitPar end as sitPar, '+ #13+
   ' case dspag.datpag when 0 then '''' else dbo.dateIntTodate(dspag.datpag) end as datPag, dspag.valpag' +
   ' from dnota (nolock) ' +#13+
   ' inner join dscre (nolock) on dnota.st_nf = '''' and  dnota.cd_pes = dscre.cd_pes ' + strCredor +#13+
   ' inner join toper (nolock) on toper.is_oper = dnota.is_oper and toper.codTransacao = 1 ' +#13+
   ' inner join dsdct (nolock) on rtrim(ltrim(dnota.nr_docf)) = (dsdct.docume) and  dnota.sr_docf = dsdct.serie and dscre.cd_cred = dsdct.credor '+#13+
   ' inner join dspar (nolock) on dsdct.numdoc = dspar.numDoc  and dspar.credor = dsdct.credor '+#13+
   ' left join dspag  (nolock) on dspag.numdoc = dspar.numdoc and  dspar.numpar  = dspag.numpar ' +#13+
   ' where ' + #13+
   ' dspar.cd_loja in ( select cd_uo from zcf_tbuo where cd_emp = '+quotedStr(cbEmpresa.Items[cbEmpresa.ItemIndex]) + ' )' + #13+
   ' and ('+ strIntDatas + ' and  dspag.datPag  > ' + fdt.dataToSqlInt(dtf.Date) +  ' and dspar.valPar > 0 )' +#13+
   ' or ( ' + strIntDatas  +' and dspag.datPag  is null and dspar.valPar > 0) ' +#13+
   ' order by  dspar.numDoc, dspar.numPar' ;

   dm.execSQL(cmd);
   tbFichas.Close();
   tbFichas.Open();
//Query da cabe�a da ficha
   cmd := 'Select distinct cd_cred, nm_razsoc from ' + tbFichas.TableName;
   dm.getQuery(qrCredores, cmd );

    if (qrCredores.IsEmpty = false)  then
   begin
      params := TStringList.Create();
      params.Add(cbEmpresa.Items[cbEmpresa.itemIndex]);
      params.Add(cbTpRel.Items[cbTpRel.itemIndex]);
      params.Add(dateToStr(dti.Date));
      params.Add(dateToStr(dtf.Date) );
      params.Add(fmMain.getNomeUsuario() );
      fmMain.imprimeRave(qrCredores, tbFichas, nil, nil, nil, 'rpParcFornFicha', params );
   end
   else
      msg.msgErro('N�o contrei nenhum compromisso que satisfa�a esses crit�rios.');
end;

procedure TfmCompFornecedor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   edCodForn.Text := '';
   f.salvaCampos(self);
   Action := caFree;
   fmCompFornecedor := nil
end;


procedure TfmCompFornecedor.carregaCodFornecedor(cod: String);
var
   cd_pes, ds_pes, ds_end:String;
   ds:TdataSet;
begin
   fmMain.getDadosFornecedor(cd_pes, ds_pes, ds_end);
   if ( cd_pes <> '') then
   begin
      ds := uPessoa.getDadosFornecedor(cd_pes,'');
      edCodForn.Text := ds.fieldByName('is_cred').AsString;
      lbCred.Caption := ds.fieldByName('fornecedor').AsString;
      ds.Destroy();
   end
   else
   begin
      edCodForn.Text := '';
      lbCred.Caption := '';
   end;
   ds.Free();
   edCodForn.SelectAll();
end;

procedure TfmCompFornecedor.FlatButton1Click(Sender: TObject);
begin
   if ( fdt.isIntervDataValido(dti, dtf, true) = true) then
      listarFichas();
end;

procedure TfmCompFornecedor.edCodFornDblClick(Sender: TObject);
begin
   carregaCodFornecedor('');
end;

procedure TfmCompFornecedor.FlatButton1DblClick(Sender: TObject);
begin
  edCodForn.SetFocus;
end;

end.
