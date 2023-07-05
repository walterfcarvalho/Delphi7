object fmRemLancContabil: TfmRemLancContabil
  Left = 393
  Top = 250
  Width = 721
  Height = 186
  BorderIcons = [biSystemMenu]
  Caption = 'Remove lan'#231'amento cont'#225'bil'
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cbEmpresa: TadLabelComboBox
    Left = 15
    Top = 33
    Width = 89
    Height = 21
    BevelInner = bvSpace
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    LabelDefs.Width = 44
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Empresa:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object edPrefSeq: TadLabelEdit
    Left = 229
    Top = 34
    Width = 90
    Height = 19
    LabelDefs.Width = 107
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Prefixo sequencial (20)'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    BiDiMode = bdRightToLeft
    Ctl3D = False
    ParentBiDiMode = False
    ParentCtl3D = False
    MaxLength = 4
    TabOrder = 1
    OnKeyPress = edSeqIKeyPress
  end
  object GroupBox1: TGroupBox
    Left = 354
    Top = 9
    Width = 163
    Height = 69
    Caption = ' Sequencial '
    TabOrder = 2
    object edSeqF: TadLabelEdit
      Left = 85
      Top = 35
      Width = 69
      Height = 19
      LabelDefs.Width = 16
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Fim'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      MaxLength = 8
      TabOrder = 1
      OnKeyPress = edSeqIKeyPress
    end
    object edSeqI: TadLabelEdit
      Left = 9
      Top = 35
      Width = 69
      Height = 19
      LabelDefs.Width = 25
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Inicio'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      MaxLength = 8
      TabOrder = 0
      Text = '123456789'
      OnKeyPress = edSeqIKeyPress
    end
  end
  object FlatButton1: TFlatButton
    Left = 645
    Top = 33
    Width = 32
    Height = 25
    Glyph.Data = {
      4E010000424D4E01000000000000760000002800000012000000120000000100
      040000000000D800000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333330000003333333333333333330000003333344333333333330000003333
      4224333333333300000033342222433333333300000033422222243333333300
      000034222A2222433333330000003222A3A222433333330000003A2A333A2224
      33333300000033A33333A222433333000000333333333A222433330000003333
      333333A222433300000033333333333A222433000000333333333333A2224300
      00003333333333333A224300000033333333333333A223000000333333333333
      333A33000000333333333333333333000000}
    TabOrder = 4
    OnClick = FlatButton1Click
  end
  object cbTipoLancamento: TadLabelComboBox
    Left = 532
    Top = 36
    Width = 89
    Height = 21
    BevelInner = bvSpace
    BevelKind = bkFlat
    BevelOuter = bvRaised
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = '- Gerencial'
    Items.Strings = (
      '- Gerencial'
      '- Fiscal')
    LabelDefs.Width = 24
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Tipo:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object rgTpRemocao: TRadioGroup
    Left = 123
    Top = 15
    Width = 97
    Height = 57
    Caption = 'Tipo remo'#231#227'o'
    ItemIndex = 0
    Items.Strings = (
      'Sequencial'
      'Lote')
    TabOrder = 5
    OnClick = rgTpRemocaoClick
  end
end
