object fmCredCliente: TfmCredCliente
  Left = 359
  Top = 135
  Width = 780
  Height = 580
  Caption = 'fmCredCliente'
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
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object rg2: TRadioGroup
    Left = 0
    Top = 309
    Width = 750
    Height = 223
    Caption = ' Baixas do cr'#233'dito '
    TabOrder = 4
  end
  object rg1: TRadioGroup
    Left = 0
    Top = 89
    Width = 750
    Height = 192
    Caption = ' Cr'#233'ditos concedidos:'
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 764
    Height = 80
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label2: TLabel
      Left = 5
      Top = 30
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
    object lbCriador: TLabel
      Left = 55
      Top = 30
      Width = 15
      Height = 13
      Caption = '-----'
    end
    object Label1: TLabel
      Left = 213
      Top = 21
      Width = 44
      Height = 13
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbNm_pes: TLabel
      Left = 263
      Top = 21
      Width = 15
      Height = 13
      Caption = '-----'
    end
    object lbcd_pes: TLabel
      Left = 213
      Top = 38
      Width = 57
      Height = 13
      Caption = '--------------'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label3: TLabel
      Left = 211
      Top = 51
      Width = 77
      Height = 13
      Caption = 'Valor cr'#233'dito:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbVlCredito: TLabel
      Left = 297
      Top = 51
      Width = 15
      Height = 13
      Caption = '-----'
    end
    object edCodCli: TadLabelEdit
      Left = 4
      Top = 18
      Width = 156
      Height = 26
      LabelDefs.Width = 35
      LabelDefs.Height = 13
      LabelDefs.Caption = '&Cliente:'
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
    end
    object FlatButton7: TFlatButton
      Left = 163
      Top = 20
      Width = 22
      Height = 21
      Caption = '...'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Layout = blGlyphLeft
      ParentFont = False
      TabOrder = 1
      OnClick = FlatButton7Click
    end
    object btConsulta: TFlatButton
      Left = 5
      Top = 51
      Width = 155
      Height = 23
      Caption = 'Consultar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Layout = blGlyphLeft
      ParentFont = False
      TabOrder = 2
      OnClick = btConsultaClick
    end
  end
  object gdAdi: TSoftDBGrid
    Left = 5
    Top = 102
    Width = 737
    Height = 173
    Ctl3D = False
    DataSource = dsadi
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = gdAdiCellClick
    OnDblClick = gdAdiDblClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object gdBaixas: TSoftDBGrid
    Left = 5
    Top = 322
    Width = 737
    Height = 204
    Ctl3D = False
    DataSource = dsBaixas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = gdBaixasDblClick
    AlternateColor = False
    ColorLow = clHighlightText
    ColorHigh = clWindow
  end
  object dsadi: TDataSource
    Left = 96
    Top = 112
  end
  object dsBaixas: TDataSource
    Left = 104
    Top = 344
  end
  object PopupMenu1: TPopupMenu
    Left = 160
    Top = 344
    object Inserirbaixadecrdito1: TMenuItem
      Caption = 'Inserir baixa de cr'#233'dito'
    end
  end
end
