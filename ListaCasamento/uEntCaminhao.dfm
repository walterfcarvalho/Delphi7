object fmEntCaminhao: TfmEntCaminhao
  Left = 360
  Top = 196
  Width = 608
  Height = 406
  Caption = 'Itens para entrega no caminh'#227'o.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 592
    Height = 303
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object grid: TSoftDBGrid
      Left = 1
      Top = 1
      Width = 590
      Height = 301
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnCellClick = gridCellClick
      OnDrawColumnCell = gridDrawColumnCell
      AlternateColor = True
      ColorLow = clWindow
      ColorHigh = clInfoBk
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 303
    Width = 592
    Height = 64
    Align = alBottom
    TabOrder = 1
    object cbIsEntrega: TfsCheckBox
      Left = 3
      Top = 3
      Width = 139
      Height = 17
      Caption = 'Marcar/desmarcar todos'
      TabOrder = 0
      OnClick = cbIsEntregaClick
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object edMotorista: TadLabelEdit
      Left = 48
      Top = 25
      Width = 237
      Height = 19
      LabelDefs.Width = 43
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Motorista'
      LabelPosition = adLeft
      Ctl3D = False
      ParentCtl3D = False
      MaxLength = 40
      TabOrder = 1
    end
    object btComprador: TFlatButton
      Left = 329
      Top = 15
      Width = 109
      Height = 26
      Caption = '&Imprimir'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDDD7777777777DDDDD0000DDDD
        000000000007DDDD0000DDD07878787870707DDD0000DD0000000000000707DD
        0000DD0F8F8F8AAA8F0007DD0000DD08F8F8F999F80707DD0000DD0000000000
        0008707D0000DD08F8F8F8F8F080807D0000DDD0000000000F08007D0000DDDD
        0BFFFBFFF0F080DD0000DDDDD0F00000F0000DDD0000DDDDD0FBFFFBFF0DDDDD
        0000DDDDDD0F00000F0DDDDD0000DDDDDD0FFBFFFBF0DDDD0000DDDDDDD00000
        0000DDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDD
        DDDDDDDDDDDDDDDD0000}
      Layout = blGlyphLeft
      TabOrder = 2
      OnClick = btCompradorClick
    end
    object FlatButton1: TFlatButton
      Left = 460
      Top = 15
      Width = 109
      Height = 26
      Caption = 'Confirmar'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 3
      OnClick = FlatButton1Click
    end
  end
  object tb: TADOTable
    Connection = dm.con
    Left = 24
    Top = 72
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 64
    Top = 80
  end
  object tbDestImpr: TADOTable
    Connection = dm.con
    Left = 24
    Top = 112
  end
end
