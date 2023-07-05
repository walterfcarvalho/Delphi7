object fmAjustaNumNF: TfmAjustaNumNF
  Left = 439
  Top = 172
  Width = 544
  Height = 323
  BorderIcons = [biSystemMenu]
  Caption = 'Ajuste de numera'#231#227'o de notas.'
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 6
    Top = 5
    Width = 23
    Height = 13
    Caption = 'Loja:'
  end
  object Label4: TLabel
    Left = 35
    Top = 5
    Width = 23
    Height = 13
    Caption = 'Loja:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object gbNotaNovo: TGroupBox
    Left = 6
    Top = 47
    Width = 512
    Height = 128
    Caption = 'Dados para alterar a nota:'
    TabOrder = 0
    Visible = False
    object cbLoja: TadLabelComboBox
      Left = 8
      Top = 40
      Width = 124
      Height = 21
      AutoCloseUp = True
      BevelInner = bvNone
      BevelKind = bkFlat
      Style = csDropDownList
      Color = clHighlightText
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      Visible = False
      LabelDefs.Width = 54
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Nova s'#233'rie:'
      Colors.WhenEnterFocus.BackColor = clWindow
      Colors.WhenExitFocus.BackColor = clInfoBk
    end
    object cbNumNovaSerie: TadLabelComboBox
      Left = 144
      Top = 40
      Width = 172
      Height = 21
      AutoCloseUp = True
      BevelInner = bvNone
      BevelKind = bkFlat
      Style = csDropDownList
      Color = clHighlightText
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnChange = cbNumNovaSerieChange
      Items.Strings = (
        ' - A pr'#243'xima da sequ'#234'ncia.'
        ' - Informada.')
      LabelDefs.Width = 82
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Nova numera'#231#227'o'
      Colors.WhenEnterFocus.BackColor = clWindow
      Colors.WhenExitFocus.BackColor = clInfoBk
    end
    object edSerie: TadLabelEdit
      Left = 327
      Top = 39
      Width = 43
      Height = 22
      LabelDefs.Width = 24
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Serie'
      Colors.WhenEnterFocus.BackColor = clWindow
      Colors.WhenExitFocus.BackColor = clInfoBk
      AutoSize = False
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Color = clHighlightText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      Visible = False
    end
    object edNumNovo: TadLabelSpinEdit
      Left = 376
      Top = 38
      Width = 105
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 40
      LabelDefs.Height = 13
      LabelDefs.Caption = 'N'#250'mero:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Decimals = 0
      TabOrder = 3
      Visible = False
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
    object edContNovo: TadLabelSpinEdit
      Left = 376
      Top = 82
      Width = 105
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 60
      LabelDefs.Height = 13
      LabelDefs.Caption = 'edContNovo'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Decimals = 0
      TabOrder = 4
      Visible = False
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
    object cbAlteraContNovo: TfsCheckBox
      Left = 143
      Top = 84
      Width = 232
      Height = 17
      Caption = 'Altere o contador da numera'#231#227'o nova para:'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = cbAlteraNumAntigoClick
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  object gbNotaAnt: TGroupBox
    Left = 6
    Top = 183
    Width = 512
    Height = 65
    Caption = ' Dados para alterar a numera'#231#227'o antiga: '
    TabOrder = 1
    Visible = False
    object edContSrAntiga: TadLabelSpinEdit
      Left = 252
      Top = 24
      Width = 105
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 3
      LabelDefs.Height = 13
      LabelPosition = adRight
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Decimals = 0
      TabOrder = 0
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
    object cbAlteraNumAntigo: TfsCheckBox
      Left = 7
      Top = 27
      Width = 241
      Height = 17
      Caption = 'Altere a '#250'ltima nota da numera'#231#227'o antiga para:'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = cbAlteraNumAntigoClick
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  object Panel1: TPanel
    Left = 5
    Top = 3
    Width = 423
    Height = 41
    TabOrder = 2
    object Label1: TLabel
      Left = 6
      Top = 5
      Width = 29
      Height = 13
      Caption = 'Loja:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbLoja: TLabel
      Left = 35
      Top = 5
      Width = 35
      Height = 13
      Caption = 'lbLoja'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label5: TLabel
      Left = 5
      Top = 20
      Width = 32
      Height = 13
      Caption = 'Nota:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbNota: TLabel
      Left = 36
      Top = 20
      Width = 49
      Height = 13
      Caption = '000/000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lbIsNota: TLabel
      Left = 361
      Top = 5
      Width = 39
      Height = 13
      Caption = 'lbIsNota'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lbUo: TLabel
      Left = 163
      Top = 21
      Width = 22
      Height = 13
      Caption = 'lbUo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lbSrAnt: TLabel
      Left = 257
      Top = 21
      Width = 34
      Height = 13
      Caption = 'lbSrAnt'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label2: TLabel
      Left = 273
      Top = 5
      Width = 97
      Height = 13
      Caption = 'Identificador BD:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object cbTpNovaSerie: TFlatButton
    Left = 432
    Top = 13
    Width = 84
    Height = 22
    Hint = 'Obter Dados do Cliente'
    Caption = 'Nova'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = cbTpNovaSerieClick
  end
  object btCancel: TFlatButton
    Left = 467
    Top = 254
    Width = 50
    Height = 26
    Glyph.Data = {
      96010000424D9601000000000000760000002800000018000000180000000100
      04000000000020010000C40E0000C40E00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
      D11DDDDDDDDDD11DDDDDDDDD1991DDDDDDDD1991DDDDDDD199991DDDDDD19999
      1DDDDDD1999991DDDD1999991DDDDDDD1999991DD1999991DDDDDDDDD1999991
      1999991DDDDDDDDDDD199999999991DDDDDDDDDDDDD1999999991DDDDDDDDDDD
      DDDD19999991DDDDDDDDDDDDDDDD19999991DDDDDDDDDDDDDDD1999999991DDD
      DDDDDDDDDD199990999991DDDDDDDDDDD19999911999991DDDDDDDDD1999991D
      D1999991DDDDDDD1999991DDDD1999991DDDDDD199991DDDDDD199991DDDDDDD
      1991DDDDDDDD1991DDDDDDDDD11DDDDDDDDDD11DDDDDDDDDDDDDDDDDDDDDDDDD
      DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
    Layout = blGlyphLeft
    TabOrder = 4
    OnClick = btCancelClick
  end
  object btOk: TFlatButton
    Left = 411
    Top = 254
    Width = 50
    Height = 26
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
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 5
    OnClick = btOkClick
  end
end
