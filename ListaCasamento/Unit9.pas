unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, TFlatButtonUnit, RpBase, RpSystem, RpRave, DB, ADODB,
  RpDefine, RpCon, RpConDS, StdCtrls, adLabelComboBox, Grids, DBGrids,funcoes;

type
  TForm9 = class(TForm)
    cbLojas: TadLabelComboBox;
    BitBtn2: TFlatButton;
    BitBtn3: TFlatButton;
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    qrCabeca: TADOQuery;
    qrCorpo: TADOQuery;
    cbTotal: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure imprimeBaixasTotais(loja:String);
    function getParametros(ds:TdataSet):TStringList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation
uses unit1, uDm, msg, fdt;

{$R *.dfm}

procedure TForm9.FormActivate(Sender: TObject);
begin
   form9.Top := fmMain.Top + 50;
   cbLojas.items := fmMain.GetNumLojas(fmMain.RParReg('Loja'));
   cbLojas.ItemIndex := 0;
   dt1.Date := now;
   dt2.Date := now;
end;

procedure TForm9.BitBtn3Click(Sender: TObject);
begin
   form9.close;
end;

procedure TForm9.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmMain.mostraMenu(sender);
   action := Cafree;
end;

procedure TForm9.BitBtn2Click(Sender: TObject);
var
   Numloja,cmd:string;
   params : TStringList;
begin
   if dt2.DateTime < dt1.DateTime then
      msg.msgErro('A data final não pode ser menor que a data incial.')
   else
   begin
      bitbtn2.Enabled := false;
      bitbtn3.Enabled := false;

      if cblojas.itemIndex = 0 then
         NumLoja := '99'
      else
         NumLoja := cblojas.Items[cblojas.itemindex] ;

      if (cbTotal.Checked = true) then
         imprimeBaixasTotais(Numloja)
      else
      begin
         cmd := ' Exec ListasComItensCompPorData_cabeca '+quotedStr(NumLoja) +' , ' +fdt.StrToSqlDate(dateToStr(dt1.Date)) +' , ' + fdt.StrToSqlDate(dateToStr(dt2.Date));
         qrCabeca.SQL.Clear;
         qrCabeca.SQL.Add(cmd);
         qrCabeca.Open;

         qrCorpo.SQL.Clear;
         qrCorpo.SQL.Add(' Exec ListasComItensCompPorData_corpo '+quotedStr(NumLoja) +' , ' +fdt.StrToSqlDate(dateToStr(dt1.Date)) +' , ' + fdt.StrToSqlDate(dateToStr(dt2.Date)) );
         qrCorpo.Open;

         if (qrCorpo.IsEmpty = false) then
         begin
            params := getParametros(qrCorpo);
            fmMain.imprimeRave(qrCabeca, qrCorpo, nil, 'rpBaixasPorData', params);
         end
         else
            msg.msgWarning('Nenhuma baixa foi realizada nesse período.')
      end;
   end;
   BitBtn2.Enabled := true;
   BitBtn3.Enabled := true;
end;

function TForm9.getParametros(ds:Tdataset): TStringList;
var
   params:TStringList;
begin
   params := TStringList.create();

   params.add(DateToStr(dt1.Date));
   params.add(DateToStr(dt2.Date));
   params.add(cblojas.Items[cblojas.itemindex]);
   params.add(funcoes.RParReg('listas','Versao'));
   Params.Add('Total de Itens: ' + inttostr(ds.RecordCount));
   params.add(funcoes.RParReg('listas', 'Versao')   );
   result := params;
end;

procedure TForm9.imprimeBaixasTotais(loja:String);
var
  ds:TdataSet;
  cmd:String;
begin
   cmd := ' Exec listaBaixaTotalPorLoja '+quotedStr(Loja) +', ' +fdt.StrToSqlDate(dateToStr(dt1.Date)) +', ' + fdt.StrToSqlDate(dateToStr(dt2.Date));
   ds:= dm.getDataSetQ(cmd);
   fmMain.imprimeRave(ds, nil, nil, 'rbBaixaSintetico', getParametros(ds) );
   ds.free();
end;


end.
