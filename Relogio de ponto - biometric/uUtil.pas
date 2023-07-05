unit uUtil;

interface

uses
  Classes, Controls, StdCtrls, ExtCtrls, CheckLst, SysUtils,  Forms,
  ADODB, Dialogs, Windows, Graphics, ActiveX, GrFingerXLib_TLB,
  AXCtrls, uDBClass, db, dbGrids, adLabelComboBox;

type
  // Raw image data type.
  TRawImage = record
    // Image data.
    img:        OleVariant;
    // Image width.
    width:      Integer;
    // Image height.
    Height:     Integer;
    // Image resolution.
    Res:        Integer;
  end;

// Some constants to make our code cleaner
const
        ERR_CANT_OPEN_BD = -999;
        ERR_INVALID_ID = -998;
        ERR_INVALID_TEMPLATE = -997;

   function ativaEmpregado(matricula: String): boolean;
   function connectionIsClosed():boolean;
   function deletaEmpregado(matricula:String):boolean;
//   function desativaEmpregado(matricula:String; dataDemissao:Tdate):boolean;
   function Enroll(mat, lado, nome, cartao:string): Integer;
   function extractTemplate(finger:TGrFingerXCtrl): Integer;
   function getCadastroDeEmpregados(localizacao:String):TdataSet;
   function getCartaoPontoStr(str: String): String;
	function getDate:Tdate;
   function getDetalheEmpregado(cartaoPonto:String):TdataSet;
   function getHoraPrevista(cartao, campo:String; ds:TDataSet):String;
   function getJustificativas(): Tstrings;
   function getCodJust(cb:TadLabelComboBox):String;
   function getLocalEmpregado(cartaoPonto:String): String;
   function getMatricula(cartaoPonto: String; DS: TdataSet): String;
   function getNome(dadosEmp:String):String;
   function getNomeLojasPonto(mostraOpcTodas, mostraNenhum:boolean): Tstrings;
   function getNomeMatPorLocalizacao(localizacao: String): TdataSet;
   function getNumeroRegistros():integer;
   function getNumLocalEmpresa(cb: TcustomComboBox):String;
   function getOcorrencias():Tstrings;
   function getUserAutorizador():String;

   function Identify(finger:TGrFingerXCtrl; var score: Integer): Integer;
   function InitializeGrFinger(finger:TGrFingerXCtrl): Integer;
   function InitializeGrFingerSemCaptura(): Integer;
   function insereEmpregado(empresa,matricula,cartaoPonto, nome,funcao, dataAdmissao, isHoraFlexivel, horario, localizacao, dataDemissao:String):boolean;
   function insereRegistroFerias(tipo, matricula: String; dtI, dtF: TDate): boolean;
   function isAtivo(data, matricula: string): boolean;
   function isDiaBaseFolga(matricula:String; data:Tdate):boolean;
   function isDigitalCadastrada(mat, lado:string):boolean;
   function isFeriado(data, cartaoPonto:String):boolean; overload;
   function isFeriado(data:Tdate;cartaoPonto:String):boolean; overload;
   function isAtzAbn(codJust:string):boolean;
   function isJustificado(matricula, ocorrencia:String; data:Tdate ; var tpJust, obsJust, jusUsuario, ljDaJust:String):String;
   function getDataHoraBD():String;
   function justificar( mat, just, data1, data2, tipo, hora1,hora2, ocorr,Cartao,DtLancamento,Obs,banco,Estabelecimento,loja, diaGeradorFolga, autorizador:string):String;
   function obterDadosFuncionarios(localizacao:String): Tstrings;
   function isconnected():Boolean;
   function isHaveBatida(dia:Tdate; cartao:String): boolean;
   function lerParametroBD(parametro:String):String;
   function opendb():Boolean;
   function registraPonto(data,Hora,cartao,loja:string):boolean;
   function removeCadastroDigital(cartaoPonto, lado:String):boolean;
   function setParamBD(parametro, uo, valor:String):boolean;
   function Verify(finger:TGrFingerXCtrl; ID: Integer; var score: Integer): Integer;
   procedure AbrirCadastroDigitais();
   procedure closeDB();
   procedure deletajustificativa(numJustificativa: String);
   procedure FinalizeGrFinger(finger:TGrFingerXCtrl);
   procedure getQuery(var qr:TADOQuery; ComandoSQL:string);
   procedure getTable(var tb: TADOTable; tbFields: string);
   function listaJustificativas(cartao,dtInicio:String):TdataSet;
   procedure MessageVersion(finger:TGrFingerXCtrl);
   procedure PrintBiometricDisplay(var imagem: Timage; grFinger:TGrFingerXCtrl; biometricDisplay: boolean; context: Cardinal);
   procedure WriteError(err: Integer);
   procedure organizarQuery(var query:TADOQuery;Coluna:Tcolumn);
   procedure criaTbResumo(var Table:TADOTAble);
   procedure preencheListaDosDias(var tabela:TADOTable; dti,dtf:Tdate);
   function isCadastroEmpOk(cartaoPonto:String):boolean;
   function isPontoCadastrado(cartaoPonto: String): boolean;
   procedure WriteLog(str:String);
   function getDataSetQ(comandoSQL:string):TdataSet;
   procedure getEmpParaRelatorioBatidas(tb:TADOTable; localizacao, mes:String);

