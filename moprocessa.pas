{--------------------------------------------------------}
{                                                        }
{    MoneyVox - assistente financeiro                    }
{                                                        }
{    M�dulo central de processamento                     }
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
{     Faz pre-inicializa��o de acordo com uma regra      }
{--------------------------------------------------------}

function preinicializa: boolean;
begin
    result := true;
end;

procedure ajudaOpcoes;
begin
    writeln;

    mensagem ('MOESCFOL',   1);    {'E - Escolher folha de lan�amento para trabalho'}
    mensagem ('MOCONFFOL',  1);    {'C - Configurar folha de lan�amento'}
    mensagem ('MOEVFOL',    1);    {'L - Lan�ar evento numa folha'}
    mensagem ('MOFOLFOL',   1);    {'F - Folhear uma folha de lan�amento'}
    mensagem ('MOEMITREL',  1);    {'R - Emitir relat�rio'}
    mensagem ('MOCONTEV',   1);    {'V - Controlar eventos futuros'}
    mensagem ('MOIEAFOL',   1);    {'I - Importar/exportar/arquivar folhas'}
    mensagem ('MOTERMINAR', 1);    {'ESC - terminar' }

    while keypressed do
        opcaoSel := upcase(readkey);

    gotoxy (1, 3);
    limpaBaixo (wherey);
    sintBip;
end;

{--------------------------------------------------------}
{                    Exibi op��es                        }
{--------------------------------------------------------}

function selSetasOpcao: char;
var
    index: integer;
const
    tabLetrasOpcao: string = 'ECLFRVI' + ESC;

    procedure MenuAdiciona (msg: string);
    begin
         popupMenuAdiciona (msg, pegaTextoMensagem (msg));
    end;

begin
    garanteEspacoTela (9);
    popupMenuCria (wherex, wherey+1, 80, length(tabLetrasOpcao), BLUE);
    menuAdiciona ('MOESCFOL');     {'E - Escolher folha de lan�amento para trabalho'}
    menuAdiciona ('MOCONFFOL');    {'C - Configurar folha de lan�amento'}
    menuAdiciona ('MOEVFOL');      {'L - Lan�ar evento numa folha'}
    menuAdiciona ('MOFOLFOL');     {'F - Folhear uma folha de lan�amento'}
    menuAdiciona ('MOEMITREL');    {'R - Emitir relat�rio'}
    menuAdiciona ('MOCONTEV');     {'V - Controlar eventos futuros'}
    menuAdiciona ('MOIEAFOL');     {'I - Importar/exportar/arquivar folhas'}
    menuAdiciona ('MOTERMINAR');   {'ESC - terminar' }

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
{              Pede op��o e trata ajudas                 }
{--------------------------------------------------------}

function pedeOpcao: char;
begin
    repeat
        limpaBaixo (5);
        textBackground (RED);
        opcaoSel := #0;
        mensagem('MOOQUE', 0); {MoneyVox - Que deseja? }

        textBackground (BLACK);
        sintLeTecla (c, c2);
        opcao := '';
        if (c = #0) and (c2 = F1) then
            ajudaOpcoes;
    until c2 <> F1;

    if (c = #0) and ((c2 = F9) or (c2 = CIMA) or (c2 = BAIX)) then
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
        begin
            writeln;
            opcaoSel := c;
        end;
    else
        opcaoSel := upcase(c);

    result := opcaoSel;
end;

{--------------------------------------------------------}
{          Faz o processo da ferramenta moneyVox         }
{--------------------------------------------------------}

procedure processa;
var
    c, c2: char;
    opcao: String;
    processando: boolean;
begin
    processando := true;
    while processando do
        begin
            opcaoSel := pedeOpcao;
            case opcaoSel of
                 'N': naoImplem ('criar nova folha de lan�amento');
                 'E': naoImplem ('escolher folha de lan�amento');
                 'C': naoImplem ('configurar folha de lan�amento');
                 'L': naoImplem ('lan�ar evento numa folha');
                 'F': naoImplem ('folhear uma folha de lan�amento');
                 'R': naoImplem ('emitir relat�rio');
                 'V': naoImplem ('controlar eventos futuros');
                 'I': naoImplem ('importar/exportar/arquivar folhas');

                 ESC:
                     begin
                         mensagem('MOCNFFIM', 0); {Confirma o fim do MoneyVox (S/N)?}
                         if popupMenuPorLetra('SN') = 'S' then
                             processando := false;
                     end;

            else
                 textBackground (MAGENTA);
                 mensagem ('MOOPINV', 0); {op��o inv�lida}
                 textBackground (BLACK);
                 clrscr;
             end;

        end;

end;
