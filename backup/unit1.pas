unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, FileUtil, LConvEncoding, ShellApi;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  arr:   array of string;
  i:integer;
  ActualLength: Integer;
  path1, path_new, dir_base:string ; //пути к файлам
implementation

{$R *.lfm}

{ TForm1 }
function cl(s:string):string;   //удаление двойных пробелов
var i:integer;
begin
for i:=length(s)-1 downto 1 do
if ((s[i]=' ') and (s[i+1]=' ')) then
begin
delete(s,i,1);
delete(s,i,1);
end;
  Result:=s;
  end;
procedure AddLineToArr(const ALine: string);
 begin
   if Length(arr) = ActualLength then
     SetLength(arr, Round(1.5 * Length(arr)) + 1);
   arr[ActualLength] := ALine;
   Inc(ActualLength);
 end;
procedure  convert_file(filename: string);
var
  path_new, f_output:  string ;
  s,ss:string;
  files2,  files: text;
   out1:string;
   arr2: array[1..9] of string;
   //c: TJSONConfig;
//  m_customName: ansistring;
begin
//if OpenDialog1.Execute then
begin
SetLength(arr, 1024);
  ActualLength := 0;
//path_new:=OpenDialog1.FileName;
AssignFile(files, filename);

  Reset(files);
if FileExists(filename) then
begin
f_output:=filename+'*.csv';
//f_output:='C:\00\1.csv';
AssignFile(files2, f_output);
{$I-}
Rewrite(files2);{$I+}
if IOResult <> 0 then ShowMessage('помилка створення файлу-конвертацii')
else
begin
//arr:= TFile.ReadAllLines(f_output);
try
  while not Eof(files) do
begin
 s:='';ss:='';
  ReadLn(files,s);

  AddLineToArr(s);
 // c.SetValue('/Systems/CustomName', UTF8Decode(CP1252ToUTF8(m_customName)));
//  Memo1.Lines.Add(s);
 ss:=cl(copy(s,0,36))+','+cl(copy(s,37,36))+','+cl(copy(s,73,36))+','+cl(copy(s,109,36))+','+cl(copy(s,145,25))+','+cl(copy(s,172,5))+','+cl(copy(s,177,31))+','+cl(copy(s,209,11));
 ss:=cp1251toutf8(ss);
 Form1.Memo1.Lines.Add(ss);
 WriteLn(files2,ss);

end;
finally
 // ShowMessage(AnsiToUtf8( s));
  CloseFile(files);
  CloseFile(files2);
  Form1.Label6.Visible:=True;
end;
 //автооткрывание
  if form1.CheckBox1.Checked=True then
  begin
//     if ShellExecute(0,nil, PChar('cmd'),PChar('/c '+f_output),nil,1) =0 then;
       if ShellExecute(0,nil, PChar(f_output),PChar(''),nil,1) =0 then;
  end;
  end;
end;
    end;    end;
procedure TForm1.Button1Click(Sender: TObject);
var
  data1, data2, s:string;
begin
if FileExists(path1) then
begin
data1:=FormatDateTime('dd.mm.yyyy hh:mm', FileDateToDateTime(FileAge(path1)));
//ShowMessage( FormatDateTime('dd.mm.yyyy hh:mm', FileDateToDateTime(FileAge(path1))) )
Label4.Caption:=data1;
end
else Label4.Caption:='недоступен файл j3271_01.way из банка ';
if FileExists(path_new) then
begin
data2:=FormatDateTime('dd.mm.yyyy hh:mm', FileDateToDateTime(FileAge(path1)));
//ShowMessage( FormatDateTime('dd.mm.yyyy hh:mm', FileDateToDateTime(FileAge(path_new))) )
Label5.Caption:=data2;
end
else Label5.Caption:='отсутвует файл j3271_01.way';
if (data1<>data2) then
begin
s:=dir_base+FormatDateTime('dd.mm.yyyy', FileDateToDateTime(FileAge(path1)));
CreateDir(dir_base+FormatDateTime('dd.mm.yyyy', FileDateToDateTime(FileAge(path1))));
if RenameFile(path_new,s+'\j3271_01.way') then
begin
if CopyFile(path1, path_new) then
begin end
else ShowMessage('помила копiювання файлу ');
end else ShowMessage('помила створення папки минулого файлу '+s);
end

else ShowMessage('вiдмiнноъ версii файлу не знайдено');

end;


procedure TForm1.Button2Click(Sender: TObject);
var
   path_new, dir1:string;
begin
GetDir(0,dir1);
opendialog1.InitialDir:=dir1;
  if OpenDialog1.Execute then
  begin
//  SetLength(arr, 1024);
  //  ActualLength := 0;
  path_new:=OpenDialog1.FileName;
if   FileExists(path_new) then  convert_file(path_new);
  end
  else ShowMessage('не обрано файлу');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if   FileExists(path_new) then  convert_file(path_new)
  else ShowMessage('файл (за замовченням) для конвертування не знайдено ');
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
path1:='\\172.16.12.3\ATTACH2$\j3271_01.way';
path_new:='\\172.16.12.6\exim-bank\j3271_01.way';
dir_base:='\\172.16.12.6\exim-bank\';
Form1.Label6.Visible:=False;
end;



end.

