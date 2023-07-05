unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uHash;

type
  TfmMain = class(TForm)
    mmEmails: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    mmMensagem: TMemo;
    Button1: TButton;

    procedure enviaEmail();
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function getDadosConMail():THash;
    procedure FormShow(Sender: TObject);
    procedure enviaEmailEvento(evento:String);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

uses uEmail, funcoes, msg, uDm;
{$R *.dfm}

{ TfmMain }

procedure TfmMain.enviaEmail;
var
  i:integer;
  lines:TStringList;
begin
   lines := TStringlist.create();

   for i:=0 to mmMensagem.Lines.Count -1 do
   begin
      funcoes.gravaLog('Email para: ' + mmEmails.Lines[i]);
      lines.Add(mmMensagem.Lines[i]);
   end;

   for i:=0 to mmEmails.Lines.Count -1 do
      uEmail.enviarEmail( getDadosConMail(), mmEmails.Lines[i], dm.msg('subject'), '', lines, 'Email');
{}
end;

procedure TfmMain.Button1Click(Sender: TObject);
begin
   enviaEmail();
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
   funcoes.limparLog();
   dm.loadCommandsBD(funcoes.getDirExe() + 'sendMailCF.DLL');
end;

function TfmMain.getDadosConMail():THash;
var
   hash : THash;
begin
   hash := THash.Create();

   hash.add('host', dm.getCMD('smtp', 'host'));
   hash.add('user', dm.getCMD('smtp', 'user'));
   hash.add('password', dm.getCMD('smtp', 'password'));
   hash.add('RemetenteNome', dm.getCMD('smtp', 'RemetenteNome'));
   hash.add('RemetenteDominio', dm.getCMD('smtp', 'RemetenteDominio'));
   hash.add('subject', dm.getCMD('smtp', 'RemetenteDominio'));

   result := hash;
end;

procedure TfmMain.enviaEmailEvento(evento: String);
var
  msgEvento:String;
begin
   msgEvento := dm.getCMD('eventos', evento);

   if msgEvento = '' then
      msgEvento := dm.getCMD('eventos', 'Indeterminado');

   mmMensagem.Lines.Clear();
   mmMensagem.Lines.add( DM.msg('msglinha1'));
   mmMensagem.Lines.add('');
   mmMensagem.Lines.add(msgEvento);
   mmMensagem.Lines.add('Gerado em:  '+  DateTimeToStr(now));

   Button1Click(nil);

   application.Terminate();
end;


procedure TfmMain.FormShow(Sender: TObject);
var
  i:integer;
begin
    for i:=1 to 5 do
       if (dm.getCMD('MSG', intToStr(i) + 'dest' ) <> '-') then
          mmEmails.Lines.Add( dm.getCMD('MSG', (intToStr(i) + 'dest') ) );

    if (paramStr(1) <> '' )then
       enviaEmailEvento(ParamStr(1));
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i:integer;
begin
   for i:=0 to 4 do
   begin
      if (Length(mmEmails.Lines[i]) >2) then
         dm.persistirParam('msg', intToStr(i+1)+'dest', mmEmails.Lines[i]);
   end;
end;

end.
