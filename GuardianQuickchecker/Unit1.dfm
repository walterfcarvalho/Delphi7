object Form1: TForm1
  Left = 734
  Top = 318
  Width = 484
  Height = 189
  BorderIcons = [biSystemMenu]
  Caption = 'Ajusta endere'#231'o ip'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object lb: TListBox
    Left = 0
    Top = 0
    Width = 468
    Height = 101
    Align = alTop
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 13
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
  end
  object cbPerfil: TadLabelComboBox
    Left = 3
    Top = 119
    Width = 464
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 13
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 1
    OnClick = cbPerfilClick
    LabelDefs.Width = 77
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Mudar o ip para:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
end
