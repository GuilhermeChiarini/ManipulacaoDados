{***************************************************************************}
{                        MANIPULÃO DE DADOS - ETL                           }
{                     HISTÓRICO DE ALTERAÇÕES DA UNIT                       }
{                                                                           }
{Data       Autor                  Tarefa Descrição                         }
{---------- ---------------------- ------ ----------------------------------}
{08/10/2020 Guilherme.Chiarini        001 Criação de manipulação de dados   }
{                                         ETL                               }
{***************************************************************************}


unit uManipulacaoDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    grdDados: TDBGrid;
    Panel1: TPanel;
    Button1: TButton;
    dsDados: TDataSource;
    cdsDados: TClientDataSet;
    Button2: TButton;
    edtArquivo: TEdit;
    mDados: TMemo;
    Button3: TButton;
    Label1: TLabel;
    lblqtdreg: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    cdsDadostcpf: TWideStringField;
    cdsDadostprivate: TWideStringField;
    cdsDadostinconpleto: TWideStringField;
    cdsDadosdDataUlt_Compra: TWideStringField;
    cdsDadosnTickt_Medio: TWideStringField;
    cdsDadosnTickt_Ult_Compra: TWideStringField;
    cdsDadostcnpj_Loja_Freq: TWideStringField;
    cdsDadostcnpj_Loja_Ult_Compra: TWideStringField;
    Label2: TLabel;
    lblTotalCpfInvalid: TLabel;
    Label3: TLabel;
    lblTotalCNPJInvalid: TLabel;
    Button4: TButton;
    mScript: TMemo;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }

   function Remove_Acento(ATexto: string):string;
   function isCPF(CPF: string): boolean;
   function isCNPJ(CNPJ: string): boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var ArqTxt: TextFile;
    linha, sDados, sCPF, sPrivate, sIncompleto, sDataUlt_Compra: string;
    sTicktMedio, sTickt_UltCompra, sCNPJ_LojaFrequente, sCNPJ_LojaUltCompra: string;
    i, iTotalCPF_Invalid, iTotalCNPJ_Invalid: Integer;
    sCPF_Validar, sCNPJ1_Validar, sCNPJ2_Validar: string;