//   function isBatVaz(bat:String):boolean;


Var
  // The last acquired image.
  raw : TRawImage;
  // The template extracted from last acquired image.
  template: TTemplate;
  // Database class.
  DB: TDBClass;

implementation

uses f, fdt, uAutorizacao, msg, uEmpregado;


function getHoraPrevista(cartao, campo:String; ds:TDataSet):String;
begin
   result := uEmpregado.getHoraPrevista(cartao, campo, ds);
end;

// Write and describe an error.
procedure WriteError(err: Integer);
Begin
  case err of
    Integer(GR_ERROR_INITIALIZE_FAIL):
      WriteLog('Fail to Initialize GrFinger. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_NOT_INITIALIZED):
      WriteLog('The GrFinger Library is not initialized. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_FAIL_LICENSE_READ):
    begin
      WriteLog('License not found. See manual for troubleshooting. (Error:'+IntToStr(err)+')');
      ShowMessage('License not found. See manual for troubleshooting.');
    end;
    Integer(GR_ERROR_NO_VALID_LICENSE):
    begin
      WriteLog('The license is not valid. See manual for troubleshooting. (Error:'+IntToStr(err)+')');
      ShowMessage('The license is not valid. See manual for troubleshooting.');
    end;
    Integer(GR_ERROR_NULL_ARGUMENT):
      WriteLog('The parameter have a null value. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_FAIL):
      WriteLog('Fail to create a GDI object.  (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_ALLOC):
      WriteLog('Fail to create a context. Cannot allocate memory. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_PARAMETERS):
      WriteLog('One or more parameters are out of bound. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_WRONG_USE):
      WriteLog('This function cannot be called at this time. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_EXTRACT):
      WriteLog('Template Extraction failed. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_SIZE_OFF_RANGE):
      WriteLog('Image is too larger or too short. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_RES_OFF_RANGE):
      WriteLog('Image have too low or too high resolution.  (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_CONTEXT_NOT_CREATED):
      WriteLog('The Context could not be created. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_INVALID_CONTEXT):
      WriteLog('The Context does not exist. (Error:'+IntToStr(err)+')');

    // Capture error codes

    Integer(GR_ERROR_CONNECT_SENSOR):
      WriteLog('Error while connection to sensor. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_CAPTURING):
      WriteLog('Error while capturing from sensor. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_CANCEL_CAPTURING):
      WriteLog('Error while stop capturing from sensor. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_INVALID_ID_SENSOR):
      WriteLog('The idSensor is invalid. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_SENSOR_NOT_CAPTURING):
      WriteLog('The sensor is not capturing. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_INVALID_EXT):
      WriteLog('The File have a unknown extension. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_INVALID_FILENAME):
      WriteLog('The filename is invalid. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_INVALID_FILETYPE):
      WriteLog('The file type is invalid. (Error:'+IntToStr(err)+')');
    Integer(GR_ERROR_SENSOR):
      WriteLog('The sensor raise an error. (Error:'+IntToStr(err)+')');

    // Our error codes

    ERR_INVALID_TEMPLATE:
      WriteLog('Invalid Template. (Error:'+IntToStr(err)+')');
    ERR_INVALID_ID:
      WriteLog('Invalid ID. (Error:'+IntToStr(err)+')');
    ERR_CANT_OPEN_BD:
      WriteLog('Unable to connect to DataBase. (Error:'+IntToStr(err)+')');
  else
    WriteLog('Error:('+IntToStr(err)+')');
  end;
end;

// Check if we have a valid template
function TemplateIsValid(): boolean;
begin
  gravaLog('uUtil.TemplateIsValid()');
  // Check template size and data
  TemplateIsValid := ((template.size > 0) and (template.tpt <> nil));
end;

// -----------------------------------------------------------------------------------
// Main functions for fingerprint recognition management
// -----------------------------------------------------------------------------------
// abrir o banco de dados
function InitializeGrFinger(finger:TGrFingerXCtrl): Integer;
//function InitializeGrFinger(): Integer;
var
  err: Integer;
begin
  // Opening database

  // walter - alteracao para evitar que seja criado nvamente quando eu fechara tela deconsultas
//   if (db.isConnected() = false )then
   begin
     DB := TDBClass.Create();
     if not DB.openDB() then begin
       gravaLog('Nao abri o banc ode dados');
       InitializeGrFinger := ERR_CANT_OPEN_BD;
       Exit;
   end;
  // Create a new Template
  template := TTemplate.Create();

  // Initializing library.
//  err := fmMain.GrFingerXCtrl1.Initialize();
  err := finger.Initialize();
  if (err < 0) then begin
    InitializeGrFinger := err;
    exit;
  end;

//  err:=   fmMain.GrFingerXCtrl1.CapInitialize();
  err:=   finger.capInitialize();
  if (err < 0) then begin
    InitializeGrFinger := err;
    exit;
  end;

  gravaLog('banco de dados aberto');

  if ( err < 0) then
     msg.msgErro('Ocorreu um erro ao inicar a captura dos dados , verifique os seguintes itens: ' +#13+
                        '    - Verifique se o acesso ao sistema está on-line.' +#13+
                        '    - Verifique se o leitor optico está conectado e funcionando. '  +#13
                    );
  InitializeGrFinger := err;
end;

end;

function InitializeGrFingerSemCaptura(): Integer;
begin
   DB := TDBClass.Create();
   if not DB.openDB() then
   begin
      InitializeGrFingerSemCaptura := ERR_CANT_OPEN_BD;
      Exit;
   end;
end;

// Finalize library and close DB.
procedure FinalizeGrFinger(finger:TGrFingerXCtrl);
begin
  // finalize library
  finger.Finalize();
  finger.CapFinalize();
  // Closing database
  DB.closeDB();
  DB.Free();
  // Freeing resources
  template.Free();
end;

procedure PrintBiometricDisplay(var imagem: Timage; grFinger:TGrFingerXCtrl; biometricDisplay: boolean; context: Cardinal);
var
  // handle to finger image
  handle: IPictureDisp;
  // screen HDC
  hdc: LongInt;
begin
  // free previous image

  Imagem.Picture.Bitmap.Dormant();
  Imagem.Picture.Bitmap.FreeImage();

  {If range checking is on - turn it off for now
   we will remember if range checking was on by defining
   a define called CKRANGE if range checking is on.
   We do this to access array members past the arrays
   defined index range without causing a range check
   error at runtime. To satisfy the compiler, we must
   also access the indexes with a variable. ie: if we
   have an array defined as a: array[0..0] of byte,
   and an integer i, we can now access a[3] by setting
   i := 3; and then accessing a[i] without error}
  {$IFOPT R+}
    {$DEFINE CKRANGE}
  {$R-}
  {$ENDIF}

  // get screen HDC
  hdc := GetDC(0);

  if (biometricDisplay  = true )then
    // get image with biometric info
//    fmMain.GrFingerXCtrl1.BiometricDisplay(template.tpt,raw.img, raw.width, raw.height,raw.Res, hdc,handle, context)
     grFinger.BiometricDisplay(template.tpt,raw.img, raw.width, raw.height,raw.Res, hdc,handle, context)
  else
    // get raw image
    grFinger.CapRawImageToHandle(raw.img, raw.width, raw.height, hdc, handle);

  // draw image on picture box
  if handle <> nil then
  begin
    SetOlePicture(imagem.Picture, handle);
    imagem.Repaint();
  end;

  // release screen HDC
  ReleaseDC(HWND(nil), hdc);

  {Turn range checking back on if it was on when we started}
  {$IFDEF CKRANGE}
    {$UNDEF CKRANGE}
    {$R+}
  {$ENDIF}
end;


function Enroll(mat,lado, nome, cartao:string): Integer;
Var
  id: Integer;
Begin
   f.gravaLog('uUtil.Enroll(), digital:'+ mat + ' lado:'+ lado + ' nome:'+ ' cartao:'+ cartao);
//   delete(cartao, 01, 02);

  // Checking if template is valid.
   if (TemplateIsValid() = true ) then begin
    // Adds template to database and gets the ID.
		id := DB.addTemplate(template, mat, lado, nome, cartao);
		result := id;
	end
	else
		result := -1;

	f.gravaLog('Gravando digital no banco, result := ' + intToStr(result));
end;

// Extract a fingerprint template from current image
function ExtractTemplate(finger:TGrFingerXCtrl): Integer;
Var
  ret: Integer;
Begin

  // set current buffer size for extract template
  template.size := GR_MAX_SIZE_TEMPLATE;
  ret := finger.Extract(raw.img, raw.width, raw.height, raw.res, template.tpt,
                        template.size, GR_DEFAULT_CONTEXT);
  // if error, set template size to 0
  // Result < 0 => extraction problem
  if (ret < 0 ) then
    template.size := 0;
  ExtractTemplate := ret;
End;

// Identify current fingerprint on our database
function Identify(finger:TGrFingerXCtrl; var score: Integer): Integer;
Var
  ret: Integer;
  tptRef: TTemplate;
Begin
  f.gravaLog('uUtil.Identify()');

  // Checking if template is valid.
  if not( uUtil.TemplateIsValid())then
  begin
    Identify := ERR_INVALID_TEMPLATE;
    exit;
  end;

// Starting identification process and supplying query template.
  ret := finger.IdentifyPrepare(template.tpt, GR_DEFAULT_CONTEXT);

  // error?
  if (ret < 0) then begin
    identify := ret;
    exit;
  end;

//  Getting enrolled templates from database.
  if (db.isDSTemplateClosed = true) then
     db.getTemplates();

  db.beginTemplates();

  tptRef := db.getNextTemplate();
  // Iterate over all templates in database
  if tptRef.size > 0 then
    repeat
      // Comparing current template.
      ret := finger.Identify(tptRef.tpt, score, GR_DEFAULT_CONTEXT);
      // Checking if query template and reference template match.
      if (ret = GR_MATCH) then
      begin
        Identify := tptRef.id;
        exit;
      end
      else if (ret < 0) then
        begin
          Identify := ret;
          exit;
        end;
      tptRef := DB.getNextTemplate();
    until tptRef.size <= 0;

    // end of database, return "no match" code

   f.gravaLog('uUtil.idetify:' + intToStr(result) );


//   Identify := GR_NOT_MATCH;
end;

function Verify(finger:TGrFingerXCtrl; ID: Integer; var score: Integer): Integer;
Var
  tptRef: TTemplate;
Begin
  // Checking if template is valid.
  if not(TemplateIsValid()) then
  begin
    Verify := ERR_INVALID_TEMPLATE;
    exit;
  end;
  // Getting template with the supplied ID from the database.
  tptRef := DB.getTemplate(id);
  if ((tptRef.tpt = nil) or (tptRef.size <= 0)) then
  begin
    Verify := ERR_INVALID_ID;
    exit;
  end;
  // Comparing templates.
  Verify := finger.Verify(template.tpt, tptRef.tpt, score, GR_DEFAULT_CONTEXT);
end;

// Show GrFinger version and type
procedure MessageVersion(finger:TGrFingerXCtrl);
var majorVersion: byte;
    minorVersion: byte;
    result: integer;
    vStr: String;
begin
    result := finger.GetGrFingerVersion(majorVersion, minorVersion);
    If result = GRFINGER_FULL Then vStr := 'FULL';
    If result = GRFINGER_LIGHT Then vStr := 'LIGHT';
//    Application.MessageBox(PChar('The GrFinger DLL version is ' + IntToStr(majorVersion) + '.' + IntToStr(minorVersion) + '.' + #13#10 + 'The license type is ''' + vStr + '''.'), PChar('GrFinger Version'), MB_OK);
end;

procedure AbrirCadastroDigitais();
begin
   gravaLog('Abrindo Cadastro de digitais');
   if (db.getTemplates() = false )then
   begin
      msg.msgErro('Houve um problema ao obtger o cadastro de digitais ' +#13+
                  'reinicie o programa e tente de novo');
      application.Terminate();
   end;
end;

function registraPonto(data,Hora,cartao,loja:string):boolean;
begin
   f.gravaLinhaEmUmArquivo(ExtractFilePath(ParamStr(0))+'logs\batReg.dat', data +';'+ Hora+';'+cartao+';'+loja);
   result := db.registraPonto(data,hora,cartao,loja);
end;

{function getBatidas(dtInicio, dtFim, cartao: String): TStringList;
begin
   result := DB.getBatidas(dtInicio, dtFim, cartao);
end;
}
function opendb():Boolean;
begin
   gravaLog('Abrindo o BD');
   DB := TDBClass.Create();
   result := db.openDB;
end;

function getNumeroRegistros():integer;
begin
   result := db.numRegistros;
end;

procedure closeDB();
begin
   db.closeDB();
end;

function getUserAutorizador():String;
begin
   result := uautorizacao.getUserAutorizador( db.getUserAutorizador() );
end;

function getUserAutorizadorPonto(listaJustificativas:boolean):String;
begin
   result := db.getUserAutorizadorPonto(listaJustificativas);
end;


function getCadastroDeEmpregados(localizacao:String):TdataSet;
begin
   result := db.getCadastroDeEmpregados(localizacao);
end;

function listaJustificativas(cartao, dtInicio:String):TdataSet;
begin
   result := db.listaJustificativas(cartao, dtInicio);
end;

procedure deletajustificativa(numJustificativa: String);
begin
   db.deletaJustificativa(numJustificativa);
end;

function isFeriado(data, cartaoPonto:String):boolean;
begin
   result := db.isFeriado(data, cartaoPonto);
end;

function isFeriado(data:Tdate;cartaoPonto:String):boolean; overload;
begin
   result := db.isFeriado(dateToStr(data), cartaoPonto);
end;

function isAtivo(data, matricula: string): boolean;
begin
   result :=  db.isAtivo(data, matricula);
end;

function isJustificado(matricula, ocorrencia:String; data:Tdate ; var tpJust, obsJust, jusUsuario, ljDaJust:String):String;
begin
   result := db.isJustificado(matricula, ocorrencia, data, tpJust, obsjust, jusUsuario,  ljDaJust);
end;

function isAtzAbn(codJust:string):boolean;
begin
   result := db.isAtzAbn(codJust)
end;


function getMatricula(cartaoPonto: String; DS: TdataSet): String;
begin
   result := uEmpregado.getEmpPorCartao(cartaoPonto).FieldByName('matricula').AsString;
end;

function justificar(mat, just, data1, data2, tipo, hora1,hora2, ocorr,Cartao,DtLancamento,Obs,banco,Estabelecimento,loja, diaGeradorFolga, autorizador:String):String;
var
   err:String;
begin
   err := db.justificar( mat, just, data1, data2, tipo, hora1,hora2, ocorr,Cartao,DtLancamento,Obs,banco,Estabelecimento,loja, diaGeradorFolga, autorizador );
   if (err <> '0') then
   begin
     if (err = 'keyViolation') then
         msg.msgErro('Já consta uma justificativa para o funcionário: ' +#13+
                      mat +#13+
                     'Dia: '+ data1 +#13+
                     'Ocorrência: '+ ocorr +#13+
                     'Essa justificativa não será lançada');

         msg.msgErro('Houve um erro não especificado ao tentar incluir a justificativa, se ele persistir entre em contato com o T.I');
   end;
   gravaLog('tentativca de lancar justificativa, erro: ' + err);
   result := err;
end;

procedure getTable(var tb: TADOTable; tbFields: string);
begin
   db.getTable( tb, tbFields );
end;

function getNomeLojasPonto(mostraOpcTodas, mostraNenhum:boolean): Tstrings;
begin
   if (connectionIsClosed() = true) then
     opendb();
   result := db.getNomeLojasPonto(mostraOpcTodas, mostraNenhum);
end;

function obterDadosFuncionarios(localizacao:String): Tstrings;
begin
   if (connectionIsClosed() = true) then
     opendb();

   result := db.getDadosFuncionarios(localizacao);
end;

procedure getQuery(var qr:TADOQuery; ComandoSQL:string);
begin
   if (connectionIsClosed() = true) then
     opendb();
   db.getQuery(qr, ComandoSQL);
end;

function getDataSetQ(comandoSQL:string):TdataSet;
begin
   if (connectionIsClosed() = true) then
     opendb();
   result := db.getDataSetQ(comandoSQL);
end;


function getJustificativas(): Tstrings;
begin
   result := db.getJustificativas();
end;

function getLocalEmpregado(cartaoPonto:String): String;
begin
end;

function getNomeMatPorLocalizacao(localizacao: String): TdataSet;
begin
   result := db.getNomeMatPorLocalizacao(localizacao);
end;

function insereEmpregado(empresa,matricula,cartaoPonto, nome,funcao, dataAdmissao, isHoraFlexivel, horario, localizacao, dataDemissao:String):boolean;
begin
   result := db.insereEmpregado(empresa,matricula,cartaoPonto, nome,funcao, dataAdmissao, isHoraFlexivel, horario, localizacao, dataDemissao);
end;


function connectionIsClosed():boolean;
begin
    result := (db = nil);
end;


function getNome(dadosEmp:String):String;
begin
   result := copy(DadosEmp,01,30);
end;

function getCartaoPontoStr(str: String): String;
begin
//   f.gravaLog(str);
   result :=  trim(copy(str, 103, 60));
end;

function getNumLocalEmpresa(cb: TcustomComboBox):String;
begin
    result := trim(copy(cb.Items[cb.itemIndex], 101, 10));
end;

function getDetalheEmpregado(cartaoPonto:String):TdataSet;
begin
   result := db.getDetalheEmpregado(cartaoPonto);
end;

function deletaEmpregado(matricula:String):boolean;
begin
   result := db.deletaEmpregado(matricula);
end;

function lerParametroBD(parametro:String):String;
begin
   if (connectionIsClosed() = true) then
     opendb();
   result := db.lerParametroBD(parametro);
end;

function setParamBD(parametro, uo, valor:String):boolean;
begin
   result := db.setParamBD(parametro, uo, valor);
end;

procedure organizarQuery(var query:TADOQuery;Coluna:Tcolumn);
begin
end;

procedure criaTbResumo(var Table:TADOTAble);
begin
   db.criaTbResumo(Table);
end;

procedure preencheListaDosDias(var tabela:TADOTable; dti,dtf:Tdate);
begin
    db.preencheListaDosDias(tabela, dti, dtf, true);
end;

function isCadastroEmpOk(cartaoPonto:String):boolean;
begin
   result := db.isCadastroEmpOk(cartaoPonto);
end;

function isPontoCadastrado(cartaoPonto: String): boolean;
begin
   result := db.isPontoCadastrado(cartaoPonto);
end;

function isconnected():Boolean;
var
   aux:boolean;
begin
   aux := db.isConnected();
   gravaLog('Funcao isConnected, valor: '+ boolToStr(aux, true) );
   result := aux;
end;

function insereRegistroFerias(tipo, matricula: String; dtI, dtF: TDate): boolean;
begin
   result := db.insereRegistroFerias(tipo, matricula, dtI, dtF);
end;

{
function desativaEmpregado(matricula:String; dataDemissao:Tdate):boolean;
begin
    result := db.desativaEmpregado(matricula,dataDemissao);
end;
 }
function ativaEmpregado(matricula: String): boolean;
begin
   result :=  db.ativaEmpregado(matricula);
end;

procedure WriteLog(str:String);
begin
   f.gravalog(str);
end;

function isDigitalCadastrada(mat, lado:string):boolean;
begin
   result := db.isDigitalCadastrada(mat, lado);
end;

function removeCadastroDigital(cartaoPonto, lado:String):boolean;
begin
   result := db.removeCadastroDigital(cartaoPonto, lado);
end;

function isDiaBaseFolga(matricula:String; data:Tdate):boolean;
begin
   result := db.isDiaBaseFolga(matricula, data);
end;

function isHaveBatida(dia:Tdate; cartao:String): boolean;
begin
//   result := db.isHaveBatida(dia, cartao);
end;


procedure getEmpParaRelatorioBatidas(tb:TADOTable; localizacao, mes:String);
var
  ds:TdataSet;
  cmd:String;
  tHorasPrev, tHorasTrab, tAtrasJus, tAtrasAut, tHorasDif,  batIncJ, batInc, falta, faltaJ :smallInt;
  tbAux:TADOTable;
  dti, dtf:Tdate;
begin
   tbAux := TADOTAble.Create(nil);

   dti := strToDate('01/'+ mes);
   dtf := strToDate(fdt.getUltimoDiaMes(dti));

   if (tb.TableName <> '') then
       tb.Close();
   cmd :=
   'nome varchar(60), cartaoPonto varchar(10), matricula varchar(10), hTrabalhada varchar(10), hPrevista varchar(10), sinal varchar(10), dif varchar(10),  atrasJust varchar(10), atrasAutoriz ' +
   'varchar(10), batIncomp varchar(10), batIncompJust varchar(10), falta varchar(10), faltaJust varchar(10)';

   uUtil.getTable(tb, cmd);

   ds:= getCadastroDeEmpregados(localizacao);

   ds.first();
   while( ds.Eof = false ) do
   begin
       tb.AppendRecord([ ds.FieldByName('nome').AsString, ds.FieldByName('cartaoPonto').AsString, ds.FieldByName('matricula').AsString, '', '', '', '', '', '', '', '' ]);
       ds.Next;
   end;
   ds.Free();

   f.gravaLog('Calcular as batidas de cada funcionario...');
   tb.First();
   while tb.Eof = false do
   begin
      tHorasPrev := 0;
      tHorasTrab := 0;
      tAtrasJus := 0;
      tHorasDif := 0;
      tAtrasJus := 0;
      tAtrasAut := 0;
      batIncJ := 0;
      batInc := 0;
      falta := 0;
      faltaJ := 0;

      f.gravaLog('criando tabela temporaria para pegar os dados de cada empregado.');
      if (tbAux.TableName <> '') then
         tbAux.close();

      uUtil.criaTbResumo(tbAux);
      uUtil.preencheListaDosDias(tbAux, dti, dtf);

//      fmMain.PreencherListaBatidas(tbAux, dti, dtf, tb.FieldByName('cartaoPonto').AsString );

      gravaLog('calcular totais de horas - ' + tb.FieldByName('nome').AsString);

//      fmMain.calcHorasTotais( tbAux, tHorasPrev, tHorasTrab, tAtrasJus, tAtrasAut, tHorasDif,  batIncJ, batInc, falta, faltaJ, tb.FieldByName('matricula').AsString, tb.FieldByName('cartaoPonto').AsString, dti);

      tb.edit;
      tb.FieldByName('hPrevista').AsString :=  f.intToHora(tHorasPrev);
      tb.FieldByName('hTrabalhada').AsString :=  f.intToHora(tHorasTrab);
      tb.FieldByName('atrasJust').AsString :=  f.intToHora(tAtrasJus);

      tb.FieldByName('atrasAutoriz').AsString := f.intToHora(tAtrasAut);

      tb.FieldByName('batIncomp').AsString :=  intToStr(batInc);
      tb.FieldByName('batIncompJust').AsString :=  intToStr(batIncJ);
      tb.FieldByName('falta').AsString :=  intToStr(falta);
      tb.FieldByName('faltaJust').AsString :=  intToStr(faltaJ);

      tb.FieldByName('dif').AsString :=  f.intToHora(tHorasDif) ;

      if  tHorasDif < 0 then
         tb.FieldByName('sinal').AsString :=  '-'
      else
         tb.FieldByName('sinal').AsString :=  '+';

      tb.Post();

      tb.Next();
   end;
end;

function getDataHoraBD():String;
begin
    result := db.getDataHoraBD();
end;

function getCodJust(cb:TadLabelComboBox):String;
begin
   result :=  trim( copy( cb.Items[cb.itemindex], 100, 06));
   f.gravaLog(result);
end;

function getDate():Tdate;
begin
 	result := db.getDate();
end;

function getOcorrencias():Tstrings;
begin
	result := db.getOcorrencias();
end;


end.

