# Пример. DLL со статическим подключением.

library FirstDLLProject;
uses
  SysUtils,
  Classes;

function Summ(X,Y:Integer) :Integer; StdCall;
begin
 Result:=X+Y;
end;

exports Summ;

{$R *.res}

begin
end.

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;

procedure Button1Click(Sender: TObject);

private
    { Private declarations }
public
    { Public declarations }
end;

var
  Form1: TForm1;
  function Summ(X,Y:Integer):Integer; stdcall;

implementation

 function Summ(X,Y:Integer):Integer;
 external 'FirstDLLProject.dll' name 'Summ';

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
 r:integer;

begin
  r:=Summ(10,34);
  Application.MessageBox(PChar(IntToStr(r)),'Результат = ');
end;

end.