begin
  OpenDialog1.Execute();
  edtArquivo.Text := OpenDialog1.FileName;
  AssignFile(ArqTxt, edtArquivo.Text);
  Reset(ArqTxt);

  i := 0;
  iTotalCPF_Invalid := 0;
  iTotalCNPJ_Invalid := 0;
  cdsDados.Open;

  //Ação de carragamento de dados
  while not eof(ArqTxt) do
  begin
    i := i + 1;
    sDados := EmptyStr;
    sCPF := EmptyStr;
    sPrivate := EmptyStr;
    sDataUlt_Compra := EmptyStr;
    sTicktMedio := EmptyStr;
    sTickt_UltCompra := EmptyStr;
    sCNPJ_LojaFrequente := EmptyStr;
    sCNPJ_LojaUltCompra := EmptyStr;
    sCPF_Validar := EmptyStr;
    sCNPJ1_Validar := EmptyStr;
    sCNPJ2_Validar := EmptyStr;

    Readln(ArqTxt, Linha);

    sCPF_Validar := StringReplace(StringReplace(Remove_Acento(trim(copy(linha,0,19))),'.','',[rfReplaceAll]), '-','',[rfReplaceAll]);
    sCNPJ1_Validar := StringReplace(StringReplace(StringReplace(Remove_Acento(trim(copy(linha,132,20))),'.','',[rfReplaceAll]), '-','',[rfReplaceAll]), '/','',[rfReplaceAll]);
    sCNPJ2_Validar := AnsiUpperCase(StringReplace(StringReplace(StringReplace(Remove_Acento(trim(copy(linha,155,23))),'.','',[rfReplaceAll]), '-','',[rfReplaceAll]), '/','',[rfReplaceAll]));


    //Validando CPF
    if not isCPF(sCPF_Validar) then
    begin
      iTotalCPF_Invalid := iTotalCPF_Invalid + 1;
    end;

     //Validando CNPJ
     if not isCNPJ(sCNPJ1_Validar) then
     begin
       iTotalCNPJ_Invalid := iTotalCNPJ_Invalid + 1;
     end;

    //Ação de carragamento de dados
    sCPF := StringReplace(StringReplace
                         (Remove_Acento(trim(copy(linha,0,19)))+';','.','',[rfReplaceAll]), '-','',[rfReplaceAll]);
    sPrivate := Remove_Acento(trim(copy(linha,20,12)))+';';
    sIncompleto := Remove_Acento(trim(copy(linha,32,12)))+';';
    sDataUlt_Compra := Remove_Acento(Trim(copy(linha,44,22)))+';';
    sTicktMedio := Remove_Acento(trim(copy(linha,66,22)))+';';
    sTickt_UltCompra := Remove_Acento(trim(copy(linha,88,20)))+';';

    sCNPJ_LojaFrequente := StringReplace(StringReplace(StringReplace(Remove_Acento(trim(copy(linha,112,20)))+';','.','',[rfReplaceAll]), '-','',[rfReplaceAll]), '/','',[rfReplaceAll]);
    sCNPJ_LojaUltCompra := StringReplace(StringReplace(StringReplace(Remove_Acento(trim(copy(linha,132,23)))+';','.','',[rfReplaceAll]), '-','',[rfReplaceAll]), '/','',[rfReplaceAll]);

    cdsDados.Append;
    cdsDados.FieldByName('tcpf').AsString := AnsiUpperCase(StringReplace
                                                          (StringReplace
                                                          (Remove_Acento(trim(copy(linha,0,19)))+';','.','',[rfReplaceAll]), '-','',[rfReplaceAll]));
    cdsDados.FieldByName('tprivate').AsString := AnsiUpperCase(Remove_Acento(trim(copy(linha,20,12))));
    cdsDados.FieldByName('tinconpleto').AsString := AnsiUpperCase(Remove_Acento(trim(copy(linha,32,12))));
    cdsDados.FieldByName('dDataUlt_Compra').AsString := AnsiUpperCase(Remove_Acento(Trim(copy(linha,44,22))));
    cdsDados.FieldByName('nTickt_Medio').AsString := AnsiUpperCase(Remove_Acento(trim(copy(linha,66,22))));
    cdsDados.FieldByName('nTickt_Ult_Compra').AsString := AnsiUpperCase(Remove_Acento(trim(copy(linha,88,20))));

    cdsDados.FieldByName('tcnpj_Loja_Freq').AsString := AnsiUpperCase(StringReplace(StringReplace
                                                                                   (StringReplace
                                                                                   (Remove_Acento(trim(copy(linha,112,20)))+';','.','',[rfReplaceAll]), '-','',[rfReplaceAll]), '/','',[rfReplaceAll]));

    cdsDados.FieldByName('tcnpj_Loja_Ult_Compra').AsString := AnsiUpperCase(StringReplace(StringReplace
                                                                                         (StringReplace
                                                                                         (Remove_Acento(trim(copy(linha,132,23)))+';','.','',[rfReplaceAll]), '-','',[rfReplaceAll]), '/','',[rfReplaceAll]));
    cdsDados.Post;

    sDados := AnsiUpperCase(sCPF) + AnsiUpperCase(sPrivate) +
              AnsiUpperCase(sIncompleto) + AnsiUpperCase(sDataUlt_Compra) +
              AnsiUpperCase(sTicktMedio) + AnsiUpperCase(sTickt_UltCompra) +
              AnsiUpperCase(sCNPJ_LojaFrequente) + AnsiUpperCase(sCNPJ_LojaUltCompra);

    mDados.Lines.Add(sDados);

    lblqtdreg.Caption := IntToStr(i);
  end;

  lblTotalCpfInvalid.Caption := IntToStr(iTotalCPF_Invalid);
  lblTotalCNPJInvalid.Caption := IntToStr(iTotalCNPJ_Invalid);
  Linha := '';

  Closefile(ArqTxt);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
//  Savedialog1.Execute;
//  mDados.Lines.SavetoFile(Savedialog1.FileName);
end;

procedure TForm1.Button4Click(Sender: TObject);
const sql_insert = 'insert into movimentacao ( tcpf, tprivate, ' +
                   ' tinconpleto, ddatault_compra, ntickt_medio, ' +
                   ' ntickt_ult_compra, tcnpj_loja_freq, tcnpj_loja_ult_compra)  values ';

