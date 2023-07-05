object fmNotasAgregadas: TfmNotasAgregadas
  Left = 437
  Top = 216
  Width = 574
  Height = 263
  BorderIcons = [biSystemMenu]
  Caption = 'Agrega'#231#227'o entre notas.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup2: TRadioGroup
    Left = 6
    Top = 113
    Width = 545
    Height = 105
    Caption = 'Notas agregadas:'
    TabOrder = 3
  end
  object RadioGroup1: TRadioGroup
    Left = 6
    Top = 3
    Width = 545
    Height = 105
    Caption = 'Notas agregadoras:'
    TabOrder = 1
  end
  object gdNotasAgregadas: TSoftDBGrid
    Left = 10
    Top = 17
    Width = 533
    Height = 86
    Ctl3D = False
    DataSource = dsNotasAgregadas
    ParentCtl3D = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = gdNotasAgregadasDblClick
    AlternateColor = False
    ColorLow = clHighlightText
    ColorHigh = clWindow
  end
  object gdNotasAgregadoras: TSoftDBGrid
    Left = 10
    Top = 127
    Width = 533
    Height = 86
    Ctl3D = False
    DataSource = dsNotasAgregadoras
    ParentCtl3D = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = gdNotasAgregadorasDblClick
    AlternateColor = False
    ColorLow = clHighlightText
    ColorHigh = clWindow
  end
  object dsNotasAgregadas: TDataSource
    DataSet = qrNotasAgregadas
    Left = 104
    Top = 32
  end
  object dsNotasAgregadoras: TDataSource
    DataSet = qrNotasAgregadoras
    Left = 112
    Top = 144
  end
  object qrNotasAgregadas: TADOQuery
    Parameters = <>
    Left = 141
    Top = 32
  end
  object qrNotasAgregadoras: TADOQuery
    Parameters = <>
    Left = 144
    Top = 144
  end
  object PopupMenu1: TPopupMenu
    Left = 184
    Top = 32
    object InserirNota1: TMenuItem
      Caption = 'Informar nota agregadora'
      OnClick = InserirNota1Click
    end
  end
end
