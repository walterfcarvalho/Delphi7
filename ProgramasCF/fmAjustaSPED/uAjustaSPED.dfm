object fmAjustaSPED: TfmAjustaSPED
  Left = 435
  Top = 158
  Width = 843
  Height = 435
  Caption = 'fmAjustaSPED'
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
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object edArq: TadLabelEdit
    Left = 190
    Top = 21
    Width = 319
    Height = 22
    LabelDefs.Width = 74
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Arquivo  SPED:'
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = 'Duplo clique para selecionar o arquivo'
    OnDblClick = edArqDblClick
  end
  object fsBitBtn1: TfsBitBtn
    Left = 512
    Top = 17
    Width = 75
    Height = 30
    Caption = 'Processar'
    TabOrder = 1
    OnClick = fsBitBtn1Click
  end
  object memo: TfsMemo
    Left = 7
    Top = 250
    Width = 801
    Height = 134
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object btOcoProduto: TButton
    Left = 636
    Top = 18
    Width = 114
    Height = 27
    Caption = 'Ocorr'#234'ncias produto'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = btOcoProdutoClick
  end
  object edRef: TEdit
    Left = 755
    Top = 22
    Width = 49
    Height = 21
    TabOrder = 4
  end
  object cbAjustaDia: TfsCheckBox
    Left = 190
    Top = 50
    Width = 78
    Height = 16
    Caption = 'Ajuste o dia:'
    TabOrder = 5
    OnClick = cbAjustaDiaClick
    FlatFont.Charset = DEFAULT_CHARSET
    FlatFont.Color = clWindowText
    FlatFont.Height = -11
    FlatFont.Name = 'MS Sans Serif'
    FlatFont.Style = []
  end
  object data: TfsDateTimePicker
    Left = 267
    Top = 48
    Width = 88
    Height = 21
    Date = 41106.371914826390000000
    Time = 41106.371914826390000000
    Enabled = False
    TabOrder = 6
  end
  object edECF: TadLabelEdit
    Left = 410
    Top = 47
    Width = 99
    Height = 22
    LabelDefs.Width = 47
    LabelDefs.Height = 13
    LabelDefs.Caption = 'S'#233'rie ECF'
    LabelPosition = adLeft
    Colors.WhenEnterFocus.BackColor = clInfoBk
    Ctl3D = False
    ParentCtl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 6
    ParentFont = False
    TabOrder = 7
    OnDblClick = edArqDblClick
  end
  object pnFiscal: TPanel
    Left = 7
    Top = 83
    Width = 513
    Height = 138
    BevelOuter = bvNone
    TabOrder = 8
    object cbAjustaECF: TfsCheckBox
      Left = 1
      Top = 1
      Width = 233
      Height = 16
      Caption = 'Aplica o martelinho de ouro nos registro ECF'
      Checked = True
      State = cbChecked
      TabOrder = 0
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbAjCfoEnt: TfsCheckBox
      Left = 1
      Top = 20
      Width = 256
      Height = 16
      Caption = 'Notas de entrada ajusta CFO itens com a cabe'#231'a'
      Checked = True
      State = cbChecked
      TabOrder = 1
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbAjVlTotNota: TfsCheckBox
      Left = 1
      Top = 38
      Width = 169
      Height = 16
      Caption = 'Ajusta valor total nota entrada'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 2
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbAjTotTribEcf: TfsCheckBox
      Left = 1
      Top = 56
      Width = 169
      Height = 16
      Caption = 'Ajusta totais trib ECF'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 3
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbAjCodProd: TfsCheckBox
      Left = 248
      Top = 1
      Width = 233
      Height = 16
      Caption = 'Substituir is_ref por cd_ref nos itens'
      Checked = True
      State = cbChecked
      TabOrder = 4
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cb_c190_c490: TfsCheckBox
      Left = 249
      Top = 20
      Width = 193
      Height = 16
      Caption = 'Remove C490/C190 duplicado'
      Checked = True
      State = cbChecked
      TabOrder = 5
      OnClick = cbdirvg_c100Click
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbAjC100: TfsCheckBox
      Left = 250
      Top = 39
      Width = 193
      Height = 16
      Caption = 'Ajusta registro C100'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 6
      OnClick = cbdirvg_c100Click
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbRem_C425_duplicado: TfsCheckBox
      Left = 250
      Top = 58
      Width = 193
      Height = 16
      Caption = 'Remove  C425 duplicado'
      Checked = True
      State = cbChecked
      TabOrder = 7
      OnClick = cbdirvg_c100Click
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbRecC100prop: TfsCheckBox
      Left = 1
      Top = 89
      Width = 245
      Height = 16
      Caption = 'Recalc notas emiss propria usando arq regras.'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 8
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbRecC100ter: TfsCheckBox
      Left = 1
      Top = 74
      Width = 245
      Height = 16
      Caption = 'Recalc notas emiss terc usando arq regras.'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 9
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbRemNfEntEmissPropria: TfsCheckBox
      Left = 251
      Top = 77
      Width = 245
      Height = 16
      Caption = 'Rem entrada fornecedor igual Filial.'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 10
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object edRecC100prop: TadLabelEdit
      Left = 99
      Top = 103
      Width = 136
      Height = 17
      HelpType = htKeyword
      LabelDefs.Width = 79
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Uo'#39's adicional(is)'
      LabelPosition = adLeft
      AutoSize = False
      Ctl3D = False
      ParentCtl3D = False
      Color = clInfoBk
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
    end
  end
  object rgTpSped: TRadioGroup
    Left = 8
    Top = 8
    Width = 177
    Height = 58
    Caption = ' Selecione qual SPED '
    ItemIndex = 0
    Items.Strings = (
      ' Fiscal'
      ' PIS/COFINS')
    TabOrder = 9
    OnClick = rgTpSpedClick
  end
  object pnPis: TPanel
    Left = 439
    Top = 83
    Width = 368
    Height = 73
    BevelOuter = bvNone
    TabOrder = 10
    Visible = False
    object cbAjusEcfPISCofins: TfsCheckBox
      Left = 1
      Top = 1
      Width = 233
      Height = 16
      Caption = 'Aplica o martelinho de ouro nos registro ECF'
      Checked = True
      State = cbChecked
      TabOrder = 0
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbVerDrgRedPisCofins: TfsCheckBox
      Left = 1
      Top = 20
      Width = 207
      Height = 16
      Caption = 'Verifica dirveg'#234'ncia C405 e  c481-c485'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = cbVerDrgRedPisCofinsClick
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object cbdirvg_c100: TfsCheckBox
      Left = 1
      Top = 40
      Width = 168
      Height = 16
      Caption = 'Verifica dirveg'#234'ncia C100 C170'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = cbdirvg_c100Click
      FlatFont.Charset = DEFAULT_CHARSET
      FlatFont.Color = clWindowText
      FlatFont.Height = -11
      FlatFont.Name = 'MS Sans Serif'
      FlatFont.Style = []
    end
    object edDifc100_170: TadLabelNumericEdit
      Left = 240
      Top = 40
      Width = 65
      Height = 16
      HelpType = htKeyword
      LabelDefs.Width = 62
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Dif maior que'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clWindow
      Colors.WhenExitFocus.BackColor = clInfoBk
      AutoSize = False
      Color = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Value = 0.020000000000000000
    end
    object edDicc481: TadLabelNumericEdit
      Left = 278
      Top = 20
      Width = 65
      Height = 16
      LabelDefs.Width = 62
      LabelDefs.Height = 13
      LabelDefs.Caption = 'Dif maior que'
      LabelPosition = adLeft
      Colors.WhenEnterFocus.BackColor = clWindow
      Colors.WhenExitFocus.BackColor = clInfoBk
      AutoSize = False
      Color = clInfoBk
      Ctl3D = False
      ParentCtl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Value = 0.020000000000000000
    end
  end
end
