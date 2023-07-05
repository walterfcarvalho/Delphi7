unit uListaFornecedores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, TFlatButtonUnit, adLabelEdit, DB,
  ADODB, Grids, DBGrids, SoftDBGrid, ExtCtrls, uPessoa;

type
  TfmListaFornecedores = class(TForm)
    fnGrid: TSoftDBGrid;
    edit1: TadLabelEdit;
    btBusca: TfsBitBtn;
    fsBitBtn2: TfsBitBtn;
    fsBitBtn3: TfsBitBtn;
    dsPes: TDataSource;
    rgTpConsulta: TRadioGroup;
    procedure btBuscaClick(Sender: TObject);
    procedure fsBitBtn3Click(Sender: TObject);
    procedure edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure listarFornecedor();
    procedure listarCliente();
    procedure ajustBuscaDefornecedor();
    procedure ajustBuscaDeCliente();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rgTpConsultaClick(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmListaFornecedores: TfmListaFornecedores;
  PERFIL:String;
implementation

uses f, cf, funcSQL, uMain, Math;

{$R *.dfm}

procedure TfmListaFornecedores.listarFornecedor();
begin
 if length( f.SohNumeros(edit1.Text)) = length(edit1.Text) then
    dsPes.DataSet := uPessoa.getDadosFornecedor(edit1.Text,'')
 else
    dsPes.DataSet := uPessoa.getDadosFornecedor('', edit1.Text);

   if (dsPes.DataSet.IsEmpty = false) then
   begin
      f.ajGridCol(fnGrid, dspes.DataSet, 'nome', 350, '');
      f.ajGridCol(fnGrid, dspes.DataSet, 'is_cred', 80, 'Cod fornecedor');
   end;
end;

procedure TfmListaFornecedores.listarCliente();
begin
   if length( f.SohNumeros(edit1.Text)) = length(edit1.Text) then
      dsPes.DataSet := uPessoa.getDadosCliente(edit1.Text,'')
   else
      dsPes.DataSet := uPessoa.getDadosCliente('', edit1.Text);

   if (dsPes.DataSet.IsEmpty = false) then
   begin
      fnGrid.Columns[dspes.DataSet.FieldByName('nome').Index ].Width := 150;
      fnGrid.Columns[dspes.DataSet.FieldByName('endereco').Index ].Width := 250;
   end;
end;

procedure TfmListaFornecedores.fsBitBtn3Click(Sender: TObject);
begin
  if (dsPes.DataSet = nil) then
     ModalResult := mrCancel
   else
     ModalResult := mrOk;
end;

procedure TfmListaFornecedores.edit1KeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if(key=VK_RETURN)then
      btBuscaClick(nil);
end;

procedure TfmListaFornecedores.FormActivate(Sender: TObject);
begin
   if (edit1.Visible = true) then
   begin
      edit1.SetFocus();
      edit1.SelectAll();
   end;
   rgTpConsultaClick(nil);
end;


procedure TfmListaFornecedores.ajustBuscaDefornecedor;
begin
   edit1.LabelDefs.Caption := 'Digite o nome do fornecedor para buscar:';
   fmListaFornecedores.Caption := 'Buscar fornecedor';
end;

procedure TfmListaFornecedores.ajustBuscaDeCliente;
begin
   edit1.LabelDefs.Caption := 'Digite o nome do cliente para buscar:';
   fmListaFornecedores.Caption := 'Buscar cliente';
end;

procedure TfmListaFornecedores.btBuscaClick(Sender: TObject);
begin
   if (rgTpConsulta.ItemIndex = 1) then
         listarFornecedor()
     else
         listarCliente();
end;

procedure TfmListaFornecedores.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
{   if (fmListaFornecedores <> nil) then
   begin
      action := cafree;
      fmListaFornecedores := nil;
   end;
}   
end;

procedure TfmListaFornecedores.FormShow(Sender: TObject);
begin
   //edit1.SetFocus;
end;

procedure TfmListaFornecedores.rgTpConsultaClick(Sender: TObject);
begin
   If ( rgTpConsulta.ItemIndex = 1) then
      ajustBuscaDefornecedor()
   else
      ajustBuscaDeCliente();
end;

end.

















