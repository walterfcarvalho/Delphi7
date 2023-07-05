object fmTelnet: TfmTelnet
  Left = 314
  Top = 463
  Width = 486
  Height = 107
  BorderIcons = []
  Caption = 'Conex'#227'o telnet'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo: TMemo
    Left = 0
    Top = 0
    Width = 470
    Height = 68
    Align = alClient
    Color = clMenu
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    OnChange = MemoChange
  end
  object tn: TIdTelnet
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 23
    OnDataAvailable = tnDataAvailable
    Terminal = 'dumb'
    Left = 104
    Top = 8
  end
end
