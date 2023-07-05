unit uTabelaModal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uTabela, DB, ADODB, StdCtrls, Buttons, fCtrls, ComCtrls,
  ExtCtrls, TFlatCheckBoxUnit, adLabelEdit, adLabelComboBox,
  TFlatButtonUnit, Grids, DBGrids, SoftDBGrid;

type
  TfmTbModal = class(TfmTabela)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmTbModal: TfmTbModal;

implementation

{$R *.dfm}

procedure TfmTbModal.FormCreate(Sender: TObject);
begin
  inherited;
   Panel1.Visible := false;
   pnPesqItem.Visible := true;
   self.Panel1.Visible := false;
   self.FormStyle := fsStayOnTop;
   self.WindowState := wsNormal;
   self.Position := poMainFormCenter;
   self.ClientWidth := FlatButton1.Left + FlatButton1.Width + 20;
   self.ClientHeight := pnPesqItem.Top + pnPesqItem.Height + 10;
   self.Visible := false;
end;

end.
