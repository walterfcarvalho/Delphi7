inherited fmManutencaoCX: TfmManutencaoCX
  Left = 391
  Top = 172
  Caption = 'fmManutencaoCX'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object lbCodCaixa: TLabel [1]
    Left = 373
    Top = 67
    Width = 3
    Height = 13
  end
  inherited cbLojas: TadLabelComboBox
    OnChange = cbLojasChange
  end
  inherited grid: TSoftDBGrid
    Top = 153
    Height = 227
    Visible = False
  end
  inherited GroupBox1: TGroupBox
    inherited cbModalidade: TadLabelComboBox
      OnChange = cbModalidadeChange
    end
    inherited edBusca: TadLabelNumericEdit
      Visible = False
    end
  end
  inherited cbCaixas: TadLabelComboBox
    OnChange = cbCaixasChange
  end
end
