unit uCategoria;

interface


uses ADODB, SysUtils;

procedure getCatProduto(qr:TADOQuery; isRef:String);
procedure getSubCategorias(qr:TADOQuery;  nivel, campoPai:String);
procedure listaCategoria(qr:TADOQuery; cd_campo, cd_campoPai, cd_vcampoPai:String);
function removeClassificacao(isRef:String):boolean;
function gravaCat(isRef, nivel, valor:String):boolean;
function marcaItemComoClassificado(is_ref:String):boolean;


implementation


uses uDm, msg, f;

procedure getSubCategorias(qr:TADOQuery; nivel, campoPai:String);
var
  cmd:String;
begin
   cmd := dm.getCMD1('cat', 'getSubCat', nivel);

   if (campoPai <> '') then
      cmd := cmd +  dm.getCMD1('cat', 'getSubCat.Pai',  quotedStr(campoPai));

   cmd := cmd +  dm.getCMD('cat', 'getSubCat.ordem');

   dm.getQuery(qr, cmd);
end;


procedure listaCategoria(qr:TADOQuery; cd_campo, cd_campoPai, cd_vcampoPai:String);
var
   cmd:String;
begin
    if ( qr.IsEmpty = true) then
       qr.Close();

    cmd := 'select cd_vcampo, ds_vcampo from tvcom ' +
           'where cd_Campo = '+ cd_campo;

    if (cd_campoPai <> '') then
       cmd := cmd + ' and cd_campoPai= '+ cd_campoPai  +
                    ' and cd_vCampoPai = ' + cd_vcampoPai;

    cmd := cmd + ' order by ds_vcampo';

    dm.getQuery(qr, cmd);
end;


function removeClassificacao(isRef:String):boolean;
begin
   result := dm.execSQL( dm.getCMD1('cat', 'delCat', isRef) );
end;

function gravaCat(isRef, nivel, valor:String):boolean;
var
   cmd:String;
begin
   cmd := dm.getCMD3('cat', 'gravaCat',  isRef,  quotedStr(nivel), quotedStr(valor) );
   result := dm.execSQL(cmd);
end;

function marcaItemComoClassificado(is_ref:String):boolean;
var
   aux:string;
begin
   aux := dm.getCMD3('cat', 'classeOk', quotedStr(DateToStr(now)), quotedStr(is_ref), '');
   result :=  dm.execSQL(aux);
end;

procedure getCatProduto(qr:TADOQuery; isRef:String);
begin
   dm.getQuery(qr, dm.getCMD1('cat', 'getCatAtual', isRef));
end;


end.
