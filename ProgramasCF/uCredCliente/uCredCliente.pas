unit uCredCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, TFlatButtonUnit, StdCtrls, adLabelEdit, Grids,
  DBGrids, SoftDBGrid, DB, Menus;

type
  TfmCredCliente = class(TForm)
    Panel1: TPanel;
    edCodCli: TadLabelEdit;
    FlatButton7: TFlatButton;
    btConsulta: TFlatButton;
    Label2: TLabel;
    lbCriador: TLabel;
    Label1: TLabel;
    lbNm_pes: TLabel;
    lbcd_pes: TLabel;
    gdAdi: TSoftDBGrid;
    rg1: TRadioGroup;
    gdBaixas: TSoftDBGrid;
    rg2: TRadioGroup;
    dsadi: TDataSource;
    dsBaixas: TDataSource;
    Label3: TLabel;
    lbVlCredito: TLabel;
    PopupMenu1: TPopupMenu;
    Inserirbaixadecrdito1: TMenuItem;
    procedure FlatButton7Click(Sender: TObject);
    procedure btConsultaClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gdAdiCellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure gdBaixasDblClick(Sender: TObject);
    procedure gdAdiDblClick(Sender: TObject);
    procedure chamaRemoverUsoCredito(devolveCredito:boolean);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCredCliente: TfmCredCliente;

implementation
uses umain, ucf, cf, f, funcsql, msg, uPessoa, uAdiantamento;

{$R *.dfm}

procedure TfmCredCliente.chamaRemoverUsoCredito(devolveCredito:boolean);
begin
    uAdiantamento.removeUsoDeCreditoCliente(
       dsadi.DataSet.fieldByName('nr_adi').AsString,
       dsBaixas.DataSet.fieldByName('id_titulo').AsString,
       devolveCredito
    );
end;

procedure TfmCredCliente.FlatButton7Click(Sender: TObject);
var
   ds_pes, cd_pes, ds_end:String;
   ds:TdataSet;
begin
   if (edCodCli.Text<> '') then
   begin
      ds := uPessoa.getDadosCliente(edCodCli.Text, '');

      if ( ds.IsEmpty = false) then
      begin
         cd_pes := ds.fieldByname('codigo').asString;
         ds_pes := ds.fieldByname('nome').asString;

         lbcd_pes.Caption := cd_pes;
         lbNm_pes.Caption := ds_pes;
      end
      else
         msg.msgErro(' Não cadastrado');
      ds.Free();
   end
   else
   begin
      if ( cd_pes = '') then
         fmMain.getDadosCliente(cd_pes, ds_pes, ds_end);


      if (cd_pes <> '') then
      begin
         edCodCli.Text := cd_pes;
         lbcd_pes.Caption := cd_pes;
         lbNm_pes.Caption := ds_pes;
      end
      else
      begin
         edCodCli.Text := '';
         lbcd_pes.Caption := '';
         lbNm_pes.Caption := '';
      end;
   end;
end;

procedure TfmCredCliente.btConsultaClick(Sender: TObject);
begin
   if (lbcd_pes.Caption <> '') then
   begin
      dsadi.DataSet := uAdiantamento.getAdiantamentos(lbcd_pes.Caption);

      f.ajGridCol( gdAdi, dsadi.DataSet, 'num_cli', -1, '');
      f.ajGridCol( gdAdi, dsadi.DataSet, 'nr_adi', 50, 'Cod Adi');
      f.ajGridCol( gdAdi, dsadi.DataSet, 'DATA_ADI', 70, 'Data');
      f.ajGridCol( gdAdi, dsadi.DataSet, 'VAL_ADI', 60, 'Valor');
      f.ajGridCol( gdAdi, dsadi.DataSet, 'VAL_UTI', 60, 'Utilizado');
      f.ajGridCol( gdAdi, dsadi.DataSet, 'NM_USU', 180, 'Usuário');
      f.ajGridCol( gdAdi, dsadi.DataSet, 'ds_uo', 150, 'Loja');
      f.ajGridCol( gdAdi, dsadi.DataSet, 'sr_docf', 25, 'Sr');
      f.ajGridCol( gdAdi, dsadi.DataSet, 'nr_docf', 45, 'NF');
      f.ajGridCol( gdAdi, dsadi.DataSet, 'historico', 300, 'Historico');
      f.ajGridCol( gdAdi, dsadi.DataSet, 'vl_credito', -1, '');

      lbVlCredito.Caption := funcSQL.somaColTable(dsadi.DataSet, 'vl_credito', true );
   end;
end;

procedure TfmCredCliente.FormResize(Sender: TObject);
begin
   rg1.Width := fmCredCliente.Width - 20;
   gdAdi.Width := rg1.Width - 10;
   rg2.Width := rg1.Width;
   gdBaixas.Width := gdAdi.Width;
end;

procedure TfmCredCliente.FormCreate(Sender: TObject);
begin
   lbcd_pes.Caption := '';
   lbVlCredito.Caption := '';
end;

procedure TfmCredCliente.gdAdiCellClick(Column: TColumn);
begin
   dsBaixas.DataSet :=  getBaixasAdiantamentos( dsadi.DataSet.fieldByName('nr_adi').AsString);
end;

procedure TfmCredCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   Action := caFree;
   fmCredCliente := nil;
end;

procedure TfmCredCliente.gdBaixasDblClick(Sender: TObject);
begin
   if (dsBaixas.DataSet.IsEmpty = false) then
      if (msg.msgQuestion(' Deseja remover esse uso do crédito?') = mrYes ) then
      begin
         chamaRemoverUsoCredito(true);
         btConsultaClick(nil);
      end;
end;

procedure TfmCredCliente.gdAdiDblClick(Sender: TObject);
begin
   if (dsadi.DataSet.IsEmpty = false) then
      if (msg.msgQuestion(' Deseja remover esse crédito?') = mrYes ) then
      begin
         dsBaixas.DataSet.First();
         while ( dsBaixas.DataSet.Eof = false ) do
         begin
            chamaRemoverUsoCredito(false);
            dsBaixas.DataSet.Next();
         end;
         uAdiantamento.removeCreditoCliente(dsadi.DataSet.fieldByName('nr_adi').AsString);
         btConsultaClick(nil);
         gdBaixas.DataSource := nil;
      end;
end;





end.
