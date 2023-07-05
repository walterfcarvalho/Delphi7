unit uLojas;



interface

uses db, StdCtrls, SysUtils, classes ;



   function getNumLocalEmpresa(cb: TcustomComboBox):String;
   function getNomeLojasPonto(mostraOpcTodas, mostraNenhum:boolean): Tstrings;



implementation

uses uDm, funcoes;


function getNumLocalEmpresa(cb: TcustomComboBox):String;
begin
    result := trim(copy(cb.Items[cb.itemIndex], 101, 10));
end;

function getNomeLojasPonto(mostraOpcTodas, mostraNenhum:boolean): Tstrings;
var
  qr:Tdataset;
  lst:TStrings;
begin
   qr := dm.getDataSetQ( 'Select * from zcf_PontoLocalizacao (nolock) order by localizacao'  );

   lst := TStringList.Create();

   if (mostraOpcTodas= true) then
      lst.Add('< Todas >');

   if (mostraNenhum= true) then
      lst.Add('< Nenhum >');

   while (qr.Eof = false) do
   begin
      lst.Add(funcoes.preencheCampo(100,' ', 'd',qr.fieldByname('ds_uo').AsString) + qr.fieldByname('localizacao').AsString);
      qr.Next();
   end;
   qr.Destroy();
   result := lst;
end;





end.
