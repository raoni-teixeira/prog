// ============================================================
//  Lab 11 — Matrizes
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 11", author: "Raoni F. S. Teixeira")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 11],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Matrizes],
      align(right)[#context counter(page).display("1")])
  ]
)

#set text(font: "Linux Libertine", size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.75em)
#set heading(numbering: "1.")

// ── Macros ───────────────────────────────────────────────────

#let atividade(num, tipo, tempo, corpo) = {
  block(width: 100%, inset: 0pt, spacing: 1em)[
    #block(
      fill: rgb("#1a3a5c"),
      inset: (x: 10pt, y: 6pt),
      radius: (top: 3pt),
      width: 100%,
    )[
      #grid(columns: (1fr, auto),
        text(fill: white, weight: "bold")[Atividade #num — #tipo],
        text(fill: rgb("#aaccee"), size: 9pt)[#tempo min],
      )
    ]
    #block(
      stroke: (left: 3pt + rgb("#1a3a5c"), right: 0.5pt + rgb("#ccc"),
               bottom: 0.5pt + rgb("#ccc")),
      inset: (left: 12pt, top: 10pt, bottom: 10pt, right: 10pt),
      radius: (bottom: 3pt),
      width: 100%,
    )[#corpo]
  ]
}

#let bug(titulo, corpo) = block(
  fill: rgb("#fdecea"), stroke: (left: 3pt + rgb("#c62828")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#c62828"))[Bug — #titulo] \ #corpo]

#let destaque(corpo) = block(
  fill: rgb("#fff8e1"), stroke: (left: 3pt + rgb("#e6a817")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#corpo]

#let desafio(corpo) = block(
  fill: rgb("#fff8e1"), stroke: (left: 3pt + rgb("#e6a817")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#e6a817"))[Desafio opcional] \ #corpo]

#let caixa_resposta(altura) = block(
  width: 100%, height: altura,
  stroke: 0.5pt + rgb("#999"),
  radius: 2pt, inset: 6pt,
)[]

// ── Título ───────────────────────────────────────────────────

#align(center)[
  #text(size: 15pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Laboratório 11 — Matrizes
  ]
  #v(2pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Duração: 2 horas  |  Trabalho individual  |  Entrega: arquivos .c ao final da aula
  ]
]

#v(8pt)

#let caixa(titulo, cor-borda, cor-fundo, corpo) = block(
  width: 100%,
  fill: cor-fundo,
  stroke: (left: 3pt + cor-borda),
  inset: (left: 10pt, right: 10pt, top: 8pt, bottom: 8pt),
  radius: (right: 3pt),
)[
  #text(weight: "bold", fill: cor-borda)[#titulo] \
  #corpo
]
#let cinza    = luma(245)
#caixa(
  "Objetivos deste laboratório",
  rgb("#555555"),
  cinza,
  [
    Ao final deste laboratório, a dupla deve ser capaz de:

  1. rastrear laços aninhados sobre matrizes relacionando índices   `[i][j]` a linha e coluna; 
  2. implementar os padrões fundamentais — percurso total, somas por linha e coluna, diagonal e transposta;
  3. identificar e corrigir bugs de índice invertido e acesso fora dos limites em matrizes; 
  4. passar matrizes para funções com a assinatura correta e justificar por que o número de colunas é obrigatório.
  ],
) 


