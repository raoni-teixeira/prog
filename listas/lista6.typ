// ============================================================
//  Lista de Exercícios — Aula 6
//  Introdução a Algoritmos
//  Raoni F. S. Teixeira
// ============================================================

#set document(
  title: "Lista de Exercícios — Aula 6",
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
      [Lista de Exercícios — Aula 6],
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

// ── Título ───────────────────────────────────────────────────

#align(center)[
  #text(size: 17pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Lista de Exercícios — Aula 6
  ]
  #v(3pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Introdução a Algoritmos  | Raoni F. S. Teixeira
  ]
]

#v(10pt)

// ============================================================
//  LISTA 6 — TESTE DE MESA E BUSCA EXAUSTIVA
// ============================================================

#secao("Lista 6", "Teste de Mesa e Busca Exaustiva")

+ Faça o teste de mesa do programa abaixo para $n = 5$ e preveja
  a saída antes de compilar:
  ```c
  int s = 0, i = 1, n = 5;
  while (i <= n) {
      if (i % 2 == 0) s += i;
      else s -= i;
      i++;
  }
  printf("%d\n", s);
  ```

+ *Análise de algoritmo.* Considere o programa:
  ```c
  int n, cont = 0;
  scanf("%d", &n);
  for (int i = 1; i <= n; i++)
      for (int j = i; j <= n; j += i)
          cont++;
  printf("%d\n", cont);
  ```
  *a)* Para $n = 6$, faça o teste de mesa e determine a saída.
  *b)* O que este programa calcula? _(Dica: qual é a relação entre
  $i$ e $j$ a cada incremento de $j$?)_
  *c)* Para $n = 12$, qual é a saída sem executar?

+ Usando força bruta, escreva um programa que encontre todos os
  pares $(a, b)$ com $1 <= a < b <= 100$ tais que
  $a^2 + b^2$ seja um quadrado perfeito (triplos pitagóricos).
  Imprima cada triplo $(a, b, c)$ onde $c = sqrt(a^2+b^2)$.

+ Escreva um programa de força bruta que encontre, dentre todos
  os inteiros de 1 a 1000, o que tem o maior número de divisores.
  Imprima o número e sua quantidade de divisores.

+ Um número é dito perfeito se é igual à soma de seus divisores
  próprios (excluindo ele mesmo). Por exemplo: $6 = 1+2+3$.
  Encontre todos os números perfeitos menores que 10000.

+ _(Desafio)_ Escreva um programa de força bruta que resolva o
  problema da mochila 0-1: dados $n$ itens com pesos e valores,
  e uma capacidade $W$, encontre o subconjunto de itens com
  valor total máximo cujo peso total não exceda $W$.
  Teste com $n <= 20$ itens.