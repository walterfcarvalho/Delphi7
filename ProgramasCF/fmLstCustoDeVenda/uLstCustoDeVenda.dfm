object fmLstCustoDeVenda: TfmLstCustoDeVenda
  Left = 358
  Top = 236
  Width = 500
  Height = 150
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Lista Preco de varejo e custo dos produtos vendidos'
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
  object Label2: TLabel
    Left = 176
    Top = 12
    Width = 38
    Height = 13
    Caption = 'Per'#237'odo'
  end
  object cbLojas: TadLabelComboBox
    Left = 11
    Top = 32
    Width = 145
    Height = 21
    BevelInner = bvNone
    BevelOuter = bvNone
    Style = csDropDownList
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 0
    LabelDefs.Width = 20
    LabelDefs.Height = 13
    LabelDefs.Caption = 'Loja'
    Colors.WhenEnterFocus.BackColor = clInfoBk
  end
  object datai: TfsDateTimePicker
    Left = 173
    Top = 31
    Width = 105
    Height = 21
    Date = 40290.641664976850000000
    Time = 40290.641664976850000000
    TabOrder = 1
  end
  object dataf: TfsDateTimePicker
    Left = 293
    Top = 31
    Width = 105
    Height = 21
    Date = 40290.641664976850000000
    Time = 40290.641664976850000000
    TabOrder = 2
  end
  object btOk: TFlatButton
    Left = 415
    Top = 28
    Width = 60
    Height = 26
    Caption = '&OK'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    Layout = blGlyphLeft
    NumGlyphs = 2
    TabOrder = 3
    ModalResult = 1
    OnClick = btOkClick
  end
end