#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Teste de mesa — indices linha e coluna", "25")[
  Considere a matriz abaixo, já inicializada:

  ```c
  int m[3][4] = {
      { 1,  2,  3,  4},
      { 5,  6,  7,  8},
      { 9, 10, 11, 12}
  };
  ```

  *a)* Sem executar, preencha a tabela com o valor de `m[i][j]`
  para cada combinação:

  #table(
    columns: (auto, auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 9pt,
    fill: (col, row) =>
      if row == 0 or col == 0 { rgb("#eaf0fb") } else { white },
    [*`m[i][j]`*], [*`j=0`*], [*`j=1`*], [*`j=2`*], [*`j=3`*],
    [*`i=0`*], [`1`], [`2`], [`3`], [`4`],
    [*`i=1`*], [],   [],    [],    [],
    [*`i=2`*], [],   [],    [],    [],
  )

  *b)* Rastreie o programa abaixo *sem compilar* e preveja a saída:

  ```c
  int soma = 0;
  for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 4; j++) {
          if (i == j)
              soma += m[i][j];
      }
  }
  printf("%d\n", soma);
  ```

  Quais elementos são somados? `_________________________________`

  Saída prevista: `_______`   Saída real: `_______`

  *c)* O que acontece se você inverter os índices — `m[j][i]`
  em vez de `m[i][j]` — no programa acima? Preveja *sem executar*:
  #caixa_resposta(28pt)

  *d)* Para a matriz `m[3][4]`, qual é o endereço de memória de
  `m[2][1]` se `m[0][0]` está no endereço 1000 e cada `int`
  ocupa 4 bytes? Mostre o cálculo:
  #caixa_resposta(28pt)
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "Padroes fundamentais em funcoes", "35")[
  Implemente as funções abaixo para uma matriz `int m[][NCOL]`
  com `#define NCOL 4`. Cada função deve ter no máximo 10 linhas.

  ```c
  #define NLIN 3
  #define NCOL 4

  /* Imprime a matriz formatada, uma linha por linha de texto */
  void imprime(int m[][NCOL], int nlin);

  /* Retorna a soma de todos os elementos */
  int soma_total(int m[][NCOL], int nlin);

  /* Preenche vet[i] com a soma da linha i */
  void soma_por_linha(int m[][NCOL], int nlin, int vet[]);

  /* Preenche vet[j] com a soma da coluna j */
  void soma_por_coluna(int m[][NCOL], int nlin, int vet[]);

  /* Retorna a soma da diagonal principal (apenas para nlin == NCOL) */
  int soma_diagonal(int m[][NCOL], int n);

  /* Armazena em t a transposta de m: t[j][i] = m[i][j] */
  void transposta(int m[][NCOL], int nlin, int t[][NLIN]);
  ```

  *a)* Use a matriz de teste:
  ```c
  int m[NLIN][NCOL] = {{1,2,3,4},{5,6,7,8},{9,10,11,12}};
  ```

  Preencha os resultados esperados antes de implementar:

  #table(
    columns: (1fr, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 8pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Chamada*], [*Resultado esperado*],
    [`soma_total(m, NLIN)`],           [`78`],
    [`soma_por_linha(m, NLIN, v)`],    [],
    [`soma_por_coluna(m, NLIN, v)`],   [],
  )

  *b)* Implemente, compile e verifique com a matriz de teste.

  *c)* Por que a assinatura usa `m[][NCOL]` e não simplesmente `m[][]`?
  O que o compilador precisa saber para calcular `m[i][j]`?
  #caixa_resposta(32pt)

  *d)* Para `transposta`, a matriz resultado `t` tem dimensões
  `t[NCOL][NLIN]` — invertidas em relação a `m`. Por que?
  Escreva um exemplo com valores para verificar:
  #caixa_resposta(36pt)
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "Caca ao bug — indices e limites", "25")[

  #bug("Indices i e j invertidos")[
    O programa abaixo pretende imprimir cada elemento com sua posição,
    mas produz acesso fora dos limites para certas matrizes.

    ```c
    #define NLIN 3
    #define NCOL 5

    void imprime_posicoes(int m[][NCOL], int nlin) {
        for (int i = 0; i < NCOL; i++) {       /* bug */
            for (int j = 0; j < NLIN; j++) {   /* bug */
                printf("m[%d][%d] = %d\n", i, j, m[i][j]);
            }
        }
    }
    ```

    *a)* Para `NLIN=3` e `NCOL=5`, quais valores de `i` causam
    acesso fora dos limites? Por que?
    #caixa_resposta(28pt)

    *b)* O comportamento seria diferente se `NLIN == NCOL`?
    Isso torna o bug mais ou menos perigoso? Explique:
    #caixa_resposta(28pt)

    *c)* Corrija a função trocando os limites dos laços no lugar correto.
  ]

  #v(10pt)

  #bug("Percurso por coluna passando o numero errado")[
    ```c
    #define NCOL 4

    int soma_coluna(int m[][NCOL], int nlin, int col) {
        int s = 0;
        for (int i = 0; i < NCOL; i++)   /* bug: deveria ser nlin */
            s += m[i][col];
        return s;
    }

    int main() {
        int m[3][NCOL] = {{1,2,3,4},{5,6,7,8},{9,10,11,12}};
        printf("%d\n", soma_coluna(m, 3, 0));
        return 0;
    }
    ```

    *a)* Para `nlin=3` e `NCOL=4`, qual é a soma correta da coluna 0?
    `_______`   O programa imprime: `_______`

    *b)* O bug só se manifesta quando `nlin != NCOL`. Construa um
    exemplo concreto em que ele produz resultado errado *e* um
    exemplo em que passa despercebido:
    #caixa_resposta(36pt)

    *c)* Corrija o programa com uma mudança mínima.
  ]
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Processamento de imagem — brilho e espelho", "30")[
  Retomando o exemplo da Aula 11: uma imagem em tons de cinza é
  uma matriz de inteiros onde cada elemento vale entre 0 (preto)
  e 255 (branco).

  ```c
  #define H 4
  #define W 5
  ```

  Use a imagem de teste:
  ```c
  int img[H][W] = {
      { 10,  20,  30,  40,  50},
      { 60,  70,  80,  90, 100},
      {110, 120, 130, 140, 150},
      {160, 170, 180, 190, 200}
  };
  ```

  *a)* Implemente e teste as três operações abaixo. Antes de
  implementar cada uma, escreva em uma frase o padrão de acesso
  que ela usa (percurso simples, dois índices opostos, etc.):

  ```c
  /* Soma delta a cada pixel, limitando ao intervalo [0, 255] */
  void ajusta_brilho(int img[][W], int h, int delta);

  /* Inverte a ordem das colunas em cada linha */
  void espelha_horizontal(int img[][W], int h);

  /* Inverte a ordem das linhas */
  void espelha_vertical(int img[][W], int h);
  ```

  Padrão de `ajusta_brilho`: `________________________________`

  Padrão de `espelha_horizontal`: `___________________________`

  Padrão de `espelha_vertical`: `_____________________________`

  *b)* Aplique as operações na sequência e preencha a tabela
  com a primeira linha da matriz após cada operação:

  #table(
    columns: (1fr, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 8pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Estado*], [*Primeira linha*],
    [Original],                  [`10  20  30  40  50`],
    [Apos brilho +50],           [],
    [Apos espelho horizontal],   [],
    [Apos espelho vertical],     [],
  )

  *c)* `espelha_horizontal` opera linha por linha, usando o mesmo
  padrão de inversão de vetor da Aula 9. `espelha_vertical` troca
  linhas inteiras. Qual das duas exige um laço aninhado? Por que?
  #caixa_resposta(28pt)

  *d)* O que acontece se você aplicar `espelha_horizontal` duas vezes
  seguidas? E `espelha_vertical` duas vezes? Verifique:
  #caixa_resposta(24pt)

  #destaque[
    *Conexão com o Trabalho Prático:* estas são exatamente as operações
    que você precisará no trabalho de halftoning — mas aplicadas a
    imagens reais lidas de arquivo PGM. O código que você escrever
    aqui pode ser reaproveitado diretamente.
  ]
]

#v(6pt)

// ── Desafio ──────────────────────────────────────────────────
#desafio[
  *Quadrado magico*

  Um quadrado mágico $n times n$ é uma matriz onde a soma de cada
  linha, cada coluna e as duas diagonais são todas iguais.

  Implemente `int eh_magico(int m[][N], int n)` que retorna 1 se
  `m` é um quadrado mágico e 0 caso contrário.

  Estratégia sugerida:
  + Calcule a soma da primeira linha — essa é a soma de referência;
  + Verifique se todas as outras linhas têm a mesma soma;
  + Verifique se todas as colunas têm a mesma soma;
  + Verifique as duas diagonais.

  Teste com o quadrado mágico clássico 3x3:
  ```
  2 7 6
  9 5 1
  4 3 8
  ```
  Todas as somas valem 15. Teste também com uma matriz que *não* é
  mágica e verifique que a função retorna 0.

  *Extensão:* quantas verificações no total sua função faz para
  uma matriz $n times n$? Expresse em função de $n$.
]
