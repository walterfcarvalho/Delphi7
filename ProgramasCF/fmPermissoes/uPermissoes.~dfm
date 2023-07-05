object fmPermissoes: TfmPermissoes
  Left = 444
  Top = 128
  Width = 698
  Height = 575
  Caption = 'Controle de permiss'#245'es'
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
  object grid: TSoftDBGrid
    Left = 297
    Top = 0
    Width = 385
    Height = 519
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = gridCellClick
    OnDrawColumnCell = gridDrawColumnCell
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 297
    Height = 537
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 0
      Top = 305
      Width = 297
      Height = 5
      Cursor = crVSplit
      Align = alTop
      Beveled = True
      MinSize = 3
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 297
      Height = 305
      Align = alTop
      Caption = 'Panel2'
      TabOrder = 0
      object Label1: TLabel
        Left = 1
        Top = 1
        Width = 295
        Height = 13
        Align = alTop
        Caption = 'Telas do sistema'
      end
      object Tree: TTreeView
        Left = 1
        Top = 14
        Width = 295
        Height = 290
        Align = alClient
        AutoExpand = True
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Indent = 19
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 0
        OnClick = TreeClick
      end
      object cbTpPerm: TfsCheckBox
        Left = 95
        Top = 1
        Width = 141
        Height = 13
        Caption = 'Permiss'#245'es por usu'#225'rio.'
        TabOrder = 1
        OnClick = cbTpPermClick
        FlatFont.Charset = DEFAULT_CHARSET
        FlatFont.Color = clWindowText
        FlatFont.Height = -11
        FlatFont.Name = 'MS Sans Serif'
        FlatFont.Style = []
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 310
      Width = 297
      Height = 227
      Align = alClient
      Caption = 'Panel3'
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 1
        Top = 1
        Width = 295
        Height = 225
        Align = alClient
        Caption = 'Consultar o grupo '
        TabOrder = 0
        DesignSize = (
          295
          225)
        object edUser: TadLabelEdit
          Left = 85
          Top = 16
          Width = 154
          Height = 19
          LabelDefs.Width = 80
          LabelDefs.Height = 13
          LabelDefs.Caption = 'Nome do usu'#225'rio'
          LabelPosition = adLeft
          Colors.WhenEnterFocus.BackColor = clInfoBk
          Ctl3D = False
          ParentCtl3D = False
          TabOrder = 0
        end
        object btIncluiXML: TfsBitBtn
          Left = 243
          Top = 16
          Width = 26
          Height = 20
          Default = True
          TabOrder = 1
          OnClick = btIncluiXMLClick
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
          NumGlyphs = 2
        end
        object SoftDBGrid1: TSoftDBGrid
          Left = 4
          Top = 40
          Width = 286
          Height = 182
          Anchors = [akLeft, akTop, akRight, akBottom]
          Ctl3D = False
          DataSource = dsuser
          ParentCtl3D = False
          PopupMenu = PopupMenu1
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDrawColumnCell = gridDrawColumnCell
          AlternateColor = True
          ColorLow = clInfoBk
          ColorHigh = 15790322
        end
      end
    end
  end
  object tb: TADOTable
    Left = 336
    Top = 72
  end
  object DataSource1: TDataSource
    DataSet = tb
    Left = 376
    Top = 72
  end
  object dsuser: TDataSource
    Left = 87
    Top = 389
  end
  object PopupMenu1: TPopupMenu
    Left = 49
    Top = 391
    object Inserirpermissodousurio1: TMenuItem
      Caption = 'Inserir permiss'#227'o do usu'#225'rio'
      OnClick = Inserirpermissodousurio1Click
    end
    object Desativaresseusurio1: TMenuItem
      Caption = 'Desativar esse usu'#225'rio'
      OnClick = Desativaresseusurio1Click
    end
  end
end
