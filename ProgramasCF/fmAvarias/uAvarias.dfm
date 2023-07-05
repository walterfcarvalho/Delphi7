object fmCadAvarias: TfmCadAvarias
  Left = 364
  Top = 165
  Width = 791
  Height = 537
  Caption = 'Controle de avarias'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  Menu = menuAvarias
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnResize = FormResize
  DesignSize = (
    775
    479)
  PixelsPerInch = 96
  TextHeight = 13
  object pnDados: TPanel
    Left = 0
    Top = 65
    Width = 775
    Height = 102
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    Visible = False
    object Bevel1: TBevel
      Left = 1
      Top = 1
      Width = 619
      Height = 87
    end
    object lbIs_ref: TLabel
      Left = 330
      Top = 43
      Width = 34
      Height = 13
      Caption = 'lbIs_ref'
      Visible = False
    end
    object lbCdref: TLabel
      Left = 283
      Top = 43
      Width = 34
      Height = 13
      Caption = 'lbIs_ref'
      Visible = False
    end
    object fsLabel1: TfsLabel
      Left = 373
      Top = 47
      Width = 62
      Height = 13
      Caption = 'Respons'#225'vel'
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object lbMNPes: TLabel
      Left = 5
      Top = 89
      Width = 153
      Height = 13
      Caption = #218'ltima Altera'#231#227'o feita por: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbCD_pes: TLabel
      Left = 157
      Top = 90
      Width = 61
      Height = 13
      Caption = '---------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbRef: TLabel
      Left = 243
      Top = 43
      Width = 34
      Height = 13
      Caption = 'lbIs_ref'
      Visible = False
    end
    object edCodigo: TadLabelEdit
      Left = 5
      Top = 21
      Width = 88
      Height = 19
      LabelDefs.Width = 33
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Codigo'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      MaxLength = 13
      TabOrder = 0
      OnKeyDown = edCodigoKeyDown
    end
    object EdDesc: TadLabelEdit
      Left = 102
      Top = 21
      Width = 267
      Height = 19
      TabStop = False
      LabelDefs.Width = 48
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Descri'#231#227'o'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      MaxLength = 13
      TabOrder = 1
    end
    object edQuant: TadLabelEdit
      Left = 374
      Top = 21
      Width = 57
      Height = 19
      LabelDefs.Width = 55
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Quantidade'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      MaxLength = 13
      TabOrder = 2
    end
    object edObs: TadLabelEdit
      Left = 6
      Top = 62
      Width = 363
      Height = 19
      LabelDefs.Width = 58
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Observa'#231#227'o'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 3
    end
    object pnConfirma: TPanel
      Left = 621
      Top = 59
      Width = 139
      Height = 29
      BevelOuter = bvNone
      TabOrder = 4
      Visible = False
      object BitBtn1: TFlatButton
        Left = 3
        Top = 1
        Width = 64
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
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object btCancela: TFlatButton
        Left = 72
        Top = 1
        Width = 64
        Height = 26
        Caption = 'Cancela'
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
        Layout = blGlyphLeft
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btCancelaClick
      end
    end
    object cbOrigemAvaria: TfsComboBox
      Left = 373
      Top = 62
      Width = 97
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      Items.Strings = (
        'Cliente'
        'Funcion'#225'rio'
        'CD'
        'Gerente/Subgerente')
    end
    object ednResponsavel: TadLabelEdit
      Left = 475
      Top = 62
      Width = 91
      Height = 19
      LabelDefs.Width = 88
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Nome respons'#225'vel'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      MaxLength = 100
      TabOrder = 6
    end
    object edPcSugerido: TadLabelNumericEdit
      Left = 441
      Top = 20
      Width = 79
      Height = 19
      LabelDefs.Width = 71
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Pre'#231'o sugerido'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Enabled = False
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 7
    end
    object edPreco: TadLabelNumericEdit
      Left = 289
      Top = 20
      Width = 50
      Height = 19
      LabelDefs.Width = 71
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Pre'#231'o sugerido'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 8
      Visible = False
    end
  end
  object pnTitulo: TFlatPanel
    Left = 0
    Top = 0
    Width = 775
    Height = 65
    ParentColor = True
    Visible = False
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 6
      Top = 2
      Width = 52
      Height = 13
      Caption = 'N'#250'mero: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbNumAvaria: TLabel
      Left = 57
      Top = 2
      Width = 36
      Height = 13
      Caption = '00000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 104
      Top = 2
      Width = 33
      Height = 13
      Caption = 'Loja: '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbLoja: TLabel
      Left = 139
      Top = 2
      Width = 36
      Height = 13
      Caption = '00000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 342
      Top = 2
      Width = 32
      Height = 13
      Caption = 'Data:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbDtAvaria: TLabel
      Left = 375
      Top = 2
      Width = 69
      Height = 13
      Caption = '99/99/9999'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 454
      Top = 2
      Width = 41
      Height = 13
      Caption = 'Status:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbStatus: TLabel
      Left = 497
      Top = 2
      Width = 55
      Height = 13
      Caption = 'Aprovada'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 272
      Top = 19
      Width = 65
      Height = 13
      Caption = 'Mensagem:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 603
      Top = 2
      Width = 96
      Height = 13
      Caption = 'Data aprova'#231#227'o:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbdtAprov: TLabel
      Left = 704
      Top = 3
      Width = 74
      Height = 16
      AutoSize = False
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbtipo: TLabel
      Left = 41
      Top = 19
      Width = 74
      Height = 16
      Caption = '-                 '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 6
      Top = 21
      Width = 30
      Height = 13
      Caption = 'Tipo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbuo: TLabel
      Left = 128
      Top = 20
      Width = 20
      Height = 13
      Caption = 'lbuo'
      Visible = False
    end
    object Label8: TLabel
      Left = 6
      Top = 46
      Width = 34
      Height = 13
      Caption = 'Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbTotal: TLabel
      Left = 43
      Top = 46
      Width = 73
      Height = 13
      Caption = '-                 '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object mmObs: TfsMemo
      Left = 344
      Top = 17
      Width = 419
      Height = 44
      Color = clMenuBar
      Enabled = False
      TabOrder = 0
    end
  end
  object pnOperacoes: TPanel
    Left = 651
    Top = 65
    Width = 114
    Height = 59
    BevelOuter = bvNone
    TabOrder = 2
    Visible = False
    object BitBtn3: TFlatButton
      Left = 0
      Top = 2
      Width = 109
      Height = 26
      Caption = '&Incluir'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 0
      OnClick = BitBtn3Click
    end
    object BitBtn5: TFlatButton
      Left = 0
      Top = 30
      Width = 109
      Height = 26
      Caption = '&Excluir'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        300033FFFFFF3333377739999993333333333777777F3333333F399999933333
        3300377777733333337733333333333333003333333333333377333333333333
        3333333333333333333F333333333333330033333F33333333773333C3333333
        330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
        333333377F33333333FF3333C333333330003333733333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 1
      OnClick = BitBtn5Click
    end
  end
  object Grid: TSoftDBGrid
    Left = 1
    Top = 171
    Width = 710
    Height = 186
    Anchors = [akLeft, akTop, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Visible = False
    OnCellClick = GridCellClick
    OnTitleClick = GridTitleClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object menuAvarias: TMainMenu
    AutoHotkeys = maManual
    Left = 240
    Top = 207
    object Nova1: TMenuItem
      Tag = 103101
      Caption = '&Nova   '
      ImageIndex = 0
      OnClick = Nova1Click
    end
    object Abrir1: TMenuItem
      Tag = 103102
      Caption = '&Abrir    '
      ImageIndex = 1
      OnClick = Abrir1Click
    end
    object Aprovar1: TMenuItem
      Tag = 103103
      Caption = 'Aprova'#231#227'o'
      ImageIndex = 3
      OnClick = Aprovar1Click
    end
    object Imprimir1: TMenuItem
      Caption = '&Imprimir'
      ImageIndex = 2
      object Imprimirrelaodeavaria1: TMenuItem
        Tag = 104101
        Caption = 'Imprimir rela'#231#227'o de avaria'
        OnClick = Imprimirrelaodeavaria1Click
      end
      object Relatrios1: TMenuItem
        Tag = 104102
        Caption = 'Valores de avarias por per'#237'odo'
        OnClick = Relatrios1Click
      end
      object Vendadeprodutosavariados1: TMenuItem
        Tag = 104103
        Caption = 'Venda de produtos avariados'
        OnClick = Vendadeprodutosavariados1Click
      end
    end
    object Exportar1: TMenuItem
      Tag = 103105
      Caption = 'Exportar'
      OnClick = Exportar1Click
    end
    object ransferirAvaria1: TMenuItem
      Tag = 103106
      Caption = 'Ajuste a loja do desconto '
      OnClick = ransferirAvaria1Click
    end
  end
  object DataSource1: TDataSource
    DataSet = tbItensAv
    Left = 152
    Top = 200
  end
  object tbItensAv: TADOTable
    Left = 48
    Top = 256
  end
end
