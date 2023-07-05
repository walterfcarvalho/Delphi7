unit uetqNotas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, adLabelEdit, adLabelComboBox, funcsql, f,
  DB, ADODB;

type
  TfmEtq = class(TForm)
    cbLojas: TadLabelComboBox;
    edSrNota: TadLabelEdit;
    edNNota: TadLabelEdit;
    FlatButton4: TFlatButton;
    procedure FlatButton4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmEtq: TfmEtq;

implementation
uses uMain, uEtiquetas, uDm;
{$R *.dfm}

procedure TfmEtq.FlatButton4Click(Sender: TObject);
var
   qr:TADOQuery;
   cmd:String;
begin
   cmd := 'select crefe.cd_ref, dmovi.qt_mov from crefe (nolock) ' +
          'inner join dmovi (nolock) on crefe.is_ref = dmovi.is_ref where dmovi.is_nota in (  select is_nota from dnota where ' +
          ' is_estoque = ' +  f.getCodUo(cbLojas) +  ' and nr_docf = ' + edNNota.text  + ' and sr_docf = + ' + quotedStr( edSrNota.Text) + ' ) ' ;

   dm.getQuery(qr, cmd );

   if qr.RecordCount > 0 then
   begin
      showMessage( ' itens ' + intToStr(qr.RecordCount));

      qr.First;
      while qr.Eof = false do
      begin
         fmEtiquetas.EdCodigo.Text := qr.fieldByName('cd_ref').asString;
         fmEtiquetas.edQuant.Text := qr.fieldByName('qt_mov').AsString;
         fmEtiquetas.btConsultaClick(nil);
         fmEtiquetas.btAddItemParaImpClick(nil);
         qr.Next;
      end;
   end;
   fmEtq.Close;
end;

procedure TfmEtq.FormCreate(Sender: TObject);
begin
   cbLojas.Items := fmEtiquetas.cbLojas.Items;
   fmMain.getParametrosForm(fmEtq);
end;

procedure TfmEtq.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := cafree;
   fmEtq := nil;
end;

end.
