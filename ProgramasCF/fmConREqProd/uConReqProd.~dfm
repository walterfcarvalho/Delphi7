object fmConReqProduto: TfmConReqProduto
  Left = 273
  Top = 175
  Width = 855
  Height = 450
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Consulta requisi'#231#245'es por produto.'
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 0
    Top = 94
    Width = 839
    Height = 295
    Ctl3D = False
    DataSource = dataSource
    ParentCtl3D = False
    PopupMenu = PopupMenu1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = gridCellClick
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 839
    Height = 94
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 495
      Top = 53
      Width = 53
      Height = 13
      Caption = 'Data Inicial'
    end
    object Label2: TLabel
      Left = 591
      Top = 53
      Width = 45
      Height = 13
      Caption = 'Data final'
    end
    object lbItem: TLabel
      Left = 168
      Top = 22
      Width = 5
      Height = 13
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edCodigo: TadLabelEdit
      Left = 3
      Top = 19
      Width = 152
      Height = 19
      LabelDefs.Width = 73
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Codigo ou EAN'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object cbLojas: TadLabelComboBox
      Left = 163
      Top = 68
      Width = 153
      Height = 21
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 1
      LabelDefs.Width = 158
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Requisi'#231#245'es feitas a partir da loja:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object dti: TfsDateTimePicker
      Left = 492
      Top = 68
      Width = 90
      Height = 21
      CalColors.BackColor = clInfoBk
      Date = 39689.000000000000000000
      Time = 39689.000000000000000000
      TabOrder = 2
    end
    object dtf: TfsDateTimePicker
      Left = 588
      Top = 68
      Width = 90
      Height = 21
      CalColors.BackColor = clInfoBk
      Date = 39689.000000000000000000
      Time = 39689.000000000000000000
      TabOrder = 3
    end
    object btConsultar: TFlatButton
      Left = 711
      Top = 32
      Width = 70
      Height = 46
      Caption = '&Consultar'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333333333333333333333FFFFF3333333333CCCCC33
        33333FFFF77777FFFFFFCCCCCC808CCCCCC377777737F777777F008888070888
        8003773FFF7773FFF77F0F0770F7F0770F037F777737F777737F70FFFFF7FFFF
        F07373F3FFF7F3FFF37F70F000F7F000F07337F77737F777373330FFFFF7FFFF
        F03337FF3FF7F3FF37F3370F00F7F00F0733373F7737F77337F3370FFFF7FFFF
        0733337F33373F337333330FFF030FFF03333373FF7373FF7333333000333000
        3333333777333777333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btConsultarClick
    end
    object cbDestReq: TadLabelComboBox
      Left = 326
      Top = 67
      Width = 153
      Height = 21
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 5
      LabelDefs.Width = 56
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Feitas Para:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
  end
  object dataSource: TDataSource
    Left = 40
    Top = 83
  end
  object PopupMenu1: TPopupMenu
    Left = 80
    Top = 80
    object remItemDaRequisicao: TMenuItem
      Caption = 'Ajuste da quantidade pedida. ***'
      OnClick = remItemDaRequisicaoClick
    end
    object Verrequisiotransferidas1: TMenuItem
      Caption = 'Ver requisi'#231#227'o transferidas.'
      OnClick = Verrequisiotransferidas1Click
    end
    object Removereincluirnoprximoabastecimento1: TMenuItem
      Caption = 'Remover e incluir no pr'#243'ximo abastecimento. ***'
      OnClick = Removereincluirnoprximoabastecimento1Click
    end
  end
end
