object fmFaturamento: TfmFaturamento
  Tag = 402
  Left = 409
  Top = 117
  Width = 850
  Height = 498
  Anchors = [akTop]
  Caption = '(08) An'#225'lise de venda, faturamento.'
  Color = clMenu
  Ctl3D = False
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
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 0
    Top = 84
    Width = 834
    Height = 376
    Align = alClient
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    PopupMenu = PopupMenu1
    TabOrder = 0
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
    Left = 0
    Top = 0
    Width = 834
    Height = 84
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 314
      Top = 58
      Width = 71
      Height = 13
      Caption = '(Que clientes?)'
      Visible = False
      OnClick = Label1Click
      OnMouseMove = Label1MouseMove
      OnMouseLeave = Label1MouseLeave
    end
    object cbLojas: TadLabelComboBox
      Left = 10
      Top = 25
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
      TabOrder = 0
      LabelDefs.Width = 23
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object cbListaVdMaracanau: TfsCheckBox
      Left = 10
      Top = 57
      Width = 297
      Height = 17
      Caption = 'Incluir vendas para clientes n'#227'o considerados como venda'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 1
      Visible = False
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object btExportar: TfsBitBtn
      Left = 624
      Top = 22
      Width = 70
      Height = 30
      Caption = 'Exportar'
      TabOrder = 2
      OnClick = btExportarClick
      Glyph.Data = {
        B2050000424DB205000000000000360400002800000013000000130000000100
        0800000000007C010000C40E0000C40E00000001000000000000000000000000
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
        FFF7525252525252495249520000FFFFFFFFF6F7075BF70807A35A49F6FFFFFF
        5200FFFFFFFFF6005952525200F0E952070808FF5200FFFFFFFFFFF706E9A100
        F0FE9AA407F608FF4A00FFFFFFFFFFFFF50600F0FE540092070708FF4A00FFF6
        F7070707F70AF0FE54A4FFFFFFF607FF4A00FF07F708080751E8FE9B9853EEFF
        FFF6F6FF4A00FF0707FFF6A4F4F3A4A306F0A9F7FFF6F6FF5200FF0707F6F700
        920007F6A3484852080707FF5200FF070708FFF6FFA40808FFFFFFF6FF0808FF
        4900FF0707080707F6A4080807070707079B49494900FF070708F608FFA408FF
        FFF6F6FFFFF7A4A3FF00FF070708F608FFA407F6F6080808F6A45208FF00FF07
        0708080708A452525252499B5BA4F6FFFF00FF070707F608F6F6FFFFFFFF07FF
        FFB507FFFF00FF070708F608F608F60708EDA4F6F7429D9CF600FF0707FFF608
        08F6FFF707A408F643C78200F700FF0707FFFFF6F6FFFF07A408FFFFF749ACF7
        F600FF08A4F7F7F7F7F7F7A408FFFFFFFFF6FFFFFF00}
    end
    object btImprime: TfsBitBtn
      Left = 537
      Top = 22
      Width = 70
      Height = 30
      Caption = '&Imprimir'
      TabOrder = 3
      OnClick = FlatButton2Click
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
    end
    object fsBitBtn3: TfsBitBtn
      Left = 453
      Top = 22
      Width = 70
      Height = 30
      Caption = '&Gerar'
      TabOrder = 4
      OnClick = FlatButton1Click
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
    object GroupBox1: TGroupBox
      Left = 179
      Top = 9
      Width = 232
      Height = 48
      Caption = ' Periodo '
      TabOrder = 5
      object lbAte: TLabel
        Left = 108
        Top = 22
        Width = 15
        Height = 13
        Caption = 'at'#233
      end
      object datai: TfsDateTimePicker
        Left = 10
        Top = 17
        Width = 95
        Height = 22
        Date = 39906.649664583330000000
        Time = 39906.649664583330000000
        TabOrder = 0
        OnChange = dataiChange
      end
      object dataf: TfsDateTimePicker
        Left = 132
        Top = 17
        Width = 95
        Height = 22
        Date = 39906.649664583330000000
        Time = 39906.649664583330000000
        TabOrder = 1
      end
    end
  end
  object tb: TADOTable
    Connection = dm.con
    CommandTimeout = 0
    Left = 139
    Top = 96
    object tbis_uo: TIntegerField
      FieldName = 'is_uo'
    end
    object tbLoja: TStringField
      FieldName = 'Loja'
      Size = 30
    end
    object tbPreviageralcaixa: TBCDField
      FieldName = 'Previa geral caixa'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbVendacredcliente: TBCDField
      FieldName = 'Venda cred cliente'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbVendaLiquida: TBCDField
      DisplayLabel = 'Recebido No Caixa'
      FieldName = 'Venda Liquida'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbFatvendaClientes: TBCDField
      FieldName = 'Fat venda Clientes'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbFatvendaentrelojas: TBCDField
      FieldName = 'Fat venda entre lojas'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbVendasemcartao: TBCDField
      FieldName = 'Vendas em cartao'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbFatVendamenosVendacartao: TBCDField
      FieldName = 'Fat Venda menos Venda cartao'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbFattransfcomotransf: TBCDField
      DisplayLabel = 'Fat transf como transf '
      FieldName = 'Fat transf como transf'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 200
    Top = 96
  end
  object PopupMenu1: TPopupMenu
    Left = 240
    Top = 96
    object Detalhar1: TMenuItem
      Caption = 'Detalhar faturamento para clientes'
    end
  end
end
