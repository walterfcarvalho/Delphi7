unit reg;

interface

   uses Registry, Windows;

   function delchave(folder, chave:String):boolean;
   function insChave(folder, chave, valor:String):boolean;

implementation

function delchave(folder, chave:String):boolean;
begin
   result := (Tregistry.create).DeleteKey(folder);
end;


function insChave(folder, chave, valor:String):boolean;
var
  Reg: Tregistry;
begin
  Reg := Tregistry.create;
  with Reg do
  begin
    rootkey := HKEY_CURRENT_USER;
    Openkey('Software\'+folder, true);
       writestring(chave, valor);
    closekey;
  end;
end;

end.
 