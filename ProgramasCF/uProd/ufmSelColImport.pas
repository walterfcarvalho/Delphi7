unit ufmSelColImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, SoftDBGrid, uDm, DB, ADODB, StdCtrls,
  Buttons, fCtrls, adLabelComboBox, adLabelEdit, adLabelNumericEdit,
  adLabelSpinEdit;

type
  TfmSelColImport = class(TForm)
    SoftDBGrid1: TSoftDBGrid;
    Panel1: TPanel;
    btCancela: TfsBitBtn;
    btOk: TfsBitBtn;
    DataSource1: TDataSource;
    tb: TADOTable;
    cbCod: TadLabelComboBox;
    cbQt: TadLabelComboBox;
    procedure carregaDadosTb(nmTb:String);
    procedure FormCreate(Sender: TObject);
    procedure btOkClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSelColImport: TfmSelColImport;

implementation

	uses f, msg;

{$R *.dfm}

procedure TfmSelColImport.carregaDadosTb(nmTb:String);
begin
	tb.TableName := nmTb;
   tb.Open();

   cbCod.Items := f.getCamposDataSet(tb);
   cbQt.Items := f.getCamposDataSet(tb);

   f.ajGridCol(SoftDBGrid1, tb, 'is_ref', 0, '');
   f.ajGridCol(SoftDBGrid1, tb, 'qt_mov', 0, '');
end;

procedure TfmSelColImport.FormCreate(Sender: TObject);
begin
	SoftDBGrid1.Align := alClient;
end;

procedure TfmSelColImport.btOkClick(Sender: TObject);
begin
	if (cbCod.ItemIndex >= 0) or (cbQt.ItemIndex > 0) then
   	fmSelColImport.ModalResult := mrOk
   else
   begin
   	msg.msgErro(dm.getMsg('msg_filtro_excel'));
   	fmSelColImport.ModalResult := mrCancel;
   end;
end;

end.
