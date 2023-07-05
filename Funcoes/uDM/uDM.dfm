object dm: Tdm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Left = 762
  Top = 244
  Height = 150
  Width = 215
  object con: TADOConnection
    ConnectionTimeout = 3
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    OnInfoMessage = conInfoMessage
    OnExecuteComplete = conExecuteComplete
    OnWillExecute = conWillExecute
    Left = 32
    Top = 16
  end
end
