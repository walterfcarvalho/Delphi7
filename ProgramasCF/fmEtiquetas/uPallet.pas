unit uPallet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, fCtrls, adLabelEdit, f, ExtCtrls;

type
  TPallet = class(TForm)
    ednPallete: TadLabelEdit;
    fsBitBtn1: TfsBitBtn;
    Rg: TRadioGroup;
    ednPalleteFim: TadLabelEdit;
    procedure fsBitBtn1Click(Sender: TObject);
    procedure imprimirPalletArgox(Sender:TObject);
    procedure imprimirPalletDynaPos(Sender:TObject);
    procedure ednPalleteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RgClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ednPalleteChange(Sender: TObject);
    procedure imprimirEnderecoArgox();

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Pallet: TPallet;

implementation

uses uEtiquetas;

{$R *.dfm}

procedure TPallet.imprimirPalletArgox(Sender:TObject);
var
  i,inicio,fim:integer;
  arq:string;
  tEAN,xEAN,yEAN:string;
  tFONTE, xFONTE, yFONTE:STRING;
begin
///  AORIENTACAO Y É DA ESQUERDA PARA A DIREITA
//   A ORIENTACAO X E DE BAIXO PARA CIMA
   if Rg.ItemIndex = 0 then
   begin
      tEAN:=  '4';
      xEAN:= '0030';
      yEAN := '0010';
      tFONTE:= '5';
      yFONTE := '0010';
      xfONTE := '0150';
   end
   else
   begin
      tEAN:=  '3';
      xEAN:= '0030';
      yEAN := '0010';
      tFONTE:= '3';
      yFONTE := '0075';
      xfONTE := '0020';
   end;

   inicio := strToInt(ednPallete.text);
   fim := strToInt(ednPalleteFim.text);

   arq:= f.getDirLogs()+ 'Etiquetas.txt';
   DeleteFile(arq);
   for i:= inicio to fim do
   begin
      f.GravaLinhaEmUmArquivo(arq, 'L');
      f.GravaLinhaEmUmArquivo(arq, '1F31025'+ '0005' + '0020' + intToStr(i));
      f.GravaLinhaEmUmArquivo(arq, '1'+ 'a'+ '31'+ '060' + yEAN + xEAN + intTostr(i) );
      f.GravaLinhaEmUmArquivo(arq, '1'{orientacao}+ tFonte+'2'{multHoriz}+'2'{multvert}+
                                     '000'{subFonte}+ yFONTE + xFONTE + intToStr(i) );
   f.GravaLinhaEmUmArquivo(arq, 'E');
   end;

   Winexec( pchar('cmd.exe /c print /d:'+ fmEtiquetas.EdLocalimp.text+' '+arq)  , SW_NORMAL);
end;

procedure TPallet.imprimirEnderecoArgox();
var
  arq:string;
  tEAN,xEAN,yEAN:string;
  tFONTE, xFONTE, yFONTE:STRING;
begin
///  AORIENTACAO Y É DA ESQUERDA PARA A DIREITA
//   A ORIENTACAO X E DE BAIXO PARA CIMA
   tEAN:=  '3';
   xEAN:= '0030';
   yEAN := '0010';
   tFONTE:= '3';
   yFONTE := '0075';
   xfONTE := '0020';


   arq:= f.getDirLogs() + 'Etiquetas.txt';
   DeleteFile(arq);
     f.GravaLinhaEmUmArquivo(arq, 'L');
         f.GravaLinhaEmUmArquivo(arq, '1F31025'+ '0005' + '0020' + ednPallete.text);
   f.GravaLinhaEmUmArquivo(arq, '1'+ 'a'+ '31'+ '060' + yEAN + xEAN +ednPallete.Text);
   f.GravaLinhaEmUmArquivo(arq, '1'{orientacao}+ tFonte+'2'{multHoriz}+'2'{multvert}+
                                     '000'{subFonte}+ yFONTE + xFONTE + ednPallete.Text );

   f.GravaLinhaEmUmArquivo(arq, 'E');

   Winexec( pchar('cmd.exe /c print /d:'+ fmEtiquetas.EdLocalimp.text+' '+arq)  , SW_NORMAL);
end;


procedure TPallet.imprimirPalletDynaPos(Sender: TObject);
var
  arq:string;
  tEAN,xEAN,yEAN:STRING;
  tFONTE,xFONTE,yFONTE:STRING;

begin
   arq := 'Etiquetas.txt';
   DeleteFile(arq);

   if Rg.ItemIndex = 0 then
   begin
     tFONTE := '5';
     xFONTE := '405';
     yFONTE := '130';
     tEAN := '150';
     xEAN := '765';
     yEAN := '150';
   end
   else
   begin
     tFONTE := '4';
     xFONTE := '765';
     yFONTE := '230';
     tEAN := '100';
     xEAN := '765';
     yEAN := '150';
   end;
 {
    formato do comando texto : Ax,y,rotacao,fonte, multiplicador horizontal, multip verticao ,normal ou reverse, texto
 Barras : Bx,y, rotacao(2), tipoDeCodB, largbarra , altura, altura, imprimeOuNaoNumero, codigo
 }
   f.GravaLinhaEmUmArquivo(arq, 'N');
   f.GravaLinhaEmUmArquivo(arq, 'Q200,24');
   f.GravaLinhaEmUmArquivo(arq, 'q800' );
   f.GravaLinhaEmUmArquivo(arq, 'B'+ xEAN   +','+ yEAN +',2,1,3,1,'+ tEAN +',N,"'+ednPallete.Text+'"' );
   f.GravaLinhaEmUmArquivo(arq, 'A'+ xFONTE +','+ yFONTE +',2,'+ tFONTE+ ',2,2,N,"' + ednPallete.Text + '"');

   f.GravaLinhaEmUmArquivo(arq,'P1');
   f.GravaLinhaEmUmArquivo(arq,'N');

   Winexec( pchar('cmd.exe /c print /d:'+ fmEtiquetas.EdLocalimp.text+' '+arq)  , SW_NORMAL);
end;

procedure TPallet.ednPalleteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
  begin
     fsBitBtn1Click(Sender);
     fsBitBtn1.SetFocus;
     ednPallete.setFocus;
  end;
end;

procedure TPallet.RgClick(Sender: TObject);
begin
   if rg.ItemIndex  = 0 then
   begin
      ednPallete.LabelDefs.Caption := 'Numero do pallet';
      ednPallete.MaxLength := 4;
      ednPalleteFim.Visible := true;
   end
   else
   begin
      ednPallete.LabelDefs.Caption := 'Endereço';
      ednPallete.MaxLength := 12;
      ednPalleteFim.Visible := false;
   end;
   ednPallete.Text :='';
end;

procedure TPallet.FormCreate(Sender: TObject);
begin
   RgClick(sender);
end;

procedure TPallet.fsBitBtn1Click(Sender: TObject);
begin
   case fmEtiquetas.cbTIpoImpressao.ItemIndex of
      0,2:begin
             if (Rg.ItemIndex = 0)  then
                 imprimirPalletArgox(Sender)
             else
                 imprimirEnderecoArgox();
          end;
      1,3:imprimirPalletDynaPos(Sender);
   end;
   ednPallete.setFocus();
end;

procedure TPallet.ednPalleteChange(Sender: TObject);
begin
  if (Rg.ItemIndex = 0) then
     ednPalleteFim.Text := ednPallete.text;
end;

end.
