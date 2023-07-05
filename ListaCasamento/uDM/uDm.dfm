object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 596
  Top = 252
  Height = 150
  Width = 215
  object con: TADOConnection
    LoginPrompt = False
    OnExecuteComplete = conExecuteComplete
    OnWillExecute = conWillExecute
    Left = 32
    Top = 16
  end
end
