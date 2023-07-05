object fmConsultaPedCompra: TfmConsultaPedCompra
  Left = 229
  Top = 172
  Width = 818
  Height = 411
  Caption = 'Relat'#243'rio de pedido de compra'
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
  PixelsPerInch = 96
  TextHeight = 13
  object lbCdpes: TLabel
    Left = 128
    Top = 62
    Width = 38
    Height = 13
    Caption = 'lbCdpes'
    Visible = False
  end
  object Bevel2: TBevel
    Left = 10
    Top = 212
    Width = 774
    Height = 2
  end
  object grBoxDatas: TGroupBox
    Left = 192
    Top = 9
    Width = 249
    Height = 50
    Caption = ' Per'#237'odo '
    TabOrder = 1
    object Label1: TLabel
      Left = 115
      Top = 23
      Width = 15
      Height = 13
      Caption = 'at'#233
    end
    object di: TfsDateTimePicker
      Left = 8
      Top = 20
      Width = 102
      Height = 21
      Date = 40842.672702233790000000
      Time = 40842.672702233790000000
      TabOrder = 0
    end
    object df: TfsDateTimePicker
      Left = 134
      Top = 20
      Width = 102
      Height = 21
      Date = 40842.672702233790000000
      Time = 40842.672702233790000000
      TabOrder = 1
    end
  end
  object cbLojas: TadLabelComboBox
    Left = 11
    Top = 25
    Width = 167
    Height = 21
    AutoDropDown = True
    BevelInner = bvNone
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    LabelDefs.Width = 20
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cbPessoa: TadLabelComboBox
    Left = 451
    Top = 27
    Width = 167
    Height = 21
    AutoDropDown = True
    BevelInner = bvNone
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    LabelDefs.Width = 54
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Comprador:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object edEmitDest: TadLabelEdit
    Left = 14
    Top = 77
    Width = 272
    Height = 19
    LabelDefs.Width = 54
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Fornecedor'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 3
    OnDblClick = edEmitDestDblClick
    OnEnter = edEmitDestDblClick
  end
  object btEmisDest: TFlatButton
    Left = 260
    Top = 78
    Width = 25
    Height = 17
    Caption = '...'
    TabOrder = 4
    OnClick = btEmisDestClick
  end
  object btOk: TFlatButton
    Left = 704
    Top = 54
    Width = 66
    Height = 26
    Caption = '&Gerar'
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
    ModalResult = 1
    OnClick = i
  end
  object cbPendentes: TfsCheckBox
    Left = 16
    Top = 133
    Width = 263
    Height = 17
    Caption = 'Apenas pendentes'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object gbAlteraDatas: TGroupBox
    Left = 16
    Top = 219
    Width = 376
    Height = 91
    Caption = 'Avan'#231'ar dias dos pedidos pendentes'
    TabOrder = 8
    object Label2: TLabel
      Left = 10
      Top = 24
      Width = 177
      Height = 13
      Caption = 'Altere a data de emiss'#227'o vencimento '
    end
    object Label3: TLabel
      Left = 9
      Top = 36
      Width = 112
      Height = 13
      Caption = 'dos itens pendentes em'
    end
    object Label4: TLabel
      Left = 240
      Top = 28
      Width = 21
      Height = 13
      Caption = 'Dias'
    end
    object edNumDias: TadLabelSpinEdit
      Left = 191
      Top = 23
      Width = 42
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 55
      LabelDefs.Height = 13
      LabelDefs.Caption = 'edNumDias'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Decimals = -1
      MaxValue = 90.000000000000000000
      MinValue = -60.000000000000000000
      Format = nfStandard
      TabOrder = 0
      Value = 3.000000000000000000
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
    object FlatButton1: TFlatButton
      Left = 285
      Top = 23
      Width = 65
      Height = 26
      Caption = '&OK'
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
      TabOrder = 1
      ModalResult = 1
      OnClick = FlatButton1Click
    end
  end
  object pnCategoria: TPanel
    Left = 450
    Top = 65
    Width = 187
    Height = 76
    BevelOuter = bvNone
    TabOrder = 6
    object lbNivel: TLabel
      Left = 146
      Top = 4
      Width = 6
      Height = 13
      Caption = '0'
      Visible = False
    end
    object lbVlCat: TLabel
      Left = 157
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
      AutoSize = False
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
      AutoSize = False
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
      AutoSize = False
      Caption = '--------------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 1
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
    object Label7: TLabel
      Left = 12
      Top = 57
      Width = 48
      Height = 13
      Caption = 'Categoria:'
    end
    object FlatButton7: TFlatButton
      Left = 17
      Top = 2
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
      OnClick = FlatButton7Click
    end
  end
  object tbPedidos: TADOTable
    Left = 344
    Top = 72
    object tbPedidosPedido: TIntegerField
      FieldName = 'Pedido'
    end
    object tbPedidosdt_emis: TDateTimeField
      FieldName = 'dt_emis'
    end
    object tbPedidosnm_usu: TStringField
      FieldName = 'nm_usu'
      Size = 100
    end
    object tbPedidoscd_pes: TIntegerField
      FieldName = 'cd_pes'
    end
    object tbPedidosnm_razsoc: TStringField
      FieldName = 'nm_razsoc'
      Size = 100
    end
    object tbPedidosvl_merc: TBCDField
      FieldName = 'vl_merc'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbPedidosvl_total: TBCDField
      FieldName = 'vl_total'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbPedidosVlPendente: TBCDField
      FieldName = 'VlPendente'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbPedidosds_prazo: TStringField
      FieldName = 'ds_prazo'
    end
  end
  object tbParcelas: TADOTable
    Left = 408
    Top = 72
  end
  object tbParcCons: TADOTable
    Left = 408
    Top = 112
    object tbParcConsseq: TAutoIncField
      FieldName = 'seq'
      ReadOnly = True
    end
    object tbParcConsmes_ano: TStringField
      FieldName = 'mes_ano'
      Size = 7
    end
    object tbParcConsano_mes: TStringField
      FieldName = 'ano_mes'
      Size = 7
    end
    object tbParcConsvalor2: TBCDField
      FieldName = 'vlParcPendente'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbParcConsvalor: TBCDField
      FieldName = 'valor'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbParcConsvlFornADM: TBCDField
      FieldName = 'vlFornADM'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
  end
  object tbPedRes: TADOTable
    Left = 344
    Top = 112
    object tbPedResseq: TAutoIncField
      FieldName = 'seq'
      ReadOnly = True
    end
    object tbPedResnm_usu: TStringField
      FieldName = 'nm_usu'
      Size = 100
    end
    object tbPedResvl_merc: TBCDField
      FieldName = 'vl_merc'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbPedResvl_total: TBCDField
      FieldName = 'vl_total'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbPedResVlPendente: TBCDField
      FieldName = 'VlPendente'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
  end
end
