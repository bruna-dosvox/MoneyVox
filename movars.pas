{--------------------------------------------------------}
{                                                        }
{    MoneyVox - assistente financeiro                    }
{                                                        }
{    Vari�veis globais                                   }
{                                                        }
{    Autor:  Bruna Lima                                  }
{                                                        }
{    Em novembro/2018                                    }
{                                                        }
{--------------------------------------------------------}

unit movars;

interface

var
    opcaoSel: char;

const
    versao = '0.1';

type
    TLancamento = record
        campos: array of string;
    end;

    TInfoCampos = record
        nomeCampo: string;
        larguraMax: integer;
        tipoCampo: (NUMERO, DATA, DINHEIRO, LETRAS);
    end;

    TInfoColunaListagem = record
         nomeColuna: string;
         largColuna: integer;
         origemColuna: integer;
    end;

var
    folhaLanc: array of TLancamento;
    infoCampo: array of TInfoCampos;
    formatoListagem: array of TInfoColunaListagem;

const
     camposPadroes: array [1..4] of TInfoCampos = (
         (nomeCampo: 'C�digo';    larguraMax:  5; tipoCampo: NUMERO),
         (nomeCampo: 'Data';      larguraMax: 10; tipoCampo: DATA),
         (nomeCampo: 'Descri��o'; larguraMax: 50; tipoCampo: NUMERO),
         (nomeCampo: 'Valor';     larguraMax: 14; tipoCampo: DINHEIRO)
     );

implementation

end.



{--------------------------------------------------------}
{              Televox - estrutura de dados
{--------------------------------------------------------}

unit telvars;
interface

Const
    VERSAO = '3.0';
    MAXCADASTRO = 15000;

{-----------------------------------------}

const
    MAXCAMPOS = 100;

    numCamposDefault = 13;
    tabDefault: array [1..numCamposDefault*3] of string[20] = (
        'NOME',      'TVNOME',    '[NOME]',
        'TELEFONE',  'TVTELEF',   '[TELEFONE]',
        'CELULAR',   'TVCELULA',  '[CELULAR]',
        'E-MAIL',    'TVEMAIL',   '[E-MAIL]',
        'ENDERE�O',  'TVENDER',   '[ENDERE�O]',
        'CIDADE',    'TVCIDADE',  '[CIDADE]',
        'CEP',       'TVCEP',     '[CEP]',
        '1',         'TVOBS1',    '[1]',
        '2',         'TVOBS2',    '[2]',
        '3',         'TVOBS3',    '[3]',
        '4',         'TVOBS4',    '[4]',
        '5',         'TVOBS5',    '[5]',
        '6',         'TVOBS6',    '[6]'
    );

var
    tabTexto: array [1..MAXCAMPOS] of string[15];
    tabFala: array [1..MAXCAMPOS] of string[8];
    tabMalaDir: array [1..MAXCAMPOS] of string[10];

const
    TODOS       = 255;
    SELECIONADO = 1;
    ACHADO      = 2;

type
   pString = ^shortstring;
   pCadastro = ^Cadastro;

   Cadastro = Record
                  status: byte;
                  campoCad: array [1..MAXCAMPOS] of PString;
              end;

var
    listaFone:  Array [1..MAXCADASTRO] Of pCadastro;
    numCampos: integer;
    cadastrados: Integer;
    achados: integer;
    posAtual: integer;
    arqFone:  text;
    nomeCadastro, dirAgendas: string;
    opc: Char;
    fim: Boolean;
    inserindo: boolean;
    imprimeNomeCampo: boolean;

procedure inicCamposDefault;

implementation

procedure inicCamposDefault;
var i: integer;
begin
    for i := 1 to MAXCAMPOS do
        begin
            tabTexto   [i] := '';
            tabFala    [i] := '';
            tabMalaDir [i] := '';
        end;

    for i := 1 to numCamposDefault do
        begin
            tabTexto   [i] := tabDefault[i*3-2];
            tabFala    [i] := tabDefault[i*3-1];
            tabMalaDir [i] := tabDefault[i*3];
        end;
    numCampos := numCamposDefault;
end;

begin
    inicCamposDefault;
end.
