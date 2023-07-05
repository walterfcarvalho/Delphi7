object fmRelCredCli: TfmRelCredCli
  Left = 189
  Top = 116
  Width = 779
  Height = 513
  Caption = 'Lista cr'#233'ditos em aberto'
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
  PixelsPerInch = 96
  TextHeight = 13
  object pnParam: TPanel
    Left = 0
    Top = 0
    Width = 763
    Height = 104
    Align = alTop
    TabOrder = 0
    object cbLojas: TadLabelComboBox
      Left = 7
      Top = 38
      Width = 167
      Height = 21
      AutoDropDown = True
      BevelInner = bvNone
      BevelKind = bkSoft
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      LabelDefs.Width = 20
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object btOk: TFlatButton
      Left = 561
      Top = 35
      Width = 80
      Height = 26
      Caption = '&OK'
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
      TabOrder = 1
      ModalResult = 1
      OnClick = btOkClick
    end
    object GroupBox1: TGroupBox
      Left = 188
      Top = 17
      Width = 154
      Height = 56
      Caption = '  Data inicial   '
      TabOrder = 2
      object di: TfsDateTimePicker
        Left = 20
        Top = 20
        Width = 102
        Height = 21
        Date = 40842.672702233790000000
        Time = 40842.672702233790000000
        TabOrder = 0
      end
    end
    object edValor: TadLabelNumericEdit
      Left = 362
      Top = 39
      Width = 130
      Height = 19
      LabelDefs.Width = 80
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Saldo a partir de:'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
    end
    object FlatButton1: TFlatButton
      Left = 663
      Top = 35
      Width = 79
      Height = 26
      Caption = '&imprime'
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
      TabOrder = 4
      ModalResult = 1
      OnClick = FlatButton1Click
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 104
    Width = 763
    Height = 359
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 1
    DesignSize = (
      763
      359)
    object rg1: TRadioGroup
      Left = 0
      Top = 0
      Width = 763
      Height = 359
      Align = alClient
      Caption = ' Cr'#233'ditos concedidos:'
      TabOrder = 0
    end
    object SoftDBGrid1: TSoftDBGrid
      Left = 5
      Top = 14
      Width = 751
      Height = 340
      Anchors = [akLeft, akTop, akRight, akBottom]
      Ctl3D = False
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = SoftDBGrid1DblClick
      OnTitleClick = SoftDBGrid1TitleClick
      AlternateColor = True
      ColorLow = clWindow
      ColorHigh = clInfoBk
    end
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 152
    Top = 184
  end
  object tb: TADOTable
    Connection = dm.con
    Left = 192
    Top = 176
  end
end
