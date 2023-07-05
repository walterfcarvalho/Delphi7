object fmGuia: TfmGuia
  Left = 372
  Top = 124
  Width = 745
  Height = 489
  Caption = 'Impress'#227'o de guia de entrega.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 5
    Top = 3
    Width = 423
    Height = 42
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 5
      Width = 29
      Height = 13
      Caption = 'Loja:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbLoja: TLabel
      Left = 35
      Top = 5
      Width = 35
      Height = 13
      Caption = 'lbLoja'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object Label5: TLabel
      Left = 5
      Top = 20
      Width = 32
      Height = 13
      Caption = 'Nota:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbNota: TLabel
      Left = 36
      Top = 20
      Width = 49
      Height = 13
      Caption = '000/000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object lbIsNota: TLabel
      Left = 359
      Top = 5
      Width = 39
      Height = 13
      Caption = 'lbIsNota'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lbUo: TLabel
      Left = 163
      Top = 21
      Width = 22
      Height = 13
      Caption = 'lbUo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object lbSrAnt: TLabel
      Left = 257
      Top = 21
      Width = 34
      Height = 13
      Caption = 'lbSrAnt'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object Label2: TLabel
      Left = 257
      Top = 5
      Width = 97
      Height = 13
      Caption = 'Identificador BD:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object cbTpNovaSerie: TFlatButton
    Left = 558
    Top = 5
    Width = 84
    Height = 22
    Hint = 'Obter Dados do Cliente'
    Caption = 'Nova'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = cbTpNovaSerieClick
  end
  object btImp: TFlatButton
    Left = 559
    Top = 39
    Width = 84
    Height = 22
    Hint = 'Obter Dados do Cliente'
    Caption = 'Imprimir'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = btImpClick
  end
  object edMsg: TadLabelEdit
    Left = 7
    Top = 67
    Width = 634
    Height = 19
    LabelDefs.Width = 52
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Mensagem'
    LabelDefs.Font.Charset = DEFAULT_CHARSET
    LabelDefs.Font.Color = clWindowText
    LabelDefs.Font.Height = -11
    LabelDefs.Font.Name = 'MS Sans Serif'
    LabelDefs.Font.Style = []
    LabelDefs.ParentFont = False
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 250
    ParentFont = False
    TabOrder = 3
    Visible = False
  end
end
