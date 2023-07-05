inherited fmReqEmSeparacao: TfmReqEmSeparacao
  Left = 287
  Top = 179
  Caption = 'Lista itens em separa'#231#227'o no cd por per'#237'odo.'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object edCodigo: TadLabelEdit [0]
    Left = 3
    Top = 103
    Width = 156
    Height = 26
    LabelDefs.Width = 124
    LabelDefs.Height = 13
    LabelDefs.Caption = '&Faixa de c'#243'digo (opcional)'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  inherited pnParam: TPanel
    inherited cbCaixas: TadLabelComboBox
      LabelDefs.Width = 42
      LabelDefs.Caption = 'Dep'#243'sito'
    end
  end
  inherited tbValoresAvarias: TADOTable
    Left = 8
    Top = 223
  end
  inherited tbValoresAvarias_Total: TADOTable
    Left = 9
    Top = 264
  end
  inherited tbPreviaDeCaixa: TADOTable
    Left = 312
    Top = 224
  end
  inherited tbOperadores: TADOTable
    Left = 352
    Top = 224
  end
  inherited tbTotRec: TADOTable
    Left = 392
    Top = 224
  end
  inherited tbSangrias: TADOTable
    Left = 432
    Top = 224
  end
  inherited tbVendasCartao: TADOTable
    Left = 480
    Top = 224
  end
  inherited qr: TADOQuery
    Left = 72
    Top = 200
  end
  object DS: TDataSource
    Left = 72
    Top = 248
  end
end
