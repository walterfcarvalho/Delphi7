object fmDetalhesNota: TfmDetalhesNota
  Left = 389
  Top = 202
  Width = 699
  Height = 524
  Caption = 'Detalhes da Nota fiscal'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  DesignSize = (
    683
    485)
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 10
    Top = 93
    Width = 664
    Height = 2
    Anchors = [akLeft, akTop, akRight]
  end
  object grid: TSoftDBGrid
    Left = 4
    Top = 117
    Width = 674
    Height = 365
    Anchors = [akLeft, akTop, akRight, akBottom]
    Ctl3D = False
    DataSource = dsItens
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = gridDrawColumnCell
    AlternateColor = True
    ColorLow = clWindow
    ColorHigh = clInfoBk
  end
  object Panel1: TPanel
    Left = -1
    Top = 2
    Width = 678
    Height = 84
    Anchors = [akLeft, akTop, akRight]
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      678
      84)
    object StaticText2: TStaticText
      Left = 5
      Top = 2
      Width = 4
      Height = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      Left = 6
      Top = 2
      Width = 664
      Height = 78
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = ' Cabe'#231'alho da Nota '
      TabOrder = 1
      object lbDestEmit: TLabel
        Left = 5
        Top = 30
        Width = 58
        Height = 13
        Caption = 'Emitente: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 5
        Top = 45
        Width = 51
        Height = 13
        Caption = 'Emiss'#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 5
        Top = 16
        Width = 36
        Height = 13
        Caption = 'Nota: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbNota: TLabel
        Left = 85
        Top = 15
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbEmitente: TLabel
        Left = 85
        Top = 30
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbOperacao: TLabel
        Left = 238
        Top = 45
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 175
        Top = 45
        Width = 60
        Height = 13
        Caption = 'Opera'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbEmissao: TLabel
        Left = 85
        Top = 45
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 5
        Top = 60
        Width = 58
        Height = 13
        Caption = 'Ent/sa'#237'da'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbEntSai: TLabel
        Left = 85
        Top = 60
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label1: TLabel
        Left = 500
        Top = 14
        Width = 29
        Height = 13
        Caption = 'CFO:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbCFO: TLabel
        Left = 535
        Top = 14
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 472
        Top = 30
        Width = 34
        Height = 13
        Caption = 'Valor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbValor: TLabel
        Left = 510
        Top = 30
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 406
        Top = 49
        Width = 99
        Height = 13
        Caption = 'Despesas Extras:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbDEspExtra: TLabel
        Left = 510
        Top = 49
        Width = 36
        Height = 13
        Caption = '000000'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object edIsNota: TadLabelEdit
        Left = 275
        Top = 8
        Width = 102
        Height = 22
        LabelDefs.Width = 97
        LabelDefs.Height = 13
        LabelDefs.Caption = 'Identificador BD:'
        LabelDefs.Font.Charset = DEFAULT_CHARSET
        LabelDefs.Font.Color = clWindowText
        LabelDefs.Font.Height = -11
        LabelDefs.Font.Name = 'MS Sans Serif'
        LabelDefs.Font.Style = [fsBold]
        LabelDefs.ParentFont = False
        LabelPosition = adLeft
        Colors.WhenEnterFocus.BackColor = clWindow
        Colors.WhenExitFocus.BackColor = clInfoBk
        AutoSize = False
        Ctl3D = False
        ParentCtl3D = False
        CharCase = ecUpperCase
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 3
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object Button1: TButton
        Left = 576
        Top = 32
        Width = 75
        Height = 25
        Caption = 'recarrega'
        TabOrder = 1
        OnClick = Button1Click
      end
    end
  end
  object StaticText1: TStaticText
    Left = 5
    Top = 99
    Width = 68
    Height = 17
    Caption = 'Itens da Nota'
    TabOrder = 2
  end
  object dsItens: TDataSource
    Left = 128
    Top = 168
  end
end
