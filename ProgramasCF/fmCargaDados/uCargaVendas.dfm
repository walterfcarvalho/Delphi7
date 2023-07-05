object fmCargaVendas: TfmCargaVendas
  Left = 330
  Top = 54
  Width = 794
  Height = 570
  Caption = 'Efetua carga das vendas da empresa'
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
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 137
    Width = 778
    Height = 394
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object memo: TadLabelMemo
      Left = 1
      Top = 14
      Width = 776
      Height = 379
      Align = alClient
      Color = clBtnFace
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      LabelDefs.Width = 776
      LabelDefs.Height = 13
      LabelDefs.Align = alTop
      LabelDefs.Caption = 'Log das a'#231#245'es executadas:'
      Colors.WhenEnterFocus.BackColor = clWindow
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 778
    Height = 137
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object edDtUltCarga: TadLabelEdit
      Left = 112
      Top = 23
      Width = 140
      Height = 26
      LabelDefs.Width = 104
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Data da ultima carga: '
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
    object edHoraCarga: TadLabelMaskEdit
      Left = 112
      Top = 60
      Width = 140
      Height = 26
      Ctl3D = False
      EditMask = '!99:99;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 5
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      Text = '  :  '
      LabelDefs.Width = 71
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Hora da carga:'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clInfoBk
    end
    object BitBtn1: TBitBtn
      Left = 288
      Top = 40
      Width = 75
      Height = 25
      Caption = 'BitBtn1'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 197
    Top = 102
  end
end
