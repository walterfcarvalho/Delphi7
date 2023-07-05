inherited fmLstDrvEntSaiCD: TfmLstDrvEntSaiCD
  Caption = 'Lista itens por tipo de movimento WellxWms'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnParam: TPanel
    inherited btOk: TFlatButton
      Width = 65
      Height = 25
    end
    inherited cbDetAvaForn: TfsCheckBox
      Width = 168
      Caption = 'Exibir somente "diverg'#234'ncias"'
      Visible = True
      OnClick = cbDetAvaFornClick
    end
    object edCodigo: TadLabelEdit
      Left = 5
      Top = 117
      Width = 145
      Height = 19
      LabelDefs.Width = 33
      LabelDefs.Height = 13
      LabelDefs.Caption = 'C'#243'digo'
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 6
      Visible = False
    end
    object btExport: TFlatButton
      Left = 657
      Top = 62
      Width = 65
      Height = 25
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
    object cbDrivgNaoAutoriz: TfsCheckBox
      Left = 192
      Top = 87
      Width = 205
      Height = 17
      Caption = 'Somente diverg'#234'ncias n'#227'o autorizadas'
      TabOrder = 8
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
  end
  inherited qr: TADOQuery
    Left = 56
    Top = 152
  end
end
