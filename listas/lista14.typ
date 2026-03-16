// ============================================================
//  Lista de Exercícios — Aula 14
//  Introdução a Algoritmos
//  Raoni F. S. Teixeira
// ============================================================

#set document(
  title: "Lista de Exercícios — Aula 14",
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
      [Lista de Exercícios — Aula 14],
      align(right)[#context counter(page).display("1")])
  ]
)
#set text(font: "Linux Libertine", size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.75em)
#set heading(numbering: none)

// ── Macros ───────────────────────────────────────────────────

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

#let nota(corpo) = block(
  fill: rgb("#eaf0fb"), stroke: (left: 3pt + rgb("#1a3a5c")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(fill: rgb("#1a3a5c"), style: "italic")[#corpo]]

// ── Título ───────────────────────────────────────────────────

#align(center)[
  #text(size: 17pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Lista de Exercícios — Aula 14
  ]
  #v(3pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Introdução a Algoritmos  | Raoni F. S. Teixeira
  ]
]

#v(10pt)

// ============================================================
//  LISTA 14 — RECURSÃO
// ============================================================

#secao("Lista 14", "Recursão")

+ Considere as funções abaixo:
  ```c
  double power(double a, int n) {
      if (n == 0) return 1;
      if (n == 1) return a;
      return a * power(a, n-1);
  }

  double power2(double a, int n) {
      double m;
      if (n == 0) return 1;
      if (n == 1) return a;
      m = power2(a, n/2);
      if (n % 2) return m*m*a;
      else       return m*m;
  }
  ```

  *a)* Qual a finalidade das duas funções e qual o resultado de
  `power(2, 5)` e `power2(2, 5)`?
  *b)* Para $n = 15$, quantas multiplicações são realizadas por
  `power` e por `power2`?

+ Escreva um programa que dado $n$ calcule a soma repetida dos
  dígitos de $n$ usando duas funções recursivas: uma para somar
  os dígitos e outra para controlar a repetição. Para $n = 9999$:
  $9+9+9+9 = 36$, depois $3+6 = 9$. Imprima 9.

+ Escreva uma função recursiva que recebe $n$ e devolve a
  quantidade de dígitos 1 na representação binária de $n$.
  Para $n = 5$ (binário: $101_2$), retorna 2.

+ A busca sequencial percorre um vetor posição a posição até
  encontrar o elemento ou esgotar o vetor. Escreva uma versão
  recursiva do algoritmo de busca sequencial.

+ Escreva funções recursivas para calcular:
  - a média dos elementos de um vetor;
  - o maior elemento de um vetor;
  - o resto da divisão entre dois inteiros (usando apenas subtrações);
  - o comprimento de uma cadeia de caracteres.

+ Escreva uma função recursiva que determina se os elementos de
  um vetor formam um palíndromo.
  - $[1, 10, 40, 10, 1]$ é palíndromo;
  - $[20, 50, 31, 20]$ não é.

+ Escreva uma função recursiva que recebe um inteiro positivo $n$
  e um vetor $v$ de $n$ inteiros, e verifica se $v$ está ordenado
  crescentemente. Retorne 1 (sim) ou 0 (não).

+ _(Desafio)_ Implemente as Torres de Hanói: $n$ discos, três
  pinos (A, B, C). Mova todos os discos de A para C usando B como
  auxiliar, nunca colocando disco maior sobre menor.
  Imprima cada movimento. Quantos movimentos são necessários
  para $n$ discos?