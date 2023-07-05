unit fmuEntUsaivdMed;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, SoftDBGrid, StdCtrls, adLabelListBox,
  ExtCtrls, adLabelEdit, adLabelComboBox, TFlatButtonUnit;

type
  TForm1 = class(TForm)
    pnTitulo: TPanel;
    btGeraEstoque: TFlatButton;
    cbLoja: TadLabelComboBox;
    edit1: TadLabelEdit;
    Panel1: TPanel;
    lbNivel: TLabel;
    lbVlCat: TLabel;
    lbClasse1: TLabel;
    lbClasse2: TLabel;
    lbClasse3: TLabel;
    Bevel1: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    FlatButton7: TFlatButton;
    pnForn: TPanel;
    btAddForn: TFlatButton;
    btRemoveForn: TFlatButton;
    lbForn: TadLabelListBox;
    grid: TSoftDBGrid;
    tbGE: TADOTable;
    DataSource1: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
