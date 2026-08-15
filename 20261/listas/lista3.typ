// ============================================================
//  Lista de Exercícios — Aula 3
//  Introdução a Algoritmos
//  Raoni F. S. Teixeira
// ============================================================

#set document(
  title: "Lista de Exercícios — Aula 3",
  author: "Raoni F. S. Teixeira"
)
#set page(
  paper: "a4",
  margin: (top: 3cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos*],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Lista de Exercícios — Aula 3],
      align(right)[#context counter(page).display("1")])
  ]
)
#set text(font: "Linux Libertine", size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.75em)
#set heading(numbering: none)

// ── Macros ───────────────────────────────────────────────────

#let campo_resposta(linhas) = {
  for _ in range(linhas) {
    block(
      width: 100%, height: 18pt,
      stroke: (bottom: 0.5pt + rgb("#999")),
    )[]
  }
}

#let secao(titulo, subtitulo) = {
  v(1.2em)
  block(
    fill: rgb("#1a3a5c"),
    inset: (x: 12pt, y: 8pt),
    radius: 3pt,
    width: 100%,
  )[
    #text(fill: white, weight: "bold", size: 13pt)[#titulo]
    #if subtitulo != "" [
      #h(8pt)#text(fill: rgb("#aaccee"), size: 10pt)[#subtitulo]
    ]
  ]
  v(0.4em)
}

#let subsecao(titulo) = {
  v(0.6em)
  text(weight: "bold", fill: rgb("#1a3a5c"), size: 11pt)[#titulo]
  v(0.2em)
}

#let destaque(corpo) = block(
  fill: rgb("#fff8e1"), stroke: (left: 3pt + rgb("#e6a817")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#corpo]

#let nota(corpo) = block(
  fill: rgb("#eaf0fb"), stroke: (left: 3pt + rgb("#1a3a5c")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(fill: rgb("#1a3a5c"), style: "italic")[#corpo]]

// ── Título ───────────────────────────────────────────────────

#align(center)[
  #text(size: 17pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Lista de Exercícios — Aula 3
  ]
  #v(3pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Introdução a Algoritmos  | Raoni F. S. Teixeira
  ]
]

#v(10pt)

// ============================================================
//  LISTA 3 — DECISÕES
// ============================================================

#secao("Lista 3", "Expressões Relacionais e Condicionais")

+ Escreva um programa que leia um inteiro e classifique-o como:
  positivo par, positivo ímpar, negativo par, negativo ímpar ou zero.

+ Escreva um programa que leia três lados de um triângulo e
  determine: (a) se formam um triângulo válido; (b) se for válido,
  se é equilátero, isósceles ou escaleno; (c) se é retângulo
  (use o critério de Pitágoras com tolerância de $10^(-6)$).

+ *Análise de algoritmo.* Leia o código abaixo com atenção.

  ```c
  int a, b;
  scanf("%d %d", &a, &b);
  if (a > 0)                /* linha 4  */
      if (b > 0)            /* linha 5  */
          printf("A\n");    /* linha 6  */
      else                  /* linha 7  */
          printf("B\n");    /* linha 8  */
  else                      /* linha 9  */
      printf("C\n");        /* linha 10 */
  ```

  *a)* Para cada entrada abaixo, indique qual letra é impressa:

  #table(
    columns: (auto, auto, auto, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*`a`*], [*`b`*], [*Saída*], [*Justificativa*],
    [`3`],  [`5`],  [], [],
    [`3`],  [`-1`], [], [],
    [`-2`], [`4`],  [], [],
    [`-2`], [`-3`], [], [],
    [`0`],  [`1`],  [], [],
  )

  *b)* O `else` da linha 7 está associado a qual `if`? Por que?

  //#campo_resposta(3)

  *c)* Reescreva o código usando chaves em todos os blocos de
  forma que o `else` da linha 7 se associe ao `if` da linha 4
  (comportamento diferente do original). Qual seria a saída
  para `a=3, b=-1`?

  //#campo_resposta(6)

+ Escreva um programa que receba o ano de nascimento de uma pessoa
  e seu mês e dia de nascimento, e o ano, mês e dia atuais, e
  calcule a idade em anos completos. Trate corretamente o caso em
  que o aniversário ainda não ocorreu no ano atual.

+ *Problema clássico de decisão.* Um banco concede empréstimos
  segundo as regras abaixo. Escreva um programa que leia os dados
  necessários e decida se o empréstimo é aprovado, aprovado com
  fiador, ou negado.
  - Renda mensal acima de R\$5.000: aprovado se a parcela não
    superar 30% da renda.
  - Renda entre R\$2.000 e R\$5.000: aprovado com fiador se a
    parcela não superar 25% da renda; negado caso contrário.
  - Renda abaixo de R\$2.000: sempre negado.

+ *Análise de algoritmo — máxima execução de linhas.*
  Considere o programa abaixo, que recebe três inteiros:

  ```c
  int a, b, c;
  scanf("%d %d %d", &a, &b, &c);

  int res = 0;
  if (a > b) {              /* linha 5  */
      res += a;             /* linha 6  */
      if (b > c)            /* linha 7  */
          res += b;         /* linha 8  */
      else                  /* linha 9  */
          res += c;         /* linha 10 */
  } else {                  /* linha 11 */
      res += b;             /* linha 12 */
  }
  printf("%d\n", res);      /* linha 14 */
  ```

  *a)* Quais linhas são executadas para `a=5, b=3, c=7`?
  //#campo_resposta(3)

  *b)* Quais linhas são executadas para `a=1, b=4, c=2`?
  //#campo_resposta(3)

  *c)* É possível que as linhas 6 e 12 sejam executadas
  na mesma chamada do programa? Justifique.
  //#campo_resposta(3)

  *d)* Para quais valores de `a`, `b`, `c` o resultado impresso
  é máximo? Existe um máximo, ou pode crescer indefinidamente?

  //#campo_resposta(4)

+ Escreva um programa que leia um inteiro e determine se ele é
  divisível por 2, 3, 5 e 7, imprimindo uma linha para cada
  divisor. Para `n=30`, a saída deve ser:
  ```
  30 e divisivel por 2
  30 e divisivel por 3
  30 e divisivel por 5
  30 nao e divisivel por 7
  ```