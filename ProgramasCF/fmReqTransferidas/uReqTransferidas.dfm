object fmReqTransferidas: TfmReqTransferidas
  Left = 596
  Top = 329
  Width = 711
  Height = 279
  BorderIcons = [biSystemMenu]
  Caption = 'Requisi'#231#245'es transferidas'
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
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TSoftDBGrid
    Left = 0
    Top = 0
    Width = 695
    Height = 240
    Align = alClient
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnColumnMoved = gridColumnMoved
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object DataSource1: TDataSource
    Left = 376
    Top = 141
  end
end
