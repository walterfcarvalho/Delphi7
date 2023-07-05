unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TFlatButtonUnit, StdCtrls, adLabelComboBox, DB, ExtCtrls, ADODB,
  Grids, DBGrids, Mask, DBCtrls, adLabelDBEdit, adLabelDBLookupComboBox,
  SoftDBGrid, funcoes;

type
  TfmSugestao = class(TForm)
    BitBtn6: TFlatButton;
    CB1: TadLabelComboBox;
    Panel1: TPanel;
    DataSource1: TDataSource;
    ledit1: TadLabelDBEdit;
    Panel2: TPanel;
    bitbtn1: TFlatButton;
    bitbtn2: TFlatButton;
    Panel3: TPanel;
    BitBtn3: TFlatButton;
    BitBtn4: TFlatButton;
    BitBtn5: TFlatButton;
    Lookup1: TadLabelDBLookupComboBox;
    DataSource2: TDataSource;
    ADOTable1: TADOTable;
    edit1: TadLabelDBEdit;
    Query1: TADOQuery;
    DBGrid1: TSoftDBGrid;
    procedure BitBtn6Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CB1Change(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure bitbtn1Click(Sender: TObject);
    procedure bitbtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmSugestao: TfmSugestao;

implementation

uses Unit1, msg, uDm;

{$R *.dfm}

procedure TfmSugestao.BitBtn6Click(Sender: TObject);
begin
   close;
end;

procedure TfmSugestao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := Cafree;
   FormStyle := fsMDIForm;
   fmMain.mostraMenu(sender);
end;

procedure TfmSugestao.CB1Change(Sender: TObject);
begin
   with query1.SQL do
   begin
      clear;
      add('Select ref, tplista,  tpProd, descricao from sugestao where tpLista = '+quotedStr(funcoes.tiraEspaco(copy(cb1.items[cb1.ItemIndex],40,20)) ) +' order by tpProd, Descricao');
   end;
   query1.Open;

   dbgrid1.Columns[2].Title.caption   := 'Tipo';
   dbgrid1.Columns[3].Title.caption   := 'Descrição';

   dbgrid1.Columns[0].Visible := false;
   dbgrid1.Columns[1].Visible := false;
   panel3.Visible := true;
   dbgrid1.Visible:= true;

   ledit1.DataField := 'descricao';
   edit1.DataField := 'tplista';
   lookup1.DataField := 'tpprod';
end;

procedure TfmSugestao.BitBtn5Click(Sender: TObject);
begin
  if msg.msgQuestion(' Deleta esse item ? '+#13) = mrYes then
    query1.Delete;
end;

procedure TfmSugestao.BitBtn3Click(Sender: TObject);
begin
   dbgrid1.enabled := false;
   panel1.Visible := true;
   ledit1.SetFocus;
   adotable1.Active:= true;
   query1.Append;

   edit1.text :=  Funcoes.tiraEspaco(copy(cb1.items[cb1.ItemIndex],40,20));
   panel2.Visible := true;
   panel3.Visible := false;
   CB1.Enabled := false;
end;

procedure TfmSugestao.bitbtn1Click(Sender: TObject);
begin
   query1.Post;
   bitbtn2Click(Sender);   
end;

procedure TfmSugestao.bitbtn2Click(Sender: TObject);
begin
   query1.Cancel;
   panel1.Visible:= false;
   panel2.Visible := false;
   panel3.Visible := true;
   dbgrid1.Enabled := true;
   CB1.Enabled := true;
end;

procedure TfmSugestao.BitBtn4Click(Sender: TObject);
begin
   dbgrid1.enabled := false;
   query1.edit;
   panel1.visible := true;
   panel2.visible := true;
   CB1.Enabled := false;
   ADOTable1.Active := true; 
end;

procedure TfmSugestao.FormShow(Sender: TObject);
begin
   cb1.Items := fmMain.GetTiposListas(false, '');
end;

procedure TfmSugestao.FormResize(Sender: TObject);
begin
   bitbtn6.left := fmSugestao.Width - bitbtn6.Width - 12;
   panel3.Left := fmSugestao.Width - panel3.Width - 12;
   panel2.Left := fmSugestao.Width - panel2.Width - 12;
   dbgrid1.Height :=  fmSugestao.Height - panel2.Top - panel2.Height - 112;
end;

end.
