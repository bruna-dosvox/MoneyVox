{--------------------------------------------------------}
{                                                        }
{    MoneyVox - assistente financeiro                    }
{                                                        }
{    Mensagens                                           }
{                                                        }
{    Autor:  Bruna Lima                                  }
{                                                        }
{    Em novembro/2018                                    }
{                                                        }
{--------------------------------------------------------}

unit momsg;

interface
uses
  dvwin,
  dvcrt,
  SysUtils;

function pegaTextoMensagem (nomeArq: string): string;
procedure mensagem (nomeArq: string; nlf: integer);
procedure limpaBaixo (y: integer);
procedure naoImplem (qual: string);

implementation

{--------------------------------------------------------}
{              descobre o texto da mensagem
{--------------------------------------------------------}

function pegaTextoMensagem (nomeArq: string): string;
var s: string;
begin
    if nomeArq = 'MOINIC' then
        s := 'MoneyVox - vers�o '
    else
    if nomeArq = 'MOFIM' then
        s := 'Fim do MoneyVox.'
    else
    if nomeArq = 'MOOK' then
        s := 'OK.'
    else
    if nomeArq = 'MOMOMENT' then
        s := 'Um momento...'
    else
    if nomeArq = 'MOPROCAN' then
        s := 'Programa cancelado...'
    else
    if nomeArq = 'MOOQUE' then
        s := 'MoneyVox - Que deseja? '
    else
    if nomeArq = 'MOOPINV' then
        s := 'Op��o inv�lida'
    else
    if nomeArq = 'MODESIST' then
        s := 'Desistiu...'
    else
    if nomeArq = 'MOAPTENT' then
        s := 'Aperte Enter para continuar.'
    else
    if nomeArq = 'MOOPCSAO' then
        s := 'As op��es s�o:'
    else
    if nomeArq = 'MOCONFIG' then
        s := 'Configurando'
    else
    if nomeArq = 'MVOPCAO' then
        s := 'Op��o: '
    else
    if nomeArq = 'MOCNFFIM' then
        s := 'Confirma o fim do MoneyVox (S/N)? '
    else
    if nomeArq = 'MONIMPL' then
        s := 'N�o implementado.'
    else
    if nomeArq = 'MOEXIREM' then
        s := 'Arquivo j� existe, posso remover (S/N)? '
    else
    if nomeArq = 'MOERRREM' then
        s := 'Erro ao remover o arquivo antigo'
    else
    if nomeArq = 'MOARQNAO' then
        s := 'Arquivo n�o existe'
    else
    if nomeArq = 'MOREMOV' then
        s := 'Removido.'
    //Menu principal
    else
    if nomeArq = 'MOESCFOL' then
        s := 'E - Escolher folha de lan�amento para trabalho'
    else
    if nomeArq = 'MOCONFFOL' then
        s := 'C - Configurar folha de lan�amento'
    else
    if nomeArq = 'MOEVFOL' then
        s := 'L - Lan�ar evento numa folha'
    else
    if nomeArq = 'MOFOLFOL' then
        s := 'F - Folhear uma folha de lan�amento'
    else
    if nomeArq = 'MOEMITREL' then
        s := 'R - Emitir relat�rio'
    else
    if nomeArq = 'MOCONTEV' then
        s := 'V - Controlar eventos futuros'
    else
    if nomeArq = 'MOIEAFOL' then
        s := 'I - Importar/exportar/arquivar folhas'
    else
    if nomeArq = 'MOTERMINAR' then
        s := 'ESC - Terminar'

    else
        s := '--> Mensagem inv�lida: ' + nomeArq;

   pegaTextoMensagem := s;
end;

{--------------------------------------------------------}
{                    d� uma mensagem
{--------------------------------------------------------}

procedure mensagem (nomeArq: string; nlf: integer);
var i: integer;
    s: string;
begin
    s := pegaTextoMensagem (nomeArq);

    if nlf >= 0 then write (s);
    for i := 1 to nlf do
         writeln;

    if existeArqSom ('EF_' + nomeArq) then
        sintSom ('EF_' + nomeArq);

    if existeArqSom (nomeArq) then
        sintSom (nomeArq)
    else
        sintetiza (s);
end;

{--------------------------------------------------------}
{       limpa debaixo de certa posi��o da tela
{--------------------------------------------------------}

procedure limpaBaixo (y: integer);
var i: integer;
begin
    for i := y to 25 do
        begin
            gotoxy (1, i);
            clreol;
        end;
    gotoxy (1, y);
end;

{--------------------------------------------------------}
{     mensagem padr�o para rotinas ainda n�o criadas
{--------------------------------------------------------}

procedure naoImplem (qual: string);
begin
    sintWriteln (qual + ' - fun��o n�o implementada ainda.');
    writeln;
end;

end.