var ArqTxt: TextFile;
    linha, sDadosScript, sCPF, sPrivate, sIncompleto, sDataUlt_Compra: string;
    sTicktMedio, sTickt_UltCompra, sCNPJ_LojaFrequente, sCNPJ_LojaUltCompra: string;
    i, iTotalCPF_Invalid, iTotalCNPJ_Invalid: Integer;
    sCPF_Validar, sCNPJ1_Validar, sCNPJ2_Validar: string;
begin
  OpenDialog1.Execute();
  edtArquivo.Text := OpenDialog1.FileName;

  AssignFile(ArqTxt, edtArquivo.Text);
  Reset(ArqTxt);

  i := 0;
  iTotalCPF_Invalid := 0;
  iTotalCNPJ_Invalid := 0;
  cdsDados.Open;

  //Ação de carragamento de dados
  while not eof(ArqTxt) do
  begin
    i := i + 1;
    sDadosScript := EmptyStr;
    sCPF := EmptyStr;
    sPrivate := EmptyStr;
    sDataUlt_Compra := EmptyStr;
    sTicktMedio := EmptyStr;
    sTickt_UltCompra := EmptyStr;
    sCNPJ_LojaFrequente := EmptyStr;
    sCNPJ_LojaUltCompra := EmptyStr;
    sCPF_Validar := EmptyStr;
    sCNPJ1_Validar := EmptyStr;
    sCNPJ2_Validar := EmptyStr;

    Readln(ArqTxt, Linha);

    sCPF_Validar := StringReplace(StringReplace(Remove_Acento(trim(copy(linha,0,19))),'.','',[rfReplaceAll]), '-','',[rfReplaceAll]);
    sCNPJ1_Validar := StringReplace(StringReplace(StringReplace(Remove_Acento(trim(copy(linha,132,20))),'.','',[rfReplaceAll]), '-','',[rfReplaceAll]), '/','',[rfReplaceAll]);
    sCNPJ2_Validar := AnsiUpperCase(StringReplace(StringReplace(StringReplace(Remove_Acento(trim(copy(linha,155,23))),'.','',[rfReplaceAll]), '-','',[rfReplaceAll]), '/','',[rfReplaceAll]));


    //Validando CPF
    if not isCPF(sCPF_Validar) then
    begin
      iTotalCPF_Invalid := iTotalCPF_Invalid + 1;
    end;

     //Validando CNPJ
     if not isCNPJ(sCNPJ1_Validar) then
     begin
       iTotalCNPJ_Invalid := iTotalCNPJ_Invalid + 1;
     end;

    //Ação de carragamento de dados
    sCPF := StringReplace(StringReplace
                         (Remove_Acento(trim(copy(linha,0,19))),'.','',[rfReplaceAll]), '-','',[rfReplaceAll]);
    sPrivate := Remove_Acento(trim(copy(linha,20,12)));
    sIncompleto := Remove_Acento(trim(copy(linha,32,12)));
    sDataUlt_Compra := Remove_Acento(Trim(copy(linha,44,22)));
    sTicktMedio := Remove_Acento(trim(copy(linha,66,22)));
    sTickt_UltCompra := Remove_Acento(trim(copy(linha,88,20)));

    sCNPJ_LojaFrequente := StringReplace(StringReplace(StringReplace(Remove_Acento(trim(copy(linha,112,20))),'.','',[rfReplaceAll]), '-','',[rfReplaceAll]), '/','',[rfReplaceAll]);
    sCNPJ_LojaUltCompra := StringReplace(StringReplace(StringReplace(Remove_Acento(trim(copy(linha,132,23))),'.','',[rfReplaceAll]), '-','',[rfReplaceAll]), '/','',[rfReplaceAll]);

    sDadosScript := sql_insert+'('+QuotedStr(AnsiUpperCase(sCPF))+',' + QuotedStr(AnsiUpperCase(sPrivate)) +','+
              QuotedStr(AnsiUpperCase(sIncompleto))+',' + QuotedStr(AnsiUpperCase(sDataUlt_Compra))+',' +
              QuotedStr(AnsiUpperCase(sTicktMedio))+',' + QuotedStr(AnsiUpperCase(sTickt_UltCompra))+',' +
              QuotedStr(AnsiUpperCase(sCNPJ_LojaFrequente))+',' + QuotedStr(AnsiUpperCase(sCNPJ_LojaUltCompra))+');';

    mScript.Lines.Add(sDadosScript);

    lblqtdreg.Caption := IntToStr(i);
  end;

  lblTotalCpfInvalid.Caption := IntToStr(iTotalCPF_Invalid);
  lblTotalCNPJInvalid.Caption := IntToStr(iTotalCNPJ_Invalid);
  Linha := '';

  Savedialog1.Execute;
  mScript.Lines.SavetoFile(Savedialog1.FileName);

  Closefile(ArqTxt);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  cdsDados.Close;
