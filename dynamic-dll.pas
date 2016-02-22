// Пример. Динамическая загрузка DLL

library TwoDLLProject;
uses
  SysUtils,
  Classes;

function Summ(X,Y:Integer):Integer; StdCall;
begin
  Result:=X+Y;
end;
exports Summ;
{$R *.res}
begin
end.

// **********************************************************

unit UnitDin;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type TAddIntegers = function(p1,p2:integer):integer; stdcall; // тип функции

type
  TForm1 = class(TForm)
    Button1: TButton;

  procedure Button1Click(Sender: TObject);

  private
    Summ: TAddIntegers;	//определение типа функции
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  r:integer;
  Handle: LongWord;
begin
  Handle:=LoadLibrary('TwoDLLProject.dll'); //загрузка библиотеки
  if (Handle=0) then
      begin
        ShowMessage('Библиотека TwoDLLProject.dll не найдена');
      Halt;
    end;
  @Summ:=GetProcAddress(Handle,'Summ');// получение указателя на функцию
  r:=Summ(12,20);	// вызов функции
  ShowMessage(IntToStr(r));	// преобразование типа и вывод рез-та
  FreeLibrary(Handle); // выгрузка библиотеки
end;
end.
