inherited fmRelGeral1: TfmRelGeral1
  Caption = 'Raz'#227'o anal'#237'tico RRANA'
  OldCreateOrder = True
  OnCanResize = FormCanResize
  PixelsPerInch = 96
  TextHeight = 13
  object edCodigo: TadLabelEdit [0]
    Left = 3
    Top = 110
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
    TabOrder = 1
  end
  inherited pnParam: TPanel
    BevelOuter = bvNone
  end
  inherited tbValoresAvarias: TADOTable
    Top = 191
  end
  inherited tbValoresAvarias_Total: TADOTable
    Top = 224
  end
  inherited qr: TADOQuery
    Connection = dm.con
    Top = 160
  end
end
