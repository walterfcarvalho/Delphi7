object fmAjCidades: TfmAjCidades
  Left = 333
  Top = 112
  Width = 716
  Height = 600
  Caption = 'Ajustar cadastro de cidade'
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
  PixelsPerInch = 96
  TextHeight = 13
  object fnGrid: TSoftDBGrid
    Left = 0
    Top = 63
    Width = 700
    Height = 200
    Align = alTop
    Ctl3D = False
    DataSource = dsCid
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWhite
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 700
    Height = 63
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 4
      Width = 200
      Height = 13
      Caption = 'Selecionar a cidade a ser alterada:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btCidEnt: TfsBitBtn
      Left = 414
      Top = 34
      Width = 27
      Height = 22
      Caption = '...'
      TabOrder = 0
      OnClick = btCidEntClick
      NumGlyphs = 2
    end
    object edCidEnt: TadLabelEdit
      Left = 71
      Top = 36
      Width = 338
      Height = 19
      LabelDefs.Width = 36
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Cidade:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object edUF: TadLabelEdit
      Left = 7
      Top = 36
      Width = 32
      Height = 19
      LabelDefs.Width = 17
      LabelDefs.Height = 13
      LabelDefs.Caption = 'UF:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object btUf: TfsBitBtn
      Left = 41
      Top = 34
      Width = 27
      Height = 22
      Caption = '...'
      TabOrder = 3
      OnClick = btUfClick
      NumGlyphs = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 263
    Width = 700
    Height = 73
    Align = alTop
    TabOrder = 2
    DesignSize = (
      700
      73)
    object Label2: TLabel
      Left = 7
      Top = 8
      Width = 162
      Height = 13
      Caption = 'Selecionar a cidade correta:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btCidSai: TfsBitBtn
      Left = 413
      Top = 44
      Width = 27
      Height = 22
      Caption = '...'
      TabOrder = 0
      OnClick = btCidSaiClick
      NumGlyphs = 2
    end
    object edcidSai: TadLabelEdit
      Left = 74
      Top = 46
      Width = 338
      Height = 19
      LabelDefs.Width = 36
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Cidade:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object fsBitBtn3: TfsBitBtn
      Left = 558
      Top = 38
      Width = 91
      Height = 29
      Anchors = [akRight]
      Caption = 'Alterar'
      TabOrder = 2
      OnClick = fsBitBtn3Click
      Kind = bkOK
    end
    object edUfNova: TadLabelEdit
      Left = 7
      Top = 46
      Width = 32
      Height = 19
      LabelDefs.Width = 17
      LabelDefs.Height = 13
      LabelDefs.Caption = 'UF:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object btUfNova: TfsBitBtn
      Left = 41
      Top = 44
      Width = 27
      Height = 22
      Caption = '...'
      TabOrder = 4
      OnClick = btUfNovaClick
      NumGlyphs = 2
    end
  end
  object grCidDest: TSoftDBGrid
    Left = 0
    Top = 336
    Width = 700
    Height = 200
    Align = alTop
    Ctl3D = False
    DataSource = dsCidDest
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    ParentCtl3D = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWhite
  end
  object dsCid: TDataSource
    Left = 96
    Top = 56
  end
  object dsCidDest: TDataSource
    Left = 88
    Top = 344
  end
end
