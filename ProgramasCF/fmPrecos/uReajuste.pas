unit uReajuste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, ADODB, Grids, DBGrids, SoftDBGrid, cf,
  TFlatButtonUnit, adLabelNumericEdit, StdCtrls, adLabelEdit, funcsql,
  TFlatCheckBoxUnit, adLabelComboBox, f;

type
  TfmReajuste = class(TForm)
    edCodigo: TadLabelEdit;
    edIPI: TadLabelNumericEdit;
    FlatButton4: TFlatButton;
    gpReajuste: TSoftDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    FlatButton1: TFlatButton;
    cbPc01: TadLabelComboBox;
    tb: TADOTable;
    chArredonda: TFlatCheckBox;
    cbPc02: TadLabelComboBox;
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
    procedure FlatButton4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
    procedure btGetCategoriasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmReajuste: TfmReajuste;

implementation

uses uMain, Uprecoswell, uDm, uPreco;

{$R *.dfm}

procedure TfmReajuste.FlatButton4Click(Sender: TObject);
var
  pc2, cmd :String;
  qr:TADOquery;
begin
   if ((edCodigo.text <> '') or (lbNivel.Caption <> '0')) and (edIPI.Value <> 0)  then
   begin
      qr := TADOQuery.Create(nil);

      uPreco.listaTabelaPrecos(
         0,
         0,
         '',
         edCodigo.Text,
         fmMain.getUoLogada(),
         f.getCodPc(cbPc01),
         f.getCodPc(cbPc02),
         lbNivel.Caption,
         lbVlCat.Caption,
         qr, 0
      );

      if tb.TableName = '' then
         dm.getTable(tb, 'is_ref int, [codigo] varchar(08) , [Descricao] varchar(50),  [PrecoAntigo] money , [PrecoNovo] money,  CRCU money');


      while tb.IsEmpty = false do
        tb.Delete;


      f.ajGridCol(gpReajuste, tb, 'is_ref', 0, '');
      f.ajGridCol(gpReajuste, tb, 'codigo', 60, 'Codigo');
      f.ajGridCol(gpReajuste, tb, 'codigo', 150, 'Descrição');
      f.ajGridCol(gpReajuste, tb, 'PrecoAntigo', 60, 'Pc antigo');
      f.ajGridCol(gpReajuste, tb, 'PrecoNovo', 60, 'Pc novo');


      gpReajuste.Columns[00].Visible := false;
      gpReajuste.Columns[01].Width := 50;
      gpReajuste.Columns[02].Width := 200;
      gpReajuste.Columns[03].Width := 50;
      gpReajuste.Columns[04].Width := 50;


      qr.First;
      while (qr.Eof = false) do
      begin
         tb.Append();
         tb.FieldByName('is_ref').Assign(qr.FieldByName('is_ref'));
         tb.FieldByName('codigo').Assign(qr.FieldByName('codigo'));
         tb.FieldByName('Descricao').Assign(qr.FieldByName('descricao'));
         tb.FieldByName('PrecoAntigo').Assign(qr.FieldByName('Preco 01'));


         if tb.FieldByName('PrecoAntigo').asFloat > 0 then
            tb.FieldByName('PrecoNovo').AsString :=  f.calculaReajuste( qr.FieldByName('Preco 01').asFloat , edIPI.Value, chArredonda.Checked );

         tb.post;
         qr.Next;
      end;
      qr.Free();
   end;
end;


procedure TfmReajuste.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmReajuste := nil;
   action := cafree;
end;

procedure TfmReajuste.FormShow(Sender: TObject);
begin
   cbPc01.items :=  uPreco.getListaPrecos( false, false, false, fmMain.getGrupoLogado());
   cbPc02.items :=  uPreco.getListaPrecos( true, true, false, fmMain.getGrupoLogado());
   cbPc01.ItemIndex :=0;
   cbPc02.ItemIndex :=0;
end;

procedure TfmReajuste.FlatButton1Click(Sender: TObject);
var
  pcNovo, pcNovo2, pcNovo3:real;
begin
   tb.First;
   while tb.Eof = false do
   begin

        if tb.FieldByName('precoNovo').asFloat > 0 then
           fmLancaPc.tb.AppendRecord([
              tb.fieldByName('codigo').AsString,
              tb.fieldByName('descricao').AsString,
              tb.fieldByname('precoAntigo').asString,
              tb.fieldByname('precoNovo').asString,
              fmLancaPc.AjustaPreco( tb.fieldByname('precoNovo').asString , '1,'+fmLancaPc.edVlMrg02.TEXT , chArredonda.checked ),
              fmLancaPc.AjustaPreco( tb.fieldByname('precoNovo').asString , '1,'+fmLancaPc.edVlMrg03.TEXT , chArredonda.checked ),
              tb.fieldByName('is_ref').AsString,
              tb.fieldByName('CRCU').AsString
          ]);
             tb.Next;
   end;
end;

procedure TfmReajuste.btGetCategoriasClick(Sender: TObject);
begin
   fmMain.ajustaValoresCategorias(lbClasse1, lbClasse2, lbClasse3, lbNivel, lbVlCat);
end;

end.
