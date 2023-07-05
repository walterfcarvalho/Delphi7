object fmExportaTable: TfmExportaTable
  Left = 764
  Top = 274
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Selecione o destino da exporta'#231#227'o'
  ClientHeight = 62
  ClientWidth = 352
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
  PixelsPerInch = 96
  TextHeight = 13
  object rgDestino: TRadioGroup
    Left = 6
    Top = 6
    Width = 141
    Height = 46
    Caption = ' Exportar para '
    ItemIndex = 0
    Items.Strings = (
      ' - Abrir no computador'
      ' - Email')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 264
    Top = 17
    Width = 75
    Height = 29
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 1
  end
  object rgFormato: TRadioGroup
    Left = 160
    Top = 7
    Width = 89
    Height = 46
    Caption = 'Formato: '
    ItemIndex = 0
    Items.Strings = (
      'Excel'
      'Csv')
    TabOrder = 2
  end
end
