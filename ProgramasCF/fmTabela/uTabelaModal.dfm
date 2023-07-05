inherited fmTbModal: TfmTbModal
  Caption = ''
  FormStyle = fsStayOnTop
  Visible = False
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgrid: TSoftDBGrid
    Height = 295
  end
  inherited pnPesqItem: TPanel
    Top = 417
  end
  inherited Query: TADOQuery
    inherited QueryestoqueAtual: TIntegerField
      DisplayLabel = 'Estoque Atual'
    end
  end
end
