inherited fmRecibo: TfmRecibo
  Left = 373
  Top = 174
  Caption = 'fmRecibo'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Label1: TLabel
    Left = 36
    Top = 433
  end
  inherited grid: TSoftDBGrid
    Top = 349
    Width = 116
    Height = 100
  end
  inherited edNova: TFlatButton
    Caption = 'Novo'
  end
  object gb2: TGroupBox [8]
    Left = 4
    Top = 131
    Width = 637
    Height = 113
    Caption = '  Dados da venda'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    object Label3: TLabel
      Left = 42
      Top = 82
      Width = 26
      Height = 13
      Caption = 'Data:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edNota: TadLabelEdit
      Left = 75
      Top = 18
      Width = 535
      Height = 19
      LabelDefs.Width = 59
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Referente a '
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = []
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edValor: TadLabelNumericEdit
      Left = 75
      Top = 48
      Width = 110
      Height = 19
      LabelDefs.Width = 30
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Valor: '
      LabelDefs.Font.Charset = DEFAULT_CHARSET
      LabelDefs.Font.Color = clWindowText
      LabelDefs.Font.Height = -11
      LabelDefs.Font.Name = 'MS Sans Serif'
      LabelDefs.Font.Style = []
      LabelDefs.ParentFont = False
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object date: TfsDateTimePicker
      Left = 75
      Top = 78
      Width = 111
      Height = 21
      Date = 36526.536439884260000000
      Time = 36526.536439884260000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MinDate = -620910.000000000000000000
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited Table: TADOTable
    Left = 64
    Top = 392
  end
  inherited DataSource1: TDataSource
    Left = 16
    Top = 392
  end
end
