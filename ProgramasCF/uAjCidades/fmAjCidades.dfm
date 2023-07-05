object Form1: TForm1
  Left = 249
  Top = 198
  Width = 928
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edUF: TadLabelEdit
    Left = 7
    Top = 21
    Width = 32
    Height = 19
    LabelDefs.Width = 17
    LabelDefs.Height = 13
    LabelDefs.Caption = 'UF:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btUF: TfsBitBtn
    Left = 41
    Top = 20
    Width = 27
    Height = 22
    Caption = '...'
    TabOrder = 1
    OnClick = btUFClick
    NumGlyphs = 2
  end
  object edCidade: TadLabelEdit
    Left = 71
    Top = 21
    Width = 215
    Height = 19
    LabelDefs.Width = 36
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Cidade:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
end
