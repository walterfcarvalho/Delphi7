unit uCad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Menus, uDBClass, ExtDlgs, ComCtrls, syncObjs,
  OleCtrls,GrFingerXLib_TLB, Buttons,fCtrls;

type
  TfmCad = class(TForm)
    memoLog: TMemo;
    btIdentify: TButton;
    btClearDB: TButton;
    btClearLog: TButton;
    ckAutoExtract: TCheckBox;
    btExtract: TButton;
    grFinger: TGrFingerXCtrl;
    cbEmp: TComboBox;
    pnDetCadastro: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lbEsq: TLabel;
    lbDir: TLabel;
    btVerificaCadastro: TBitBtn;
    Panel2: TPanel;
    image: TImage;
    Bevel1: TBevel;
    btEnroll: TButton;
    Button1: TButton;
    btIncEsq: TfsBitBtn;
    btRemEsq: TfsBitBtn;
    btIncDir: TfsBitBtn;
    btRemDir: TfsBitBtn;
    Label3: TLabel;
    lbLadoAIncluir: TLabel;
    lbUser: TLabel;
    Bevel2: TBevel;
    btVerify: TButton;
    procedure mnOptionsClick(Sender: TObject);
    procedure btClearDBClick(Sender: TObject);
    procedure btEnrollClick(Sender: TObject);
    procedure btVerifyClick(Sender: TObject);
    procedure btIdentifyClick(Sender: TObject);
    procedure btClearLogClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btExtractClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mnVersionClick(Sender: TObject);
    procedure grFingerSensorPlug(Sender: TObject;
      const idSensor: WideString);
    procedure grFingerSensorUnplug(Sender: TObject;
      const idSensor: WideString);
    procedure grFingerFingerDown(Sender: TObject;
      const idSensor: WideString);
    procedure grFingerFingerUp(Sender: TObject;
      const idSensor: WideString);
    procedure grFingerImageAcquired(Sender: TObject;
      const idSensor: WideString; width, height: Integer;
      var rawImage: OleVariant; res: Integer);

   procedure WriteLog(str:String);
   function verificaDigitalCadastrada(cartao, lado:String):String;
    procedure btVerificaCadastroClick(cartao:String);
    procedure FormActivate(Sender: TObject);
    procedure btApagaCadastroClick(lado:String);
    procedure btRemEsqClick(Sender: TObject);
    procedure preparaParaConsulta(nCartao:String);
    procedure verificaCadastro(Sender: Tobject);
    procedure btRemDirClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure preparaParaIncluirLado(lado:String);
    procedure btIncEsqClick(Sender: TObject);
    procedure btIncDirClick(Sender: TObject);
    procedure setUser(user:String);
  private
  public
  end;

var
  fmCad: TfmCad;

implementation

uses uOptions, uUtil, f, funcSQl, RelogioPonto, msg, uEmpregado, uDm;
{$R *.dfm}

// Application startup code
procedure TfmCad.FormCreate(Sender: TObject);
begin
end;

// Application finalization code
procedure TfmCad.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//  finalize GrFingerX
  uUtil.FinalizeGrFinger(grFinger);
  Application.Terminate;
end;

// Add a fingerprint to database
procedure TfmCad.btEnrollClick(Sender: TObject);
var
  id: Integer;
  erro:boolean;
begin
	erro := false;
	if ( uUtil.extractTemplate(fmMain.GrFingerXCtrl1) = GR_BAD_QUALITY) then
		if (msg.msgQuestion( dm.getMsg('msgDigRuim') ) = mrNo) then
			erro := true;

	if (erro = false) then
  	begin
		id :=
      uUtil.Enroll(
			trim(fmMain.getMat(cbEmp)),
      	trim(copy(lbLadoAIncluir.Caption, 01, 01)),
      	trim(fmMain.getNomeCB(cbEmp)),
			trim(fmMain.getCartaoPonto(cbEmp))
      );
      if (id >= 0 )then
			msg.msgExclamation( 'A digital foi gravada.' )
      else
			msg.msgErro('A digital não gravada.');

		preparaParaConsulta(fmMain.getCartaoPonto(cbEmp));
	end;
