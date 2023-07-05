object fmFornACriticar: TfmFornACriticar
  Left = 320
  Top = 269
  Width = 794
  Height = 654
  Caption = 'Fornecedores  que criticam quant de caixa requisi'#231#245'es'
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
  DesignSize = (
    778
    616)
  PixelsPerInch = 96
  TextHeight = 13
  object fsBitBtn1: TfsBitBtn
    Left = 416
    Top = 9
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Adicionar'
    TabOrder = 0
    OnClick = fsBitBtn1Click
  end
  object fsBitBtn2: TfsBitBtn
    Left = 416
    Top = 41
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = '&Remover'
    TabOrder = 1
    OnClick = fsBitBtn2Click
  end
  object grid: TSoftDBGrid
    Left = 8
    Top = 8
    Width = 401
    Height = 385
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = gridTitleClick
    AlternateColor = False
    ColorLow = 933522
    ColorHigh = 15790322
  end
  object tb: TADOTable
    Connection = dm.con
    Left = 96
    Top = 64
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 128
    Top = 64
  end
end
