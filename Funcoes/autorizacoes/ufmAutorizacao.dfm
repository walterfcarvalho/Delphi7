object fmAutorizacao: TfmAutorizacao
  Left = 639
  Top = 230
  Anchors = []
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Usu'#225'rio autorizador'
  ClientHeight = 136
  ClientWidth = 202
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object lbMsg: TLabel
    Left = 8
    Top = 90
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object cbUser: TadLabelComboBox
    Left = 7
    Top = 25
    Width = 188
    Height = 24
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    Color = clInfoBk
    DropDownCount = 15
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 16
    ParentBiDiMode = False
    ParentFont = False
    TabOrder = 0
    OnChange = cbUserChange
    OnClick = cbUserClick
    LabelDefs.Width = 39
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Usu'#225'rio:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object edSenha: TadLabelEdit
    Left = 7
    Top = 66
    Width = 188
    Height = 22
    LabelDefs.Width = 31
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Senha'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    PasswordChar = '*'
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    TabOrder = 1
    OnChange = edSenhaChange
    OnKeyDown = edSenhaKeyDown
  end
  object btOk: TfsBitBtn
    Left = 93
    Top = 104
    Width = 48
    Height = 22
    Default = True
    TabOrder = 2
    OnClick = btOkClick
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
    Left = 149
    Top = 104
    Width = 47
    Height = 22
    TabOrder = 3
    OnClick = btCancelClick
    Kind = bkCancel
  end
end
