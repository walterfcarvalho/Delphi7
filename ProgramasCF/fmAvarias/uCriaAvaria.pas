unit uCriaAvaria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, adLabelEdit, TFlatButtonUnit, f;

type
  TfmCriarAvaria = class(TForm)
    lbData: TadLabelEdit;
    cbTipo: TadLabelComboBox;
    btOk: TFlatButton;
    btClose: TFlatButton;
    Label1: TLabel;
    lbLoja: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btOkClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmCriarAvaria: TfmCriarAvaria;

implementation

uses uAvarias,uMain, uDm;

{$R *.dfm}

procedure TfmCriarAvaria.FormActivate(Sender: TObject);
begin
   lbData.text := DateToStr(now);
   lbLoja.Caption := dm.GetValorWell('O','Select ds_uo From Tbuo with(Nolock) where is_uo = '+ fmMain.getUoLogada() ,'ds_uo');
end;

procedure TfmCriarAvaria.btOkClick(Sender: TObject);
var
  aux:string;
  nAvaria:string;
begin
   nAvaria := dm.getValorWell( 'O', ' Select isNull(max(numAvaria)+1,1) as nAvaria from zcf_avarias with(nolock) where loja = ' + fmMain.getUoLogada() , 'nAvaria') ;

   dm.execSQL('insert zcf_avarias Values('+ nAvaria +' , '+ fmMain.getUoLogada() +
   ' , GetDate(), 0, null,  ' + intToStr(cbTipo.ItemIndex)  + ' , '+  quotedStr(f.getNomeDaEstacao() + ' User:' + fmMain.getNomeUsuario()  )   +'  , '''',0, 1, ' + fmMain.getUoLogada()+ ' )');


   aux :=  f.preencheCampo(05,'0','e', nAvaria);
   fmCadAvarias.lbNumAvaria.Caption := aux ;
   fmCadAvarias.CarregarCabecalhoAvarias( aux,  fmMain.getUoLogada()  );
   fmCadAvarias.CarregaItensAvarias(aux, fmMain.getUoLogada() );
   btCloseClick(Sender);
end;

procedure TfmCriarAvaria.btCloseClick(Sender: TObject);
begin
    fmCriarAvaria.Close();
end;

procedure TfmCriarAvaria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
end;

end.
