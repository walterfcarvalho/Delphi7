object fmDirDialog: TfmDirDialog
  Left = 362
  Top = 180
  Width = 599
  Height = 394
  Caption = 'Localize o diret'#243'rio que deseja pegar os arquivos:'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  DesignSize = (
    583
    356)
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 152
    Width = 583
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object lbArquivos: TFileListBox
    Left = 0
    Top = 155
    Width = 583
    Height = 165
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelInner = bvNone
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 583
    Height = 152
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 1
    DesignSize = (
      583
      152)
    object Label1: TLabel
      Left = 3
      Top = 2
      Width = 39
      Height = 13
      Caption = 'Diret'#243'rio'
    end
    object cbUnidades: TDriveComboBox
      Left = 3
      Top = 17
      Width = 578
      Height = 19
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvNone
      BevelKind = bkFlat
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 0
      OnChange = cbUnidadesChange
    end
    object lbDiretorios: TDirectoryListBox
      Left = 3
      Top = 39
      Width = 576
      Height = 107
      Anchors = [akLeft, akTop, akRight]
      Ctl3D = False
      ItemHeight = 16
      ParentCtl3D = False
      TabOrder = 1
      OnChange = lbDiretoriosChange
    end
  end
  object fsBitBtn1: TfsBitBtn
    Left = 518
    Top = 322
    Width = 62
    Height = 29
    Anchors = [akRight, akBottom]
    TabOrder = 2
    Kind = bkOK
  end
end
