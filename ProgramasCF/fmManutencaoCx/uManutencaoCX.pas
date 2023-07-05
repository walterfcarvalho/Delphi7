unit uManutencaoCX;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uRemoveRegTEF, Menus, DB, ADODB, StdCtrls, adLabelEdit,
  adLabelNumericEdit, ComCtrls, fCtrls, TFlatButtonUnit, Grids, DBGrids,
  SoftDBGrid, adLabelComboBox;

type
  TfmManutencaoCX = class(TfmRemRegTEF)
    lbCodCaixa: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbLojasChange(Sender: TObject);
    procedure cbCaixasChange(Sender: TObject);
    procedure carregaOpcoesDeCaixa();
    procedure cbModalidadeChange(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
    procedure FlatButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmManutencaoCX: TfmManutencaoCX;

implementation

uses uMain, f, funcSQL, uCF, uDm, uLj, msg, uCaixa;

{$R *.dfm}

procedure TfmManutencaoCX.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  inherited;
   action := cafree;
   fmManutencaoCX := nil;
end;

procedure TfmManutencaoCX.FormCreate(Sender: TObject);
begin
   carregaOpcoesDeCaixa();
   uLj.getListaLojas(cbLojas, false, false, fmMain.getCdPesLogado(), fmMain.getUoLogada() );
   cbLojasChange(nil);
end;

procedure TfmManutencaoCX.cbLojasChange(Sender: TObject);
begin
   cbCaixas.Items :=  uCaixa.getDescCaixas( f.getCodUO(cbLojas), false, false);
   carregaOpcoesDeCaixa();
end;

procedure TfmManutencaoCX.cbCaixasChange(Sender: TObject);
var
   ds:TdataSet;
   cmd:String;
begin
   cmd :=
   'Select statusCaixa, codCaixa from caixas where codLoja=' + f.getCodUO(cbLojas) +
   'and  codCaixa= ' + f.getCodCaixa(cbCaixas);
   ds:= dm.getDataSetQ(cmd);

   if (ds.FieldByName('statusCaixa').AsString = 'A') then
      cbModalidade.ItemIndex := 0
   else
      cbModalidade.ItemIndex := 1;
   ds.FieldByName('codCaixa').AsString;
   lbCodCaixa.Caption := 'PDV CTF: ' + ds.FieldByName('codCaixa').AsString;
   ds.free();
end;

procedure TfmManutencaoCX.carregaOpcoesDeCaixa;
begin
   Label1.Visible := false;
   dt.Visible := false;
   btConsulta.Visible := false;
   groupBox1.Caption := 'Caixas';
   cbModalidade.LabelDefs.Caption := 'Status Caixa';
   cbModalidade.Items.Clear();
   cbModalidade.Items.Add('Aberto');
   cbModalidade.Items.Add('Fechado');
   cbModalidade.ItemIndex := -1;
   GroupBox1.Caption := '';
end;

procedure TfmManutencaoCX.cbModalidadeChange(Sender: TObject);
var
   cmd:String;
begin
   if (msg.msgQuestion('Mudar o status do caixa para ' + cbModalidade.Items[cbModalidade.ItemIndex] +' ?') = mrYes) then
   begin
      cmd :=
      ' update caixas set statusCaixa = ' + quotedStr(copy(cbModalidade.Items[cbModalidade.ItemIndex],01,01)) +
      ' where codLoja=' + f.getCodUO(cbLojas) +
      ' and  codCaixa= ' + f.getCodCaixa(cbCaixas);
      dm.execSQL(cmd);
      MSG.msgExclamation('Status do caixa alterado!');
   end;
end;

procedure TfmManutencaoCX.FlatButton1Click(Sender: TObject);

var
  cmd:String;
begin
   if (cbLojas.ItemIndex < 0) or (cbCaixas.ItemIndex < 0) then
      msg.msgErro('Escolha uma loja e um caixa')
   else
   begin
      cmd := ' delete from vendasIncompletas' +
             ' where descEstacao= ' + quotedStr(f.getNomeDoCx(cbCaixas));

      if ( msg.msgQuestion('Remove o registro de venda incompleta desse caixa?') = mrYes) then
        dm.execSQL(cmd);
   end;
end;

procedure TfmManutencaoCX.btConsultaClick(Sender: TObject);
begin
//  inherited;

end;

end.
