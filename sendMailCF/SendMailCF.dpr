program SendMailCF;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  funcoes in '..\Funcoes\funcoes.pas',
  msg in '..\Funcoes\msg.pas',
  uMsgMemoInput in '..\Funcoes\formsMsg\uMsgMemoInput.pas' {fmMsgMemoInput},
  uEmail in '..\Funcoes\uEmail.pas',
  uLj in '..\Funcoes\uLj\uLj.pas',
  uSelecionaUo in '..\Programas  da Casa Freitas\fmSelecionaUo\uSelecionaUo.pas' {fmSelecionaUo},
  uEnviaEmail in '..\Programas  da Casa Freitas\fmEmail\uenviaEmail.pas' {fmEnviaEmail},
  uDm in '..\Funcoes\uDM\uDm.pas' {dm: TDataModule},
  uHash in '..\Funcoes\uHash.pas';

{$R *.res}

begin
   Application.Initialize;
   Application.CreateForm(Tdm, dm);
   Application.CreateForm(TfmMain, fmMain);
   Application.Run;
end.
