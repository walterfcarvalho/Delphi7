unit uCmd;

interface

   uses SysUtils, iniFiles, msg;

   function getCMD(arq:TiniFile; setor,chave:String):String;
   procedure setParam(var cmd:String; vlParam:String);
   procedure setQtParam(var cmd:String; param:String);
   function  formataCMD(cmd:String):String;


implementation

uses Classes, f;

function  formataCMD(cmd:String):String;
var
   p:Tstrings;
   i, idxP:integer;
   s1, sa:String;
begin
   p:= TStringList.create();
   p.add('from');
   p.add('inner');
   p.add('left');
   p.add('where');
   p.add('and');
   p.add('group');
   p.Add('order');
   p.Add('into');

	for i:= length(cmd) downto 1 do
   begin
		for idxP:= 0 to p.Count-1 do
      begin
			s1 := copy( cmd, i, length(p[idxP]) );

         if ( s1 = p[idxP] ) then
            if (cmd[i-1] <> '$') then
            	insert(#13+' ', cmd, i);

      end;
   end;


	for i:= length(cmd) downto 1 do
   begin
   // Quebra a linha
         if ( cmd[i] = '|') then
         begin
            delete(cmd, i, 1);
            insert( #13 + ' ', cmd, i );
         end;

			if ( cmd[i] = '$') then
				delete(cmd, i, 1);
   end;

   
   result := cmd;
end;

function getCMD(arq:TiniFile; setor,chave:String):String;
var
  aux:String;
begin
    aux := arq.ReadString( setor, chave, '');
    if (aux <> '') then
    begin
       aux := formataCMD(aux);
    end
    else
    begin
       f.gravaLog('Não achei o resource setor: <'+ setor + '> chav: <'+ chave+'>');
       msg.msgErro('Não achei o resource setor: <'+ setor + '> chav: <'+ chave+'>');
    end;

    result := aux;
end;

procedure setParam(var cmd:String; vlParam:String);
var
   i:integer;
begin
   i:= pos('?', cmd);
   if (i > 0) then
   begin
      delete(cmd, i, 1);
      insert(vlParam, cmd, i);
   end
end;

procedure setQtParam(var cmd:String; param:String);
begin
   param := quotedStr(param);
   setParam(cmd, param);
end;
end.
