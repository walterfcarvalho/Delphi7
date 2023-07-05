object fmSelColImport: TfmSelColImport
  Left = 316
  Top = 182
  Width = 730
  Height = 386
  Caption = 
    'Informe os campos correspondente ao c'#243'digo e a quantidade deseja' +
    'da:'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object SoftDBGrid1: TSoftDBGrid
    Left = 0
    Top = 0
    Width = 714
    Height = 281
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object Panel1: TPanel
    Left = 0
    Top = 297
    Width = 714
    Height = 50
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      714
      50)
    object btCancela: TfsBitBtn
      Left = 636
      Top = 10
      Width = 74
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      TabOrder = 0
      Kind = bkCancel
    end
    object btOk: TfsBitBtn
      Left = 558
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      TabOrder = 1
      OnClick = btOkClick
      Kind = bkOK
    end
    object cbCod: TadLabelComboBox
      Left = 5
      Top = 20
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
      TabOrder = 2
      LabelDefs.Width = 72
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Coluna C'#243'digo:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object cbQt: TadLabelComboBox
      Left = 181
      Top = 20
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
      TabOrder = 3
      LabelDefs.Width = 92
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Coluna quantidade:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 96
    Top = 16
  end
  object tb: TADOTable
    Connection = dm.con
    Left = 144
    Top = 16
  end
end
