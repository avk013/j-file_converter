unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  ExtCtrls, FileUtil, LConvEncoding, ShellApi, Types;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    PageControl1: TPageControl;
    Panel1: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1ChangeBounds(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private

  public

  end;

var
  Form1: TForm1;
  arr:   array of string;
  i:integer;
  ActualLength: Integer;
  path1, path_new, dir_base, base_dir, namefile:string ; //пути к файлам
  //base_dir папка в которой программа
  psedi:string;
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
f_output:=filename+'.csv';
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
  data1, data2, s, s2:string;
begin
data1:='_';
data2:='+';
if FileExists(path1) then
begin                  // data1 новый файл
data1:=FormatDateTime('dd.mm.yyyy hh:mm', FileDateToDateTime(FileAge(path1)));
//ShowMessage( FormatDateTime('dd.mm.yyyy hh:mm', FileDateToDateTime(FileAge(path1))) )
Label4.Caption:=data1;
end
else Label4.Caption:='недоступний файл j3271_01.way з банку ';
// старый файл path_new
if FileExists(path_new) then
begin
data2:=FormatDateTime('dd.mm.yyyy hh:mm', FileDateToDateTime(FileAge(path_new)));
//ShowMessage( FormatDateTime('dd.mm.yyyy hh:mm', FileDateToDateTime(FileAge(path_new))) )
Label5.Caption:=data2;
end
else Label5.Caption:='вiдсутн. файл j3271_01.way';
if (data1<>data2) then
begin
if (data2<>'+') then
begin
//ShowMessage(data2);
s:=base_dir+FormatDateTime('dd.mm.yyyy', FileDateToDateTime(FileAge(path_new)));
CreateDir(base_dir+FormatDateTime('dd.mm.yyyy', FileDateToDateTime(FileAge(path_new))));
sleep(1000);
//CopyFile(path_new,s+'\j3271_01.way');
//sleep(1000);
s:=s+'\'+namefile;
if CopyFile(path_new,s, True) then
begin
//CopyFile(path1, path_new);
end else ShowMessage('помилка створення папки минулого файлу '+s);
end;
//else оказывается что тут логическая ошибка....
// не должно так быть
if CopyFile(path1, path_new, True) then
begin Form1.Label7.Visible:=True;
 ShowMessage('файл вiд '+data1+' завантажено') end
else ShowMessage('помила копiювання файлу ');
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

procedure TForm1.Button4Click(Sender: TObject);
begin

end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin

end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.Edit1ChangeBounds(Sender: TObject);
begin

end;

procedure TForm1.Edit1Enter(Sender: TObject);
begin
   edit1.text:='';
end;

procedure TForm1.Edit1Exit(Sender: TObject);
begin
if (psedi='1112') then
begin
panel1.Visible:=true;
edit2.Text:=path1;
edit3.Text:=path_new;
end;
psedi:=edit1.text;
edit1.text:='********';
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
pagecontrol1.ActivePage:=TabSheet1;
// fignia GetDir(0,base_dir);
base_dir:=ExtractFileDir(Application.ExeName)+'\';
path1:='\\172.16.12.3\ATTACH2$\j3271_01.way';
//path_new:='\\172.16.12.6\exim-bank\
namefile:='j3271_01.way';
dir_base:='\\172.16.12.6\exim-bank\';
path_new:=base_dir+'j3271_01.way';
Form1.Label6.Visible:=False;
Form1.Label7.Visible:=False;
Form1.Caption:='copy_converter v2   (C) УДП CIКЗ 2020';
Button2.Caption:='конв.з'+#10#13+'папки';
panel1.Visible:=false;

end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin

end;

procedure TForm1.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;



end.

