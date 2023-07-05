object fmFTP: TfmFTP
  Left = 593
  Top = 190
  Width = 610
  Height = 137
  BorderIcons = [biSystemMenu]
  Caption = 'Conex'#227'o FTP'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 594
    Height = 98
    Align = alClient
    Color = clBtnFace
    ReadOnly = True
    TabOrder = 0
  end
  object ftp: TIdFTP
    OnStatus = ftpStatus
    MaxLineAction = maSplit
    ReadTimeout = 0
    OnDisconnected = ftpDisconnected
    OnConnected = ftpConnected
    Passive = True
    Password = 'cf'
    Username = 'cf'
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 24
    Top = 16
  end
end
