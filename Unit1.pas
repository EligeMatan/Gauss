unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, Grids, ExtCtrls;

type
  TForm1 = class(TForm)
    SG: TStringGrid;
    Panel1: TPanel;
    SG_Answ: TStringGrid;
    procedure FormShow(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    procedure SolveGauss;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  A: array of array of Extended;      // матрица коэффициентов
  X: array of Extended;               // решение СЛАУ
  b: array of Extended;               // свободные члены

const
  N = 10;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
var
  i, j: Integer;
begin
  SG.RowCount := N;
  SG.ColCount := N + 1;

  SetLength(A, N, N + 1);
  SetLength(X, N);
  SetLength(b, N);

  for i := 1 to N do
  begin
    b[i - 1] := i;
    SG.Cells[N, i - 1] := FormatFloat('0.0', b[i - 1]);
    for j := 1 to N do
    begin
      A[i - 1, j - 1] := Sqrt(i + j + N) + 10 + N / i + Exp(-N - i * j / 100);
      SG.Cells[j - 1, i - 1] := FormatFloat('0.0000000', A[i - 1, j - 1]);
    end;
  end;

  SG_Answ.RowCount := 1;
  SG_Answ.ColCount := N;
end;

procedure TForm1.SolveGauss;
var
  k, i, j, ind: Integer;
  temp: Extended;
  max: Extended;
const
  eps = 0.000001;
begin
  for k := 0 to N - 1 do
  begin
    // Поиск строки с максимальным a[i][k]
    max := Abs(A[k, k]);
    ind := k;
    for i := k + 1 to N - 1 do
      if Abs(A[i, k]) > max then
      begin
        max := Abs(A[i, k]);
        ind := k;
      end;

    // Перестановка строк
    if max < eps then
    begin
      // нет ненулевых диагональных элементов
      ShowMessage('Решение получить невозможно из-за нулевого столбца' + #13#10 +
     IntToStr(ind) + ' матрицы A');
      Exit;
    end;

    for j := 0 to N - 1 do
    begin
      temp := A[k, j];
      A[k, j] := A[ind, j];
      A[ind, j] := temp;
    end;

    temp := b[k];
    b[k] := b[ind];
    b[ind] := temp;

    // Нормализация уравнений
    for i := k to N - 1 do
    begin
      temp := A[i, k];
      if Abs(temp) < eps then
        Continue;               // для нулевого коэффициента пропустить

      for j := 0 to N - 1 do
        A[i, j] := A[i, j] / temp;

      b[i] := b[i] / temp;
      if i = k then
        Continue;               // уравнение не вычитать само из себя

      for j := 0 to N - 1 do
        A[i, j] := A[i, j] - A[k, j];

      b[i] := b[i] - b[k];
    end;
  end;

  
  for i := 1 to N do
  begin
    SG.Cells[N, i - 1] := FormatFloat('0.0', b[i - 1]);
    for j := 1 to N do
      SG.Cells[j - 1, i - 1] := FormatFloat('0.0000000', A[i - 1, j - 1]);
  end;


  // обратная подстановка
  for k := N - 1 downto 0 do
  begin
    X[k] := b[k];

    for i := 0 to k - 1 do
      b[i] := b[i] - A[i, k] * X[k];
  end;
end;

procedure TForm1.Panel1Click(Sender: TObject);
var
  i: Integer;
begin
  SolveGauss;
  for i := 0 to Length(X) - 1 do
    SG_Answ.Cells[i, 0] := FloatToStr(X[i]);
end;

end.


