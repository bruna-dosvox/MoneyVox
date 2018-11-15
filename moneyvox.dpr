{--------------------------------------------------------}
{                                                        }
{    MoneyVox - assistente financeiro                    }
{                                                        }
{    Programa principal                                  }
{                                                        }
{    Autor:  Bruna Lima                                  }
{                                                        }
{    Em novembro/2018                                    }
{                                                        }
{--------------------------------------------------------}

program moneyvox;

uses
  dvwin,
  dvcrt,
  dvform,
  SysUtils,
  moarq,
  momsg,
  movars,
  moprocessa;

{--------------------------------------------------------}

procedure inicializa;
var amb: string;
begin
    clrscr;
    setWindowTitle('MoneyVox - v' + versao);
    amb := sintAmbiente ('MONEYVOX', 'DIRMONEYVOX');
    if amb = '' then
        amb := '\winvox\som\moneyvox';
    sintInic (0, amb);

    textBackground (BLUE);
    mensagem ('MOINIC', 0);    {'MoneyVox - versão '}
    sintWriteln (versao);
    writeln;
    textBackground (BLACK);

    if not preInicializa then
        begin
            mensagem ('MOPROCAN', 0);  {'Programa cancelado'}
            sintFim;
            doneWinCrt;
        end;
end;

{--------------------------------------------------------}

procedure finaliza;
begin
    mensagem ('MOFIM', 1);   {'Fim do MoneyVox.'}
    sintfim;
    doneWinCrt;
end;

{--------------------------------------------------------}
begin
    inicializa;
    processa;
    finaliza;
end.
