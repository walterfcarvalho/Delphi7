object fmCep: TfmCep
  Left = 289
  Top = 223
  Width = 788
  Height = 348
  Caption = 'Cadastro de CEP'
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 772
    Height = 233
    Caption = ' Cadastro de CEP '
    TabOrder = 0
    DesignSize = (
      772
      233)
    object pnItens: TPanel
      Left = 3
      Top = 52
      Width = 645
      Height = 85
      BevelOuter = bvNone
      TabOrder = 0
      object lbCd_cid: TLabel
        Left = 120
        Top = 7
        Width = 41
        Height = 13
        Caption = 'lbCd_cid'
        Visible = False
      end
      object lbCd_bai: TLabel
        Left = 391
        Top = 6
        Width = 41
        Height = 13
        Caption = 'lbCd_bai'
        Visible = False
      end
      object edUF: TadLabelEdit
        Left = 7
        Top = 21
        Width = 32
        Height = 19
        LabelDefs.Width = 17
        LabelDefs.Height = 13
        LabelDefs.Caption = 'UF:'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = edUFClick
        OnEnter = edUFEnter
      end
      object btUF: TfsBitBtn
        Left = 41
        Top = 20
        Width = 27
        Height = 22
        Caption = '...'
        TabOrder = 1
        OnClick = btUFClick
        NumGlyphs = 2
      end
      object edCidade: TadLabelEdit
        Left = 71
        Top = 21
        Width = 215
        Height = 19
        LabelDefs.Width = 36
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Cidade:'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = edCidadeClick
        OnEnter = edCidadeEnter
      end
      object btCidade: TfsBitBtn
        Left = 289
        Top = 20
        Width = 27
        Height = 22
        Caption = '...'
        TabOrder = 3
        OnClick = btCidadeClick
        NumGlyphs = 2
      end
      object edBairro: TadLabelEdit
        Left = 321
        Top = 21
        Width = 209
        Height = 19
        LabelDefs.Width = 27
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Bairro'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 4
        Text = 'edBairro'
        OnClick = edBairroClick
        OnEnter = edBairroEnter
      end
      object btBairro: TfsBitBtn
        Left = 534
        Top = 20
        Width = 27
        Height = 22
        Caption = '...'
        TabOrder = 5
        OnClick = btBairroClick
        NumGlyphs = 2
      end
      object edLog: TadLabelEdit
        Left = 153
        Top = 61
        Width = 328
        Height = 19
        LabelDefs.Width = 96
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Nome do logradouro'
        Colors.WhenEnterFocus.BackColor = clInfoBk
        Ctl3D = False
        ParentCtl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 60
        ParentFont = False
        TabOrder = 6
      end
      object cbTpLog: TadLabelComboBox
        Left = 6
        Top = 59
        Width = 131
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
        TabOrder = 7
        LabelDefs.Width = 21
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Tipo'
        Colors.WhenEnterFocus.BackColor = clWindow
        Colors.WhenExitFocus.BackColor = clInfoBk
      end
    end
    object edCEP: TadLabelEdit
      Left = 11
      Top = 31
      Width = 120
      Height = 19
      LabelDefs.Width = 21
      LabelDefs.Height = 13
      LabelDefs.Caption = 'CEP'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      MaxLength = 8
      TabOrder = 1
    end
    object pnOperacao: TPanel
      Left = 650
      Top = 21
      Width = 117
      Height = 108
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      TabOrder = 2
      Visible = False
      object btIncluir: TFlatButton
        Left = 4
        Top = 26
        Width = 109
        Height = 26
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
        TabOrder = 0
        OnClick = btIncluirClick
      end
      object btAltera: TFlatButton
        Left = 4
        Top = 52
        Width = 109
        Height = 26
        Caption = 'Alte&rar'
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
        TabOrder = 1
        OnClick = btAlteraClick
      end
      object btExclui: TFlatButton
        Left = 4
        Top = 78
        Width = 109
        Height = 26
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
        TabOrder = 2
        OnClick = btExcluiClick
      end
      object btConsulta: TFlatButton
        Left = 4
        Top = 0
        Width = 109
        Height = 26
        Caption = '&Consulta'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333333333333333333333FFFFF3333333333CCCCC33
          33333FFFF77777FFFFFFCCCCCC808CCCCCC377777737F777777F008888070888
          8003773FFF7773FFF77F0F0770F7F0770F037F777737F777737F70FFFFF7FFFF
          F07373F3FFF7F3FFF37F70F000F7F000F07337F77737F777373330FFFFF7FFFF
          F03337FF3FF7F3FF37F3370F00F7F00F0733373F7737F77337F3370FFFF7FFFF
          0733337F33373F337333330FFF030FFF03333373FF7373FF7333333000333000
          3333333777333777333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        Layout = blGlyphLeft
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btConsultaClick
      end
    end
    object pnOkCancel: TPanel
      Left = 586
      Top = 149
      Width = 171
      Height = 25
      Anchors = [akTop, akRight]
      BevelOuter = bvNone
      TabOrder = 3
      object btOk: TfsBitBtn
        Left = 15
        Top = 1
        Width = 75
        Height = 25
        TabOrder = 0
        OnClick = btOkClick
        Kind = bkOK
      end
      object btCancela: TfsBitBtn
        Left = 95
        Top = 0
        Width = 74
        Height = 25
        Caption = 'Cancelar'
        TabOrder = 1
        OnClick = btCancelaClick
        Kind = bkCancel
      end
    end
  end
end
