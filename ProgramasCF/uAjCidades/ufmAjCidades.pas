unit ufmAjCidades;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, Buttons, fCtrls, adLabelComboBox,
  TFlatButtonUnit, ExtCtrls, Db, Grids, DBGrids, SoftDBGrid ;

type
  TfmAjCidades = class(TForm)
    fnGrid: TSoftDBGrid;
    dsCid: TDataSource;
    Panel1: TPanel;
    btCidEnt: TfsBitBtn;
    edCidEnt: TadLabelEdit;
    edUF: TadLabelEdit;
    btUf: TfsBitBtn;
    Panel2: TPanel;
    btCidSai: TfsBitBtn;
    edcidSai: TadLabelEdit;
    grCidDest: TSoftDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    fsBitBtn3: TfsBitBtn;
    dsCidDest: TDataSource;
    edUfNova: TadLabelEdit;
    btUfNova: TfsBitBtn;
    procedure btUfClick(Sender: TObject);
    procedure btCidEntClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btCidSaiClick(Sender: TObject);
    procedure ajGrid(nmGrid:TSoftDbGrid);
    procedure fsBitBtn3Click(Sender: TObject);
    procedure btUfNovaClick(Sender: TObject);
    procedure getUf(edUf_:TadLabelEdit);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAjCidades: TfmAjCidades;

implementation

{$R *.dfm}

uses uBuscasDiversas, f, uPessoa, udm, msg;



procedure TfmAjCidades.btUfClick(Sender: TObject);
var
  cd_uf, nm_uf:String;
begin
   self.getUf(edUF);{
   if (uBuscasDiversas.pegarDadosCampo( 'uf', 'cd_uf', 'nm_uf', '*', '*', cd_uf, nm_uf ) = true) then
   begin
      edUF.Text := cd_uf;
   end;
}
end;

procedure TfmAjCidades.btCidEntClick(Sender: TObject);
begin
   if (edUF.Text <> '') then
   begin
      dsCid.DataSet := uBuscasDiversas.getListaCidades(edUF.Text, edCidEnt.text, false);
      ajGrid(fnGrid);
   end;
end;

procedure TfmAjCidades.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := cafree;
   fmAjCidades := nil;
end;

procedure TfmAjCidades.btCidSaiClick(Sender: TObject);
begin
   if (edUfNova.Text <> '') then
   begin
      dsCidDest.DataSet := uBuscasDiversas.getListaCidades(edUfNova.Text, edcidSai.text, true);
      ajGrid(grCidDest);
   end;
end;

procedure TfmAjCidades.ajGrid(nmGrid: TSoftDbGrid);
begin
   f.ajGridCol(nmGrid, nmGrid.DataSource.DataSet, 'nm_cid', 100, 'Cidade' );
   f.ajGridCol(nmGrid, nmGrid.DataSource.DataSet, 'cd_cid', 100, 'Código cidade' );
   f.ajGridCol(nmGrid, nmGrid.DataSource.DataSet, 'codigoIbge', 100, 'Código IbBGE' );
end;

procedure TfmAjCidades.fsBitBtn3Click(Sender: TObject);
begin
   if (dsCid.DataSet.IsEmpty = false ) and (dsCidDest.DataSet.IsEmpty = false) then
      if (trim(dsCid.DataSet.FieldByName('codigoIbge').AsString) = '') then
      begin
         uPessoa.removeCidadeinvalida(
            dsCid.DataSet.FieldByName('cd_cid').AsString,
            dsCidDest.DataSet.FieldByName('cd_cid').AsString
         );
         btCidEntClick(nil);
      end
      else
         msg.msgErro(  dm.getMsg('errCodCid') );
end;

procedure TfmAjCidades.btUfNovaClick(Sender: TObject);
begin
   self.getUf(edUfNova);
end;

procedure TfmAjCidades.getUf(edUf_: TadLabelEdit);
var
  cd_uf, nm_uf:String;
begin
   if (uBuscasDiversas.pegarDadosCampo( 'uf', 'cd_uf', 'nm_uf', '*', '*', cd_uf, nm_uf ) = true) then
   begin
      edUF_.Text := cd_uf;
   end;
end;


end.
