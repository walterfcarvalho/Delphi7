object Form1: TForm1
  Left = 261
  Top = 162
  Width = 928
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnTitulo: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 104
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object btGeraEstoque: TFlatButton
      Left = 187
      Top = 44
      Width = 83
      Height = 54
      Caption = '&Gerar Estoque'
      TabOrder = 0
    end
    object cbLoja: TadLabelComboBox
      Left = 5
      Top = 16
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
      TabOrder = 1
      LabelDefs.Width = 23
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Loja:'
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object edit1: TadLabelEdit
      Left = 5
      Top = 58
      Width = 156
      Height = 26
      LabelDefs.Width = 75
      LabelDefs.Height = 13
      LabelDefs.Caption = '&Faixa de c'#243'digo'
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object Panel1: TPanel
      Left = 633
      Top = 3
      Width = 187
      Height = 76
      BevelOuter = bvNone
      TabOrder = 3
      object lbNivel: TLabel
        Left = 146
        Top = 4
        Width = 6
        Height = 13
        Caption = '0'
        Visible = False
      end
      object lbVlCat: TLabel
        Left = 157
        Top = 4
        Width = 24
        Height = 13
        Caption = '0000'
        Visible = False
      end
      object lbClasse1: TLabel
        Left = 46
        Top = 30
        Width = 81
        Height = 13
        Caption = '--------------------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbClasse2: TLabel
        Left = 60
        Top = 44
        Width = 81
        Height = 13
        Caption = '--------------------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbClasse3: TLabel
        Left = 71
        Top = 58
        Width = 81
        Height = 13
        Caption = '--------------------'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel1: TBevel
        Left = 1
        Top = 18
        Width = 184
        Height = 55
      end
      object Label5: TLabel
        Left = 3
        Top = 28
        Width = 26
        Height = 13
        Caption = 'Dep: '
      end
      object Label6: TLabel
        Left = 6
        Top = 43
        Width = 37
        Height = 13
        Caption = 'Se'#231#227'o: '
      end
      object Label2: TLabel
        Left = 8
        Top = 57
        Width = 48
        Height = 13
        Caption = 'Categoria:'
      end
      object FlatButton7: TFlatButton
        Left = 17
        Top = 2
        Width = 91
        Height = 21
        Caption = 'Categorias    '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Glyph.Data = {
          36050000424D3605000000000000360400002800000010000000100000000100
          0800000000000001000000000000000000000001000000000000000000000000
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
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA4A4A4A4A4A4FFFFFFFFFFFFFFFF
          FFFFA400A4A4A4A4FFFFFFFFFFFFFFFFFFFFA408080008A4FFFFFFFFFFFFFFFF
          FFFFA40808A4A4A4FFFFFFFFFFFF0000A4A4000008A4A4A4FFFFFFFFFFFF00FF
          0808FF000800FFA4FFFFFFFFA400A4A4A4A4A400A4A4A4A4FFFFFFFFA40808FF
          00A4A400A4A4A4A4FFFFFFFFA408000000A4A400FFFFFFFFFFFFFF0000080000
          00A4A400FFFFFFFFFFFFFFFF0808000808A40000FFFFFFFFFFFFFFFFA408FFFF
          00A4A4A4FFFFFFFFFFFFFFFF0000A4A400A400FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
        Layout = blGlyphLeft
        ParentFont = False
        TabOrder = 0
      end
    end
    object pnForn: TPanel
      Left = 499
      Top = 52
      Width = 199
      Height = 49
      TabOrder = 4
      Visible = False
      object btAddForn: TFlatButton
        Left = 180
        Top = 5
        Width = 17
        Height = 16
        Hint = 'Buscar um fornecedor'
        Caption = '+'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object btRemoveForn: TFlatButton
        Left = 180
        Top = 28
        Width = 17
        Height = 16
        Hint = 'Buscar um fornecedor'
        Caption = '-'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object lbForn: TadLabelListBox
        Left = 3
        Top = 2
        Width = 176
        Height = 45
        Ctl3D = False
        ItemHeight = 13
        ParentCtl3D = False
        TabOrder = 2
        LabelDefs.Width = 29
        LabelDefs.Height = 13
        LabelDefs.Caption = 'lbForn'
        Colors.WhenEnterFocus.BackColor = clInfoBk
      end
    end
  end
  object grid: TSoftDBGrid
    Left = 0
    Top = 104
    Width = 912
    Height = 338
    Align = alClient
    Ctl3D = False
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  object tbGE: TADOTable
    Left = 338
    Top = 141
  end
  object DataSource1: TDataSource
    DataSet = tbGE
    Left = 376
    Top = 141
  end
end
