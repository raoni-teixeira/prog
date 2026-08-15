// ============================================================
//  Lab 8 — Ponteiros
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 8", author: "Raoni F. S. Teixeira")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 8],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Ponteiros],
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
    Laboratório 8 — Ponteiros
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

  1. distinguir os três significados de `*` em C pelo contexto e explicar  `&` como operador de endereço; 
  2. desenhar o diagrama de memória de um programa com ponteiros, mostrando endereços e valores; 
  3. escrever funções que modificam variáveis do chamador via ponteiros; 
  4. identificar e corrigir os erros clássicos de ponteiro não inicializado e uso após free.
  ],
) 



#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Leitura de codigo com ponteiros — prever sem executar", "25")[
  Para cada trecho abaixo, *sem compilar*: (a) identifique o significado
  de cada `*` e `&`; (b) preveja a saida; (c) compile e verifique.

  *Trecho A:*
  ```c
  int x = 5, y = 10;
  int *p = &x;
  *p = 20;
  p = &y;
  *p = *p + x;
  printf("%d %d\n", x, y);
  ```

  Identifique cada simbolo:
  #table(
    columns: (auto, auto, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Linha*], [*Simbolo*], [*Significado*],
    [`int *p = &x`], [`*`  (na declaracao)], [],
    [`int *p = &x`], [`&x`],                 [],
    [`*p = 20`],     [`*p`],                 [],
    [`p = &y`],      [`&y`],                 [],
    [`*p + x`],      [`*p`],                 [],
  )

  Saida prevista: `_______`   Saida real: `_______`

  #v(8pt)
  *Trecho B:*
  ```c
  int a = 3, b = 7;
  int *p = &a, *q = &b;
  *p = *p * *q;
  *q = *p - *q;
  *p = *p - *q;
  printf("%d %d\n", a, b);
  ```

  Saida prevista: `_______`   Saida real: `_______`

  O que essa sequencia de tres operacoes faz com `a` e `b`?
  #caixa_resposta(24pt)

  #v(8pt)
  *Trecho C — o scanf explicado:*
  ```c
  int n;
  int *p = &n;
  scanf("%d", p);          /* sem & — por que funciona? */
  printf("%d\n", n);
  ```

  Por que `scanf("%d", p)` funciona sem o `&` neste caso?
  #caixa_resposta(28pt)
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "Diagrama de memoria", "20")[
  Para o programa abaixo, desenhe o diagrama de memoria no momento
  em que a linha marcada com `/* AQUI */` esta sendo executada.
  Use enderecos fictícios: `x` em 1000, `y` em 1004, `p` em 2000,
  `q` em 2008.

  ```c
  int x = 10, y = 20;
  int *p = &x;
  int *q = &y;
  *p = *q + 5;            /* AQUI */
  q = p;
  printf("%d %d\n", x, y);
  ```

  Diagrama (use as caixas abaixo — escreva o endereço, nome e valor
  de cada variável):

  #block(
    fill: rgb("#f5f5f5"), stroke: 0.5pt + rgb("#999"),
    inset: 16pt, radius: 4pt, width: 100%,
  )[
    #table(
      columns: (1fr, 1fr, 1fr, 1fr),
      stroke: 0.5pt + rgb("#aaa"),
      inset: 20pt,
      fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
      [*`x`* \ end: 1000 \ val: __], [*`y`* \ end: 1004 \ val: __],
      [*`p`* \ end: 2000 \ val: __], [*`q`* \ end: 2008 \ val: __],
    )
  ]

  *a)* Apos a linha `q = p`, o que `*q` vale? `_______`

  *b)* Apos `q = p`, modificar `*q` afetaria `x` ou `y`? Por que?
  #caixa_resposta(28pt)

  *c)* Compile e verifique o valor impresso. Confere com sua analise?
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "Passagem por referencia — funcoes que modificam o chamador", "30")[
  Agora que sabemos o que o Lab 7 nao conseguia fazer, vamos resolver.

  *Parte A — a troca que funciona:*

  Implemente `void troca(int *a, int *b)` que troca os valores das
  variaveis apontadas. Teste com o programa abaixo:

  ```c
  int x = 10, y = 20;
  printf("Antes:  x=%d, y=%d\n", x, y);
  troca(&x, &y);
  printf("Depois: x=%d, y=%d\n", x, y);
  /* deve imprimir: Depois: x=20, y=10 */
  ```

  *a)* Por que passamos `&x` e `&y` em vez de `x` e `y`?
  #caixa_resposta(28pt)

  *Parte B — multiplos retornos via ponteiros:*

  Implemente a funcao abaixo que calcula simultaneamente o quociente
  e o resto da divisao inteira, escrevendo os resultados nos enderecos
  fornecidos:

  ```c
  /*
   * Calcula quociente e resto de a / b.
   * Escreve o quociente em *q e o resto em *r.
   * Pre-cond.: b != 0
   */
  void divide(int a, int b, int *q, int *r);
  ```

  Teste com: `divide(17, 5, &q, &r)` deve produzir `q=3, r=2`.

  *b)* Por que esta funcao usa ponteiros em vez de retornar um valor?
  #caixa_resposta(28pt)

  *Parte C — minimo e maximo em uma passagem:*

  Implemente:
  ```c
  /*
   * Le n inteiros do teclado e armazena o menor em *min
   * e o maior em *max.
   * Pre-cond.: n >= 1
   */
  void minmax(int n, int *min, int *max);
  ```

  Escreva `main` que leia `n`, chame `minmax` e imprima o resultado.
  Teste com `n=5`, valores `3 7 1 9 4`. Esperado: min=1, max=9.
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Caca ao bug — tres erros classicos com ponteiros", "20")[

  #bug("Ponteiro nao inicializado")[
    ```c
    #include <stdio.h>
    int main() {
        int *p;
        *p = 42;
        printf("%d\n", *p);
        return 0;
    }
    ```
    *a)* O que acontece ao executar? Por que?
    #caixa_resposta(28pt)

    *b)* Corrija o programa declarando uma variavel `int x` e fazendo
    `p` apontar para ela antes de usar `*p`.
  ]

  #v(8pt)

  #bug("Retornar endereco de variavel local")[
    ```c
    #include <stdio.h>

    int *cria_valor(int n) {
        int x = n * 2;
        return &x;        /* perigo */
    }

    int main() {
        int *p = cria_valor(5);
        printf("%d\n", *p);
        return 0;
    }
    ```
    *a)* O programa pode parecer funcionar em algumas execucoes.
    Por que o resultado e imprevisivel?
    #caixa_resposta(32pt)

    *b)* Relacione este bug ao modelo de stack da Aula 13a:
    o que acontece com `x` quando `cria_valor` retorna?
    #caixa_resposta(28pt)

    *c)* Corrija o programa sem usar `malloc` — apenas mude onde
    `x` e declarado.
    #caixa_resposta(36pt)
  ]

  #v(8pt)

  #bug("Confusao entre * na declaracao e * na desreferencia")[
    O trecho abaixo tem um erro conceitual que o compilador pode
    nao detectar. Identifique-o.

    ```c
    int x = 10;
    int *p, q;      /* intencao: dois ponteiros */
    p = &x;
    q = &x;         /* erro aqui */
    ```

    *a)* `q` e um ponteiro para `int` ou um `int`? Por que?
    #caixa_resposta(24pt)

    *b)* Como declarar corretamente dois ponteiros na mesma linha?
    #caixa_resposta(20pt)

    #destaque[
      Por isso muitos programadores preferem declarar cada ponteiro
      em sua propria linha, ou escrever `int* p` em vez de `int *p`
      — embora ambas as formas sejam equivalentes para o compilador.
    ]
  ]
]

#v(6pt)

// ── Desafio ──────────────────────────────────────────────────
#desafio[
  *Ordenar tres valores via ponteiros*

  Escreva uma funcao `void ordena3(int *a, int *b, int *c)` que
  garante que apos a chamada `*a <= *b <= *c`, usando apenas chamadas
  a `troca` da Atividade 3.

  Quantas chamadas a `troca` sao necessarias no pior caso?

  Teste com todas as permutacoes de `(1, 2, 3)`:
  `(1,2,3)`, `(1,3,2)`, `(2,1,3)`, `(2,3,1)`, `(3,1,2)`, `(3,2,1)`.
  Em todos os casos o resultado deve ser `1 2 3`.
]
