inherited fmItensSemMov: TfmItensSemMov
  Left = 438
  Top = 61
  Width = 910
  Height = 660
  Caption = 'Produtos Sem Movimenta'#231#227'o'
  OldCreateOrder = True
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnParam: TPanel
    Width = 894
    Height = 133
    object Label3: TLabel [0]
      Left = 166
      Top = 100
      Width = 137
      Height = 13
      Caption = 'dias ou mais sem movimento.'
    end
    inherited GroupBox1: TGroupBox
      Caption = ' Per'#237'odo  do evento '
    end
    inherited cbDetAvaForn: TfsCheckBox
      Left = 452
      Top = 53
      Width = 197
      Caption = 'Data de entrada por transfer'#234'ncia'
    end
    inherited pnSelCat: TPanel
      Top = 53
      Width = 212
    end
    object edCodigo: TadLabelEdit
      Left = 4
      Top = 65
      Width = 145
      Height = 19
      LabelDefs.Width = 75
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Faixa de c'#243'digo'
      Colors.WhenEnterFocus.BackColor = clWindow
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 6
    end
    object spedit: TadLabelSpinEdit
      Left = 123
      Top = 97
      Width = 41
      Height = 22
      Cursor = crDefault
      LabelDefs.Width = 28
      LabelDefs.Height = 13
      LabelDefs.Caption = 'spedit'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Decimals = -1
      MaxValue = 9999.000000000000000000
      MinValue = 1.000000000000000000
      Format = nfStandard
      TabOrder = 7
      Value = 30.000000000000000000
      Increment = 1.000000000000000000
      RoundValues = False
      Wrap = False
    end
    object btExport: TFlatButton
      Left = 737
      Top = 22
      Width = 66
      Height = 26
      Caption = 'Exportar'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
        333333333333337FF3333333333333903333333333333377FF33333333333399
        03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
        99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
        99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
        03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
        33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
        33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
        3333777777333333333333333333333333333333333333333333}
      Layout = blGlyphLeft
      NumGlyphs = 2
      TabOrder = 8
      ModalResult = 1
      OnClick = btExportClick
    end
    object cbRemSemMov: TfsCheckBox
      Left = 5
      Top = 100
      Width = 117
      Height = 16
      Caption = 'Remova os itens com'
      Checked = True
      State = cbChecked
      TabOrder = 9
      OnClick = cbRemSemMovClick
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  object grid: TSoftDBGrid [1]
    Left = 0
    Top = 140
    Width = 545
    Height = 317
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
    OnTitleClick = gridTitleClick
    AlternateColor = True
    ColorLow = clInfoBk
    ColorHigh = clWindow
  end
  inherited tbValoresAvarias: TADOTable
    Left = 704
    Top = 199
  end
  inherited tbValoresAvarias_Total: TADOTable
    Left = 705
    Top = 240
  end
  inherited tbPreviaDeCaixa: TADOTable
    Left = 480
    Top = 112
  end
  inherited tbOperadores: TADOTable
    Left = 520
    Top = 112
  end
  inherited tbTotRec: TADOTable
    Left = 560
    Top = 112
  end
  inherited tbSangrias: TADOTable
    Left = 600
    Top = 112
  end
  inherited tbVendasCartao: TADOTable
    Left = 648
    Top = 112
  end
  inherited qr: TADOQuery
    Left = 704
    Top = 160
  end
  object DataSource1: TDataSource
    DataSet = tbOperadores
    Left = 152
    Top = 184
  end
end
