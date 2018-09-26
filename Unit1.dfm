object Form1: TForm1
  Left = 87
  Top = 76
  Width = 1165
  Height = 410
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SG: TStringGrid
    Left = 0
    Top = 0
    Width = 1149
    Height = 293
    Align = alClient
    DefaultColWidth = 90
    FixedCols = 0
    FixedRows = 0
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 293
    Width = 1149
    Height = 41
    Align = alBottom
    Caption = #1056#1077#1096#1077#1085#1080#1077':'
    Color = clWhite
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Times New Roman'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 1
    OnClick = Panel1Click
  end
  object SG_Answ: TStringGrid
    Left = 0
    Top = 334
    Width = 1149
    Height = 38
    Align = alBottom
    DefaultColWidth = 100
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 2
  end
end