end;

function TForm1.isCNPJ(CNPJ: string): boolean;
var   dig13, dig14: string;
    sm, i, r, peso: integer;
begin
// length - retorna o tamanho da string do CNPJ (CNPJ é um número formado por 14 dígitos)
  if ((CNPJ = '00000000000000') or (CNPJ = '11111111111111') or
      (CNPJ = '22222222222222') or (CNPJ = '33333333333333') or
      (CNPJ = '44444444444444') or (CNPJ = '55555555555555') or
      (CNPJ = '66666666666666') or (CNPJ = '77777777777777') or
      (CNPJ = '88888888888888') or (CNPJ = '99999999999999') or
      (length(CNPJ) <> 14))
     then begin
            isCNPJ := false;
            exit;
          end;

// "try" - protege o código para eventuais erros de conversão de tipo através da função "StrToInt"
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    sm := 0;
    peso := 2;
    for i := 12 downto 1 do
    begin
// StrToInt converte o i-ésimo caractere do CNPJ em um número
      sm := sm + (StrToInt(CNPJ[i]) * peso);
      peso := peso + 1;
      if (peso = 10)
         then peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1))
       then dig13 := '0'
    else str((11-r):1, dig13); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
    sm := 0;
    peso := 2;
    for i := 13 downto 1 do
    begin
      sm := sm + (StrToInt(CNPJ[i]) * peso);
      peso := peso + 1;
      if (peso = 10)
         then peso := 2;
    end;
    r := sm mod 11;
    if ((r = 0) or (r = 1))
       then dig14 := '0'
    else str((11-r):1, dig14);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig13 = CNPJ[13]) and (dig14 = CNPJ[14]))
       then isCNPJ := true
    else isCNPJ := false;
  except
    isCNPJ := false
  end;end;

function TForm1.isCPF(CPF: string): boolean;
var  dig10, dig11: string;
    s, i, r, peso: integer;
begin
// length - retorna o tamanho da string (CPF é um número formado por 11 dígitos)
  if ((CPF = '00000000000') or (CPF = '11111111111') or
      (CPF = '22222222222') or (CPF = '33333333333') or
      (CPF = '44444444444') or (CPF = '55555555555') or
      (CPF = '66666666666') or (CPF = '77777777777') or
      (CPF = '88888888888') or (CPF = '99999999999') or
      (length(CPF) <> 11))
     then begin
              isCPF := false;
              exit;
            end;

// try - protege o código para eventuais erros de conversão de tipo na função StrToInt
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
// StrToInt converte o i-ésimo caractere do CPF em um número
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig11 := '0'
    else str(r:1, dig11);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = CPF[10]) and (dig11 = CPF[11]))
       then isCPF := true
    else isCPF := false;
  except
    isCPF := false
  end;
end;

function TForm1.Remove_Acento(ATexto: string): string;
const
  ComAcento = 'àâêôûãõáéíóúçüñýÀÂÊÔÛÃÕÁÉÍÓÚÇÜÑÝ';
  SemAcento = 'aaeouaoaeioucunyAAEOUAOAEIOUCUNY';
var
  x: Cardinal;
begin;
  for x := 1 to Length(ATexto) do
  try
    if (Pos(ATexto[x], ComAcento) <> 0) then
      ATexto[x] := SemAcento[ Pos(ATexto[x], ComAcento) ];
  except on E: Exception do
    raise Exception.Create('Erro no processo.');
  end;

  Result := ATexto;
end;

end.
