// ============================================================
//  Lista de Exercícios — Aulas 9 e 10
//  Introdução a Algoritmos
//  Raoni F. S. Teixeira
// ============================================================

#set document(
  title: "Lista de Exercícios — Aulas 9 e 10",
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
      [Lista de Exercícios — Aulas 9 e 10],
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
    Lista de Exercícios — Aulas 9 e 10
  ]
  #v(3pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Introdução a Algoritmos  | Raoni F. S. Teixeira
  ]
]

#v(10pt)

// ============================================================
//  LISTA 9 E 10 — VETORES E STRINGS
// ============================================================

#secao("Lista 9 e 10", "Vetores e Cadeias de Caracteres")


+ Escreva funções que calculam, sobre um vetor de reais de tamanho $n$:
  - a soma dos elementos;
  - a média dos elementos;
  - o desvio padrão;
  - o número de elementos repetidos;
  - a mediana _(dica: ordene uma cópia do vetor)_; e
  - a moda.
  Organize com funções auxiliares para reduzir duplicação.

+ Escreva um programa que lê $n$ idades (entre 1 e 100) e calcula
  o histograma dessas idades — quantas pessoas têm cada idade.

+ Escreva uma função que verifica se um vetor de inteiros está
  em ordem crescente.

+ Você e seus amigos participam de um bolão de futebol. Leia os
  números das camisetas dos 11 titulares e depois os números dos
  jogadores escalados. Imprima quantos titulares foram escalados.

+ Uma transportadora tem caminhões com limites de peso diferentes.
  Cada caminhão transporta no máximo duas caixas. Leia $n$ pesos
  de caixas e o limite de um caminhão, e verifique se existem duas
  caixas que podem ser transportadas juntas. Se sim, imprima seus
  índices.

+ Escreva um programa que lê duas palavras e verifica se formam
  um anagrama.

+ Escreva um programa que lê uma palavra e determina se é
  palíndromo.

+ Escreva uma função com protótipo:
  ```c
  int compara(char s1[], char s2[]);
  ```
  que retorna $-1$ se `s1` é lexicograficamente menor que `s2`,
  $1$ se for maior, e $0$ se forem iguais.

+ Escreva uma função:
  ```c
  int concatena(char str1[], char str2[], char res[]);
  ```
  que concatena `str1` e `str2` em `res` e retorna o comprimento
  do resultado.

+ Em citações científicas (ABNT), um autor é referenciado pelo
  último sobrenome em maiúsculas seguido dos demais nomes
  abreviados. Por exemplo, "Luis Fernando Verissimo" vira
  "VERISSIMO, L. F.". Escreva um programa que leia um nome
  completo e imprima a abreviatura ABNT correspondente.
  Assuma: no mínimo um prenome e um sobrenome; sem acentos;
  sem preposições.