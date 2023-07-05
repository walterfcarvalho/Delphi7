object fmDadosAdTotvs: TfmDadosAdTotvs
  Left = 324
  Top = 209
  Width = 826
  Height = 480
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'fmDadosAdTotvs'
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
  DesignSize = (
    810
    442)
  PixelsPerInch = 96
  TextHeight = 13
  object edCod: TadLabelEdit
    Left = 9
    Top = 22
    Width = 146
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
    OnKeyDown = edCodKeyDown
  end
  object edDesc: TadLabelEdit
    Left = 157
    Top = 22
    Width = 346
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
    OnKeyDown = edDescKeyDown
  end
  object btConsulta: TFlatButton
    Left = 508
    Top = 21
    Width = 74
    Height = 27
    Caption = '&Listar'
    TabOrder = 2
    OnClick = btConsultaClick
  end
  object gridItens: TSoftDBGrid
    Left = 8
    Top = 52
    Width = 622
    Height = 291
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = gridItensTitleClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object tb: TADOTable
    AutoCalcFields = False
    Connection = dm.con
    AfterPost = tbAfterPost
    Left = 168
    Top = 64
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 128
    Top = 64
  end
end
