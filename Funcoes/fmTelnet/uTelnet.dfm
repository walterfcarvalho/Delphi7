object fmTelnet: TfmTelnet
  Left = 498
  Top = 370
  Width = 430
  Height = 107
  Caption = 'Conex'#227'o telnet'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbMsg: TLabel
    Left = 84
    Top = 24
    Width = 325
    Height = 16
    Caption = 'lbMsg'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object flash: TShockwaveFlash
    Left = 0
    Top = 0
    Width = 77
    Height = 66
    TabOrder = 0
    ControlData = {
      6755665500090000F5070000D206000008000200000000000800000000000800
      0000000008000E000000570069006E0064006F00770000000800040000003000
      00000800060000002D003100000008000A000000480069006700680000000800
      0200000000000800060000002D00310000000800000000000800020000000000
      080010000000530068006F00770041006C006C00000008000400000030000000
      0800040000003000000008000E00000043003000420030004100430000000800
      0000000008000200000000000D00000000000000000000000000000000000800
      0400000031000000080004000000300000000800000000000800040000003000
      000008000800000061006C006C00000008000C000000660061006C0073006500
      0000}
  end
  object telnet: TIdTelnet
    MaxLineAction = maException
    ReadTimeout = 0
    Port = 23
    OnDataAvailable = telnetDataAvailable
    Terminal = 'dumb'
    Left = 80
    Top = 40
  end
end
