object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'ETL'
  ClientHeight = 451
  ClientWidth = 933
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grdDados: TDBGrid
    Left = 0
    Top = 28
    Width = 933
    Height = 298
    Align = alTop
    DataSource = dsDados
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 416
    Width = 933
    Height = 35
    Align = alBottom
    TabOrder = 1
    object Label1: TLabel
      Left = 9
      Top = 11
      Width = 91
      Height = 16
      Caption = 'Total Registros:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblqtdreg: TLabel
      Left = 106
      Top = 11
      Width = 7
      Height = 16
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 207
      Top = 11
      Width = 108
      Height = 16
      Caption = 'CPF Invalido Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalCpfInvalid: TLabel
      Left = 321
      Top = 11
      Width = 7
      Height = 16
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 399
      Top = 11
      Width = 114
      Height = 16
      Caption = 'CNPJ Invalido Total:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalCNPJInvalid: TLabel
      Left = 519
      Top = 11
      Width = 7
      Height = 16
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Button1: TButton
      Left = 771
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Load data'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 850
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Close'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 692
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Export data'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 614
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Script ETL'
      TabOrder = 3
      OnClick = Button4Click
    end
  end
  object edtArquivo: TEdit
    Left = 0
    Top = 0
    Width = 933
    Height = 22
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
  end
  object mDados: TMemo
    Left = 0
    Top = 22
    Width = 933
    Height = 6
    Align = alTop
    TabOrder = 3
    Visible = False
    ExplicitHeight = 182
  end
  object mScript: TMemo
    Left = 0
    Top = 327
    Width = 933
    Height = 89
    Align = alBottom
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object dsDados: TDataSource
    DataSet = cdsDados
    Left = 496
    Top = 216
  end
  object cdsDados: TClientDataSet
    PersistDataPacket.Data = {
      290100009619E0BD010000001800000008000000000003000000290104746370
      6601004A00000001000557494454480200020026000874707269766174650100
      4A00000001000557494454480200020028000B74696E636F6E706C65746F0100
      4A00000001000557494454480200020028000F6444617461556C745F436F6D70
      726101004A0000000100055749445448020002002C000C6E5469636B745F4D65
      64696F01004A0000000100055749445448020002002C00116E5469636B745F55
      6C745F436F6D70726101004A00000001000557494454480200020028000F7463
      6E706A5F4C6F6A615F4672657101004A00000001000557494454480200020028
      001574636E706A5F4C6F6A615F556C745F436F6D70726101004A000000010005
      5749445448020002002C000000}
    Active = True
    Aggregates = <>
    Params = <>
    Left = 584
    Top = 216
    object cdsDadostcpf: TWideStringField
      DisplayLabel = 'CPF'
      DisplayWidth = 13
      FieldName = 'tcpf'
      Size = 19
    end
    object cdsDadostprivate: TWideStringField
      DisplayLabel = 'Private'
      DisplayWidth = 12
      FieldName = 'tprivate'
    end
    object cdsDadostinconpleto: TWideStringField
      DisplayLabel = 'Inconpleto'
      DisplayWidth = 13
      FieldName = 'tinconpleto'
    end
    object cdsDadosdDataUlt_Compra: TWideStringField
      Alignment = taCenter
      DisplayLabel = 'Data ult. Compra'
      DisplayWidth = 14
      FieldName = 'dDataUlt_Compra'
      Size = 22
    end
    object cdsDadosnTickt_Medio: TWideStringField
      Alignment = taRightJustify
      DisplayLabel = 'Tickt M'#233'dio'
      DisplayWidth = 14
      FieldName = 'nTickt_Medio'
      Size = 22
    end
    object cdsDadosnTickt_Ult_Compra: TWideStringField
      DisplayLabel = 'Tickt ult. Compra'
      DisplayWidth = 20
      FieldName = 'nTickt_Ult_Compra'
    end
    object cdsDadostcnpj_Loja_Freq: TWideStringField
      DisplayLabel = 'Loja Frequente'
      DisplayWidth = 20
      FieldName = 'tcnpj_Loja_Freq'
    end
    object cdsDadostcnpj_Loja_Ult_Compra: TWideStringField
      DisplayLabel = 'Loja ult. Compra'
      DisplayWidth = 22
      FieldName = 'tcnpj_Loja_Ult_Compra'
      Size = 22
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 496
    Top = 272
  end
  object SaveDialog1: TSaveDialog
    Left = 576
    Top = 272
  end
end
