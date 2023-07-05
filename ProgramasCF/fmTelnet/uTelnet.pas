unit uTelnet;

interface

uses Controls, forms, sysUtils, IdTelnet, dialogs;

//function executeTelnetCmd(uo, comando:String):boolean;
function execCmdBool(uo, comando:String):boolean;
function geraArqPDF(uo, comando:String):String;

implementation

uses uFmTelnet;

function execCmdBool(uo, comando:String):boolean;
var
 res : boolean;
 s:String;
begin
   application.CreateForm(TfmTelnet, fmTelnet);
   fmTelnet.Show();

//   res := fmTelnet.chamaExecutarTelnet(uo, comando);
   res := fmTelnet.execCmd(uo, comando);

 //  sleep(6000);
   fmTelnet.Close();

   fmTelnet.Close();
   fmTelnet := nil;
   result := res;
end;


function geraArqPDF(uo, comando:String):String;
var
 res : String;
 s:String;
begin
   application.CreateForm(TfmTelnet, fmTelnet);
   fmTelnet.Show();

//   res := fmTelnet.chamaExecutarTelnet(uo, comando);
   res := fmTelnet.geraArqPDF(uo, comando);

 //  sleep(6000);
   fmTelnet.Close();

   fmTelnet.Close();
   fmTelnet := nil;
   result := res;
end;



end.
