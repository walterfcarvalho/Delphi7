object fmRemRegTEF: TfmRemRegTEF
  Left = 355
  Top = 177
  Width = 800
  Height = 469
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Ajustes de recebimento de caixa'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    784
    431)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 193
    Top = 6
    Width = 23
    Height = 13
    Caption = 'Data'
  end
  object cbLojas: TadLabelComboBox
    Left = 5
    Top = 22
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
    TabOrder = 0
    OnClick = cbLojasClick
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object grid: TSoftDBGrid
    Left = 5
    Top = 67
    Width = 636
    Height = 271
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    PopupMenu = PopupMenu1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = gridDrawColumnCell
    OnTitleClick = gridTitleClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clHighlightText
  end
  object btConsulta: TFlatButton
    Left = 429
    Top = 15
    Width = 48
    Height = 27
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
    TabOrder = 2
    OnClick = btConsultaClick
  end
  object dt: TfsDateTimePicker
    Left = 193
    Top = 20
    Width = 95
    Height = 22
    Date = 39906.649664583330000000
    Time = 39906.649664583330000000
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 514
    Top = 2
    Width = 267
    Height = 60
    Caption = ' Pesquisar dentro da consulta '
    TabOrder = 4
    object cbModalidade: TadLabelComboBox
      Left = 8
      Top = 32
      Width = 129
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      DropDownCount = 15
      ItemHeight = 13
      ParentBiDiMode = False
      TabOrder = 0
      LabelDefs.Width = 58
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Modalidade:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object edBusca: TadLabelNumericEdit
      Left = 141
      Top = 32
      Width = 81
      Height = 19
      LabelDefs.Width = 30
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Valor: '
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      OnKeyDown = edBuscaKeyDown
      TabOrder = 1
    end
    object FlatButton1: TFlatButton
      Left = 224
      Top = 28
      Width = 30
      Height = 25
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
      TabOrder = 2
      OnClick = FlatButton1Click
    end
  end
  object cbCaixas: TadLabelComboBox
    Left = 293
    Top = 19
    Width = 129
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 5
    LabelDefs.Width = 29
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Caixa:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 136
    Top = 208
  end
  object tb: TADOTable
    Left = 174
    Top = 208
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 216
    Top = 209
    object Alteramodalidadedepagamento1: TMenuItem
      Caption = 'Altera modalidade de pagamento'
      OnClick = Alteramodalidadedepagamento1Click
    end
    object Inseremodalidadepagamento1: TMenuItem
      Caption = 'Insere modalidade pagamento'
      OnClick = chamaInsereModalidadePagamento1Click
    end
    object RemoveModalidaDedePagamento1: TMenuItem
      Caption = 'Remove modalidade de pagamento'
      OnClick = RemoveModalidaDedePagamento1Click
    end
    object EF1: TMenuItem
      Caption = 'TEF'
      object ConsultaroMAC1: TMenuItem
        Caption = 'Consultar o MAC de uma opera'#231#227'o TEF'
        OnClick = ConsultaroMAC1Click
      end
      object RemoveregistrodeTEF1: TMenuItem
        Caption = 'Remove registro de TEF'
        OnClick = chamaRemoveRegistroDeTEF1Click
      end
      object ConsultaMACdeoperaoTEFcomNU1: TMenuItem
        Caption = 'Consulta MAC de opera'#231#227'o TEF com NSU'
        OnClick = ConsultaMACdeoperaoTEFcomNU1Click
      end
    end
  end
end
