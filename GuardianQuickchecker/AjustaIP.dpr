program AjustaIP;

uses
  Forms,
  uAjustaIP in 'uAjustaIP.pas' {fmAjustaIP},
  uDm in '..\Funcoes\uDM\uDm.pas' {dm: TDataModule},
  uCmd in '..\Funcoes\uCmd\uCmd.pas';
{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Ajusta ip do computador';
  Application.CreateForm(TfmAjustaIP, fmAjustaIP);
  Application.Run;
end.
