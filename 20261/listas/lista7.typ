// ============================================================
//  Lista de Exercícios — Aula 7
//  Introdução a Algoritmos
//  Raoni F. S. Teixeira
// ============================================================

#set document(
  title: "Lista de Exercícios — Aula 7",
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
      [Lista de Exercícios — Aula 7],
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
    Lista de Exercícios — Aula 7
  ]
  #v(3pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Introdução a Algoritmos  | Raoni F. S. Teixeira
  ]
]

#v(10pt)

// ============================================================
//  LISTA 7 — FUNÇÕES
// ============================================================

#secao("Lista 7", "Funções")

//#nota[Fonte: Lista 3 (Funções).]

+ Escreva um programa que implementa uma calculadora. Leia um
  símbolo de operação e dois valores reais. Implemente uma função
  para cada operação da tabela abaixo, reutilizando funções
  auxiliares (ex.: use a função de fatorial para combinações):

  #table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Operação*], [*Símbolo*], [*Arg. 1*], [*Arg. 2*],
    [Adição],       [`+`], [Termo1],    [Termo2],
    [Subtração],    [`-`], [Minuendo],  [Subtraendo],
    [Multiplicação],[`*`], [Fator1],    [Fator2],
    [Divisão],      [`/`], [Dividendo], [Divisor],
    [Resto],        [`%`], [Dividendo], [Divisor],
    [Potenciação],  [`^`], [Base],      [Expoente],
    [Combinação],   [`C`], [N],         [P],
  )

+ Faça uma função que calcule a integral usando a aproximação:
  $integral_0^n e^(-x^2) d x approx n - frac(n^3, 3 dot 1!) + frac(n^5, 5 dot 2!) - frac(n^7, 7 dot 3!) + dots$
  Protótipo: `double aprox_integral(float n, float cte)`, onde
  `cte` é o critério de parada (pare quando o termo for menor que
  `cte` em valor absoluto).

+ Escreva uma função que recebe a área de um retângulo como
  parâmetro e imprime todos os valores inteiros possíveis para
  seus dois lados.

+ Uma padaria produz pães e bolos usando farinha, fermento e ovos.
  Estoque: 60 de farinha, 38 de fermento, 18 ovos.
  Receita: 1 pão = 1 farinha + 2 fermento;
  1 bolo = 3 farinha + 1 ovo.
  Preços: pão R\$5,00, bolo R\$7,00.
  Escreva um programa de força bruta que determine a quantidade
  de pães e bolos a produzir para maximizar o lucro respeitando
  o estoque. Escreva uma função para verificar se uma combinação
  é viável.