object fmConReqDep: TfmConReqDep
  Left = 420
  Top = 135
  Width = 795
  Height = 516
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poScreenCenter
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 0
    Top = 237
    Width = 779
    Height = 13
    Align = alBottom
    Caption = 'Itens'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object grid: TSoftDBGrid
    Left = 0
    Top = 60
    Width = 779
    Height = 177
    Align = alClient
    Ctl3D = False
    DataSource = dsReq
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    PopupMenu = popMenu
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = gridDblClick
    OnTitleClick = gridTitleClick
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object pdGrid: TSoftDBGrid
    Left = 0
    Top = 250
    Width = 779
    Height = 228
    Align = alBottom
    Ctl3D = False
    DataSource = DataSource2
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 779
    Height = 60
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 420
      Top = 3
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object Label2: TLabel
      Left = 533
      Top = 3
      Width = 48
      Height = 13
      Caption = 'Data Final'
    end
    object Label5: TLabel
      Left = 83
      Top = 43
      Width = 180
      Height = 13
      Caption = '( Duplo clique para visualizer os itens )'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 5
      Top = 43
      Width = 74
      Height = 13
      Caption = 'Requisi'#231#245'es '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object fsBitBtn1: TfsBitBtn
      Left = 652
      Top = 6
      Width = 119
      Height = 49
      Caption = '&Consultar'
      TabOrder = 0
      OnClick = fsBitBtn1Click
    end
    object dtf: TfsDateTimePicker
      Left = 535
      Top = 18
      Width = 105
      Height = 21
      CalColors.BackColor = clInfoBk
      Date = 39689.000000000000000000
      Time = 39689.000000000000000000
      TabOrder = 1
    end
    object dti: TfsDateTimePicker
      Left = 420
      Top = 18
      Width = 106
      Height = 21
      CalColors.BackColor = clInfoBk
      Date = 39689.000000000000000000
      Time = 39689.000000000000000000
      TabOrder = 2
    end
    object cbLojaEstoque: TadLabelComboBox
      Left = 216
      Top = 16
      Width = 173
      Height = 21
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 3
      LabelDefs.Width = 56
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Para a loja: '
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object cbLojas: TadLabelComboBox
      Left = 3
      Top = 18
      Width = 170
      Height = 21
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 4
      LabelDefs.Width = 158
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Requisi'#231#245'es feitas a partir da loja:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
  end
  object dsReq: TDataSource
    DataSet = qrReq
    Left = 112
    Top = 75
  end
  object DataSource2: TDataSource
    DataSet = qrItens
    Left = 112
    Top = 347
  end
  object qrReq: TADOQuery
    Connection = dm.con
    Parameters = <>
    Left = 152
    Top = 72
  end
  object qrItens: TADOQuery
    Connection = dm.con
    Parameters = <>
    Left = 144
    Top = 344
  end
  object popMenu: TPopupMenu
    Left = 200
    Top = 80
    object Removerrequisio1: TMenuItem
      Caption = 'Remover requisi'#231#227'o.'
      OnClick = Removerrequisio1Click
    end
  end
end
