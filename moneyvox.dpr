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
var
    processando: boolean;
begin
    processando := true;
    inicializa;

    while processando do
        begin
            processa;
            if opcaoSel <> #0 then
                begin
                    case opcaoSel of
                         'E': naoImplem ('escolher folha de lançamento');     { procedure de escolher folha de lançamento }
                         'C': naoImplem ('configurar folha de lançamento');   { procedure de Configurar folha de lançamento }
                         'L': naoImplem ('lançar evento numa folha');         { procedure de lançar evento numa folha }
                         'F': naoImplem ('folhear uma folha de lançamento');  { procedure de folhear uma folha de lançamento }
                         'R': naoImplem ('emitir relatório');                 { procedure de emitir relatório }
                         'V': naoImplem ('controlar eventos futuros');        { procedure de controlar eventos futuros }
                         'I': naoImplem ('importar/exportar/arquivar folhas');{ procedure de importar/exportar/arquivar folhas }

                    else
                         textBackground (MAGENTA);
                         mensagem ('MOOPINV', 0); {opção inválida}
                         textBackground (BLACK);
                         clrscr;
                     end;
                end
            else
                begin
                    mensagem('MOCNFFIM', 0); {Confirma o fim do MoneyVox (S/N)?}
                    if popupMenuPorLetra('SN') = 'S' then
                        processando := false;
                end;
        end;

    finaliza;
end.
