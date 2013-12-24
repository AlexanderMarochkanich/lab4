unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TASeries, TAFuncSeries, Forms, Controls,
  Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Chart1: TChart;
    Chart1FuncSeries1: TFuncSeries;
    Chart1LineSeries1: TLineSeries;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;
  const e=0.001; //погрешность

var
  Form1: TForm1;
  x,a,b: double;
implementation

{$R *.lfm}

{ TForm1 }
function f1(z: double): double; {Основная функция}
begin
f1:=z-(sin(z)/cos(z));
end;
function f2(z:double): double; {Производная от основной функции}
begin
f2:=(cos(2*z)-1)/(cos(2*z)+1) ;
end;
procedure TForm1.Button4Click(Sender: TObject);
begin
  Application.Terminate
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
Edit1.Text := '';
Edit2.Text := '';
Edit4.Text := '';
Memo1.Clear;
Checkbox1.Checked := False;
Checkbox2.Checked := False;
Checkbox3.Checked := False;
Chart1lineseries1.Clear;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
memo1.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
memo1.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
 a, b, u: real;
 y, x, p: real;
 mes, nach, konec, pou: byte;
 s: string;
begin
  begin
    val(Edit1.Text, a, nach);
if nach <> 0 then
mes := Application.MessageBox('Введите пожалуйста значение ', '', 0)
else
begin
val(Edit2.Text, b, konec);
if konec <> 0 then
mes := Application.MessageBox('Введите пожалуйста значение', '', 0)
else
begin
val(Edit4.Text, u, pou);
if pou <> 0 then
mes := Application.MessageBox('Ошибка ввода шага !!!', '', 0)
else
begin
if a > b then
ShowMessage('Предупреждение!!! A не должно быть больше чем B')
else
if checkbox2.Checked then
 begin
 if f1(a)*f2(a)<0 then x:=b
 else x:=a;
 while abs(f1(x))<e do
    begin
      x:=x-f1(x)/f2(x);
//memo1.Lines.Add('sqr- ' + Floattostrf(x, fffixed, 6, 2));
s := Floattostrf(x, fffixed, 6, 2) + ' ' + Floattostrf(y, fffixed, 10, 4);
 if checkbox1.Checked then
memo1.Lines.Add(s);
 if checkbox3.Checked then
 Chart1LineSeries1.AddXY(x, y, '', clBlack);
 x := x + u;
 end;
     end;
    end;
   end;
  end;
 end;
end;
end.

