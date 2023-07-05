unit uDirDialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TFlatButtonUnit, FileCtrl, Buttons, fCtrls, ExtCtrls;

type
  TfmDirDialog = class(TForm)
    lbArquivos: TFileListBox;
    Panel1: TPanel;
    Label1: TLabel;
    cbUnidades: TDriveComboBox;
    lbDiretorios: TDirectoryListBox;
    Splitter1: TSplitter;
    fsBitBtn1: TfsBitBtn;
    procedure FlatButton2Click(Sender: TObject);
    procedure lbDiretoriosChange(Sender: TObject);
    procedure cbUnidadesChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmDirDialog: TfmDirDialog;

implementation

{$R *.dfm}

procedure TfmDirDialog.FlatButton2Click(Sender: TObject);
begin    //    if lbDiretorios.Directory
end;

procedure TfmDirDialog.lbDiretoriosChange(Sender: TObject);
begin
   lbArquivos.Directory := lbDiretorios.Directory;
end;

procedure TfmDirDialog.cbUnidadesChange(Sender: TObject);
begin
  lbDiretorios.Drive := cbUnidades.Drive;
end;

procedure TfmDirDialog.FormShow(Sender: TObject);
begin
   cbUnidadesChange(nil);  
end;

end.
