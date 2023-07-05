unit uFluxoClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, fCtrls, ComCtrls, Buttons,  Grids, DBGrids;

type
  TfmVdPorHora = class(TForm)
    cbLoja: TfsComboBox;
    label2: TLabel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    di: TfsDateTimePicker;
    df: TfsDateTimePicker;
    fsBitBtn1: TfsBitBtn;
    Memo1: TMemo;
    procedure GerarFluxo(sender:Tobject);
    procedure fsBitBtn1Click(Sender: TObject);
    procedure diChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmVdPorHora: TfmVdPorHora;


implementation

uses uDm, f, fdt, uLj, uMain;


{$R *.dfm}

procedure TfmVdPorHora.GerarFluxo(sender: Tobject);
var
  auxHora, hora,i:integer;
  nVendas: array[0..14] of real;
  vVendas: array[0..14] of real;

  horas: array[8..22] of integer;

  ntVendas:real;
  vtVendas:real;

  percAtend,percVenda:real;

  ds:TDataSet;
  cmd:String;

begin
   for i:=0 to 14 do
   begin
      nVendas[i] :=0;
      vVendas[i] :=0;
   end;

   cmd := dm.getCMD3('Vendas', 'getVendasPorHorario', fdt.dateToSqlDate(di.Date), fdt.dateToSqlDate(df.date), f.getCodUO(cbLoja));
   ds:= dm.getDataSetQ(cmd);


   while ds.Eof = false do
   begin
      hora := f.HoraToInt( copy(ds.FieldByname('dt_trab').AsString, 12,05 )) ;

      auxHora := 08;
      if hora  <= ( 60 * auxHora )  then
      begin
         nVendas[0] := nVendas[0] +1;
         vvendas[0] := vVendas[0] + ds.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 08;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 09;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 10;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 11;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 12;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 13;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 14;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 15;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;
      auxHora := 16;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;
      auxHora := 17;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7]:= vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;
      auxHora := 18;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;
      auxHora := 19;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;
      auxHora := 20;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 21;
      if ( hora  > (( 60 * auxHora ) ) )  and  ( hora  <= ( 60 * auxHora ) + 60 ) then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7]+1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;

      auxHora := 22;
      if ( hora  > (( 60 * auxHora ) ) )   then
      begin
         nVendas[auxHora-7] := nVendas[auxHora-7] +1;
         vvendas[auxHora-7] := vVendas[auxHora-7] + ds.FieldByname('vl_Venda').AsFloat;
      end;
      ds.Next();
   end;

   ntVendas := 0;
   for i:= 0 to 14 do
     ntVendas:= ntVendas + nVendas[i];

   vtVendas := 0;
   for i:= 0 to 14 do
     vtVendas := vtVendas +vVendas[i];

// mostrar o resultado

   if vtVendas > 0 then
   begin
      percAtend := ( nVendas[0]* 100 ) / ntVendas ;
      percVenda := ( vVendas[0]* 100 ) / vtVendas ;

      memo1.lines.add('Loja: '+ uLj.getNomeUO(cbLoja) );
      memo1.lines.add('Período: ' + dateToStr(di.date) + ' a ' + dateToStr(df.date));
      memo1.lines.add('----------------------------------------------------------------------------');

      memo1.lines.Add( '00:00 ate 08:00 - Nº de vendas: ' +  f.preencheCampo(5,' ','e', FloatToStr(nVendas[0]) ) + '(' +  f.preencheCampo(6,' ','e', floattostrf( percAtend  ,ffNumber,18,2) )  +'%)'+
                       ' Valor: '+
                       f.preencheCampo(12,' ', 'e', floattostrf(  vVendas[0]  ,ffNumber,18,2) ) +
                       '(' +  f.preencheCampo(6,' ','e', floattostrf( percVenda, ffNumber,18,2) )  +'%)'
                     );
      for i:=1 to 13 do
      begin
         percAtend := (nVendas[i]*100 ) / ntVendas  ;
         percVenda := (vVendas[i]* 100 ) / vtVendas ;

         memo1.lines.Add( f.preencheCampo(2,'0','e', inttoStr(i+7))  +
                          ':00 ate ' +
                          f.preencheCampo(2,'0','e', inttoStr(i+8))  +
                          ':00 - Nº de vendas: ' + f.preencheCampo(5,' ','e', FloatToStr(nVendas[i]) ) +
                          '(' +  f.preencheCampo(6,' ','e', floattostrf( percAtend  ,ffNumber,18,2) )  +'%)'+
                          ' Valor: '+
                          f.preencheCampo(12,' ', 'e', floattostrf(  vVendas[i]  ,ffNumber,18,2) ) +
                          '(' +  f.preencheCampo(6,' ','e', floattostrf( percVenda  , ffNumber,18,2) )  +'%)'
                        );
      end;

      percAtend := ( nVendas[14]* 100 ) / ntVendas ;
      percVenda := ( vVendas[14]* 100 ) / vtVendas ;
      memo1.lines.Add( '21:00 ate 24:00 - Nº de vendas: ' +  f.preencheCampo(5,' ','e', FloatToStr(nVendas[14]) )     +
                       '(' +  f.preencheCampo(6,' ','e', floattostrf( percAtend  ,ffNumber,18,2) )  +'%)'+
                       ' Valor: '+
                       f.preencheCampo(12,' ', 'e', floattostrf(  vVendas[i]  ,ffNumber,18,2) ) +
                       '(' +  f.preencheCampo(6,' ','e', floattostrf( percVenda  ,ffNumber,18,2) )  +'%)'
                     );
      memo1.lines.add('----------------------------------------------------------------------------');
      memo1.Lines.Add('Total de atendimentos :  '+  floatToStr(ntVendas)  ) ;
      memo1.Lines.Add('Total de Vendas: ' + floattostrf(  vtVendas  ,ffNumber,18,2) )
   end
   else
      memo1.Lines.Add('Sem vendas............');
end;

procedure TfmVdPorHora.fsBitBtn1Click(Sender: TObject);
begin
   memo1.Lines.Clear;
   GerarFluxo(sender);
end;

procedure TfmVdPorHora.diChange(Sender: TObject);
begin
   df.Date := di.Date;
end;

procedure TfmVdPorHora.FormCreate(Sender: TObject);
begin
   uLj.getListaLojas( cbLoja, false, false, '' , fmMain.getUoLogada());
   di.Date := now;
   df.date := now;
end;

procedure TfmVdPorHora.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   action := caFree;
   fmVdPorHora := nil;
end;

end.
