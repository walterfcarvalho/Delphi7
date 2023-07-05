object fmAjustaSerie: TfmAjustaSerie
  Left = 385
  Top = 215
  Width = 582
  Height = 335
  Caption = 'fmAjustaSerie'
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
  PixelsPerInch = 96
  TextHeight = 13
  object cbLoja: TadLabelComboBox
    Left = 13
    Top = 30
    Width = 164
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    Ctl3D = True
    DropDownCount = 15
    ItemHeight = 13
    ParentBiDiMode = False
    ParentCtl3D = False
    TabOrder = 0
    OnChange = cbLojaChange
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object Panel1: TPanel
    Left = 181
    Top = -1
    Width = 284
    Height = 129
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object cbTipoSerie: TadLabelComboBox
      Left = 12
      Top = 30
      Width = 164
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      Ctl3D = True
      DropDownCount = 15
      ItemHeight = 13
      ParentBiDiMode = False
      ParentCtl3D = False
      TabOrder = 0
      Items.Strings = (
        'Normal'
        'SCAN')
      LabelDefs.Width = 30
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Status'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object btOk: TFlatButton
      Left = 211
      Top = 94
      Width = 50
      Height = 26
      Glyph.Data = {
        96010000424D9601000000000000760000002800000018000000180000000100
        04000000000020010000C40E0000C40E00001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
        D11DDDDDDDDDD11DDDDDDDDD1991DDDDDDDD1991DDDDDDD199991DDDDDD19999
        1DDDDDD1999991DDDD1999991DDDDDDD1999991DD1999991DDDDDDDDD1999991
        1999991DDDDDDDDDDD199999999991DDDDDDDDDDDDD1999999991DDDDDDDDDDD
        DDDD19999991DDDDDDDDDDDDDDDD19999991DDDDDDDDDDDDDDD1999999991DDD
        DDDDDDDDDD199990999991DDDDDDDDDDD19999911999991DDDDDDDDD1999991D
        D1999991DDDDDDD1999991DDDD1999991DDDDDD199991DDDDDD199991DDDDDDD
        1991DDDDDDDD1991DDDDDDDDD11DDDDDDDDDD11DDDDDDDDDDDDDDDDDDDDDDDDD
        DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD}
      Layout = blGlyphLeft
      TabOrder = 1
      OnClick = btOkClick
    end
    object FlatButton1: TFlatButton
      Left = 155
      Top = 94
      Width = 50
      Height = 26
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
      TabOrder = 2
      OnClick = FlatButton1Click
    end
    object ckTAlteraTodas: TfsCheckBox
      Left = 14
      Top = 100
      Width = 133
      Height = 16
      Caption = 'Altere todas as lojas.'
      TabOrder = 3
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
end
