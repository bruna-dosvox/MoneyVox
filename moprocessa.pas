{--------------------------------------------------------}
{                                                        }
{    MoneyVox - assistente financeiro                    }
{                                                        }
{    Módulo central de processamento                     }
{                                                        }
{    Autor:  Bruna Lima                                  }
{                                                        }
{    Em novembro/2018                                    }
{                                                        }
{--------------------------------------------------------}

unit moprocessa;

interface
uses
    dvcrt,
    dvwin,
    dvform,
    movars,
    momsg,
    sysutils;

function preinicializa: boolean;
procedure processa;

implementation

{--------------------------------------------------------}
{     Faz pre-inicialização de acordo com uma regra      }
{--------------------------------------------------------}

function preinicializa: boolean;
begin
    result := true;
end;

procedure ajudaOpcoes;
begin
    writeln;

    mensagem ('MOESCFOL',  1);
    mensagem ('MOCONFFOL', 1);
    mensagem ('MOEVFOL',   1);
    mensagem ('MOFOLFOL',  1);
    mensagem ('MOEMITREL', 1);
    mensagem ('MOCONTEV',  1);
    mensagem ('MOIEAFOL',  1);
    mensagem ('MOTERMINAR',1);

    while keypressed do
        opcaoSel := upcase(readkey);

    gotoxy (1, 3);
    limpaBaixo (wherey);
    sintBip;
end;

{--------------------------------------------------------}
{                    Exibi opções                        }
{--------------------------------------------------------}

function selSetasOpcao: char;
var
    index: integer;
const
    tabLetrasOpcao: string = 'ECLFRVI' + ESC;
begin
    garanteEspacoTela (9);
    popupMenuCria (wherex, wherey+1, 80, length(tabLetrasOpcao), BLUE);
    popupMenuAdiciona ('MOESCFOL',  'E - Escolher folha de lançamento para trabalho');
    popupMenuAdiciona ('MOCONFFOL', 'C - Configurar folha de lançamento');
    popupMenuAdiciona ('MOEVFOL',   'L - Lançar evento numa folha');
    popupMenuAdiciona ('MOFOLFOL',  'F - Folhear uma folha de lançamento');
    popupMenuAdiciona ('MOEMITREL', 'R - Emitir relatório');
    popupMenuAdiciona ('MOCONTEV',  'V - Controlar eventos futuros');
    popupMenuAdiciona ('MOIEAFOL',  'I - Importar/exportar/arquivar folhas');
    popupMenuAdiciona ('MOTERMINAR','ESC - terminar' );

    index := popupMenuSeleciona;
    if index > 0 then
        begin
            selSetasOpcao := tabLetrasOpcao[index];
            writeln (tabLetrasOpcao[index]);
        end
    else
        selSetasOpcao := ESC;
end;

{--------------------------------------------------------}
{          Faz o processo da ferramenta moneyVox         }
{--------------------------------------------------------}

procedure processa;
var
    c, c2: char;
    opcao: String;
begin
    textBackground (RED);
    opcaoSel := #0;
    mensagem('MOOQUE', 0); {MoneyVox - Que deseja? }

    textBackground (BLACK);
    sintLeTecla (c, c2);
    opcao := '';
    if (c = #0) and ((c2 = CIMA) or (c2 = BAIX)) then
        begin
            c := selSetasOpcao;
            if c <> #$1b then
                begin
                    opcao := copy(opcoesItemSelecionado,1, pos ('-', opcoesItemSelecionado)-1);
                    opcaoSel := opcao[1];
                end;
        end
    else
    if c = ESC then
        writeln
    else
    if (c = #0) and (c2 = F9) then
        ajudaOpcoes
    else
        opcaoSel := upcase(c);
end;

end.
