object fmTabela: TfmTabela
  Left = 359
  Top = 86
  Width = 809
  Height = 596
  Caption = '(12) Tabela de Pre'#231'os com estoque.'
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  DockSite = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  WindowState = wsMaximized
  WindowMenu = fmMain.abeladePreos1
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgrid: TSoftDBGrid
    Left = 0
    Top = 122
    Width = 793
    Height = 312
    TabStop = False
    Ctl3D = False
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = dbgridCellClick
    OnDblClick = dbgridDblClick
    OnTitleClick = dbgridTitleClick
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object Panel1: TPanel
    Left = 0
    Top = 510
    Width = 793
    Height = 48
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 639
      Top = 5
      Width = 42
      Height = 13
      Caption = 'Total 01:'
      Visible = False
    end
    object Label2: TLabel
      Left = 639
      Top = 29
      Width = 42
      Height = 13
      Caption = 'Total 02:'
      Visible = False
    end
    object lbTotal1: TLabel
      Left = 685
      Top = 5
      Width = 26
      Height = 13
      Caption = '0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lbTotal2: TLabel
      Left = 684
      Top = 29
      Width = 26
      Height = 13
      Caption = '0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object btImprime: TFlatButton
      Left = 2
      Top = 4
      Width = 102
      Height = 40
      Caption = '&Imprimir'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDDD7777777777DDDDD0000DDDD
        000000000007DDDD0000DDD07878787870707DDD0000DD0000000000000707DD
        0000DD0F8F8F8AAA8F0007DD0000DD08F8F8F999F80707DD0000DD0000000000
        0008707D0000DD08F8F8F8F8F080807D0000DDD0000000000F08007D0000DDDD
        0BFFFBFFF0F080DD0000DDDDD0F00000F0000DDD0000DDDDD0FBFFFBFF0DDDDD
        0000DDDDDD0F00000F0DDDDD0000DDDDDD0FFBFFFBF0DDDD0000DDDDDDD00000
        0000DDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDD
        DDDDDDDDDDDDDDDD0000}
      Layout = blGlyphLeft
      TabOrder = 0
      OnClick = btImprimeClick
    end
    object cbTpImp: TadLabelComboBox
      Left = 114
      Top = 20
      Width = 121
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      TabStop = False
      OnChange = cbTpImpChange
      Items.Strings = (
        'Impressora'
        'Porta')
      LabelDefs.Width = 89
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Enviar a impress'#227'o'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object FlatButton3: TFlatButton
      Left = 551
      Top = 20
      Width = 81
      Height = 26
      Caption = 'Exportar'
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
      TabOrder = 2
      OnClick = FlatButton3Click
    end
    object EdLocalImp: TadLabelEdit
      Left = 247
      Top = 20
      Width = 172
      Height = 19
      LabelDefs.Width = 90
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Porta de impress'#227'o'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
    end
  end
  object pnTitulo: TPanel
    Left = 0
    Top = 0
    Width = 793
    Height = 122
    Align = alTop
    TabOrder = 2
    object edCodigo: TadLabelEdit
      Left = 5
      Top = 18
      Width = 113
      Height = 26
      LabelDefs.Width = 104
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Fornecedor ou &codigo'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnKeyDown = edCodigoKeyDown
    end
    object cbPreco01: TadLabelComboBox
      Left = 126
      Top = 19
      Width = 139
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      TabStop = False
      LabelDefs.Width = 43
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Preco 01'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object cbPreco02: TadLabelComboBox
      Left = 270
      Top = 19
      Width = 139
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      TabStop = False
      LabelDefs.Width = 43
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Preco 02'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object cbLoja: TadLabelComboBox
      Left = 426
      Top = 19
      Width = 139
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      TabStop = False
      LabelDefs.Width = 118
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja para listar o estoque'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object rgTpestoque: TadLabelComboBox
      Left = 574
      Top = 18
      Width = 100
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 4
      TabStop = False
      Text = 'Todos'
      Items.Strings = (
        'Todos'
        'Que t'#234'm estoque'
        'Maior que zero'
        'Menor que zero')
      LabelDefs.Width = 75
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Listar o estoque'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object edDescricao: TadLabelEdit
      Left = 127
      Top = 61
      Width = 306
      Height = 20
      LabelDefs.Width = 48
      LabelDefs.Height = 13
      LabelDefs.Caption = '&Descricao'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      AutoSize = False
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      TabOrder = 5
      Visible = False
    end
    object cbItens: TRadioGroup
      Left = 5
      Top = 49
      Width = 111
      Height = 60
      Caption = '  Com os itens    '
      Ctl3D = False
      ItemIndex = 0
      Items.Strings = (
        '&Todos'
        'Que comec&am'
        '&Que contem')
      ParentCtl3D = False
      TabOrder = 6
      OnClick = cbItensClick
    end
    object cbOrder: TFlatCheckBox
      Left = 127
      Top = 103
      Width = 134
      Height = 14
      Caption = 'Ordena por fornecedor'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 7
      TabStop = True
    end
    object cbTotaliza: TFlatCheckBox
      Left = 264
      Top = 103
      Width = 134
      Height = 14
      Caption = 'Totaliza os valores'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 8
      TabStop = True
      Visible = False
      OnClick = cbTotalizaClick
    end
    object pnCategoria: TPanel
      Left = 442
      Top = 42
      Width = 184
      Height = 76
      BevelOuter = bvNone
      TabOrder = 9
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
    object FlatButton1: TFlatButton
      Left = 667
      Top = 57
      Width = 102
      Height = 57
      Caption = 'Pesquisar ( F7 )'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFF0000000000000000000000000000004000008000008000008000
        00800000800000800000FFFFFFFFFFFFFFFFFF20000080404080404080404080
        4040804040802020800000800000800000800000800000800000FFFFFFFFFFFF
        2000008040408040408040408040408040408040408020208000008000008000
        00800000800000800000FFFFFF20000080404080404080404080404080404080
        4040804040802020703030AF3030AF3030400000400000400000200000804040
        804040804040804040804040804040804040804040503030DF6060DF6060DF60
        60000000FFFFFFFFFFFF000000000000007F7F007F7F007F7F007F7F007F7F3F
        7F7F3F7F7F3FBFBFDF6060DF6060DF6060000000FFFFFFFFFFFFFFFFFFFFFFFF
        003F3F00BFBF00FFFFBFFFFF3FFFFF3FFFFF00FFFF00FFFF9F9F9FDF6060DF60
        60000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00BFBF00FFFF3FFFFF3F
        FFFF3FFFFF3FFFFF00FFFF003F3F000000000000FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF007F7F00FFFF3FFFFF3FFFFF3FFFFF209F9F4040200000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF003F3F00
        BFBF3FFFFF407F7F707050A0A060606040000000FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF205F5FAFAFAFAFAFAF9090707070
        30202000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF000000909090EFEFEF8F8F8F808060505050000000FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000006060609F9F9F7F7F
        5F707050707070000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF0000000000006F6F30BFBFBF909050707070FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
        003F3F7FBFBFBF909050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00003F6F6F50BFBFBF}
      TabOrder = 10
      OnClick = FlatButton1Click
    end
    object Animate: TAnimate
      Left = 681
      Top = 63
      Width = 78
      Height = 45
      AutoSize = False
      CommonAVI = aviFindFile
      StopFrame = 8
      Visible = False
    end
    object cbContaEstoque: TadLabelComboBox
      Left = 681
      Top = 18
      Width = 87
      Height = 21
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 12
      TabStop = False
      Text = 'Fisico'
      Items.Strings = (
        'Fisico'
        'Diponivel')
      LabelDefs.Width = 69
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Conta estoque'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
  end
  object pnPesqItem: TPanel
    Left = 0
    Top = 469
    Width = 793
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    DesignSize = (
      793
      41)
    object btOk: TfsBitBtn
      Left = 611
      Top = 3
      Width = 86
      Height = 33
      Anchors = [akRight, akBottom]
      Caption = '&Ok'
      TabOrder = 0
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
    object btCancela: TfsBitBtn
      Left = 704
      Top = 3
      Width = 86
      Height = 33
      Anchors = [akRight, akBottom]
      Caption = '&Cancelar'
      ModalResult = 2
      TabOrder = 1
      OnClick = btCancelaClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 192
    Top = 144
  end
  object tb: TADOTable
    Left = 168
    Top = 144
  end
  object tbImg: TADOTable
    Left = 96
    Top = 144
  end
  object PopupMenu1: TPopupMenu
    Left = 536
    Top = 152
    object pmInsereItens: TMenuItem
      Caption = 'Insere Item'
      OnClick = pmInsereItensClick
    end
    object TMenuItem
    end
    object SalvarTabela1: TMenuItem
      Caption = 'Salvar Tabela'
      OnClick = SalvarTabela1Click
    end
    object CarregarTabela1: TMenuItem
      Caption = 'Carregar Tabela'
      OnClick = CarregarTabela1Click
    end
  end
end