end;

// Identify a fingerprint
procedure TfmCad.btIdentifyClick(Sender: TObject);
var
  ret, score: Integer;
begin
  score := 0;
  // identify it
  ret := Identify(fmMain.GrFingerXCtrl1, score);
  // write result to log
  if ret > 0 then
  begin
    WriteLog('Digital reconhecida . ID = '+IntToStr(ret)+'. Score = '+
             IntToStr(score)+'.');
    PrintBiometricDisplay(image, grFinger, true, GR_DEFAULT_CONTEXT);
  end
  else if ret = 0 then
    WriteLog('Digital não reconhecida . .')
  else
    WriteError(ret);
end;

// Check a fingerprint
procedure TfmCad.btVerifyClick(Sender: TObject);
var
  id, score: Integer;
  ret: Integer;
begin
  // ask target fingerprint ID
  score := 0;
  id := StrToIntDef(InputBox('Enter the ID to verify', 'Verify',''), -1);
  if id >= 0 then
  begin
    // compare fingerprints
    ret := Verify(fmMain.GrFingerXCtrl1, id, score);
    // write result to log
    if ret < 0 then
      WriteError(ret);
    if ret = GR_NOT_MATCH then
      WriteLog('Did not match with score = ' + IntToStr(score));
    if ret = GR_MATCH then
    begin
      WriteLog('Matched with score = ' + IntToStr(score));
      // if they match, display matching minutiae/segments/directions
      PrintBiometricDisplay(image, grFinger, true, GR_DEFAULT_CONTEXT);
    end;
  end;
end;

// Extract a template from a fingerprint image
procedure TfmCad.btExtractClick(Sender: TObject);
var
  ret: Integer;
begin
  // extract template
  ret := ExtractTemplate(fmMain.GrFingerXCtrl1);
  // write template quality to log
  if (ret = GR_BAD_QUALITY)
    then writeLog('Imagem adquirida. Qualidade baixa.')
  else if (ret = GR_MEDIUM_QUALITY)
    then writeLog('Imagem adquirida. Qualidade média.')
  else if (ret = GR_HIGH_QUALITY)
    then writeLog('Imagem adquirida. Qualidade boa.');
  if ret >= 0 then
  begin
    // if no error, display minutiae/segments/directions into the image
    PrintBiometricDisplay(image, grFinger, true, GR_NO_CONTEXT);
    // enable operations we can do over extracted template
    BtExtract.Enabled := false;
    btEnroll.Enabled := true;
    btIdentify.Enabled := true;
    btVerify.Enabled := true;
  end
  else
    // write error to log
    WriteError(ret);
end;

procedure TfmCad.btClearDBClick(Sender: TObject);
begin
end;

// Clear log
procedure TfmCad.btClearLogClick(Sender: TObject);
begin
  memoLog.Lines.Clear();
end;


procedure TfmCad.mnOptionsClick(Sender: TObject);
var
  minutiaeColor: Integer;
  minutiaeMatchColor: Integer;
  segmentsColor: Integer;
  segmentsMatchColor: Integer;
  directionsColor: Integer;
  directionsMatchColor: Integer;
  thresholdId : Integer;
  rotationMaxId: Integer;
  thresholdVr : Integer;
  rotationMaxVr: Integer;
  ok: boolean;
  ret: integer;
