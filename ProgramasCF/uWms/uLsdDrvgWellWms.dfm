inherited fmLsdDrvgWellWms: TfmLsdDrvgWellWms
  Width = 748
  Caption = 'Lista diverg'#234'ncia estoque Well x WMS.'
  Position = poDesigned
  WindowState = wsNormal
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  inherited edCodigo: TadLabelEdit
    Left = 396
    Top = 72
    Height = 9
  end
  inherited pnParam: TPanel
    Width = 732
    inherited btOk: TFlatButton
      Left = 622
      Width = 77
      Height = 30
      Caption = '&Imprime'
    end
    inherited GroupBox1: TGroupBox
      Height = 8
    end
    inherited cbDetAvaForn: TfsCheckBox
      Left = 245
      Top = 30
      Width = 159
      Height = 14
      Caption = 'N'#227'o considerar itens Maison'
    end
    inherited pnSelCat: TPanel
      Left = 397
      Top = 85
      Height = 7
      inherited FlatButton7: TFlatButton
        Left = 25
      end
    end
    object edCod: TadLabelEdit
      Left = 5
      Top = 79
      Width = 145
      Height = 19
      LabelDefs.Width = 33
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Codigo'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 6
    end
    object btExport: TFlatButton
      Left = 622
      Top = 76
      Width = 77
      Height = 30
      Caption = 'exportar'
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
      TabOrder = 7
      OnClick = btExportClick
    end
  end
end
