unit uHash;

interface

uses Classes, f;

type
   THash = class

   public
      index: TSTringList;
      valor: TSTringList;

      constructor Create;
      destructor Destroy;

      function add(idx, val:String):boolean;
      function getValor(idx:String):String;
      function indexOf(valor:String):integer;

      procedure Free();
      procedure saveParams();
   end;



implementation

function THash.add(idx, val: String): boolean;
begin
   index.add(idx);
   valor.Add(val);
end;

constructor THash.Create;
begin
   index := Tstringlist.Create();
   valor := Tstringlist.Create();
end;


destructor THash.Destroy;
begin
  if Self <> nil then
    Destroy;
end;

procedure THash.Free;
begin
   if Self <> nil then
       Destroy;
end;

function THash.getValor(idx: String): String;
begin
   if (index.IndexOf(idx) >= 0 )then
      result :=  valor[index.IndexOf(idx)]
   else
      result :=  '';
end;

function THash.indexOf(valor: String): integer;
begin
	result := index.IndexOf(valor);
end;

procedure THash.saveParams();
var
  i:integer;
begin
   f.gravaLog('---------');
   if (index <> nil) then
      for i:=0 to index.Count - 1 do
        f.gravaLog(index[i] + ' - '+ valor[i]);
   f.gravaLog('---------');
end;

end.
