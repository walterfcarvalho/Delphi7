unit uAlteraFinanceira;

interface

uses
  Windows, DB, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, adLabelEdit, TFlatButtonUnit ;


type
  TfmAlteraFiananceira = class(TForm)
    edCodigo: TadLabelEdit;
    cbOrigem: TadLabelComboBox;
    Label1: TLabel;
    lbFinanceira: TLabel;
    btAlteraFinanceira: TFlatButton;
    Button1: TButton;
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btAlteraFinanceiraClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAlteraFiananceira: TfmAlteraFiananceira;

implementation

uses uMain, uDm, funcSQl, f, uFiscal;

{$R *.dfm}

procedure TfmAlteraFiananceira.edCodigoKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
begin
   if key = VK_RETURN  then
   begin
      lbFinanceira.Caption := dm.openSQL( ' select  cast( dsagn.cb_codagen as varchar   )   + '' '' +  dsagn.cb_nomc_ag as agente from dsagn (nolock) inner join ' +
                              ' dsfat (nolock)on dsagn.cb_codagen = dsfat.cb_codagen where nr_contrato = '  + QuotedStr(edCodigo.text),
                              'agente');
   end;
end;

procedure TfmAlteraFiananceira.btAlteraFinanceiraClick(Sender: TObject);
var
   tc:Word;
   SHIF: TShiftState;

   agente, cmd, nossoNum, dvNossoNum:String;
   dsdup:TDataSet;
begin
    TC := VK_RETURN;
    SHIF := [ssShift];
//    if f.msgQuestion('Deseja alterar a financeira desse contrato ? ') = mrYes then
    begin
       agente := copy(cbOrigem.Items[cbOrigem.itemIndex], 01, 01);

       // atualizar a dsfat
       cmd := dm.getCMD('financeiro', 'AtualizaDsfat');
       dm.setParam(cmd, agente);
       dm.setParam(cmd, agente);
       dm.setParam(cmd, edCodigo.Text);
       dm.execSQL(cmd);


       // pegar os dados dos boletos
       cmd := dm.getCMD('financeiro', 'getDadosDuplicata');
       dm.setParam(cmd, edCodigo.Text);
       dsDup := dm.getDataSetQ(cmd);

       dsdup.First();
       while (dsdup.Eof = false) do
       begin
          // pegando o novo nosso numero
          cmd := dm.getCMD('financeiro', 'getNossoNum');
          dm.setParam(cmd, agente);
          nossoNum := dm.openSQL(cmd, '');

          dvNossoNum := uFiscal.getDvModulo11(nossoNum);

          // atualiza a dsdup
          cmd := dm.getCMD('financeiro', 'AtualizaDsdup');
          dm.setParam(cmd,  agente);
          dm.setQtParam(cmd, f.preencheCampo(7, '0', 'e', nossoNum));
          dm.setParam(cmd, dvNossoNum);
          dm.setParam(cmd, edCodigo.Text);
          dm.setQtParam(cmd, dsdup.fieldByName('par_dup').AsString );
          dm.execSQL(cmd);

        // atualiza o contador do nosso numero
          cmd := dm.getCMD('financeiro', 'upContNossoNum');
          dm.setParam(cmd, nossoNum);
          dm.setParam(cmd, agente);
          dm.execSQL(cmd);

          dsdup.Next();
       end;

       dsdup.free();

       edCodigoKeyDown(nil, TC, SHIF);

//       f.msgExclamation('Alteração processada')
    end;
end;

procedure TfmAlteraFiananceira.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   f.salvaCampos(fmAlteraFiananceira);
   fmAlteraFiananceira:= nil;
   action := CaFree;
end;

procedure TfmAlteraFiananceira.Button1Click(Sender: TObject);
var
   ds:TdataSet;
   cmd:String;
   bt:word;
begin
bt:= VK_RETURN;

   cmd := 'select  nr_contrato from dsfat '+
          'where cb_codagen = 5 '+
          'and dt_emi_fat >= 20120501 AND cb_prefDup = ''DP'' ';

   ds:= dm.getDataSetQ(cmd);

   ds.First();
   while ( ds.Eof = false ) do
   begin
     edCodigo.Text := ds.fieldByName('nr_contrato').AsString;
     edCodigoKeyDown(nil, bt, [ssShift]);

     cbOrigem.ItemIndex := 1;

     btAlteraFinanceiraClick(nil);
     ds.Next();
   end;
   ds.free;
end;

end.
