object fmSelCat: TfmSelCat
  Left = 392
  Top = 87
  Width = 573
  Height = 550
  Caption = 'Selecionar os valores das categorias.'
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
  OnCreate = FormCreate
  DesignSize = (
    557
    512)
  PixelsPerInch = 96
  TextHeight = 13
  object lbnivel: TLabel
    Left = 43
    Top = 473
    Width = 32
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'lbNivel'
  end
  object lbValorNivel: TLabel
    Left = 43
    Top = 490
    Width = 56
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'lbValorNivel'
  end
  object Label1: TLabel
    Left = 5
    Top = 473
    Width = 36
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'N'#237'vel:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 7
    Top = 490
    Width = 34
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Valor:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object grClasse1: TSoftDBGrid
    Left = 3
    Top = 4
    Width = 180
    Height = 456
    Anchors = [akLeft, akTop, akBottom]
    Ctl3D = False
    DataSource = DsClasse1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = grClasse1CellClick
    OnTitleClick = grClasse1TitleClick
    AlternateColor = True
    ColorLow = clHighlightText
    ColorHigh = clInfoBk
    Columns = <
      item
        Expanded = False
        FieldName = 'cd_vcampo'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ds_vcampo'
        Title.Caption = 'Departamento'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 237
        Visible = True
      end>
  end
  object grClasse2: TSoftDBGrid
    Left = 188
    Top = 4
    Width = 180
    Height = 456
    Anchors = [akLeft, akTop, akBottom]
    Ctl3D = False
    DataSource = dsClasse2
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = grClasse2CellClick
    OnTitleClick = grClasse2TitleClick
    AlternateColor = True
    ColorLow = clHighlightText
    ColorHigh = clInfoBk
    Columns = <
      item
        Expanded = False
        FieldName = 'cd_vcampo'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ds_vcampo'
        Title.Caption = 'Sec'#231#227'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 237
        Visible = True
      end>
  end
  object grClasse3: TSoftDBGrid
    Left = 373
    Top = 5
    Width = 180
    Height = 456
    Anchors = [akLeft, akTop, akBottom]
    Ctl3D = False
    DataSource = dsClasse3
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnCellClick = grClasse3CellClick
    OnTitleClick = grClasse3TitleClick
    AlternateColor = True
    ColorLow = clHighlightText
    ColorHigh = clInfoBk
    Columns = <
      item
        Expanded = False
        FieldName = 'cd_vcampo'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ds_vcampo'
        Title.Caption = 'Categoria'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -11
        Title.Font.Name = 'MS Sans Serif'
        Title.Font.Style = [fsBold]
        Width = 237
        Visible = True
      end>
  end
  object fsBitBtn1: TfsBitBtn
    Left = 396
    Top = 475
    Width = 75
    Height = 27
    Anchors = [akLeft, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
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
    NumGlyphs = 2
  end
  object fsBitBtn2: TfsBitBtn
    Left = 477
    Top = 475
    Width = 75
    Height = 27
    Anchors = [akLeft, akBottom]
    Caption = 'Cancela'
    ModalResult = 2
    TabOrder = 4
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object qrClasse1: TADOQuery
    Parameters = <>
    SQL.Strings = (
      
        'select cd_vcampo, ds_vcampo  from tvcom  with(Nolock) where cd_c' +
        'ampo =1 order by ds_vcampo')
    Left = 40
    Top = 72
  end
  object qrClasse2: TADOQuery
    BeforeClose = qrClasse2BeforeClose
    Parameters = <>
    SQL.Strings = (
      
        'select cd_vcampo, ds_vcampo  from tvcom  with(Nolock) where cd_c' +
        'ampo =2 order by ds_vcampo')
    Left = 256
    Top = 72
  end
  object qrClasse3: TADOQuery
    Parameters = <>
    SQL.Strings = (
      
        'select cd_vcampo, ds_vcampo  from tvcom  with(Nolock) where cd_c' +
        'ampo =3 order by ds_vcampo')
    Left = 400
    Top = 80
  end
  object DsClasse1: TDataSource
    DataSet = qrClasse1
    Left = 40
    Top = 104
  end
  object dsClasse2: TDataSource
    DataSet = qrClasse2
    Left = 256
    Top = 104
  end
  object dsClasse3: TDataSource
    DataSet = qrClasse3
    Left = 400
    Top = 112
  end
end
