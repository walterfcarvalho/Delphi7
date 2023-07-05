object fmEtiquetas: TfmEtiquetas
  Left = 438
  Top = 129
  Width = 776
  Height = 571
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 482
    Width = 760
    Height = 51
    Align = alBottom
    TabOrder = 0
    object FlatButton1: TFlatButton
      Left = 3
      Top = 13
      Width = 103
      Height = 25
      Caption = '&Imprimir'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF40
        4040606060606060FFFFFF404040202020FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF202020606060202020505050303030202020606060AFAFAF5F5F
        5F202020FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF202020404040AFAFAF40404060
        60606060606060609F9F9FEFEFEFEFEFEF5F5F5F202020FFFFFFFFFFFFFFFFFF
        202020404040808080DFDFDF404040AFAFAF6F6F6F606060DFDFDFEFEFEFEFEF
        EFEFEFEF5F5F5FFFFFFFFFFFFF2020204040408080808080809F9F9F7F7F7F7F
        7F7FBFBFBF9F9F9FDFDFDFEFEFEFEFEFEFCFCFCFFFFFFF000000FFFFFF000000
        8080808080809090909F9F9F000000BFBFBF808080DFDFDFBFBFBFDFDFDFCFCF
        CFFFFFFF3F3F3FFFFFFFFFFFFF000000808080808080CFCFCFB0B0B070707000
        0000202020BFBFBFDFDFDFBFBFBFDFDFDF5F5F5F404040FFFFFFFFFFFF000000
        808080BFBFBFEFEFEFAFAFAFA0A0A0707070000000202020A0A0A0BFBFBF3F3F
        3F7F7F7F404040202020FFFFFF000000808080EFEFEFDFDFDFDFDFDFAFAFAFA0
        A0A0707070000000202020202020AFAFAF505050202020FFFFFFFFFFFFFFFFFF
        4040409FBFBFDFDFDFDFDFDFDFDFDFAFAFAFA0A0A0707070000000AFAFAF5050
        50202020FFFFFFFFFFFFFFFFFFFFFFFF2020207090909FBFBFDFDFDFDFDFDFDF
        DFDFAFAFAFA0A0A0505050606060000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF3030307090909FBFBFDFDFDFDFDFDFDFDFDFAFAFAF6060607070700000
        00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3030307090909FBFBFDF
        DFDFDFDFDFDFDFDF7F7F7F303030FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFF3030307090909FBFBFDFDFDFDFDFDF303030FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF20202020
        20208F8F8F303030FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphLeft
      TabOrder = 0
      OnClick = FlatButton1Click
    end
    object cbTIpoImpressao: TadLabelComboBox
      Left = 117
      Top = 17
      Width = 172
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      DropDownCount = 15
      ItemHeight = 13
      ParentBiDiMode = False
      TabOrder = 1
      TabStop = False
      OnChange = cbTIpoImpressaoChange
      Items.Strings = (
        
          'Itens - Argox                         '#9'                   '#9'     ' +
          '                              |0'
        
          'Gondola - Argox                                                 ' +
          '                            '#9'   |2'
        
          'Gondola - Zebra                                                 ' +
          '                          '#9'     |4'
        
          'Gondola - Atacado Argox                         '#9'               ' +
          '                              |5'
        
          'Gondola - Atacarejo Argox                                       ' +
          '                                                   |7')
      LabelDefs.Width = 62
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Tipo etiqueta'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object EdLocalImp: TadLabelEdit
      Left = 497
      Top = 19
      Width = 251
      Height = 19
      TabStop = False
      LabelDefs.Width = 153
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Local para impress'#227'o do arquivo'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Colors.WhenExitFocus.BackColor = clMenu
      Ctl3D = False
      ParentCtl3D = False
      Color = clMenu
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object cbImpPc: TfsCheckBox
      Left = 292
      Top = 20
      Width = 100
      Height = 16
      TabStop = False
      Caption = 'Imprimir o pre'#231'o'
      Checked = True
      State = cbChecked
      TabOrder = 3
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  object gridItem: TSoftDBGrid
    Left = 0
    Top = 158
    Width = 257
    Height = 324
    TabStop = False
    Align = alLeft
    Ctl3D = False
    DataSource = DsEtq
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = gridItemDblClick
    AlternateColor = False
    ColorLow = 14936544
    ColorHigh = 15790322
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 760
    Height = 158
    Align = alTop
    Caption = 'Panel2'
    TabOrder = 2
    DesignSize = (
      760
      158)
    object lbItensaSeemImpressos: TLabel
      Left = 6
      Top = 141
      Width = 112
      Height = 13
      Caption = 'Itens a serem impressos'
    end
    object lbTitLstProds: TLabel
      Left = 309
      Top = 1
      Width = 313
      Height = 13
      Caption = 
        'C'#243'digos de barras para o produto (duplo clique para ver a imagem' +
        ')'
    end
    object EdCodigo: TadLabelEdit
      Left = 170
      Top = 16
      Width = 135
      Height = 22
      LabelDefs.Width = 33
      LabelDefs.Height = 13
      LabelDefs.Caption = '&Codigo'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 13
      ParentFont = False
      TabOrder = 0
      OnKeyPress = EdCodigoKeyPress
    end
    object DBGrid: TSoftDBGrid
      Left = 307
      Top = 16
      Width = 473
      Height = 138
      TabStop = False
      Anchors = [akLeft, akTop, akRight]
      Ctl3D = False
      DataSource = dsEan
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      TabOrder = 7
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DBGridDblClick
      AlternateColor = False
      ColorLow = clInfoBk
      ColorHigh = 15790322
    end
    object btConsulta: TFlatButton
      Left = 170
      Top = 44
      Width = 135
      Height = 25
      Caption = '&Consultar'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33033333333333333F7F3333333333333000333333333333F777333333333333
        000333333333333F777333333333333000333333333333F77733333333333300
        033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
        33333377333777733333307F8F8F7033333337F333F337F3333377F88F88F773
        3333373337F3373F3333078FF8F8870333337F33F7FFF37F333307F87F8FF703
        33337F377777337F3333078F87F88703333373F337F33373333377F7F8F8F773
        333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
        333333773FF77333333333370007333333333333777333333333}
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabStop = True
      TabOrder = 1
      OnClick = btConsultaClick
    end
    object btAddItemParaImp: TFlatButton
      Left = 171
      Top = 116
      Width = 133
      Height = 25
      Caption = '&Adiciona a lista.'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        33333333FF33333333FF333993333333300033377F3333333777333993333333
        300033F77FFF3333377739999993333333333777777F3333333F399999933333
        33003777777333333377333993333333330033377F3333333377333993333333
        3333333773333333333F333333333333330033333333F33333773333333C3333
        330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
        993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
        333333333337733333FF3333333C333330003333333733333777333333333333
        3000333333333333377733333333333333333333333333333333}
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabStop = True
      TabOrder = 4
      OnClick = btAddItemParaImpClick
    end
    object cbPrecos: TadLabelComboBox
      Left = 7
      Top = 88
      Width = 153
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      DropDownCount = 15
      ItemHeight = 13
      ParentBiDiMode = False
      TabOrder = 5
      LabelDefs.Width = 76
      LabelDefs.Height = 13
      LabelDefs.Caption = '&Pre'#231'o de venda'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object cbLojas: TadLabelComboBox
      Left = 5
      Top = 18
      Width = 157
      Height = 21
      BevelInner = bvLowered
      BevelKind = bkSoft
      BevelOuter = bvNone
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      DropDownCount = 15
      ItemHeight = 13
      ParentBiDiMode = False
      TabOrder = 6
      LabelDefs.Width = 23
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object edQuant: TadLabelEdit
      Left = 170
      Top = 88
      Width = 65
      Height = 22
      LabelDefs.Width = 55
      LabelDefs.Height = 13
      LabelDefs.Caption = '&Quantidade'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 13
      ParentFont = False
      TabOrder = 2
      OnKeyPress = edQuantKeyPress
    end
    object edQtMin: TadLabelEdit
      Left = 250
      Top = 88
      Width = 54
      Height = 22
      LabelDefs.Width = 46
      LabelDefs.Height = 13
      LabelDefs.Caption = '&Qt minima'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      MaxLength = 13
      ParentFont = False
      TabOrder = 3
      Visible = False
      OnKeyPress = edQuantKeyPress
    end
  end
  object Panel3: TPanel
    Left = 564
    Top = 158
    Width = 196
    Height = 324
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 3
    object LbDescricao: TLabel
      Left = -104
      Top = 169
      Width = 60
      Height = 13
      Caption = 'LbDescricao'
    end
    object lbDescImgProd: TLabel
      Left = 6
      Top = 16
      Width = 72
      Height = 13
      Caption = 'lbDescImgProd'
    end
    object StaticText1: TStaticText
      Left = 83
      Top = 1
      Width = 52
      Height = 17
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object pnImage: TPanel
      Left = 3
      Top = 35
      Width = 190
      Height = 129
      TabOrder = 1
      object Image1: TImage
        Left = 1
        Top = 1
        Width = 148
        Height = 103
        Stretch = True
      end
    end
  end
  object dsEan: TDataSource
    Left = 408
    Top = 38
  end
  object DsEtq: TDataSource
    DataSet = tb
    Left = 120
    Top = 302
  end
  object tb: TADOTable
    Connection = dm.con
    Left = 160
    Top = 304
  end
end
