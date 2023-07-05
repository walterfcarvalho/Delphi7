object Form4: TForm4
  Left = 352
  Top = 129
  BiDiMode = bdLeftToRight
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 354
  ClientWidth = 695
  Color = clBtnFace
  ParentFont = True
  KeyPreview = True
  OldCreateOrder = False
  ParentBiDiMode = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  DesignSize = (
    695
    354)
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TadLabelEdit
    Left = 1
    Top = 18
    Width = 308
    Height = 19
    LabelDefs.Width = 31
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Nome '
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    CharCase = ecUpperCase
    MaxLength = 40
    TabOrder = 0
    OnKeyDown = Edit1KeyDown
  end
  object cbox1: TadLabelComboBox
    Left = 1
    Top = 334
    Width = 117
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 1
    Text = 'N'#227'o comprados'
    Visible = False
    Items.Strings = (
      'N'#227'o comprados'
      'Todos'
      'Somente Comprados')
    LabelDefs.Width = 74
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Imprimir os itens'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object BitBtn1: TFlatButton
    Left = 603
    Top = 14
    Width = 88
    Height = 25
    Default = True
    Caption = '&Procurar'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33033333333333333F7F3333333333333000333333333333F777333333333333
      000333333333333F777333333333333000333333333333F77733333333333300
      033333333FFF3F777333333700073B703333333F7773F77733333307777700B3
      33333377333777733333307F8F8F7033333337F333F337F3333377F8F9F8F773
      3333373337F3373F3333078F898F870333337F33F7FFF37F333307F99999F703
      33337F377777337F3333078F898F8703333373F337F33373333377F8F9F8F773
      333337F3373337F33333307F8F8F70333333373FF333F7333333330777770333
      333333773FF77333333333370007333333333333777333333333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TFlatButton
    Left = 532
    Top = 318
    Width = 75
    Height = 29
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
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object btCancela: TFlatButton
    Left = 614
    Top = 318
    Width = 75
    Height = 29
    Caption = '&Cancelar'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 4
    OnClick = btCancelaClick
  end
  object CB1: TadLabelComboBox
    Left = 458
    Top = 17
    Width = 141
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 5
    LabelDefs.Width = 57
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Tipo de lista'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object DBGrid1: TSoftDBGrid
    Left = 0
    Top = 44
    Width = 690
    Height = 268
    Anchors = [akLeft, akTop, akBottom]
    Ctl3D = False
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    OnDblClick = DBGrid1DblClick
    OnTitleClick = DBGrid1TitleClick
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
    Columns = <
      item
        Expanded = False
        FieldName = 'NumLista'
        Title.Caption = 'N'#250'mero'
        Width = 48
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        Width = 134
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'noiva'
        Title.Caption = 'Noiva'
        Width = 195
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'noivo'
        Title.Caption = 'Noivo'
        Width = 231
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Loja'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EndEntrega'
        Title.Caption = 'Endere'#231'o de entrega'
        Width = 180
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dataCasamento'
        ImeName = 'DataCasamento'
        Title.Caption = 'Data evento'
        Width = 81
        Visible = True
      end>
  end
  object cbBuscaNum: TfsCheckBox
    Left = 317
    Top = 19
    Width = 132
    Height = 17
    Caption = 'Procure pelo n'#250'mero'
    TabOrder = 7
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object DataSource1: TDataSource
    DataSet = QueryImpressao
    Left = 19
    Top = 125
  end
  object qrCorpo: TADOQuery
    Connection = dm.con
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from PRODUTOS where numlista =7')
    Left = 16
    Top = 192
  end
  object qrCabeca: TADOQuery
    Connection = dm.con
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from listas where numlista =7')
    Left = 15
    Top = 224
  end
  object QueryImpressao: TADOQuery
    Connection = dm.con
    CursorType = ctStatic
    LockType = ltBatchOptimistic
    Parameters = <>
    SQL.Strings = (
      
        'Exec stoObterCadastroDeListasResumo @dtinicio = '#39'01/01/2000'#39' , @' +
        'dtFim = '#39'12/31/2029'#39' , @loja = '#39'00'#39' , @tipo = '#39#39' , @nome = '#39'mari' +
        'a'#39)
    Left = 20
    Top = 88
  end
end
