object fmCadastro: TfmCadastro
  Left = 373
  Top = 130
  Width = 789
  Height = 570
  ActiveControl = CheckBox1
  Caption = 'Associar imagem a um produto.'
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
  ShowHint = True
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 402
    Top = 282
    Width = 176
    Height = 13
    Caption = 'Duplo clique para carregar a imagem.'
  end
  object Panel2: TPanel
    Left = 400
    Top = 4
    Width = 363
    Height = 273
    TabOrder = 4
    object Image1: TImage
      Left = 5
      Top = 6
      Width = 349
      Height = 262
      Center = True
      Stretch = True
      OnDblClick = Image1DblClick
    end
  end
  object edCodigo: TadLabelEdit
    Left = 8
    Top = 127
    Width = 169
    Height = 19
    LabelDefs.Width = 33
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Codigo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    MaxLength = 13
    TabOrder = 0
    OnKeyDown = edCodigoKeyDown
  end
  object edDescricao: TadLabelEdit
    Left = 9
    Top = 183
    Width = 377
    Height = 19
    LabelDefs.Width = 60
    LabelDefs.Height = 13
    LabelDefs.Caption = 'edDescricao'
    Colors.WhenDisabled.TextColor = clDefault
    Colors.WhenEnterFocus.BackColor = clBtnFace
    Ctl3D = False
    ParentCtl3D = False
    Color = clBtnFace
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 13
    ParentFont = False
    TabOrder = 1
  end
  object pnBotoes: TPanel
    Left = 8
    Top = 1
    Width = 180
    Height = 33
    BevelOuter = bvNone
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 2
    object btConsultar: TFlatButton
      Left = 1
      Top = 5
      Width = 29
      Height = 25
      Hint = 'Consultar'
      Glyph.Data = {
        42010000424D4201000000000000760000002800000012000000110000000100
        040000000000CC000000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777770077
        77777700000077777700B0000007770000007707700BBBBBBBB07700000070C0
        770BBBBBBBBB070000000CCC0770B0000000000000000CC077770077770BB000
        0000000777777077770BB000000000C07700777777000000000070CC00C07777
        777777000000770CCCC077770000000000007770CCC077777099900000007700
        0000777777099000000077777777007770999000000077777770100709990000
        0000777777701110999070000000777777770109990777000000777777777000
        007777000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btConsultarClick
    end
    object btIncluir: TFlatButton
      Left = 32
      Top = 5
      Width = 29
      Height = 25
      Hint = 'Incluir '
      Glyph.Data = {
        E6000000424DE60000000000000076000000280000000E0000000E0000000100
        04000000000070000000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00700000000000
        00000FF000000770F0000FF000000770F0800FF000000770F0800FF000000000
        F0000FFFFFFFFFFFF0800FF00000000FF0800F0777777770F0000F0777777770
        F0800F0777777770F0800F0777777770F0000F077777777000A00F0777777770
        70000000000000000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btIncluirClick
    end
    object btAlterar: TFlatButton
      Left = 64
      Top = 5
      Width = 29
      Height = 25
      Hint = 'Alterar'
      Glyph.Data = {
        4E010000424D4E01000000000000760000002800000011000000120000000100
        040000000000D8000000CE0E0000D80E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777777000000
        00000000000077CCC70CC07770CC00000000777CC70CC07770CC0000000077C7
        C70CC07770CC000000007C77770CC00000CC00000000C777770CCCCCCCCC0000
        00007777770CC88888CC000000000000000CC8FFF8CC000000000990770CC8FF
        F8CC000000000990770000000000000000000990777099077777700000000990
        0000990777999000000009999999990777799000000009988888990777979000
        00000998FFF899077977700000000998FFF89907977770000000000000000007
        777770000000777777777777777770000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btAlterarClick
    end
    object btExcluir: TFlatButton
      Left = 97
      Top = 5
      Width = 29
      Height = 25
      Hint = 'Excluir'
      Glyph.Data = {
        E6000000424DE60000000000000076000000280000000D0000000E0000000100
        04000000000070000000120B0000120B00001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00777700000777
        70007770AAAAA0777000770A0AAA0A077000770A0A0A0A0770F07700AA0AA007
        760070A0AA0AA0A0700070A0AA0AA0A0700070A0AA0AA0A0700070AAAAAAAAA0
        70000AA0000000AA0000000AAA0AAA0000000AAAA000AAAA0600700AAA0AAA00
        70007770000000777000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btExcluirClick
    end
    object FlatButton3: TFlatButton
      Left = 146
      Top = 5
      Width = 29
      Height = 25
      Hint = 'Incluir imagens de diret'#243'rio'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555555555555555555555555555555555555555555
        555555555555555555555555555555555555555FFFFFFFFFF555550000000000
        55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
        B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
        000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
        555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
        55555575FFF75555555555700007555555555557777555555555555555555555
        5555555555555555555555555555555555555555555555555555}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = FlatButton3Click
    end
  end
  object CheckBox1: TFlatCheckBox
    Left = 672
    Top = 283
    Width = 89
    Height = 16
    Caption = 'Ajusta imagem'
    Checked = True
    TabOrder = 3
    TabStop = True
    OnClick = CheckBox1Click
  end
  object edFaixa: TadLabelEdit
    Left = 16
    Top = 450
    Width = 145
    Height = 19
    LabelDefs.Width = 33
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Codigo'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    MaxLength = 13
    TabOrder = 5
    Visible = False
    OnKeyDown = edCodigoKeyDown
  end
  object btExportarImg: TFlatButton
    Left = 177
    Top = 448
    Width = 120
    Height = 25
    Hint = 'Excluir'
    Caption = 'salvar as imagens'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    Visible = False
    OnClick = btExportarImgClick
  end
  object edIsRef: TadLabelEdit
    Left = 8
    Top = 71
    Width = 169
    Height = 19
    LabelDefs.Width = 25
    LabelDefs.Height = 13
    LabelDefs.Caption = 'is_ref'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    MaxLength = 13
    TabOrder = 7
    OnKeyDown = edCodigoKeyDown
  end
end
