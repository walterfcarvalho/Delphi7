object fmMain: TfmMain
  Left = 462
  Top = 184
  Width = 446
  Height = 329
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Envio de email.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 10
    Top = 2
    Width = 29
    Height = 13
    Caption = 'emails'
  end
  object Label2: TLabel
    Left = 8
    Top = 106
    Width = 29
    Height = 13
    Caption = 'emails'
  end
  object mmEmails: TMemo
    Left = 8
    Top = 16
    Width = 417
    Height = 87
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
  end
  object mmMensagem: TMemo
    Left = 6
    Top = 120
    Width = 417
    Height = 129
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
  end
  object Button1: TButton
    Left = 349
    Top = 254
    Width = 75
    Height = 25
    Caption = 'Envia'
    TabOrder = 2
    OnClick = Button1Click
  end
end
