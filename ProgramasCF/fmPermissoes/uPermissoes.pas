unit uPermissoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, adLabelComboBox, Menus,  Grids, DBGrids,
  SoftDBGrid, f, funcsql, DB, ADODB, TFlatButtonUnit, ComCtrls,
  adLabelListBox, adLabelEdit, Buttons, fCtrls, ExtCtrls, ImgList,
  TFlatCheckBoxUnit;

type
  TfmPermissoes = class(TForm)
    grid: TSoftDBGrid;
    tb: TADOTable;
    DataSource1: TDataSource;
    dsuser: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    Tree: TTreeView;
    Label1: TLabel;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    edUser: TadLabelEdit;
    btIncluiXML: TfsBitBtn;
    SoftDBGrid1: TSoftDBGrid;
    Splitter1: TSplitter;
    cbTpPerm: TfsCheckBox;
    PopupMenu1: TPopupMenu;
    Inserirpermissodousurio1: TMenuItem;
    Desativaresseusurio1: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListarMenus(Sender: TObject;  item:TmenuItem);
    procedure gridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    function liberaMenu(lst:Tstringlist; tag:string):boolean;
    procedure CarregaMenu(menu:TMenu);
    procedure InsertNodeChild(menuItem:TMenuItem; noPai:TTreeNode);
    function getMenuName(Str:String):String;
    procedure TreeClick(Sender: TObject);
    procedure criarTabela();
    procedure inserirGruposNaTabela(tpGrupos:char);
    procedure mostraPermissoes(cod:String);
    procedure btIncluiXMLClick(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure ajustaPermisssaoAcessoTela();
    procedure ajustaPermisaoAcessoRestrito();
    procedure ajustaPermissaoSolicitaSenha();
    procedure ajustaPermissaoCampo(campo:String);
    procedure cbTpPermClick(Sender: TObject);
    procedure Inserirpermissodousurio1Click(Sender: TObject);

    procedure ajustaDescColuna(field:String);
    procedure Desativaresseusurio1Click(Sender: TObject);




  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPermissoes: TfmPermissoes;
  LISTA:TStringList;
  MENU_SELECIONADO:String;
  TELAS_VISIVEIS:Tstringlist;

implementation

uses uMain, uAvarias, uDm, uUsuarios;

{$R *.dfm}

procedure TfmPermissoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   fmMain.Menu := fmMain.menuPrincipal;
   fmPermissoes := nil;
   fmCadAvarias := nil;
   action := caFree;
end;

procedure TfmPermissoes.ListarMenus(Sender: TObject;  item:TmenuItem);
var
   i:integer;
begin
   tb.Open;
   if (item.Count > 0) then
   begin
      if item.parent = nil then
      begin
          tb.InsertRecord(['', '', item.Caption,'']);
      end
      else
      begin
          tb.InsertRecord(['', '', item.Caption, '']);
      end ;

      for i:=0 to item.Count -1 do
         ListarMenus(nil, item.Items[i]);
    end
    else
    begin
       if item.Tag <> 0 then
          tb.InsertRecord(['', 'x', '', item.Caption, inttostr(item.Tag)]);
    end;
end;

procedure TfmPermissoes.gridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
   if Column.Field.FieldName = 'Menu' then
      column.Font.Style := [fsbold];

   if (Column.Field.FieldName = 'Acessa')
   or (Column.Field.FieldName = 'isAcessoRestrito')
   or (Column.Field.FieldName = 'isPedeAutorizacao')
   or (Column.Field.FieldName = 'isAcessoTotal')
   then
   begin
      column.Font.Style := [fsbold];
      Column.Font.Color := clred;
   end;
end;

function TfmPermissoes.liberaMenu(lst: Tstringlist; tag: string): boolean;
var
  i:integer;
  achou:boolean;
begin
   achou := false;
   for i:=0 to lst.Count-1 do
      if tag = lst[i] then
      begin
         achou := true;
         break;
      end;
    result := achou;
end;

procedure TfmPermissoes.InsertNodeChild( menuItem: TMenuItem; noPai: TTreeNode);
var
   i:integer;
   nodoFilho:TTreeNode;
begin
   for i:=0 to menuItem.Count-1 do
      if menuItem.Items[i].Count > 0 then
      begin
         if (TELAS_VISIVEIS.IndexOf(intToStr(menuItem.Items[i].Tag)) > -1) then
         begin
            nodoFilho := tree.Items.AddChild(noPai, f.preencheCampo(4,'0','E', intToStr(menuItem.Items[i].Tag), false)+'-'+ getMenuName(menuItem.Items[i].Caption));
            InsertNodeChild(menuItem.Items[i], nodoFilho );
            LISTA.AddObject( intToStr(menuItem.Items[i].tag),  nodoFilho  )
         end
      end
      else
      begin
         if (TELAS_VISIVEIS.IndexOf(intToStr(menuItem.Items[i].Tag)) > -1) then
            LISTA.AddObject( intToStr( menuItem.Items[i].tag),  tree.Items.AddChild(noPai,  f.preencheCampo(4,'0','E', intToStr(menuItem.Items[i].Tag)) +'-'+getMenuName( menuItem.Items[i].Caption) ) )
      end;
end;

procedure TfmPermissoes.carregaMenu(menu:TMenu);
var
  nod:TTreeNode;
begin
   nod := tree.Items.Add(nil,menu.Name);

//inserir na arvore
   InsertNodeChild(menu.Items, nod);
end;

function TfmPermissoes.getMenuName(Str: String): String;
begin
   while pos('&',str) > 0 do
      delete(str, pos('&',str) , 1);
   result := str;
end;

procedure TfmPermissoes.mostraPermissoes(cod: String);
var
  ds:TdataSet;
  cmd:String;
begin
   if (cbTpPerm.Checked = false) then
      cmd :=  dm.getCMD('adm','listaPermTelaGrupo')
   else
      cmd :=  dm.getCMD('adm','listaPermUsers');

   dm.setParam(cmd, cod);

   ds:= dm.getDataSetQ(cmd);
   grid.Visible := false;
   tb.First;
   while (tb.Eof = false) do
   begin
      ds.First();
      tb.Edit;
      tb.FieldByName('Acessa').asString := '';
      tb.FieldByName('isAcessoRestrito').asString := '';
      tb.post;

      while (ds.Eof = false) do
      begin
         if tb.FieldByName('codGrupo').asinteger = ds.FieldByName('grupo').AsInteger then
         begin
            tb.Edit;
            tb.FieldByName('Acessa').asString := 'X';

            if (ds.FieldByName('isAcessoRestrito').asInteger <> 0) then
               tb.FieldByName('isAcessoRestrito').asString := 'X'
            else
               tb.FieldByName('isAcessoRestrito').asString := '';

            if (ds.FieldByName('isPedeAutorizacao').asInteger <> 0) then
               tb.FieldByName('isPedeAutorizacao').asString := 'X'
            else
               tb.FieldByName('isPedeAutorizacao').asString := '';

            if (ds.FieldByName('isAcessoTotal').AsString = '-1' ) then
               tb.FieldByName('isAcessoTotal').asString := 'X'
            else
               tb.FieldByName('isAcessoTotal').asString := '';

            tb.post;
            break;
         end;
         ds.Next();
      end;
      tb.Next();
  end;
  ds.Free();
  grid.Visible := true;
end;


procedure TfmPermissoes.TreeClick(Sender: TObject);
begin
   if LISTA.IndexOfObject( tree.Selected ) > -1 then
   begin
      MENU_SELECIONADO := LISTA[LISTA.IndexOfObject(tree.Selected)];
      mostraPermissoes( MENU_SELECIONADO );
   end;
end;

procedure TfmPermissoes.criarTabela();
var
   cmd:String;
begin
   cmd := dm.getCMD('adm', 'tbTempPermissao');
   dm.getTable(tb, cmd);
   DataSource1.DataSet := tb;
end;

procedure TfmPermissoes.inserirGruposNaTabela(tpGrupos:char);
var
   cmd : String;
begin
   if (tpGrupos = 'G') then
     cmd :=  dm.getCMD1('adm', 'getLstPermGrupoPadrao', tb.TableName)
   else
      cmd := dm.getCMD1('adm','getLstPermUserPadrao', tb.tableName);


   dm.execSQL(cmd);
   tb.Close();
   tb.open();

   grid.Columns[ tb.FieldByName('isPedeAutorizacao').Index ].Title.Caption := 'Pede autorização';
   grid.Columns[ tb.FieldByName('isPedeAutorizacao').Index ].Alignment := taCenter;

   grid.Columns[ tb.FieldByName('isAcessoRestrito').Index ].Title.Caption := 'Acesso restrito';
   grid.Columns[ tb.FieldByName('isAcessoRestrito').Index ].Alignment := taCenter;

   grid.Columns[ tb.FieldByName('isAcessototal').Index ].Title.Caption := 'Acesso total';
   grid.Columns[ tb.FieldByName('isAcessototal').Index ].Alignment := taCenter;

   grid.Columns[ tb.FieldByName('seq').Index ].Visible := false;
   grid.Columns[ tb.FieldByName('Codgrupo').Index ].Visible := false;
   grid.Columns[ tb.FieldByName('grupo').Index ].Width := 150;
   grid.Columns[ tb.FieldByName('acessa').Index ].Width := 50;
   grid.Columns[ tb.FieldByName('acessa').Index ].Alignment := taCenter;
end;


procedure TfmPermissoes.FormCreate(Sender: TObject);
begin
	grid.Align := alClient;

   cbTpPermClick(nil);


   LISTA := TStringList.Create();

   TELAS_VISIVEIS := uUsuarios.getTelasPrograma();

// carrega o menu principal
   carregaMenu(fmMain.menuPrincipal);

// inica o menu de avarias para aplicar as permissoes a ele
   Application.CreateForm( TfmCadAvarias  , fmCadAvarias);
   fmCadAvarias.Enabled := false;

   carregaMenu(fmCadAvarias.menuAvarias);

   fmCadAvarias.Free();
end;

procedure TfmPermissoes.btIncluiXMLClick(Sender: TObject);
var
   cmd:String;
begin
   cmd := dm.getQtCMD1('adm', 'getUsers', edUser.Text + '%');

   dsuser.DataSet := dm.getDataSetQ(cmd);
end;

procedure TfmPermissoes.ajustaPermisssaoAcessoTela();
var
  cmd:String;
begin
   tb.Edit();
   if(tb.FieldByName('Acessa').asString = '') then
   begin
      cmd := dm.getCMD2('adm', 'insPermGrupoTela', MENU_SELECIONADO, tb.fieldByname('codGrupo').asString);
      dm.execSQL(cmd);
      tb.FieldByName('Acessa').asString := 'X'
   end
   else
   begin
      cmd := dm.getCMD2('adm', 'delPermGrupoTela', MENU_SELECIONADO, tb.fieldByname('codGrupo').asString);
      dm.execSQL(cmd);
      tb.FieldByName('Acessa').asString := ''
   end;
   tb.Post();
end;

procedure TfmPermissoes.ajustaPermissaoCampo(campo:String);
var
   cmd:String;
begin
   tb.Edit();

   cmd :=
   dm.getCMD4(
      'adm',
      'UptPermGrupoTela',
      campo,
      boolToStr(not(tb.fieldByname(campo).asString <> '')),
      MENU_SELECIONADO,
      tb.fieldByname('codGrupo').asString
   );

   dm.execSQL(cmd);

   if(tb.FieldByName(campo).asString = '') then
      tb.FieldByName(campo).asString := 'X'
   else
      tb.FieldByName(campo).asString := '';

   tb.post();
end;

procedure TfmPermissoes.ajustaPermisaoAcessoRestrito();
begin
   ajustaPermissaoCampo('isAcessoRestrito');
end;

procedure TfmPermissoes.ajustaPermissaoSolicitaSenha();
begin
   ajustaPermissaoCampo('isPedeAutorizacao');
end;

procedure TfmPermissoes.gridCellClick(Column: TColumn);
begin
   if (tb.IsEmpty = false) and (tree.Selected <> nil) then
   begin
      if (Column.FieldName = 'Acessa') or
         (Column.FieldName = 'teste') or
         (Column.FieldName = 'isAcessoRestrito') or
         (Column.FieldName = 'isPedeAutorizacao') or
         (Column.FieldName = 'isAcessoTotal') then
      begin
          if (cbTpPerm.Checked = false) then
          begin
             if (Column.FieldName = 'Acessa')then
                ajustaPermisssaoAcessoTela();

             if (tb.FieldByName('Acessa').asString = 'X') and (Column.FieldName = 'isAcessoRestrito') then
                ajustaPermisaoAcessoRestrito();

             if (tb.FieldByName('Acessa').asString = 'X') and (Column.FieldName = 'isPedeAutorizacao') then
                ajustaPermissaoSolicitaSenha();

             if (tb.FieldByName('Acessa').asString = 'X') and (Column.FieldName = 'isAcessoTotal') then
                   ajustaPermissaoCampo('isAcessoTotal');
          end
          else
          begin
                uUsuarios.ajPermissaoUser(
                   tb.fieldByName('codGrupo').AsString,
                   MENU_SELECIONADO,
                   tb.FieldByName('isAcessoRestrito').AsBoolean,
                   tb.FieldByName('isPedeAutorizacao').AsBoolean,
                   tb.FieldByName('isAcessoTotal').AsBoolean,
                   not(tb.FieldByName('Acessa').asString = 'X')
                );

                ajustaDescColuna(Column.FieldName);
          end;
      end;
   end;
end;


procedure TfmPermissoes.cbTpPermClick(Sender: TObject);
begin
   criarTabela();

   if (cbTpPerm.Checked = true) then
      inserirGruposNaTabela('U')
   else
      inserirGruposNaTabela('G');

   Inserirpermissodousurio1.Enabled := cbTpPerm.Checked;
end;

procedure TfmPermissoes.Inserirpermissodousurio1Click(Sender: TObject);
begin
   uUsuarios.ajPermissaoUser(
      dsuser.DataSet.fieldByName('cd_pes').AsString,
      '000',
      false,
      false,
      false,
      true
   );
   cbTpPermClick(nil);
   cbTpPermClick(nil);
end;

procedure TfmPermissoes.ajustaDescColuna(field: String);
begin
   tb.Edit();
   if (tb.FieldByName(field).AsString = 'X') then
      tb.FieldByName(field).AsString := ''
   else
      tb.FieldByName(field).AsString := 'X';
   tb.post();
end;

procedure TfmPermissoes.Desativaresseusurio1Click(Sender: TObject);
begin
   uUsuarios.desativaUsuario(dsuser.DataSet.fieldByName('cd_pes').AsString);
end;

end.
