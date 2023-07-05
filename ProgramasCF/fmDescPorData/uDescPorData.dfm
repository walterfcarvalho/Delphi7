inherited fmDescPorData: TfmDescPorData
  Caption = 'Descontos dados por data.'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnParam: TPanel
    inherited btOk: TFlatButton
      Width = 69
    end
    inherited pnSelCat: TPanel
      Height = 21
    end
    object FlatButton1: TFlatButton
      Left = 657
      Top = 62
      Width = 69
      Height = 26
      Caption = 'Imprime'
      Glyph.Data = {
        66010000424D6601000000000000760000002800000014000000140000000100
        040000000000F000000000000000000000001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
        DDDDDDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDDD7777777777DDDDD0000DDDD
        000000000007DDDD0000DDD07878787870707DDD0000DD0000000000000707DD
        0000DD0F8F8F8AAA8F0007DD0000DD08F8F8F999F80707DD0000DD0000000000
        0008707D0000DD08F8F8F8F8F080807D0000DDD0000000000F08007D0000DDDD
        0BFFFBFFF0F080DD0000DDDDD0F00000F0000DDD0000DDDDD0FBFFFBFF0DDDDD
        0000DDDDDD0F00000F0DDDDD0000DDDDDD0FFBFFFBF0DDDD0000DDDDDDD00000
        0000DDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDDDDDDDDDDDDDDDDDD0000DDDD
        DDDDDDDDDDDDDDDD0000}
      Layout = blGlyphLeft
      TabOrder = 6
      ModalResult = 1
      OnClick = FlatButton1Click
    end
  end
  object grid: TSoftDBGrid [1]
    Left = 136
    Top = 200
    Width = 561
    Height = 120
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = gridDblClick
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  inherited tbPreviaDeCaixa: TADOTable
    Left = 16
    Top = 232
  end
  inherited tbOperadores: TADOTable
    CursorType = ctStatic
    Left = 288
    Top = 216
    object tbOperadoresds_uo: TStringField
      FieldName = 'ds_uo'
      Size = 50
    end
    object tbOperadoresnota: TStringField
      FieldName = 'nota'
      Size = 63
    end
    object tbOperadoresValorProdutos: TBCDField
      FieldName = 'ValorProdutos'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbOperadoresvalorVenda: TBCDField
      FieldName = 'valor Venda'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbOperadoresNumeropedido: TIntegerField
      FieldName = 'Numero pedido'
    end
    object tbOperadoresPercentualDesconto: TBCDField
      FieldName = 'Percentual Desconto'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbOperadoresValorDesconto: TBCDField
      FieldName = 'Valor Desconto'
      DisplayFormat = '#,###,###0.00'
      Precision = 19
    end
    object tbOperadoresds_tipoPreco: TStringField
      FieldName = 'ds_tipoPreco'
      Size = 50
    end
  end
  inherited tbTotRec: TADOTable
    Left = 16
    Top = 208
  end
  inherited tbSangrias: TADOTable
    Left = 24
    Top = 232
  end
  inherited tbVendasCartao: TADOTable
    Left = 24
  end
  object DataSource1: TDataSource
    DataSet = tbOperadores
    Left = 248
    Top = 216
  end
end
