object fmListaJust: TfmListaJust
  Left = 577
  Top = 291
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Justificativa'
  ClientHeight = 142
  ClientWidth = 334
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
  object cbJust: TadLabelComboBox
    Left = 7
    Top = 25
    Width = 323
    Height = 24
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    Color = clInfoBk
    DropDownCount = 15
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 0
    LabelDefs.Width = 58
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Justificativa:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object btOk: TfsBitBtn
    Left = 187
    Top = 113
    Width = 70
    Height = 22
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btCancel: TfsBitBtn
    Left = 259
    Top = 113
    Width = 70
    Height = 22
    TabOrder = 3
    Kind = bkCancel
  end
  object edObs: TadLabelEdit
    Left = 9
    Top = 69
    Width = 320
    Height = 19
    LabelDefs.Width = 58
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Observa'#231#227'o'
    Ctl3D = False
    ParentCtl3D = False
    MaxLength = 60
    TabOrder = 1
  end
end
