object fmRelatorioComissao: TfmRelatorioComissao
  Left = 307
  Top = 128
  Width = 800
  Height = 548
  Caption = 'Lista comiss'#227'o.'
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
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    784
    510)
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 4
    Top = 3
    Width = 560
    Height = 95
    Caption = ' Dados do relat'#243'rio  '
    TabOrder = 0
    object cbLoja: TadLabelComboBox
      Left = 6
      Top = 29
      Width = 161
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      Ctl3D = True
      DropDownCount = 15
      ItemHeight = 13
      ParentBiDiMode = False
      ParentCtl3D = False
      TabOrder = 0
      LabelDefs.Width = 23
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object GroupBox2: TGroupBox
      Left = 169
      Top = 14
      Width = 220
      Height = 46
      Caption = ' Per'#237'odo '
      TabOrder = 1
      object datai: TfsDateTimePicker
        Left = 5
        Top = 16
        Width = 95
        Height = 22
        Date = 40238.649664583330000000
        Time = 40238.649664583330000000
        TabOrder = 0
      end
      object dataf: TfsDateTimePicker
        Left = 121
        Top = 16
        Width = 95
        Height = 22
        Date = 40238.649664583330000000
        Time = 40238.649664583330000000
        TabOrder = 1
      end
      object StaticText1: TStaticText
        Left = 102
        Top = 19
        Width = 19
        Height = 17
        Caption = 'at'#233
        TabOrder = 2
      end
    end
    object cbTipoComissao: TadLabelComboBox
      Left = 393
      Top = 36
      Width = 164
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      Ctl3D = True
      DropDownCount = 15
      ItemHeight = 13
      ParentBiDiMode = False
      ParentCtl3D = False
      TabOrder = 2
      OnChange = cbTipoComissaoChange
      Items.Strings = (
        'Varejo - Completo'
        'Atacado - Completo (C)'
        'Varejo - Consumidor (C)'
        'Varejo - Cliente cadastrado (C) '
        'Atacado - Consumidor'
        'Atacado - Cliente cadastrado'
        '<Todos >')
      LabelDefs.Width = 66
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Tipo Relat'#243'rio'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object cbComissFlores: TfsCheckBox
      Left = 353
      Top = 72
      Width = 202
      Height = 16
      BiDiMode = bdRightToLeft
      Caption = 'Remova Venda de flores da Comiss'#227'o'
      Checked = True
      ParentBiDiMode = False
      State = cbChecked
      TabOrder = 3
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbNomeTb: TfsCheckBox
      Left = 171
      Top = 70
      Width = 163
      Height = 16
      BiDiMode = bdRightToLeft
      Caption = 'Usa tabelas n'#227'o temporaria'
      Checked = True
      ParentBiDiMode = False
      State = cbChecked
      TabOrder = 4
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  object FlatButton1: TFlatButton
    Left = 567
    Top = 9
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
    TabOrder = 1
    OnClick = FlatButton1Click
  end
  object FlatButton2: TFlatButton
    Left = 567
    Top = 56
    Width = 32
    Height = 25
    Glyph.Data = {
      C6040000424DC60400000000000036040000280000000C0000000C0000000100
      08000000000090000000C40E0000C40E00000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A6000020400000206000002080000020A0000020C0000020E000004000000040
      20000040400000406000004080000040A0000040C0000040E000006000000060
      20000060400000606000006080000060A0000060C0000060E000008000000080
      20000080400000806000008080000080A0000080C0000080E00000A0000000A0
      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
      20004000400040006000400080004000A0004000C0004000E000402000004020
      20004020400040206000402080004020A0004020C0004020E000404000004040
      20004040400040406000404080004040A0004040C0004040E000406000004060
      20004060400040606000406080004060A0004060C0004060E000408000004080
      20004080400040806000408080004080A0004080C0004080E00040A0000040A0
      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
      20008000400080006000800080008000A0008000C0008000E000802000008020
      20008020400080206000802080008020A0008020C0008020E000804000008040
      20008040400080406000804080008040A0008040C0008040E000806000008060
      20008060400080606000806080008060A0008060C0008060E000808000008080
      20008080400080806000808080008080A0008080C0008080E00080A0000080A0
      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00000000000000
      0000000000000010AEF7F7F7F7F7F7F70A00000A08EEF5AEF5B609B69A000093
      135A135A135A535212005A0707B607B607B60707AB0053F5AEB5AEB5AEB557ED
      F75052EFFFEF09EF0807FF07ED0A005293989D9A9DAB93939D40000000EFEB92
      DA9B0700000000000000EF090909FF9A0000000000009B07EDEDDBFF50000000
      00000052529A53520000}
    TabOrder = 2
    OnClick = FlatButton2Click
  end
  object grid: TSoftDBGrid
    Left = 4
    Top = 98
    Width = 559
    Height = 249
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource2
    ParentCtl3D = False
    PopupMenu = PopupMenu
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object gbExporta: TGroupBox
    Left = 608
    Top = 4
    Width = 166
    Height = 94
    Caption = '  Outras op'#231#245'es   '
    TabOrder = 4
    Visible = False
    object FlatButton3: TFlatButton
      Left = 5
      Top = 41
      Width = 156
      Height = 25
      Caption = 'Exporta dados das vendas'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
        333333333333337FF3333333333333903333333333333377FF33333333333399
        03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
        99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
        99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
        03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
        33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
        33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
        3333777777333333333333333333333333333333333333333333}
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 0
    end
  end
  object tb: TADOTable
    Connection = dm.con
    Left = 240
    Top = 136
  end
  object DataSource2: TDataSource
    DataSet = tbResult
    Left = 80
    Top = 136
  end
  object qrResult: TADOQuery
    Connection = dm.con
    Parameters = <>
    Left = 120
    Top = 137
  end
  object tbResult: TADOTable
    Connection = dm.con
    Left = 288
    Top = 136
  end
  object PopupMenu: TPopupMenu
    Left = 152
    Top = 192
    object N1: TMenuItem
      Caption = 'Exporta anal'#237'tico do resultado'
      OnClick = N1Click
    end
  end
end
