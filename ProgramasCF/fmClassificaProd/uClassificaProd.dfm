object fmClassificaProd: TfmClassificaProd
  Left = 387
  Top = 100
  Width = 831
  Height = 631
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Classifica'#231#227'o em massa de produtos.     '
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 6
    Top = 276
    Width = 131
    Height = 13
    AutoSize = False
    Caption = 'Classifica'#231#227'o atual'
  end
  object Label1: TLabel
    Left = 622
    Top = 25
    Width = 76
    Height = 13
    AutoSize = False
    Caption = 'Mov a partir de:'
  end
  object Label3: TLabel
    Left = 422
    Top = 278
    Width = 44
    Height = 13
    Caption = 'Sec'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 235
    Top = 278
    Width = 80
    Height = 13
    Caption = 'Departamento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 605
    Top = 278
    Width = 55
    Height = 13
    Caption = 'Categoria'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 349
    Top = 5
    Width = 67
    Height = 13
    AutoSize = False
    Caption = 'Classifica'#231#227'o'
  end
  object Label7: TLabel
    Left = 464
    Top = 5
    Width = 67
    Height = 13
    AutoSize = False
    Caption = 'Tipo consulta'
  end
  object btConsulta: TFlatButton
    Left = 568
    Top = 17
    Width = 49
    Height = 26
    Caption = '&Listar'
    TabOrder = 2
    OnClick = btConsultaClick
  end
  object edit1: TadLabelEdit
    Left = 8
    Top = 19
    Width = 102
    Height = 26
    LabelDefs.Width = 76
    LabelDefs.Height = 13
    LabelDefs.Caption = '&Faixa de C'#243'digo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnKeyDown = edit1KeyDown
  end
  object gridCat1: TSoftDBGrid
    Left = 235
    Top = 296
    Width = 180
    Height = 294
    Ctl3D = False
    DataSource = DataSource3
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    PopupMenu = PopupMenu1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = gridCat1CellClick
    OnTitleClick = gridCat1TitleClick
    AlternateColor = True
    ColorLow = clHighlightText
    ColorHigh = clInfoBk
  end
  object gridCat2: TSoftDBGrid
    Left = 420
    Top = 296
    Width = 180
    Height = 294
    Ctl3D = False
    DataSource = DataSource4
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    PopupMenu = PopupMenu2
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = gridCat2CellClick
    OnTitleClick = gridCat2TitleClick
    AlternateColor = True
    ColorLow = clHighlightText
    ColorHigh = clInfoBk
  end
  object gridCat3: TSoftDBGrid
    Left = 605
    Top = 296
    Width = 180
    Height = 294
    Ctl3D = False
    DataSource = DataSource5
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    PopupMenu = PopupMenu3
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = gridCat3TitleClick
    AlternateColor = True
    ColorLow = clHighlightText
    ColorHigh = clInfoBk
  end
  object btReclass: TFlatButton
    Left = 8
    Top = 548
    Width = 186
    Height = 42
    Caption = 'Reclassificar itens selecionados'
    TabOrder = 3
    OnClick = btReclassClick
  end
  object cbListaClassificado: TfsComboBox
    Left = 348
    Top = 21
    Width = 112
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 7
    Text = 'Nao classificados'
    Items.Strings = (
      'Nao classificados'
      'Classificados'
      'Todos')
  end
  object cbDtExpPreco: TFlatCheckBox
    Left = 7
    Top = 276
    Width = 144
    Height = 18
    Caption = 'Marca / desmarca todos'
    TabOrder = 8
    TabStop = True
    OnClick = cbDtExpPrecoClick
  end
  object btManterClass: TFlatButton
    Left = 8
    Top = 497
    Width = 120
    Height = 37
    Caption = '&Manter Classifica'#231#227'o'
    TabOrder = 9
    OnClick = btManterClassClick
  end
  object gridItens: TSoftDBGrid
    Left = 8
    Top = 52
    Width = 776
    Height = 222
    Ctl3D = False
    DataSource = dsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 10
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = gridItensCellClick
    OnTitleClick = gridItensTitleClick
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object gridCatAtual: TSoftDBGrid
    Left = 8
    Top = 312
    Width = 180
    Height = 171
    Ctl3D = False
    DataSource = DataSource2
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 11
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clHighlightText
    ColorHigh = clInfoBk
  end
  object edDesc: TadLabelEdit
    Left = 118
    Top = 19
    Width = 225
    Height = 26
    LabelDefs.Width = 48
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Descri'#231#227'o'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnKeyDown = edit1KeyDown
  end
  object di: TfsDateTimePicker
    Left = 703
    Top = 21
    Width = 80
    Height = 21
    Date = 40842.672702233790000000
    Time = 40842.672702233790000000
    TabOrder = 12
  end
  object cbTpConsulta: TfsComboBox
    Left = 463
    Top = 21
    Width = 99
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 13
    Text = 'Faixa de codigo'
    Items.Strings = (
      'Faixa de codigo'
      'Ped Compra')
  end
  object DataSource2: TDataSource
    DataSet = qrCatAtual
    Left = 112
    Top = 360
  end
  object qrCatAtual: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 72
    Top = 344
  end
  object qrNvCa1: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 320
    Top = 400
  end
  object DataSource3: TDataSource
    AutoEdit = False
    DataSet = qrNvCa1
    Left = 320
    Top = 368
  end
  object DataSource4: TDataSource
    DataSet = qrNvCa2
    Left = 536
    Top = 344
  end
  object qrNvCa2: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 536
    Top = 376
  end
  object DataSource5: TDataSource
    DataSet = qrNvCa3
    Left = 733
    Top = 336
  end
  object qrNvCa3: TADOQuery
    CursorType = ctStatic
    Parameters = <>
    Left = 736
    Top = 368
  end
  object dsItens: TDataSource
    DataSet = tb
    Left = 176
    Top = 112
  end
  object tb: TADOTable
    CursorType = ctStatic
    Left = 72
    Top = 136
  end
  object PopupMenu1: TPopupMenu
    Left = 248
    Top = 344
    object NovoItem1: TMenuItem
      Caption = 'Novo &Item'
      OnClick = NovoItem1Click
    end
    object N1: TMenuItem
      Caption = ' '
    end
    object RemoveItem1: TMenuItem
      Caption = '&Remove Item'
      OnClick = RemoveItem1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 424
    Top = 336
    object MenuItem1: TMenuItem
      Caption = 'Novo &Item'
      OnClick = MenuItem1Click
    end
    object MenuItem2: TMenuItem
      Caption = ' '
    end
    object MenuItem3: TMenuItem
      Caption = '&Remove Item'
      OnClick = MenuItem3Click
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 624
    Top = 344
    object MenuItem4: TMenuItem
      Caption = 'Novo &Item'
      OnClick = MenuItem4Click
    end
    object MenuItem5: TMenuItem
      Caption = ' '
    end
    object MenuItem6: TMenuItem
      Caption = '&Remove Item'
      OnClick = MenuItem6Click
    end
  end
end
