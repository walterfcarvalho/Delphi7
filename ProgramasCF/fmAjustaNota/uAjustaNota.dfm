object fmAjustaNota: TfmAjustaNota
  Left = 245
  Top = 100
  Width = 993
  Height = 544
  Caption = 'Ajuste de notas'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 977
    Height = 506
    Align = alClient
    TabOrder = 0
    Visible = False
    DesignSize = (
      977
      506)
    object Label1: TLabel
      Left = 352
      Top = 110
      Width = 64
      Height = 13
      Caption = 'Data emiss'#227'o'
    end
    object lbIsEstoque: TLabel
      Left = 178
      Top = 22
      Width = 60
      Height = 13
      Caption = 'lbIs_estoque'
      Visible = False
    end
    object Label3: TLabel
      Left = 109
      Top = 33
      Width = 30
      Height = 13
      Caption = 'Tipo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbTipo: TLabel
      Left = 151
      Top = 34
      Width = 15
      Height = 13
      Caption = '-----'
    end
    object Label4: TLabel
      Left = 109
      Top = 19
      Width = 29
      Height = 13
      Caption = 'Loja:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbLoja: TLabel
      Left = 151
      Top = 20
      Width = 15
      Height = 13
      Caption = '-----'
    end
    object lbCodPes: TLabel
      Left = 217
      Top = 112
      Width = 15
      Height = 13
      Caption = '-----'
    end
    object Label2: TLabel
      Left = 109
      Top = 48
      Width = 45
      Height = 13
      Caption = 'Criador:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbCriador: TLabel
      Left = 159
      Top = 48
      Width = 15
      Height = 13
      Caption = '-----'
    end
    object Label5: TLabel
      Left = 440
      Top = 107
      Width = 59
      Height = 13
      Caption = 'Data sai/ent'
    end
    object Label6: TLabel
      Left = 109
      Top = 63
      Width = 114
      Height = 13
      Caption = 'Pedido relacionado:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbPedido: TLabel
      Left = 230
      Top = 63
      Width = 15
      Height = 13
      Caption = '-----'
    end
    object lbNotasRelacionadas: TLabel
      Left = 112
      Top = 78
      Width = 110
      Height = 13
      Caption = 'Notas relacionadas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnClick = lbNotasRelacionadasClick
      OnMouseMove = lbNotasRelacionadasMouseMove
      OnMouseLeave = lbNotasRelacionadasMouseLeave
    end
    object lbCodTrans: TLabel
      Left = 255
      Top = 22
      Width = 54
      Height = 13
      Caption = 'lbCodTrans'
      Visible = False
    end
    object Label7: TLabel
      Left = 643
      Top = 193
      Width = 158
      Height = 13
      Caption = 'Recalcula valores dos itens'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnClick = Label7Click
      OnMouseMove = Label7MouseMove
      OnMouseLeave = Label7MouseLeave
    end
    object Label8: TLabel
      Left = 812
      Top = 192
      Width = 92
      Height = 13
      Caption = 'Recalcula ICMS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnClick = Label8Click
      OnMouseMove = Label8MouseMove
      OnMouseLeave = Label8MouseLeave
    end
    object lbIsDoc: TLabel
      Left = 255
      Top = 38
      Width = 36
      Height = 13
      Caption = 'lbIsDoc'
      Visible = False
    end
    object Label9: TLabel
      Left = 813
      Top = 208
      Width = 78
      Height = 13
      Caption = 'Recalcula IPI'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnClick = Label9Click
      OnMouseMove = Label9MouseMove
      OnMouseLeave = Label9MouseLeave
    end
    object edSerie: TadLabelEdit
      Left = 7
      Top = 127
      Width = 24
      Height = 19
      LabelDefs.Width = 24
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Serie'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      ReadOnly = True
      TabOrder = 7
    end
    object edEmitDest: TadLabelEdit
      Left = 110
      Top = 127
      Width = 214
      Height = 19
      LabelDefs.Width = 103
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Emitente/ destinat'#225'rio'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edCFO: TadLabelEdit
      Left = 535
      Top = 126
      Width = 53
      Height = 19
      LabelDefs.Width = 47
      LabelDefs.Height = 13
      LabelDefs.Caption = 'CFO Nota'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 4
      ParentFont = False
      TabOrder = 1
      OnDblClick = edCFODblClick
    end
    object dtEmiss: TfsDateTimePicker
      Left = 350
      Top = 125
      Width = 84
      Height = 21
      Date = 40301.458043576390000000
      Time = 40301.458043576390000000
      TabOrder = 2
    end
    object edVlDEspExtra: TadLabelNumericEdit
      Left = 7
      Top = 163
      Width = 80
      Height = 19
      LabelDefs.Width = 77
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Valor desp Extra'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 3
    end
    object btEmisDest: TFlatButton
      Left = 304
      Top = 127
      Width = 19
      Height = 19
      Caption = '...'
      TabOrder = 4
      OnClick = btEmisDestClick
    end
    object btOk: TfsBitBtn
      Left = 641
      Top = 260
      Width = 75
      Height = 25
      TabOrder = 5
      OnClick = btOkClick
      Kind = bkOK
    end
    object btCancela: TfsBitBtn
      Left = 718
      Top = 260
      Width = 74
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 6
      OnClick = btCancelaClick
      Kind = bkCancel
    end
    object edNumero: TadLabelEdit
      Left = 32
      Top = 127
      Width = 72
      Height = 19
      LabelDefs.Width = 37
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Numero'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 8
    end
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 189
      Width = 308
      Height = 106
      Caption = ' Valores de ICMS  (Duplo clique para remover)'
      TabOrder = 9
    end
    object gdICMS: TSoftDBGrid
      Left = 12
      Top = 202
      Width = 297
      Height = 90
      Ctl3D = False
      DataSource = dsICM
      ParentCtl3D = False
      TabOrder = 10
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnColExit = gdICMSColExit
      OnDblClick = gdICMSDblClick
      AlternateColor = True
      ColorLow = clHighlightText
      ColorHigh = clWindow
    end
    object cbOperIntegrada: TadLabelComboBox
      Left = 596
      Top = 125
      Width = 284
      Height = 21
      AutoCloseUp = True
      BevelInner = bvNone
      BevelKind = bkFlat
      Style = csDropDownList
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 11
      LabelDefs.Width = 97
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Opera'#231#227'o integrada:'
      Colors.WhenEnterFocus.BackColor = clWindow
      Colors.WhenExitFocus.BackColor = clInfoBk
    end
    object cbCancelada: TfsCheckBox
      Left = 780
      Top = 98
      Width = 97
      Height = 17
      Caption = 'Nota Cancelada.'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 12
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object edObservacao: TadLabelEdit
      Left = 712
      Top = 163
      Width = 166
      Height = 19
      LabelDefs.Width = 97
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Observa'#231#227'o da nota'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 13
    end
    object edIsNota: TadLabelEdit
      Left = 519
      Top = 24
      Width = 120
      Height = 19
      LabelDefs.Width = 97
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Identificador BD:'
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = [fsBold]
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Color = clMenu
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 14
    end
    object edCodNFE: TadLabelEdit
      Left = 519
      Top = 45
      Width = 65
      Height = 19
      LabelDefs.Width = 104
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Identificador NFE:'
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = [fsBold]
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Color = clMenu
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 15
    end
    object dtEntSai: TfsDateTimePicker
      Left = 441
      Top = 125
      Width = 84
      Height = 21
      Date = 40301.458043576390000000
      Time = 40301.458043576390000000
      TabOrder = 16
    end
    object gbItens: TGroupBox
      Left = 7
      Top = 294
      Width = 965
      Height = 204
      Anchors = [akLeft, akTop, akRight, akBottom]
      BiDiMode = bdLeftToRight
      Caption = 'Itens'
      ParentBiDiMode = False
      TabOrder = 17
      DesignSize = (
        965
        204)
      object gridItens: TSoftDBGrid
        Left = 2
        Top = 13
        Width = 960
        Height = 165
        Anchors = [akLeft, akTop, akRight, akBottom]
        Ctl3D = False
        DataSource = dsItens
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        ParentCtl3D = False
        PopupMenu = PopupMenu1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnColExit = gridItensColExit
        OnTitleClick = gridItensTitleClick
        AlternateColor = True
        ColorLow = clInfoBk
        ColorHigh = clWindow
      end
      object edTotItens: TadLabelNumericEdit
        Left = 243
        Top = 182
        Width = 89
        Height = 19
        Anchors = [akLeft, akBottom]
        LabelDefs.Width = 33
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Itens:'
        LabelDefs.Font.Charset = DEFAULT_CHARSET
        LabelDefs.Font.Color = clWindowText
        LabelDefs.Font.Height = -11
        LabelDefs.Font.Name = 'MS Sans Serif'
        LabelDefs.Font.Style = [fsBold]
        LabelDefs.ParentFont = False
        LabelPosition = adLeft
        Color = clBtnFace
        Ctl3D = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 1
      end
      object edTotBase: TadLabelNumericEdit
        Left = 403
        Top = 182
        Width = 89
        Height = 19
        Anchors = [akLeft, akBottom]
        LabelDefs.Width = 63
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Base ICMS'
        LabelDefs.Font.Charset = DEFAULT_CHARSET
        LabelDefs.Font.Color = clWindowText
        LabelDefs.Font.Height = -11
        LabelDefs.Font.Name = 'MS Sans Serif'
        LabelDefs.Font.Style = [fsBold]
        LabelDefs.ParentFont = False
        LabelPosition = adLeft
        Color = clBtnFace
        Ctl3D = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 2
      end
      object edICMS: TadLabelNumericEdit
        Left = 562
        Top = 182
        Width = 89
        Height = 19
        Anchors = [akLeft, akBottom]
        LabelDefs.Width = 31
        LabelDefs.Height = 13
        LabelDefs.Caption = 'ICMS'
        LabelDefs.Font.Charset = DEFAULT_CHARSET
        LabelDefs.Font.Color = clWindowText
        LabelDefs.Font.Height = -11
        LabelDefs.Font.Name = 'MS Sans Serif'
        LabelDefs.Font.Style = [fsBold]
        LabelDefs.ParentFont = False
        LabelPosition = adLeft
        Color = clBtnFace
        Ctl3D = False
        ParentCtl3D = False
        ReadOnly = True
        TabOrder = 3
      end
    end
    object btCarregaNf: TFlatButton
      Left = 617
      Top = 25
      Width = 21
      Height = 17
      Glyph.Data = {
        C6040000424DC60400000000000036040000280000000C0000000C0000000100
        08000000000090000000C40E0000C40E00000001000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
        A6000020400000206000002080000020A0000020C0000020E000004000000040
        20000040400000406000004080000040A0000040C0000040E000006000000060
        20000060400000606000006080000060A0000060C0000060E000008000000080
        20000080400000806000008080000080A0000080C0000080E00000A0000000A0
        200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
        200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
        200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
        20004000400040006000400080004000A0004000C0004000E000402000004020
        20004020400040206000402080004020A0004020C0004020E000404000004040
        20004040400040406000404080004040A0004040C0004040E000406000004060
        20004060400040606000406080004060A0004060C0004060E000408000004080
        20004080400040806000408080004080A0004080C0004080E00040A0000040A0
        200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
        200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
        200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
        20008000400080006000800080008000A0008000C0008000E000802000008020
        20008020400080206000802080008020A0008020C0008020E000804000008040
        20008040400080406000804080008040A0008040C0008040E000806000008060
        20008060400080606000806080008060A0008060C0008060E000808000008080
        20008080400080806000808080008080A0008080C0008080E00080A0000080A0
        200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
        200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
        200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
        2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
        2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
        2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
        2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
        2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
        2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
        2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFF608FF
        FFFFFFFFFFFFFFFFFFE2EA08F6F6FFFFFFFFFFFF07D9E2E1E1EB08FFFFFFFFFF
        D1E2E2EBECF4F307FFFFFFFF07EBD8F5FFFFF6EAF6FFFFFFFFFFF6ECF6FFFFFF
        FFFFFFFFF6FFFFFFECF6FFFFFFFFFFFFE207FFFF09D0E309FFFFFFFF09D0E2EB
        E2E2E2D8FFFFFFFFFF09D9D0D0D9E209FFFFFFFFFFFFFFF608EBE3FFFFFFFFFF
        FFFFFFFFFF08F6FFFFFF}
      TabOrder = 18
      OnClick = btCarregaNfClick
    end
    object RadioGroup2: TRadioGroup
      Left = 330
      Top = 189
      Width = 308
      Height = 106
      Caption = ' Valores de ICMS dos itens'
      TabOrder = 19
    end
    object gdIcmItem: TSoftDBGrid
      Left = 335
      Top = 202
      Width = 297
      Height = 90
      Color = clBtnFace
      Ctl3D = False
      DataSource = dsIcmItens
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      TabOrder = 20
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      AlternateColor = True
      ColorLow = clHighlightText
      ColorHigh = clWindow
    end
    object edVlNf: TadLabelNumericEdit
      Left = 91
      Top = 163
      Width = 80
      Height = 19
      LabelDefs.Width = 65
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Valor da Nota'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 21
    end
    object edVlItens: TadLabelNumericEdit
      Left = 175
      Top = 163
      Width = 80
      Height = 19
      LabelDefs.Width = 69
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Valor dos itens'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 22
    end
    object edIsOper: TadLabelEdit
      Left = 519
      Top = 66
      Width = 120
      Height = 19
      LabelDefs.Width = 104
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Cod da Opera'#231#227'o:'
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = [fsBold]
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Color = clMenu
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 23
    end
    object edDescNf: TadLabelNumericEdit
      Left = 259
      Top = 163
      Width = 69
      Height = 19
      LabelDefs.Width = 67
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Valor desc NF'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 24
    end
    object edPercDesc: TadLabelNumericEdit
      Left = 332
      Top = 163
      Width = 69
      Height = 19
      LabelDefs.Width = 65
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Perc desc NF'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 25
    end
    object edVlDescRatIt: TadLabelNumericEdit
      Left = 404
      Top = 162
      Width = 69
      Height = 19
      LabelDefs.Width = 80
      LabelDefs.Height = 13
      LabelDefs.Caption = 'VL desc rat Itens'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Color = clBtnFace
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 26
    end
    object edVlIpi: TadLabelNumericEdit
      Left = 489
      Top = 162
      Width = 69
      Height = 19
      LabelDefs.Width = 29
      LabelDefs.Height = 13
      LabelDefs.Caption = 'VL IPI'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 27
    end
    object edVlDesp: TadLabelNumericEdit
      Left = 569
      Top = 162
      Width = 69
      Height = 19
      LabelDefs.Width = 82
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Despesas Acess.'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 28
    end
  end
  object btPesquisa: TfsBitBtn
    Left = 10
    Top = 23
    Width = 80
    Height = 45
    Caption = 'Pesquisar'
    Default = True
    TabOrder = 1
    OnClick = FlatButton1Click
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      1800000000000003000000000000000000000000000000000000FFFFFFFFFFFF
      FFFFFFFFFFFF0000000000000000000000000000004000008000008000008000
      00800000800000800000FFFFFFFFFFFFFFFFFF20000080404080404080404080
      4040804040802020800000800000800000800000800000800000FFFFFFFFFFFF
      2000008040408040408040408040408040408040408020208000008000008000
      00800000800000800000FFFFFF20000080404080404080404080404080404080
      4040804040802020703030AF3030AF3030400000400000400000200000804040
      804040804040804040804040804040804040804040503030DF6060DF6060DF60
      60000000FFFFFFFFFFFF000000000000007F7F007F7F007F7F007F7F007F7F3F
      7F7F3F7F7F3FBFBFDF6060DF6060DF6060000000FFFFFFFFFFFFFFFFFFFFFFFF
      003F3F00BFBF00FFFFBFFFFF3FFFFF3FFFFF00FFFF00FFFF9F9F9FDF6060DF60
      60000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00BFBF00FFFF3FFFFF3F
      FFFF3FFFFF3FFFFF00FFFF003F3F000000000000FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF007F7F00FFFF3FFFFF3FFFFF3FFFFF209F9F4040200000
      00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF003F3F00
      BFBF3FFFFF407F7F707050A0A060606040000000FFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF205F5FAFAFAFAFAFAF9090707070
      30202000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF000000909090EFEFEF8F8F8F808060505050000000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000006060609F9F9F7F7F
      5F707050707070000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFF0000000000006F6F30BFBFBF909050707070FFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000
      003F3F7FBFBFBF909050FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00003F6F6F50BFBFBF}
  end
  object tbICM: TADOTable
    Left = 96
    Top = 255
  end
  object dsICM: TDataSource
    DataSet = tbICM
    Left = 120
    Top = 255
  end
  object tbItens: TADOTable
    CursorType = ctStatic
    BeforePost = tbItensBeforePost
    AfterScroll = tbItensAfterScroll
    Left = 40
    Top = 383
  end
  object dsItens: TDataSource
    DataSet = tbItens
    Left = 79
    Top = 383
  end
  object dsIcmItens: TDataSource
    Left = 432
    Top = 207
  end
  object PopupMenu1: TPopupMenu
    Left = 79
    Top = 350
    object Setavalorunitrioparaduascasas1: TMenuItem
      Caption = 'Valor unit'#225'rio - Seta para duas casas'
      OnClick = Setavalorunitrioparaduascasas1Click
    end
    object SetaValordodescontoparaduascasas1: TMenuItem
      Caption = 'Valor desconto - Seta para duas casas'
      OnClick = SetaValordodescontoparaduascasas1Click
    end
    object Exportaritens1: TMenuItem
      Caption = 'Exportar itens'
      OnClick = Exportaritens1Click
    end
  end
end
