unit uBuscasDiversas;

interface

uses   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelEdit, Buttons, fCtrls, adLabelComboBox,
  TFlatButtonUnit, ExtCtrls, Db, adodb;

   function getListaCidades(UF, cidade:String; hasCodIBGE:boolean):TdataSet;
   function getUFS():TdataSet;
   function pegarDadosCampo(codPerfil, campoCodigo, campoNome, campoDiparador, filtro:String ; var codRetorno, nmRetorno:String):boolean;


implementation

uses uBuscaCidade, f, uDm;


function pegarDadosCampo(codPerfil, campoCodigo, campoNome, campoDiparador, filtro:String ; var codRetorno, nmRetorno:String):boolean;
var
  res:boolean;
begin
// cod perfil {cidade, bairro, uf }


   res:= false;
   if (campoDiparador <> '') then
   begin
      Application.CreateForm(TfmBuscaDiversas, fmBuscaDiversas);
      fmBuscaDiversas.setPerfil(codPerfil);
      fmBuscaDiversas.edFiltro.Text := filtro;

      fmBuscaDiversas.showModal();

      if (fmBuscaDiversas.ModalResult = mrOk) then
      begin
         codRetorno := fmBuscaDiversas.dsPes.DataSet.fieldByName(campoCodigo).asString;
         nmRetorno := fmBuscaDiversas.dsPes.DataSet.fieldByName(campoNome).asString;
         res:= true;
      end;
      fmBuscaDiversas.Close();
      fmBuscaDiversas := nil;
   end;
   result := res;

end;

function getListaCidades(UF, cidade:String; hasCodIBGE:boolean):TdataSet;
var
   codIBGE:String;
begin
   if (hasCodIBGE = true) then
      codIBGE := dm.getCMD('otr', 'lstCid.codIbge');

   result :=
   dm.getDataSetQ(
      dm.getCMD3('otr', 'lstCid', quotedStr(uf), quotedstr(cidade + '%'), codIBGE)
   );
end;

function getUFS():TdataSet;
var
   cmd:String;
begin
   cmd := 'Select cd_uf, nm_uf from TUF order by nm_uf';
   result := dm.getDataSetQ(cmd);
end;




end.
