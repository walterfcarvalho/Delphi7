object fmExportaPedido: TfmExportaPedido
  Left = 351
  Top = 180
  Width = 502
  Height = 134
  Anchors = []
  Caption = 'Exportacao de Pedidos'
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
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object cbPreco02: TadLabelComboBox
    Left = 344
    Top = 24
    Width = 139
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
    TabStop = False
    LabelDefs.Width = 43
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Preco 02'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object cbPreco01: TadLabelComboBox
    Left = 200
    Top = 24
    Width = 139
    Height = 21
    BevelKind = bkSoft
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    TabStop = False
    LabelDefs.Width = 43
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Preco 01'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object edCodigo: TadLabelEdit
    Left = 3
    Top = 19
    Width = 163
    Height = 26
    LabelDefs.Width = 33
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Pedido'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    CharCase = ecUpperCase
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object Button1: TButton
    Left = 406
    Top = 61
    Width = 75
    Height = 29
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 3
    OnClick = Button1Click
  end
end
