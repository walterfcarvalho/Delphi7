object fmMapa: TfmMapa
  Left = 3
  Top = 0
  Width = 798
  Height = 570
  Caption = 'Mapa de separa'#231#227'o'
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
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 0
    Top = 121
    Width = 782
    Height = 386
    Align = alCustom
    BiDiMode = bdLeftToRight
    Ctl3D = False
    DataSource = DataSource1
    ParentBiDiMode = False
    ParentCtl3D = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = gridCellClick
    OnColEnter = gridColEnter
    OnColExit = gridColExit
    OnKeyDown = gridKeyDown
    OnTitleClick = gridTitleClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 782
    Height = 31
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 2
    object btNova: TFlatButton
      Left = 1
      Top = 2
      Width = 66
      Height = 26
      Caption = '&Nova'
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btovaClick
    end
    object btAbrir: TFlatButton
      Left = 71
      Top = 2
      Width = 66
      Height = 26
      Caption = '&Abrir'
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btAbrirClick
    end
    object btSalvar: TFlatButton
      Left = 141
      Top = 2
      Width = 66
      Height = 26
      Caption = '&Salvar'
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btSalvarClick
    end
    object btAprovar: TFlatButton
      Left = 211
      Top = 2
      Width = 66
      Height = 26
      Caption = 'A&provar'
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btAprovarClick
    end
    object btImprimir: TFlatButton
      Left = 280
      Top = 2
      Width = 66
      Height = 26
      Caption = '&Imprimir'
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btImprimirClick
    end
    object btInsere: TFlatButton
      Left = 349
      Top = 2
      Width = 66
      Height = 26
      Caption = 'I&nsere Item'
      Enabled = False
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 5
      OnClick = btInsereClick
    end
  end
  object pnTitulo: TFlatPanel
    Left = 0
    Top = 31
    Width = 782
    Height = 90
    ParentColor = True
    Align = alTop
    TabOrder = 1
    DesignSize = (
      782
      90)
    object lbNumMp: TLabel
      Left = 54
      Top = 1
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 128
      Top = 1
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
      Left = 162
      Top = 1
      Width = 5
      Height = 13
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 4
      Top = 31
      Width = 37
      Height = 13
      Caption = 'Nome:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbNome: TLabel
      Left = 43
      Top = 31
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 353
      Top = 3
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
      Left = 4
      Top = 61
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
      Left = 48
      Top = 61
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 4
      Top = 1
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
    object Label4: TLabel
      Left = 4
      Top = 46
      Width = 45
      Height = 13
      Caption = 'Criador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 151
      Top = 61
      Width = 63
      Height = 13
      Caption = 'Aprovador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbAprovador: TLabel
      Left = 220
      Top = 61
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbCriador: TLabel
      Left = 48
      Top = 46
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 201
      Top = 73
      Width = 224
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Clique com o bot'#227'o direito para o menu de itens'
    end
    object lbCodCriador: TLabel
      Left = 143
      Top = 20
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label9: TLabel
      Left = 5
      Top = 16
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
    object lbDsUo: TLabel
      Left = 35
      Top = 17
      Width = 13
      Height = 13
      Caption = ' - '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object mmObs: TfsMemo
      Left = 354
      Top = 17
      Width = 138
      Height = 53
      Anchors = [akLeft, akTop, akRight]
      Color = clInfoBk
      TabOrder = 0
      OnDblClick = mmObsDblClick
    end
    object cbCriticaQuant: TfsCheckBox
      Left = 444
      Top = 34
      Width = 92
      Height = 17
      Caption = 'Critica estoque'
      TabOrder = 1
      Visible = False
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 112
    Top = 184
  end
  object tb: TADOTable
    Connection = dm.con
    AfterOpen = tbAfterOpen
    BeforePost = tbBeforePost
    Left = 80
    Top = 184
  end
  object PopupMenu1: TPopupMenu
    Left = 168
    Top = 184
    object Listarentradasdoproduto1: TMenuItem
      Caption = 'Entradas / compras'
      OnClick = Listarentradasdoproduto1Click
    end
    object Resumodeestoquedaslojas1: TMenuItem
      Caption = 'Estoque nas lojas'
      OnClick = Resumodeestoquedaslojas1Click
    end
    object Vendasnoperiodo1: TMenuItem
      Caption = 'Saidas'
      OnClick = Vendasnoperiodo1Click
    end
    object Resumoentradassaidas1: TMenuItem
      Caption = 'Resumo ent/sai'
    end
    object Verrequisicoes1: TMenuItem
      Caption = 'Ver requisi'#231#245'es'
      OnClick = Verrequisicoes1Click
    end
    object RemoveositensMarcados1: TMenuItem
      Caption = 'Remove os itens Marcados '
      OnClick = RemoveositensMarcados1Click
    end
  end
end