begin

  while true do begin
        // get current identification/verification parameters
        grFinger.GetIdentifyParameters(thresholdId, rotationMaxId, GR_DEFAULT_CONTEXT);
        grFinger.GetVerifyParameters(thresholdVr, rotationMaxVr, GR_DEFAULT_CONTEXT);
        // set current identification/verification parameters on options form
        formOptions.setParameters(thresholdId, rotationMaxId, thresholdVr, rotationMaxVr);

        ok := true;
        // show form with match, display and colors options
        // and get new parameters
        if not formOptions.getParameters(thresholdId, rotationMaxId, thresholdVr, rotationMaxVr,
                minutiaeColor, minutiaeMatchColor, segmentsColor, segmentsMatchColor, directionsColor, directionsMatchColor) then exit;
        if ((thresholdId < GR_MIN_THRESHOLD) or
         (thresholdId > GR_MAX_THRESHOLD) or
         (rotationMaxId < GR_ROT_MIN) or
         (rotationMaxId > GR_ROT_MAX)) then begin
            ShowMessage('Invalid identify parameters values!');
            ok := false;
        end;
        if ((thresholdVr < GR_MIN_THRESHOLD) or
         (thresholdVr > GR_MAX_THRESHOLD) or
         (rotationMaxVr < GR_ROT_MIN) or
         (rotationMaxVr > GR_ROT_MAX)) then begin
            showmessage ('Invalid verify parameters values!');
            ok := false;
        end;
        // set new identification parameters
        if ok then begin
          ret := grFinger.SetIdentifyParameters(thresholdId, rotationMaxId, GR_DEFAULT_CONTEXT);
          // error?
          if ret = GR_DEFAULT_USED then begin
            showmessage('Invalid identify parameters values. Default values will be used.');
            ok := false;
          end;
          // set the verification parameters
          ret := grFinger.SetVerifyParameters(thresholdVr, rotationMaxVr, GR_DEFAULT_CONTEXT);
          // error?
          if ret = GR_DEFAULT_USED then begin
            showmessage('Invalid verify parameters values. Default values will be used.');
            ok := false;
          end;
          // if everything ok
          if ok then begin
            // accept the parameters
            formOptions.AcceptChanges();
            // set the colors
            grFinger.SetBiometricDisplayColors(minutiaeColor, minutiaeMatchColor, segmentsColor, segmentsMatchColor, directionsColor, directionsMatchColor);
            Exit;
          end;
        end;
  end;
end;

// Display GrFinger version
procedure TfmCad.mnVersionClick(Sender: TObject);
begin
  MessageVersion(fmMain.GrFingerXCtrl1);
end;

// -----------------------------------------------------------------------------------
// GrFingerX events
// -----------------------------------------------------------------------------------

// A fingerprint reader was plugged on system
procedure TfmCad.grFingerSensorPlug(Sender: TObject;
  const idSensor: WideString);
begin
  writeLog ('Sensor: ' + idSensor + '. detectado.');
  grFinger.CapStartCapture (idSensor);
end;

// A fingerprint reader was unplugged on system
procedure TfmCad.grFingerSensorUnplug(Sender: TObject;
  const idSensor: WideString);
begin
    writeLog ('Sensor: ' + idSensor + '. não detectado.');
    grFinger.CapStopCapture (idSensor);
end;

// A finger was placed on reader
procedure TfmCad.grFingerFingerDown(Sender: TObject;
  const idSensor: WideString);
begin
    writeLog ('Sensor: ' + idSensor + '. Event: digital capturada.');
end;

// A finger was removed from reader
procedure TfmCad.grFingerFingerUp(Sender: TObject;
  const idSensor: WideString);
begin
    writeLog ('Sensor: ' + idSensor + '. Event: digital removida.');
end;


procedure TfmCad.grFingerImageAcquired(Sender: TObject;
  const idSensor: WideString; width, height: Integer;
  var rawImage: OleVariant; res: Integer);
begin
  // Copying aquired image
  raw.height := height;
  raw.width := width;
  raw.res := res;
  raw.img := rawImage;

  // Signaling that an Image Event occurred.
  writeLog ('Sensor: ' + idSensor + '. Event: Image captured.');

  // display fingerprint image
  PrintBiometricDisplay(image, grFinger, false, GR_DEFAULT_CONTEXT);

  // now we have a fingerprint, so we can extract template
  btEnroll.Enabled := false;
  btExtract.Enabled := true;
  btIdentify.Enabled := false;
