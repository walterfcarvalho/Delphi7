unit uAprovaAvaria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fCtrls, TFlatButtonUnit, adLabelEdit,  DBCtrls, adLabelDBMemo,
  adLabelMemo,ADODB;

type
  TfmAprovaAv = class(TForm)
    Label1: TLabel;
    lbNumAvaria: TLabel;
    Label4: TLabel;
    lbLoja: TLabel;
    BitBtn1: TFlatButton;
    chAprova: TfsCheckBox;
    lbUo: TLabel;
    mmObs: TfsMemo;
    Label6: TLabel;
    lbUsAprovador: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAprovaAv: TfmAprovaAv;

implementation

uses uAvarias, uMain, funcsql, f, uDm, uEstoque, msg, fdt;

{$R *.dfm}

procedure TfmAprovaAv.FormCreate(Sender: TObject);
var
   cmd:String;
begin
   lbNumAvaria.Caption := fmCadAvarias.lbNumAvaria.Caption;
   lbLoja.caption := fmCadAvarias.lbLoja.caption;
   lbuo.Caption := fmCadAvarias.lbuo.Caption;

   cmd := ' Select observacao from zcf_avarias where' +
          ' numAvaria= ' + lbNumAvaria.Caption +' and loja= '+ lbuo.Caption;
   mmObs.Lines.add( dm.openSQL(cmd, 'observacao') );

   cmd := ' Select ehAprovada from zcf_avarias where' +
          ' numAvaria = ' + lbNumAvaria.Caption +' and loja = '+ lbuo.Caption;

   if (dm.openSQL(cmd, 'ehAprovada') = '1') then
      chAprova.Checked := true;
end;

procedure TfmAprovaAv.BitBtn1Click(Sender: TObject);
var
  Aprovar:String;
  dtAprovacao:string;
  cmd:string;
  i:integer;
begin
   for i:= 0 to mmObs.Lines.Count -1 do
      cmd := cmd + mmObs.Lines[i] + '      ';

   aprovar := '0';
   dtAprovacao := 'null';

   if chAprova.Checked = true then
   begin
      aprovar := '1';
      dtAprovacao :=  fdt.dateToSqlDate(now);

      if (lbUo.Caption <> fmMain.getUOCD() ) then
      begin
         if msg .msgQuestion( dm.getMsg('avaria.confirmacao')) = mrYes then
         uEstoque.baixaDeAvarias( fmCadAvarias.tbItensAv, lbUo.Caption, lbUsAprovador.Caption);
      end
      else
         msg.msgErro( dm.getMsg('avaria.errLocal') );
   end;

   dm.execSQL('Update zcf_avarias set Ehaprovada = '+ aprovar + ', DataAprovacao = '+ dtAprovacao + ' , Observacao = '+  quotedStr(cmd) + ' where  numAvaria = ' + lbNumAvaria.Caption  + ' and loja = ' +fmCadAvarias.lbuo.Caption);
   fmCadAvarias.CarregarCabecalhoAvarias( lbNumAvaria.Caption, lbUo.Caption );
   fmCadAvarias.CarregaItensAvarias(lbNumAvaria.Caption, lbUo.Caption );
   fmAprovaAv.Close;
end;

procedure TfmAprovaAv.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmCadAvarias.CarregarCabecalhoAvarias( lbNumAvaria.Caption, lbUo.Caption );
   fmCadAvarias.CarregaItensAvarias(lbNumAvaria.Caption, lbUo.Caption );

   action := cafree;
   fmAprovaAv := nil;
end;


end.
