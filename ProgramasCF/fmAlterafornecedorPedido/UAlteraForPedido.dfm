object fmAlteraPedForn: TfmAlteraPedForn
  Left = 358
  Top = 85
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsNone
  Caption = 'Altera loja do pedido de compra'
  ClientHeight = 509
  ClientWidth = 715
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
  OnShow = FormShow
  DesignSize = (
    715
    509)
  PixelsPerInch = 96
  TextHeight = 13
  object btConsPedForn: TFlatButton
    Left = 155
    Top = 16
    Width = 95
    Height = 21
    Caption = '&Localizar'
    TabOrder = 0
    OnClick = btConsPedFornClick
  end
  object Edit1: TadLabelEdit
    Left = 4
    Top = 17
    Width = 145
    Height = 19
    LabelDefs.Width = 36
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pedido:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
  end
  object DBGrid: TSoftDBGrid
    Left = 5
    Top = 41
    Width = 693
    Height = 88
    Ctl3D = False
    DataSource = DataSource1
    Enabled = False
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object cb2: TadLabelComboBox
    Left = 5
    Top = 145
    Width = 164
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    Enabled = False
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 3
    LabelDefs.Width = 23
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object FlatButton2: TFlatButton
    Left = 603
    Top = 261
    Width = 95
    Height = 21
    Caption = '&Alterar'
    TabOrder = 4
    OnClick = FlatButton2Click
  end
  object cbComprador: TadLabelComboBox
    Left = 192
    Top = 146
    Width = 164
    Height = 21
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvNone
    Style = csDropDownList
    BiDiMode = bdRightToLeft
    DropDownCount = 15
    Enabled = False
    ItemHeight = 13
    ParentBiDiMode = False
    TabOrder = 5
    LabelDefs.Width = 54
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Comprador:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object gridParcelas: TSoftDBGrid
    Left = 382
    Top = 145
    Width = 317
    Height = 88
    Ctl3D = False
    DataSource = DataSource2
    Enabled = False
    Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = False
    ColorLow = clInfoBk
    ColorHigh = 15790322
  end
  object gridItens: TSoftDBGrid
    Left = 5
    Top = 313
    Width = 692
    Height = 160
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = dsItens
    Enabled = False
    ParentCtl3D = False
    TabOrder = 7
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = gridItensDblClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object Query1: TADOQuery
    Connection = dm.con
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select '
      'tbuo.ds_uo, dspes.nm_pes, dspdf.vl_total from dspdf'
      'inner join tbuo  on dspdf.is_uoCompra = tbuo.is_uo'
      'inner join dspes on dspdf.cd_pes = dspes.cd_pes'
      'where dspdf.is_pedf = 000')
    Left = 216
    Top = 48
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 249
    Top = 48
  end
  object tbParc: TADOTable
    Connection = dm.con
    Left = 144
    Top = 224
  end
  object DataSource2: TDataSource
    DataSet = tbParc
    Left = 177
    Top = 224
  end
  object dsItens: TDataSource
    DataSet = tbParc
    Left = 144
    Top = 322
  end
end
