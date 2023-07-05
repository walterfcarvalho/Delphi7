program Listas;

uses
  Forms,
  Unit1 in 'Unit1.pas' {fmMain},
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {Form3},
  Unit4 in 'Unit4.pas' {Form4},
  Unit5 in 'Unit5.pas' {Form5},
  Unit6 in 'Unit6.pas' {fmSugestao},
  Unit7 in 'Unit7.pas' {Form7},
  Unit9 in 'Unit9.pas' {Form9},
  Unit8 in 'Unit8.pas' {Form8},
  uBaixaAvulsa in 'uBaixaAvulsa.pas' {fmBaixaAvulsa},
  uPRelacionadas in 'uPRelacionadas.pas' {fmPRelacionadas},
  sysUtils,
  funcoes,
  windows,
  uAutorizacao in '..\Funcoes\autorizacoes\uAutorizacao.pas',
  ufmAutorizacao in '..\Funcoes\autorizacoes\ufmAutorizacao.pas' {fmAutorizacao},
  uDm in '..\Funcoes\uDM\uDm.pas' {dm: TDataModule},
  msg in '..\Funcoes\msg.pas',
  uCredCli in '..\Programas  da Casa Freitas\fmCredCliente\uCredCli.pas',
  uUsuarios in '..\Funcoes\uUsuarios\uUsuarios.pas',
  uProduto in 'uProduto.pas',
  uEntCaminhao in 'uEntCaminhao.pas' {fmEntCaminhao},
  uLista in 'uLista.pas',
  uMsgMemoInput in '..\Funcoes\formsMsg\uMsgMemoInput.pas' {fmMsgMemoInput},
  uCmd in '..\Funcoes\uCmd\uCmd.pas',
  uCmdSQL in '..\Funcoes\uCmd\uCmdSQL.pas';

{$R *.res}

begin
   if (length(ParamStr(1)) = 0) and ( FileExists('upgrade.exe') ) then
   begin
      winExec(pchar('cmd /c Upgrade.exe *** '+ ParamStr(0) ), sw_hide);
      application.terminate;
   end
   else begin
      Application.Initialize;
      Application.Title := 'Listas';
      Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
   end;
end.



