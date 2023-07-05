program Relogio;

uses
  Forms,
  RelogioPonto in 'RelogioPonto.pas' {fmMain},
  uUtil in 'uUtil.pas',
  UOcorrencia in 'UOcorrencia.pas' {FmOcorrencia},
  Justificativas in 'Justificativas.pas' {Justificativa},
  uConsultarBatidas in 'uConsultarBatidas.pas' {fmBatidas},
  uCad in 'uCad.pas' {fmCad},
  windows,
  SysUtils,
  f in '..\Funcoes\f.pas',
  funcSQL in '..\Funcoes\funcSQL.pas',
  uAutorizacao in '..\Funcoes\autorizacoes\uAutorizacao.pas',
  ufmAutorizacao in '..\Funcoes\autorizacoes\ufmAutorizacao.pas' {fmAutorizacao},
  uListaJust in 'uListaJust\uListaJust.pas' {fmListaJust},
  uDm in '..\Funcoes\uDM\uDm.pas' {dm: TDataModule},
  uCmd in '..\Funcoes\uCmd\uCmd.pas',
  uBatida in 'uBatida.pas',
  uUsuarios in '..\Funcoes\uUsuarios\uUsuarios.pas',
  uEmpregado in 'uEmpregado.pas',
  uAutorizadores in '..\manip de batidas\uAutorizadores.pas' {fmAutorizadores},
  uAutorizador in '..\manip de batidas\uAutorizador.pas',
  uPesqUsu in '..\manip de batidas\uPesqUsu.pas' {fmPesqUsuario};

{$R *.RES}

begin
   if (f.getIdxParam('***') < 0 ) and (SysUtils.fileExists('upgrade.exe') ) then
   begin
      f.gravaLog('mudar para a aplicação:' + 'cmd /c Upgrade.exe'+ ' p1 ' + ParamStr(0) +' -noUpgrade');
      windows.winExec(pchar('cmd /c Upgrade.exe'+ ' p1 ' + ParamStr(0) +' -noUpgrade'  ), sw_hide);
      application.terminate;
   end
   else
   begin
      Application.Initialize;
      Application.Title := 'Controle interno';

      Application.CreateForm(Tdm, dm);

      f.gravaLog('Iniciando o form principal');
	   Application.CreateForm(TfmMain, fmMain);
      Application.Run;
   end;
end.
