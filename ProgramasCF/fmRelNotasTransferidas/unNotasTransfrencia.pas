unit unNotasTransfrencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, Grids, DBGrids, SoftDBGrid, TFlatButtonUnit,
  ComCtrls, ExtCtrls, DB, ADODB, Menus,  fCtrls;

type
  TfmNotasTransf = class(TForm)
    Bevel1: TBevel;
    Label1: TLabel;
    cbStatus: TadLabelComboBox;
    Label2: TLabel;
    btOk: TFlatButton;
    grid: TSoftDBGrid;
    DataSource1: TDataSource;
    tb: TADOTable;
    FlatButton1: TFlatButton;
    cbLojas: TadLabelComboBox;
    PopupMenu1: TPopupMenu;
    Detalhesdanota1: TMenuItem;
    Reiniciaroprocessoderecebimento1: TMenuItem;
    di: TfsDateTimePicker;
    df: TfsDateTimePicker;
    procedure btOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure gridTitleClick(Column: TColumn);
    procedure FlatButton1Click(Sender: TObject);
    procedure Detalhesdanota1Click(Sender: TObject);
    procedure Reiniciaroprocessoderecebimento1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmNotasTransf: TfmNotasTransf;
  QT_DIAS_INTERV_DATA:integer;
implementation

uses uMain, uCF, udm, uLj, f, msg, fdt;
{$R *.dfm}

procedure TfmNotasTransf.btOkClick(Sender: TObject);
var
   cmd:String;
   qrNotas:TADOQuery;
begin
   if (fdt.isIntervDataValido(di, df, true, QT_DIAS_INTERV_DATA) = true) then
   begin
      while tb.IsEmpty = false do tb.Delete;

      cmd := 'Exec zcf_StoListarNotasTransferencia '+
              fdt.DateTimeToSqlDateTime(di.Date,'') + ' , '+
              fdt.DateTimeToSqlDateTime(df.Date,'') + ' , 2, ' +
              f.getNumUO(cbLojas);


      qrNotas := TADOQuery.Create(nil);
      qrNotas.Connection := tb.Connection;
      qrNotas.CommandTimeout := 300;
      qrNotas.sql.add(cmd);
      qrNotas.Open;

      qrNotas.First;
// preencher somente com as notas NAO recebidas
      if cbStatus.ItemIndex = 0 then
      begin
         while qrNotas.Eof = false do
         begin
            if qrNotas.FieldByName('DT_ENTSAI_DOCREF').AsString = '01/01/1900' then
               tb.AppendRecord([ qrNotas.Fields[0].AsInteger,qrNotas.Fields[1].AsString,qrNotas.Fields[2].AsString,qrNotas.Fields[3].AsString,qrNotas.Fields[4].AsString,qrNotas.Fields[5].AsCurrency, '' ]);
            qrNotas.Next;
         end;
      end;
// preencher somente com as notas recebidas
      if cbStatus.ItemIndex = 1 then
      begin
         while qrNotas.Eof = false do
         begin
            if qrNotas.FieldByName('DT_ENTSAI_DOCREF').AsString <> '01/01/1900' then
               tb.AppendRecord([qrNotas.Fields[0].AsInteger, qrNotas.Fields[1].AsString, qrNotas.Fields[2].AsString, qrNotas.Fields[3].AsString, qrNotas.Fields[4].AsString, qrNotas.Fields[5].AsCurrency, qrNotas.Fields[6].AsString ]);
            qrNotas.Next;
         end
      end;

      if cbStatus.ItemIndex = 2 then
      begin
         while qrNotas.Eof = false do
         begin
            if qrNotas.FieldByName('DT_ENTSAI_DOCREF').AsString = '01/01/1900' then
               cmd := ''
            else
               cmd := qrNotas.FieldByName('DT_ENTSAI_DOCREF').AsString;

            tb.AppendRecord([ qrNotas.Fields[0].AsInteger,qrNotas.Fields[1].AsString,qrNotas.Fields[2].AsString,qrNotas.Fields[3].AsString,qrNotas.Fields[4].AsString,qrNotas.Fields[5].AsCurrency,cmd]);
            qrNotas.Next;
         end;
      end;
      fmMain.MsgStatus('Total de Notas: ' + intToStr(tb.RecordCount));
      tb.First;
   end;
end;

procedure TfmNotasTransf.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := CaFree;
   fmNotasTransf := nil;
end;

procedure TfmNotasTransf.FormCreate(Sender: TObject);
begin
   di.Date := now - 5;
   df.Date := now;
   dm.getTable(tb, 'is_nota int primary key, [Data Emissao] varchar(10), [Loja] varchar(40), [Serie] varchar(03), [Nota] varchar(06), [Valor] money, [Data Recebimento] varchar(10) ');

   uLj.getListaLojas(cbLojas, false, false, fmMain.getCdPesLogado(), '' );

   grid.Columns[0].Visible := false;
   Reiniciaroprocessoderecebimento1.Enabled := not(fmMain.isGrupoRestrito(106));

      if (fmMain.isAcessoTotal(fmMain.Relacaodenotasdetransferncia1.Tag) = true) then
		QT_DIAS_INTERV_DATA := 99999
   else
		QT_DIAS_INTERV_DATA := 31;

end;


procedure TfmNotasTransf.gridTitleClick(Column: TColumn);
begin
   dm.organizarTabela(tb, grid, Column);
end;

procedure TfmNotasTransf.FlatButton1Click(Sender: TObject);
var
   Par:TStringList;
begin
    if tb.IsEmpty = false then
    begin
       par:= TStringList.Create();
       par.Add( uLj.getNomeUO(cbLojas) );
       par.Add(dateToStr(di.date));
       par.Add(dateToStr(df.date));
       par.Add(fmMain.StatusBar1.Panels[1].text);
       fmMain.imprimeRave(tb, nil, nil, nil, nil, 'rpRelNotasT',par);
    end
end;

procedure TfmNotasTransf.Detalhesdanota1Click(Sender: TObject);
begin
   if tb.IsEmpty = false then
       fmMain.mostraDetalhesNota(tb.fieldByName('is_nota').AsString);
end;

procedure TfmNotasTransf.Reiniciaroprocessoderecebimento1Click(Sender: TObject);
var
   ds:TdataSet;
   cmd:String;
begin
   if (tb.IsEmpty = false) then
      if (tb.FieldByName('Data Recebimento').asString  = '') then
      begin
         cmd :=  dm.getCMD( 'fiscal', 'LiberaRecNF');         dm.execSQL(cmd);
         msg.msgExclamation('msgNfLiberada');
      end
      else
         msg.msgErro('Essa nota já foi confirmada.');



end;

end.