//  btVerify.Enabled := false;

  // Extracting template from image.
  if fmCad.ckAutoExtract.Checked then
      fmCad.btExtractClick(nil)
  else
    fmCad.btExtract.Enabled := true;

end;

procedure TfmCad.WriteLog(str:String);
begin
   memoLog.Lines.add(str);
end;

function TfmCad.verificaDigitalCadastrada(cartao, lado:String):String;
begin
   if ( uUtil.isDigitalCadastrada(cartao ,lado) = true ) then
      result := 'OK'
   else
      result := 'Nao cadastrado';
end;


procedure TfmCad.btVerificaCadastroClick(cartao:String);
begin
   lbEsq.Caption := verificaDigitalCadastrada(cartao, 'e');
   if ( lbEsq.Caption <> 'OK') then
   begin
     btIncEsq.Visible := true;
     btRemEsq.Visible := false;
   end
   else
   begin
      btRemEsq.Visible := true;
      btIncEsq.Visible := false;
   end;


   lbDir.Caption := verificaDigitalCadastrada(cartao, 'd');
   if ( lbDir.Caption <>'OK') then
   begin
      btIncDir.Visible := true;
      btRemDir.Visible := false;
   end
   else
   begin
      btRemDir.Visible := true;
      btIncDir.Visible := false;
   end;

   pnDetCadastro.Visible := true;
end;

procedure TfmCad.verificaCadastro(Sender: Tobject);
begin
   if (cbEmp.ItemIndex > -1) then
      btVerificaCadastroClick( fmMain.getMat(cbEmp) );
end;

procedure TfmCad.FormActivate(Sender: TObject);
begin
   if (uUtil.InitializeGrFinger(grFinger) < 0) then
   begin
      ShowMessage('erro');
      application.Terminate;

   end  ;
   cbEmp.Items := uUtil.obterDadosFuncionarios('');
//   cbEmp.Items.SaveToFile('c:\cbEmp.txt');
end;

procedure TfmCad.btApagaCadastroClick(lado:String);
begin
    if ( msg.msgQuestion('Deseja remover as digitais Cadastradas ?') = mrYes) then
       if (  uEmpregado.removeCadastroDigital(fmMain.getMat(cbEmp), lado) = true ) then
          msg.msgExclamation('Cadastro removido com sucesso')
       else
          msg.msgErro('Erro ao Tentar excluir');
end;

procedure TfmCad.btRemEsqClick(Sender: TObject);
begin
   btApagaCadastroClick('E');
   verificaCadastro(nil);
end;
procedure TfmCad.btRemDirClick(Sender: TObject);
begin
   btApagaCadastroClick('D');
   verificaCadastro(nil);
end;


procedure TfmCad.preparaParaConsulta(nCartao:String);
begin
   btVerificaCadastro.Enabled := true;
   image.Picture := nil;
   image.Refresh();
   panel2.Visible := false;
   lbEsq.Caption := '---';
   lbDir.Caption := '---';
   btIncEsq.Visible := false;
   btIncDir.Visible := false;
   btRemEsq.Visible := false;
   btRemDir.Visible := False;
   cbEmp.Enabled := true;
end;


procedure TfmCad.Button1Click(Sender: TObject);
begin
   preparaParaConsulta('');
end;

procedure TfmCad.preparaParaIncluirLado(lado: String);
begin
    pnDetCadastro.Visible := false;
    image.Picture := nil;
    lbLadoAIncluir.Caption := lado;
    cbEmp.Enabled := false;
    btVerificaCadastro.Enabled := false;
    Panel2.Visible := true;
end;

procedure TfmCad.btIncEsqClick(Sender: TObject);
begin
   preparaParaIncluirLado('Esquerdo');
end;

procedure TfmCad.btIncDirClick(Sender: TObject);
begin
   preparaParaIncluirLado('Direito');
end;

procedure TfmCad.setUser(user: String);
begin
   lbUser.Caption := user;
end;

end.
