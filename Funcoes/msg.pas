unit msg;

interface

uses windows,dialogs,SysUtils,classes,MaskUtils, DB,
     Messages, Variants, Graphics, Controls, Forms, QStdCtrls,StdCtrls,dateUtils,
     fCtrls, QExtCtrls, ComCtrls, uInput2, unMsgTela2, uInputData, uAbreMovDiario;


       procedure getUoData(cbLj:TCustomComboBox; cd_pes:String; var uo, ds_uo:String; var data:Tdate);
       procedure msgItDs(ds:TdataSet);
	 	 function getTString(msgDialog:String):TStrings; overload;
       function msgErro(msg:String):integer;
       function msgErro2(msg:String):integer;
       function msgExclamation(msg:String):integer; overload;
       function msgExclamation(arq, msg:String):integer; overload;
       function msgInput(msg, vlDefault:String):String; overload;
       function msgInput(msgDialogo:String):String; overload;
       function msgInput2(msg, vlDefault:String):String;
       function msgInputData(dataMin, dataMax:Tdate):Tdate;
       function msgQuestion(msg:String):integer;
       function msgQuestion2(msg:String):integer;
       function msgWarning(msg:String):integer;
       function msgTela2(msg: string; showBtOk, showBtCancel:boolean ): integer;
       function showAndWriteErr(msg:String):integer;


implementation

uses f, uMsgMemoInput;

function msgTela2(msg: string; showBtOk, showBtCancel:boolean ): integer;
begin
	// mensagem de tela para o aplicativo do coletor
   application.CreateForm(TfmMsgTela2, fmMsgTela2);
   fmMsgTela2.preparaParaExibir(msg, showBtOk, showBtCancel);
   fmMsgTela2.ShowModal;
   result := fmMsgTela2.ModalResult;
end;

function msgTela(titulo, Msg: string; iconeBotao: integer): integer; overload;
begin
   if (titulo = '') then
      titulo := application.Title;
   result := application.MessageBox(pchar(msg), pchar(titulo), iconeBotao );
end;

function msgTela(Msg: string; iconeBotao: integer): integer; overload;
begin
   result := msgTela('', Msg, iconeBotao);
end;

function msgErro(msg:String):integer;
begin
   result := msgTela(msg, MB_ICONHAND + MB_OK);
end;

function msgErro2(msg:String):integer;
begin
   result := msgTela2(msg, true, false);
end;

function msgQuestion(msg:String):integer;
begin
   result := msgTela(msg, MB_ICONQUESTION + MB_YESNO);
end;

function msgQuestion2(msg:String):integer;
begin
   result := msgTela2(msg, true, true);
end;

function msgWarning(msg:String):integer;
begin
   result := msgTela(msg, MB_ICONWARNING + MB_ok);
end;

function msgExclamation(msg:String):integer;
begin
   result := msgTela(msg, MB_ICONEXCLAMATION + MB_ok);
end;

function msgInput(msg, vlDefault:String):String; overload;
var
   aux:String;
begin
   aux := vlDefault;
   aux := inputBox(application.Title, msg, aux);
   result := aux;
end;

function msgInput2(msg, vlDefault:String):String;
begin
   application.CreateForm(TfmInput2, fmInput2);
   fmInput2.ajustaCampos('Informe o número do lote:', '', true, true);
   fmInput2.ShowModal;

   if ( fmInput2.ModalResult = mrOk) then
      vlDefault := fmInput2.edInput.Text
   else
     vlDefault:= '';

    fmInput2 := nil;

    result := vlDefault;
end;


function msgInputData(dataMin, dataMax:Tdate):Tdate;
var
  data:Tdate;
begin
   Application.CreateForm(TfmInputData, fmInputData);
   fmInputData.dt.MinDate:= dataMin;
   fmInputData.dt.MaxDate:= dataMax;

   fmInputData.ShowModal();

   if (fmInputData.ModalResult = mrOk) then
      data := fmInputData.dt.Date
   else
     data := -1;

   fmInputData := nil;

   result := data;
end;

procedure getUoData(cbLj:TCustomComboBox; cd_pes:String; var uo, ds_uo:String; var data:Tdate);
begin
   application.CreateForm(TfmDialogMov, fmDialogMov);

   fmDialogMov.confCampos(data);

   fmDialogMov.cbLoja.Items := cbLj.Items;
   fmDialogMov.cbLoja.ItemIndex := cbLj.ItemIndex;

   fmDialogMov.ShowModal();
   if (fmDialogMov.ModalResult = MrOk) then
   begin
      uo := f.getCodUO(fmDialogMov.cbLoja);
      ds_uo :=  'descricao da uo';//  uLj.getNomeUO(fmDialogMov.cbLoja);
      data := fmDialogMov.fsData.date;
   end
   else
   begin
      uo := '';
      ds_uo := '';
   end;
   fmDialogMov := nil;
end;

function showAndWriteErr(msg:String):integer;
begin
   f.gravaLog(msg);
   msgErro(msg);
end;

function getTString(msgDialog:String):TStrings; overload;
var
  i:integer;
  cmd:String;
begin
   application.CreateForm(TfmMsgMemoInput, fmMsgMemoInput);
   fmMsgMemoInput.Caption := msgDialog;
   
   fmMsgMemoInput.ShowModal();

   if (fmMsgMemoInput.ModalResult = mrOk) then
      result := fmMsgMemoInput.Memo1.Lines
   else
      result := TStringlist.Create();
end;


function msgInput(msgDialogo:String):String; overload;
var
  i:integer;
  cmd:String;
  itens:TStrings;
begin //
	itens := getTString(msgDialogo);

   if (itens.Count > 0) then
   begin
      for i:= 0 to fmMsgMemoInput.Memo1.Lines.Count -1 do
         cmd := cmd + fmMsgMemoInput.Memo1.Lines[i] + ' ';

      cmd := f.tiraCaracter(cmd, '  ');
      cmd := f.tiraCaracter(cmd, #13);

      result := cmd;
   end
   else
      result := '';
end;


procedure msgItDs(ds:TdataSet);
var
  cmd:String;
  i:integer;
begin
   for i:=0 to ds.FieldCount -1 do
      cmd:=
      cmd + ds.FieldDefs[i].Name + ': ' + ds.Fields[i].AsString + #13;
   msg.msgExclamation(cmd);
end;

function msgExclamation(arq, msg:String):integer; overload;
var
   i:integer;
   f:TStringlist;
begin
   f:= TStringlist.create();
   f.LoadFromFile(arq);

   for i:= 0 to f.Count -1 do
      msg := msg + f[i] + ', ';

   f.Free();   
   result := msgExclamation(msg);
end;


end.
