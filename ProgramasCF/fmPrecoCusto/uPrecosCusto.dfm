object fmPrecoCustos: TfmPrecoCustos
  Left = 313
  Top = 78
  Width = 790
  Height = 593
  Caption = 'Lancamento de preco de custo'
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
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 547
    Top = 335
    Width = 156
    Height = 13
    Caption = 'Lan'#231'ar v'#225'rios custos de uma vez'
    OnClick = Label1Click
    OnDblClick = Label1DblClick
  end
  object Label3: TLabel
    Left = 547
    Top = 349
    Width = 160
    Height = 13
    Caption = 'Formato <cod> <espa'#231'o><pre'#231'o>'
    OnClick = Label1Click
    OnDblClick = Label1DblClick
  end
  object edCodigo: TadLabelEdit
    Left = 5
    Top = 17
    Width = 164
    Height = 26
    LabelDefs.Width = 33
    LabelDefs.Height = 13
    LabelDefs.Caption = 'C'#243'digo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnKeyDown = edCodigoKeyDown
  end
  object Grid: TSoftDBGrid
    Left = 5
    Top = 72
    Width = 741
    Height = 258
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clHighlightText
  end
  object edPcNovo: TadLabelNumericEdit
    Left = 406
    Top = 15
    Width = 120
    Height = 24
    LabelDefs.Width = 56
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Novo pre'#231'o'
    Colors.WhenEnterFocus.BackColor = clWindow
    Colors.WhenExitFocus.BackColor = clInfoBk
    AutoSize = False
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
  object btAjustaPreco: TFlatButton
    Left = 538
    Top = 14
    Width = 59
    Height = 25
    Caption = '&Ajustar'
    TabOrder = 3
    OnClick = btAjustaPrecoClick
  end
  object btConsultaProduto: TFlatButton
    Left = 175
    Top = 17
    Width = 25
    Height = 26
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33033333333333333F7F3333333333333000333333333333F777333333333333
      000333333333333F777333333333333000333333333333F77733333333333300
      033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
      33333377333777733333307888887033333337F333F337F33333778888888773
      3333373337F3373F333307888888870333337F33F7FFF37F3333078888888703
      33337F377777337F3333078888888703333373F337F333733333778888888773
      333337F3373337F333333078888870333333373FF333F7333333330777770333
      333333773FF77333333333370007333333333333777333333333}
    NumGlyphs = 2
    TabOrder = 4
    OnClick = btConsultaProdutoClick
  end
  object cbCustoFiscal: TFlatCheckBox
    Left = 5
    Top = 340
    Width = 79
    Height = 18
    Caption = 'Custo Fiscal'
    Checked = True
    TabOrder = 5
    TabStop = True
    OnClick = cbCustoMedioUnicoClick
  end
  object cbCustoMedioUnico: TFlatCheckBox
    Left = 5
    Top = 357
    Width = 108
    Height = 18
    Caption = 'Custo Medio unico'
    TabOrder = 6
    TabStop = True
    OnClick = cbCustoMedioUnicoClick
  end
  object cbLoja: TadLabelComboBox
    Left = 226
    Top = 19
    Width = 164
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 7
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object memoItens: TMemo
    Left = 547
    Top = 364
    Width = 199
    Height = 132
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 8
  end
  object Button1: TButton
    Left = 120
    Top = 346
    Width = 79
    Height = 27
    Caption = 'Ajustar itens'
    TabOrder = 9
  end
  object edNome: TadLabelEdit
    Left = 5
    Top = 45
    Width = 741
    Height = 26
    LabelDefs.Width = 40
    LabelDefs.Height = 13
    LabelDefs.Caption = 'edNome'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 10
    OnKeyDown = edCodigoKeyDown
  end
  object GroupBox1: TGroupBox
    Left = 6
    Top = 379
    Width = 297
    Height = 86
    Caption = ' Ajuste de custos de notas  '
    TabOrder = 11
    object FlatButton1: TFlatButton
      Left = 6
      Top = 18
      Width = 133
      Height = 25
      Caption = '&Lancar custo fiscal'
      TabOrder = 0
      OnClick = FlatButton1Click
    end
    object edAjustaCusto: TadLabelSpinEdit
      Left = 230
      Top = 19
      Width = 52
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 84
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Ajuste o valor em:'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Decimals = 0
      MaxValue = 100.000000000000000000
      TabOrder = 1
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
    object FlatButton2: TFlatButton
      Left = 6
      Top = 56
      Width = 133
      Height = 25
      Caption = '&Recalcular CMU'
      TabOrder = 2
      OnClick = btRecalculaCMUItensNotaClick
    end
  end
  object fsBitBtn1: TfsBitBtn
    Left = 672
    Top = 502
    Width = 75
    Height = 25
    Caption = 'Processa'
    TabOrder = 12
    OnClick = fsBitBtn1Click
  end
  object query: TADOQuery
    Parameters = <>
    Left = 146
    Top = 77
  end
  object DataSource1: TDataSource
    DataSet = query
    Left = 90
    Top = 77
  end
end
