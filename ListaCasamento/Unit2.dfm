object Form2: TForm2
  Left = 513
  Top = 46
  BorderStyle = bsSingle
  Caption = ' Cadastro de Listas '
  ClientHeight = 624
  ClientWidth = 758
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnClose = FormClose
  OnResize = FormResize
  DesignSize = (
    758
    624)
  PixelsPerInch = 96
  TextHeight = 13
  object DBText1: TDBText
    Left = 258
    Top = 155
    Width = 65
    Height = 12
    DataSource = DataSource1
    Visible = False
  end
  object cbTpLista: TadLabelComboBox
    Left = 350
    Top = 17
    Width = 160
    Height = 21
    BevelKind = bkFlat
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = cbTpListaChange
    Items.Strings = (
      '- Todas'
      '- Per'#237'odo')
    LabelDefs.Width = 57
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Tipo da lista'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object dbedit13: TadLabelDBEdit
    Left = 533
    Top = 135
    Width = 23
    Height = 19
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 19
    Visible = False
    OnExit = Dbedit11Exit
    LabelDefs.Width = 20
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object Dbedit8: TadLabelDBEdit
    Left = 4
    Top = 179
    Width = 323
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 9
    LabelDefs.Width = 58
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Observa'#231#227'o'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object DBGrid1: TSoftDBGrid
    Left = 0
    Top = 328
    Width = 758
    Height = 296
    Align = alBottom
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    PopupMenu = PopupMenu1
    TabOrder = 18
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnTitleClick = DBGrid1TitleClick
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
    Columns = <
      item
        Expanded = False
        FieldName = 'Loja'
        Title.Caption = 'LJ'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DescTipo'
        Title.Caption = 'Tipo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Noiva'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Noivo'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 222
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DataCasamento'
        Title.Caption = 'Dt Evento'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'dataLista'
        Title.Caption = 'Dt Lista'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 63
        Visible = True
      end>
  end
  object DBEdit1: TadLabelDBEdit
    Left = 2
    Top = 19
    Width = 324
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 0
    LabelDefs.Width = 28
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Noiva'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object DBEdit2: TadLabelDBEdit
    Left = 2
    Top = 58
    Width = 324
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 3
    LabelDefs.Width = 28
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Noivo'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object DBEdit5: TadLabelDBEdit
    Left = 2
    Top = 96
    Width = 324
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 6
    LabelDefs.Width = 100
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Endere'#231'o de entrega'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object DBedit6: TadLabelDBEdit
    Left = 350
    Top = 59
    Width = 175
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 4
    LabelDefs.Width = 27
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Bairro'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object DBedit7: TadLabelDBEdit
    Left = 2
    Top = 133
    Width = 323
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 7
    LabelDefs.Width = 93
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Ponto de referencia'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object Dbedit11: TadLabelDBEdit
    Left = 350
    Top = 96
    Width = 145
    Height = 19
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 8
    OnExit = Dbedit11Exit
    LabelDefs.Width = 96
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Telefone de contato'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object dbEdNumLista: TadLabelDBEdit
    Left = 561
    Top = 135
    Width = 41
    Height = 19
    TabStop = False
    Ctl3D = False
    DataSource = DataSource1
    Enabled = False
    ParentCtl3D = False
    TabOrder = 10
    OnEnter = dbEdNumListaEnter
    LabelDefs.Width = 73
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Numero da lista'
    Colors.WhenDisabled.TextColor = clInfoText
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object BitBtn3: TFlatButton
    Left = 675
    Top = 59
    Width = 75
    Height = 27
    Color = clBtnFace
    Caption = '&Incluir'
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
    ParentColor = False
    TabOrder = 12
    OnClick = BitBtn3Click
  end
  object BitBtn4: TFlatButton
    Left = 675
    Top = 88
    Width = 75
    Height = 27
    Caption = '&Alterar'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
      000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
      00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
      F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
      0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
      FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
      FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
      0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
      00333377737FFFFF773333303300000003333337337777777333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 13
    OnClick = BitBtn4Click
  end
  object BitBtn5: TFlatButton
    Left = 675
    Top = 117
    Width = 75
    Height = 27
    Caption = '&Excluir'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333FF33333333333330003333333333333777333333333333
      300033FFFFFF3333377739999993333333333777777F3333333F399999933333
      3300377777733333337733333333333333003333333333333377333333333333
      3333333333333333333F333333333333330033333F33333333773333C3333333
      330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
      993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
      333333377F33333333FF3333C333333330003333733333333777333333333333
      3000333333333333377733333333333333333333333333333333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 14
    OnClick = buyytClick
  end
  object BitBtn6: TFlatButton
    Left = 675
    Top = 5
    Width = 75
    Height = 27
    Caption = '&Voltar'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
      03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
      0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
      0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
      0333337F777FFFFF7F3333000000000003333377777777777333}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 15
    OnClick = BitBtn6Click
  end
  object bitBtn1: TFlatButton
    Left = 583
    Top = 160
    Width = 81
    Height = 29
    Caption = 'Ok'
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
    TabOrder = 16
    ModalResult = 1
    OnClick = bitBtn1Click
  end
  object bitbtn2: TFlatButton
    Left = 675
    Top = 160
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
    TabOrder = 17
    OnClick = BitBtn2Click
  end
  object dBDT1: TadLabelDBDateTimePicker
    Left = 532
    Top = 19
    Width = 116
    Height = 21
    BevelInner = bvNone
    BevelOuter = bvRaised
    BevelKind = bkSoft
    CalAlignment = dtaRight
    Date = 39120.687247893520000000
    Time = 39120.687247893520000000
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    DataSource = DataSource1
    LabelDefs.Width = 74
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Data do evento'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object dbEdTpLista: TadLabelDBEdit
    Left = 294
    Top = 18
    Width = 35
    Height = 19
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 20
    Visible = False
    OnExit = Dbedit11Exit
    LabelDefs.Width = 60
    LabelDefs.Height = 13
    LabelDefs.Caption = 'dbEdTpLista'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object edCEP: TadLabelDBEdit
    Left = 532
    Top = 59
    Width = 85
    Height = 19
    CharCase = ecUpperCase
    Ctl3D = False
    DataSource = DataSource1
    MaxLength = 8
    ParentCtl3D = False
    TabOrder = 5
    LabelDefs.Width = 21
    LabelDefs.Height = 13
    LabelDefs.Caption = 'CEP'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object edCodWell: TadLabelDBEdit
    Left = 531
    Top = 96
    Width = 86
    Height = 19
    Ctl3D = False
    DataSource = DataSource1
    MaxLength = 8
    ParentCtl3D = False
    TabOrder = 21
    LabelDefs.Width = 106
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Codigo cliente no Well'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object edCPF: TadLabelDBEdit
    Left = 350
    Top = 134
    Width = 104
    Height = 19
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    TabOrder = 22
    OnExit = Dbedit11Exit
    LabelDefs.Width = 20
    LabelDefs.Height = 13
    LabelDefs.Caption = 'CPF'
    Colors.WhenDisabled.TextColor = clWindow
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object pnBusca: TPanel
    Left = 319
    Top = 157
    Width = 339
    Height = 37
    Anchors = [akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 23
    object cb1: TComboBox
      Left = 231
      Top = 14
      Width = 70
      Height = 21
      BevelInner = bvSpace
      BevelKind = bkSoft
      BevelOuter = bvRaised
      Style = csDropDownList
      BiDiMode = bdRightToLeft
      Ctl3D = False
      ItemHeight = 13
      ItemIndex = 0
      ParentBiDiMode = False
      ParentCtl3D = False
      TabOrder = 0
      Text = 'Noiva'
      Items.Strings = (
        'Noiva'
        'Noivo'
        'N'#250'mero da lista')
    end
    object edit1: TadLabelEdit
      Left = 92
      Top = 14
      Width = 137
      Height = 21
      LabelDefs.Width = 45
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Localizar '
      Colors.WhenEnterFocus.BackColor = clInfoBk
      AutoSize = False
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      TabOrder = 1
    end
    object cbLojas: TadLabelComboBox
      Left = 0
      Top = 15
      Width = 74
      Height = 21
      BevelInner = bvSpace
      BevelKind = bkFlat
      BevelOuter = bvRaised
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 2
      OnSelect = cbLojasSelect
      LabelDefs.Width = 73
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Mostrar da Loja'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object btBusca: TfsBitBtn
      Left = 305
      Top = 12
      Width = 23
      Height = 25
      TabOrder = 3
      OnClick = btBuscaClick
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
      NumGlyphs = 2
    end
  end
  object pnIncluiItens: TPanel
    Left = 102
    Top = 234
    Width = 344
    Height = 406
    BevelInner = bvLowered
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 11
    Visible = False
    object Lb1: TadLabelListBox
      Left = 6
      Top = 20
      Width = 333
      Height = 150
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      Sorted = True
      TabOrder = 0
      LabelDefs.Width = 143
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Itens que n'#227'o entrar'#227'o na lista'
      Colors.WhenDisabled.BackColor = clHighlightText
      Colors.WhenDisabled.TextColor = clWindow
      Colors.WhenEnterFocus.BackColor = clWindow
    end
    object lb2: TadLabelListBox
      Left = 6
      Top = 222
      Width = 333
      Height = 150
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      Sorted = True
      TabOrder = 1
      LabelDefs.Width = 122
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Itens que entrar'#227'o na lista'
      Colors.WhenDisabled.BackColor = clHighlightText
      Colors.WhenDisabled.TextColor = clWindow
      Colors.WhenEnterFocus.BackColor = clWindow
    end
    object BitBtn7: TBitBtn
      Left = 12
      Top = 173
      Width = 67
      Height = 26
      TabOrder = 2
      OnClick = BitBtn7Click
      Glyph.Data = {
        26050000424D260500000000000036040000280000000F0000000F0000000100
        080000000000F0000000C40E0000C40E0000000100000000000067010100C0C0
        C000A800000077F6D500FFFFFF000036FF002E00350000670000660069000000
        00000000000000000000000100000000000000000000000000000001E600001B
        00000000000000000000D25CBC00F9A87700E80012000012F800D25CF1000556
        7700C80002000012F8001400000017E600002477F50000000000140D48000000
        0000B80014000015260012F8A0005CBC0000E877D2000012FA00F7900500D5F0
        7700FF77F600FFFFFF00F517E60017787700B277F50077F51700000000000000
        0000A800000000487300000046005DB00000000018000000000012F9C4000000
        00009000000077F5160016F35800164E00007877F50000140700F5166A00F380
        7700600016000016F3001867AC00017800009800140000186700000000000178
        00007800140000140100D2589D00058E770046000100000000000000000058B1
        00009077D20000186700185DB000201300001C77F50077F52000186788000024
        0000100002000014650012FA3000000000009000000077F5160012FA3C000000
        00009000000077F5160018679000164E0000D877F50000140700F5166A0067AC
        770098001800001867000000000073A800000500480000000000000028000000
        000000000000000000000000B20068F00000000001000014000012F908000168
        0000F00014000012F900F7900500D5C87700FF77F600FFFFFF00F5166A00268E
        7700A977F50077F52600FC30E000269C77008077F5000016F30016F3600067AC
        0000000018007FFDE00012F9D80000B20000340000000012FA00F7900500D680
        7700FF77F600FFFFFF00F5269C00263177000777F50000000000000038006798
        0000000018000000000016F3400031280000000001000014000012F980000000
        0000800000000012FA00F7900500D5C87700FF77F600FFFFFF00F5166A00EF21
        77000077E6000014000000000000EF2D00001477E60077D27900000000000005
        00000000000000000000FDE0000000B27F000000B400000000000000000000FC
        0000980000000018670012FA5000FA5C0000B00012000012FF00E84809001098
        7700FF77E800FFFFFF00E6EF2D004DDC77009800430000186700D27914000000
        77002000000000000000791FC6009726D4000A01C100EB9A1600C4E6C5004300
        010024F70D00000000000001200000480000A800000077F6D500FFFFFF000000
        FF0069000000000066001526B80000000000D40014000012F80012FB0400FB34
        00000500120077F79000F6D5E000FFFF7700B2FFFF0077F51700E6A6D4000000
        77000800140000140000E6A6E500791477000077D20000000000000000000000
        0000000000000000000044C0C400270E00007C0015000016E200152712007402
        0000FF004800FFFFFF001526B800C12E00000E00440000152700010000000000
        0000000000000000010000000000000000010000000000000000000000000000
        0101010000000000000000000000000101010101000000000000000000000101
        0101010101000000000000000001010101010101010100000000000001010101
        0101010101010100000000010101010101010101010101010000000000000001
        0101010100000000000000000000000101010101000000000000000000000001
        0101010100000000000000000000000101010101000000000000000000000001
        0101010100000000000000000000000000000000000000000000010000000000
        00000000000000000100}
      Spacing = 7
    end
    object BitBtn8: TBitBtn
      Left = 81
      Top = 173
      Width = 67
      Height = 26
      TabOrder = 3
      OnClick = BitBtn8Click
      Glyph.Data = {
        26050000424D260500000000000036040000280000000F0000000F0000000100
        080000000000F0000000C40E0000C40E0000000100000000000067010100C0C0
        C000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000010000000000
        0001000000000000010000000000000001010100000000000000000000000001
        0101010100000000000000000000010101010101010000000000000000010101
        0101010101010000000000000101010101010101010101000000000101010101
        0101010101010101000000000000000101010101000000000000000000000101
        0101010101000000000000000001010101010101010100000000000001010101
        0101010101010100000000010101010101010101010101010000000000000001
        0101010100000000000000000000000101010101000000000000010000000000
        00000000000000000100}
      Spacing = 7
    end
    object BitBtn9: TBitBtn
      Left = 189
      Top = 172
      Width = 67
      Height = 26
      TabOrder = 4
      OnClick = BitBtn9Click
      Glyph.Data = {
        26050000424D260500000000000036040000280000000F0000000F0000000100
        080000000000F0000000C40E0000C40E0000000100000001000067010100C0C0
        C000A800000077F6D500FFFFFF000036FF002E00350000670000660069000000
        00000000000000000000000100000000000000000000000000000001E600001B
        00000000000000000000D25CBC00F9A87700E80012000012F800D25CF1000556
        7700C80002000012F8001400000017E600002477F50000000000140D48000000
        0000B80014000015260012F8A0005CBC0000E877D2000012FA00F7900500D5F0
        7700FF77F600FFFFFF00F517E60017787700B277F50077F51700000000000000
        0000A800000000487300000046005DB00000000018000000000012F9C4000000
        00009000000077F5160016F35800164E00007877F50000140700F5166A00F380
        7700600016000016F3001867AC00017800009800140000186700000000000178
        00007800140000140100D2589D00058E770046000100000000000000000058B1
        00009077D20000186700185DB000201300001C77F50077F52000186788000024
        0000100002000014650012FA3000000000009000000077F5160012FA3C000000
        00009000000077F5160018679000164E0000D877F50000140700F5166A0067AC
        770098001800001867000000000073A800000500480000000000000028000000
        000000000000000000000000B20068F00000000001000014000012F908000168
        0000F00014000012F900F7900500D5C87700FF77F600FFFFFF00F5166A00268E
        7700A977F50077F52600FC30E000269C77008077F5000016F30016F3600067AC
        0000000018007FFDE00012F9D80000B20000340000000012FA00F7900500D680
        7700FF77F600FFFFFF00F5269C00263177000777F50000000000000038006798
        0000000018000000000016F3400031280000000001000014000012F980000000
        0000800000000012FA00F7900500D5C87700FF77F600FFFFFF00F5166A00EF21
        77000077E6000014000000000000EF2D00001477E60077D27900000000000005
        00000000000000000000FDE0000000B27F000000B400000000000000000000FC
        0000980000000018670012FA5000FA5C0000B00012000012FF00E84809001098
        7700FF77E800FFFFFF00E6EF2D004DDC77009800430000186700D27914000000
        77002000000000000000791FC6009726D4000A01C100EB9A1600C4E6C5004300
        010024F70D00000000000001200000480000A800000077F6D500FFFFFF000000
        FF0069000000000066001526B80000000000D40014000012F80012FB0400FB34
        00000500120077F79000F6D5E000FFFF7700B2FFFF0077F51700E6A6D4000000
        77000800140000140000E6A6E500791477000077D20000000000000000000000
        0000000000000000000044C0C400270E00007C0015000016E200152712007402
        0000FF004800FFFFFF001526B800C12E00000E00440000152700010000000000
        0000000000000000010000000000000000000000000000000000000000000001
        0101010100000000000000000000000101010101000000000000000000000001
        0101010100000000000000000000000101010101000000000000000000000001
        0101010100000000000000010101010101010101010101010000000001010101
        0101010101010100000000000001010101010101010100000000000000000101
        0101010101000000000000000000000101010101000000000000000000000000
        0101010000000000000000000000000000010000000000000000010000000000
        00000000000000000100}
      Style = bsNew
      Spacing = 7
    end
    object BitBtn10: TBitBtn
      Left = 259
      Top = 172
      Width = 67
      Height = 26
      TabOrder = 5
      OnClick = BitBtn10Click
      Glyph.Data = {
        26050000424D260500000000000036040000280000000F0000000F0000000100
        080000000000F0000000C40E0000C40E0000000100000001000067010100C0C0
        C000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000010000000000
        0000000000000000010000000000000101010101000000000000000000000001
        0101010100000000000000010101010101010101010101010000000001010101
        0101010101010100000000000001010101010101010100000000000000000101
        0101010101000000000000000000000101010101000000000000000101010101
        0101010101010101000000000101010101010101010101000000000000010101
        0101010101010000000000000000010101010101010000000000000000000001
        0101010100000000000000000000000001010100000000000000010000000000
        00010000000000000100}
      Spacing = 7
    end
    object BitBtn11: TBitBtn
      Left = 184
      Top = 375
      Width = 75
      Height = 26
      Caption = 'OK'
      Default = True
      TabOrder = 6
      OnClick = BitBtn11Click
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
      Style = bsWin31
      Spacing = 7
    end
    object BitBtn12: TBitBtn
      Left = 263
      Top = 375
      Width = 75
      Height = 26
      Cancel = True
      Caption = 'Cancelar'
      TabOrder = 7
      OnClick = BitBtn12Click
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
      NumGlyphs = 2
      Style = bsWin31
      Spacing = 7
    end
  end
  object DataSource1: TDataSource
    DataSet = fmMain.Query1
    Left = 32
    Top = 251
  end
  object PopupMenu1: TPopupMenu
    Left = 16
    Top = 208
    object Adicionarpessoasrelacioandas1: TMenuItem
      Caption = 'Pessoas relacionadas '#224' lista'
      OnClick = Adicionarpessoasrelacioandas1Click
    end
    object Abrirestalista1: TMenuItem
      Caption = '&Abrir esta lista'
      OnClick = Abrirestalista1Click
    end
    object ImprimirEstalista1: TMenuItem
      Caption = '&Imprimir esta lista'
      OnClick = ImprimirEstalista1Click
    end
    object Imprimirotermodeconcordncia1: TMenuItem
      Caption = 'Imprimir o termo de concord'#226'ncia'
      OnClick = Imprimirotermodeconcordncia1Click
    end
    object Incluirosprodutosnalista1: TMenuItem
      Caption = 'Incluir os produtos na lista.'
      OnClick = Incluirosprodutosnalista1Click
    end
  end
end
