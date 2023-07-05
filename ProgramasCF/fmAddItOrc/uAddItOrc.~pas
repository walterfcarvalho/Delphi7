unit uAddItOrc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Grids, DBGrids, SoftDBGrid, adLabelEdit,
  TFlatButtonUnit, ADODB, adLabelNumericEdit, adLabelDBNumericEdit;

type
  TfmAddItOrc = class(TForm)
    btConsPed: TFlatButton;
    gridItens: TSoftDBGrid;
    Label4: TLabel;
    dsPed: TDataSource;
    tbItens: TADOTable;
    edDesc: TadLabelEdit;
    edCod: TadLabelEdit;
    edValor: TadLabelNumericEdit;
    FlatButton1: TFlatButton;
    edQt: TadLabelNumericEdit;
    edNmPed: TadLabelNumericEdit;
    procedure btConsPedClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edCodKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure edNmPedKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure edQtKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FlatButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmAddItOrc: TfmAddItOrc;
  DS_ITEM:TdataSet;
  DS_PED:TdataSet;
implementation

uses uPedCliente, msg, uDM, f, uMain, uProd, uCf;

{$R *.dfm}

procedure TfmAddItOrc.btConsPedClick(Sender: TObject);
var
   nmPedido, cmd:String;
begin
   if (edNmPed.Value > 0) then
   begin
      nmPedido := edNmPed.Text;
      cmd :=  '';

      DS_PED:= uPedCliente.getDadosPedCliente(nmpedido);

      if (DS_PED.FieldByName('st').AsString = 'P' ) AND
         (DS_PED.FieldByName('is_uo').AsString = fmMain.getUoLogada()  )then
      begin
         if (DS_PED.IsEmpty = false) then
         begin
            uPedCliente.carregaItensPedido(
               tbItens,  dsPed, gridItens, edNmPed.Text
            );

            f.ajGridCol(gridItens, dsped.DataSet, 'Responsavel pela avaria', 0, '');
            f.ajGridCol(gridItens, dsped.DataSet, 'custoFator', 0, '');

            edValor.Value := DS_PED.fieldByName('Vl Produtos').AsCurrency;
            edCod.SetFocus();
        end
     end
     else
        msg.msgErro('O pedido está aberto ou já foi recebido, ou não é dessa loja');

     edQt.Text := '0';
     edCod.Text := '';
     edDesc.Text := '';
   end;
end;

procedure TfmAddItOrc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   action := caFree;
   fmAddItOrc := nil;
end;

procedure TfmAddItOrc.edCodKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = VK_return) then
   begin
      DS_ITEM := uProd.getDadosProdEst( fmMain.getUoLogada(), edCod.Text, '', '101', true, 'D', 'CE', 'CE', true);

      if (DS_ITEM.IsEmpty = false) then
      begin
         if (DS_ITEM.Fields[0].FieldName <> 'CODIGO') then
         begin
            edDesc.Text :=
            DS_ITEM.fieldByName('cd_ref').AsString +' '+
            f.preencheCampo(40, ' ', 'D',DS_ITEM.fieldByName('ds_ref').AsString, true) + ' '+
            'R$ '+  strToMoney(DS_ITEM.fieldByName('precoComponente').AsString);
        end
         else
         begin
            edDesc.Text :=
            DS_ITEM.fieldByName('codigo').AsString +' '+
            f.preencheCampo(40, ' ', 'D',DS_ITEM.fieldByName('descricao').AsString, true) + ' '+
            'R$ '+  strToMoney(DS_ITEM.fieldByName('preco').AsString);
         end;
         edQt.SetFocus;
      end
   end;
end;

procedure TfmAddItOrc.edNmPedKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key = VK_RETURN) then
      btConsPedClick(nil);
end;

procedure TfmAddItOrc.edQtKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   qt:real;
begin
   f.gravaLog('quantidade de colunas' + intToStr(DS_ITEM.FieldCount));

   if (key = VK_RETURN) then
      if (DS_ITEM.IsEmpty = false) and (DS_PED.IsEmpty = false) and (edQt.Value > 0) then
         if (DS_ITEM.Fields[0].FieldName <> 'CODIGO') then
         begin
            qt := strToFloat(edQt.Text);

            DS_ITEM.First();
            while DS_ITEM.Eof = false do
            begin
               if (DS_ITEM.IsEmpty = false) and (DS_PED.IsEmpty = false) then
                  uPedCliente.insereItem(DS_PED,
                        DS_ITEM.fieldByName('precoComponente').AsFloat,
                        DS_ITEM.fieldByName('is_ref').AsString,
                        floatToStr(qt * DS_ITEM.fieldByName('quantidadeComponente').asFloat)
                  );
               btConsPedClick(nil);
               DS_ITEM.Next();
            end;
         end
         else
         begin
            if (edQt.Value > 0) and (DS_ITEM.FieldByName('preco').AsFloat > 0) then
            begin
               if (msg.msgQuestion(dm.getMsg('addItOrc')) = mrYes) then
               begin
                  uPedCliente.insereItem(DS_PED, DS_ITEM.fieldByName('preco').AsFloat, DS_ITEM.fieldByName('is_ref').AsString, edQt.Text);
                  btConsPedClick(nil);
                  ucf.logAlteracoesBD('uAddItOrc', fmMain.getNomeUsuario(), dm.getDataBd());
               end
               else
                  edCod.SetFocus();
            end;
         end;
{
   end;
}
end;

procedure TfmAddItOrc.FlatButton1Click(Sender: TObject);
begin
   edNmPed.Clear();
   edQt.Text := '0';
   edCod.Text := '';
   edDesc.Text := '';
   tbItens.Close();
   edValor.clear();
   edNmPed.SetFocus();
end;

procedure TfmAddItOrc.FormActivate(Sender: TObject);
begin
   DS_ITEM := TDataSet.Create(nil);
   DS_PED := TDataSet.Create(nil);
   edNmPed.SetFocus();
end;

end.
