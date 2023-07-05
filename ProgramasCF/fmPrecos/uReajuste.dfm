object fmReajuste: TfmReajuste
  Left = 355
  Top = 260
  Width = 752
  Height = 404
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'fmReajuste'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    736
    366)
  PixelsPerInch = 96
  TextHeight = 13
  object edCodigo: TadLabelEdit
    Left = 1
    Top = 20
    Width = 131
    Height = 22
    LabelDefs.Width = 75
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Faixa de codigo'
    Colors.Active = False
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object edIPI: TadLabelNumericEdit
    Left = 592
    Top = 19
    Width = 70
    Height = 22
    LabelDefs.Width = 63
    LabelDefs.Height = 13
    LabelDefs.Caption = '% de reajuste'
    Colors.Active = False
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    Color = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object FlatButton4: TFlatButton
    Left = 674
    Top = 15
    Width = 40
    Height = 28
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      55555FFFFFFF5F55FFF5777777757559995777777775755777F7555555555550
      305555555555FF57F7F555555550055BB0555555555775F777F55555550FB000
      005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
      B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
      B05555577F555557F7F5550E0BFBFB00B055557575F55577F7F550EEE0BFB0B0
      B05557FF575F5757F7F5000EEE0BFBF0B055777FF575FFF7F7F50000EEE00000
      B0557777FF577777F7F500000E055550805577777F7555575755500000555555
      05555777775555557F5555000555555505555577755555557555}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 3
    OnClick = FlatButton4Click
  end
  object gpReajuste: TSoftDBGrid
    Left = 3
    Top = 74
    Width = 726
    Height = 249
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object Panel1: TPanel
    Left = 5
    Top = 323
    Width = 723
    Height = 37
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 5
    object FlatButton1: TFlatButton
      Left = 643
      Top = 2
      Width = 74
      Height = 32
      Caption = '&Processar'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00337000000000
        73333337777777773F333308888888880333337F3F3F3FFF7F33330808089998
        0333337F737377737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3F3F3F3F7F33330808080808
        0333337F737373737F333308888888880333337F3FFFFFFF7F33330800000008
        0333337F7777777F7F333308000E0E080333337F7FFFFF7F7F33330800000008
        0333337F777777737F333308888888880333337F333333337F33330888888888
        03333373FFFFFFFF733333700000000073333337777777773333}
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 0
      OnClick = FlatButton1Click
    end
  end
  object cbPc01: TadLabelComboBox
    Left = 140
    Top = 20
    Width = 110
    Height = 21
    AutoCloseUp = True
    BevelInner = bvNone
    BevelKind = bkFlat
    Style = csDropDownList
    Color = clInfoBk
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ItemIndex = 0
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    Text = 'Varejo'
    Items.Strings = (
      'Varejo'
      'Atacado')
    LabelDefs.Width = 28
    LabelDefs.Height = 13
    LabelDefs.Caption = '&Preco'
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
  end
  object chArredonda: TFlatCheckBox
    Left = 1
    Top = 46
    Width = 121
    Height = 17
    Caption = 'Usa arredondamento'
    TabOrder = 6
    TabStop = True
  end
  object cbPc02: TadLabelComboBox
    Left = 263
    Top = 20
    Width = 110
    Height = 21
    AutoCloseUp = True
    BevelInner = bvNone
    BevelKind = bkFlat
    Style = csDropDownList
    Color = clInfoBk
    Ctl3D = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ItemIndex = 0
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 7
    Text = 'Varejo'
    Items.Strings = (
      'Varejo'
      'Atacado')
    LabelDefs.Width = 27
    LabelDefs.Height = 13
    LabelDefs.Caption = '&Custo'
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
  end
  object pnCategoria: TPanel
    Left = 396
    Top = -2
    Width = 184
    Height = 76
    BevelOuter = bvNone
    TabOrder = 8
    object lbNivel: TLabel
      Left = 139
      Top = 4
      Width = 6
      Height = 13
      Caption = '0'
      Visible = False
    end
    object lbVlCat: TLabel
      Left = 154
      Top = 4
      Width = 24
      Height = 13
      Caption = '0000'
      Visible = False
    end
    object lbClasse1: TLabel
      Left = 46
      Top = 30
      Width = 81
      Height = 13
      Caption = '--------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbClasse2: TLabel
      Left = 60
      Top = 44
      Width = 81
      Height = 13
      Caption = '--------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbClasse3: TLabel
      Left = 71
      Top = 58
      Width = 81
      Height = 13
      Caption = '--------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 18
      Width = 184
      Height = 55
    end
    object Label5: TLabel
      Left = 3
      Top = 28
      Width = 26
      Height = 13
      Caption = 'Dep: '
    end
    object Label6: TLabel
      Left = 6
      Top = 43
      Width = 37
      Height = 13
      Caption = 'Se'#231#227'o: '
    end
    object Label3: TLabel
      Left = 8
      Top = 57
      Width = 48
      Height = 13
      Caption = 'Categoria:'
    end
    object btGetCategorias: TFlatButton
      Left = 13
      Top = 5
      Width = 91
      Height = 21
      Caption = 'Categorias    '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        0800000000000001000000000000000000000001000000000000000000000000
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
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA4A4A4A4A4A4FFFFFFFFFFFFFFFF
        FFFFA400A4A4A4A4FFFFFFFFFFFFFFFFFFFFA408080008A4FFFFFFFFFFFFFFFF
        FFFFA40808A4A4A4FFFFFFFFFFFF0000A4A4000008A4A4A4FFFFFFFFFFFF00FF
        0808FF000800FFA4FFFFFFFFA400A4A4A4A4A400A4A4A4A4FFFFFFFFA40808FF
        00A4A400A4A4A4A4FFFFFFFFA408000000A4A400FFFFFFFFFFFFFF0000080000
        00A4A400FFFFFFFFFFFFFFFF0808000808A40000FFFFFFFFFFFFFFFFA408FFFF
        00A4A4A4FFFFFFFFFFFFFFFF0000A4A400A400FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphLeft
      ParentFont = False
      TabOrder = 0
      OnClick = btGetCategoriasClick
    end
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 208
    Top = 120
  end
  object tb: TADOTable
    Left = 176
    Top = 112
  end
end
