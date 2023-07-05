inherited fmBuscaDiversas: TfmBuscaDiversas
  Left = 401
  Top = 139
  Caption = 'fmBuscaDiversas'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object edFiltro: TEdit [0]
    Left = 342
    Top = 22
    Width = 161
    Height = 19
    Color = clBtnFace
    Ctl3D = False
    Enabled = False
    ParentCtl3D = False
    TabOrder = 6
    Text = 'edFiltro'
  end
  inherited fnGrid: TSoftDBGrid
    OnDblClick = fnGridDblClick
  end
end
