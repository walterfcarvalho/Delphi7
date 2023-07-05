object fmVdPorHora: TfmVdPorHora
  Left = 376
  Top = 0
  Width = 879
  Height = 587
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = ' Fluxo de clientes por per'#237'odo.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object label2: TLabel
    Left = 8
    Top = 12
    Width = 23
    Height = 13
    Caption = 'Loja:'
  end
  object cbLoja: TfsComboBox
    Left = 7
    Top = 30
    Width = 176
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 192
    Top = 8
    Width = 281
    Height = 56
    Caption = 'Per'#237'odo'
    TabOrder = 1
    object Label1: TLabel
      Left = 129
      Top = 26
      Width = 15
      Height = 13
      Caption = 'at'#233
    end
    object di: TfsDateTimePicker
      Left = 12
      Top = 22
      Width = 113
      Height = 21
      Date = 39619.669346238430000000
      Time = 39619.669346238430000000
      TabOrder = 0
      OnChange = diChange
    end
    object df: TfsDateTimePicker
      Left = 152
      Top = 22
      Width = 121
      Height = 21
      Date = 39619.669346238430000000
      Time = 39619.669346238430000000
      TabOrder = 1
    end
  end
  object fsBitBtn1: TfsBitBtn
    Left = 488
    Top = 24
    Width = 75
    Height = 25
    Caption = '&Gerar'
    TabOrder = 2
    OnClick = fsBitBtn1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 72
    Width = 838
    Height = 394
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
  end
end
