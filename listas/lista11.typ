// ============================================================
//  Lista de Exercícios — Aula 11
//  Introdução a Algoritmos
//  Raoni F. S. Teixeira
// ============================================================

#set document(
  title: "Lista de Exercícios — Aula 11",
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
      [Lista de Exercícios — Aula 11],
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
    Lista de Exercícios — Aula 11
  ]
  #v(3pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Introdução a Algoritmos  | Raoni F. S. Teixeira
  ]
]

#v(10pt)

// ============================================================
//  LISTA 11 — MATRIZES
// ============================================================

#secao("Lista 11", "Matrizes")

#nota[Fonte: Lista 5 (Matrizes).]

+ Escreva funções que calculam as seguintes operações sobre
  matrizes quadradas $10 times 10$:
  - adição de duas matrizes;
  - subtração de duas matrizes;
  - transposta de uma matriz;
  - multiplicação de duas matrizes.

+ Escreva uma função que verifica se ocorreu xeque num jogo de
  xadrez. O tabuleiro é uma matriz $8 times 8$ onde 0 indica
  ausência de peça. Peças são representadas conforme a tabela:

  #table(
    columns: (auto, auto, auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 6pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Val.*],[*Peça*],[*Val.*],[*Peça*],[*Val.*],[*Peça*],
    [`1`],[Peão preto],  [`5`],[Rei preto],   [`9`],[Torre branca],
    [`2`],[Cavalo preto],[`6`],[Rainha preta], [`10`],[Bispo branco],
    [`3`],[Torre preta], [`7`],[Peão branco],  [`11`],[Rei branco],
    [`4`],[Bispo preto], [`8`],[Cavalo branco],[`12`],[Rainha branca],
  )

+ Escreva um programa que recebe uma matriz de caracteres e uma
  palavra e determina se a palavra está na matriz. Uma palavra
  está na matriz se pode ser encontrada iniciando em alguma célula
  e seguindo em linha reta em um dos oito sentidos (N, NE, L, SE,
  S, SO, O, NO). Imprima todas as posições iniciais encontradas.

+ Implemente o Jogo da Vida de Conway num reticulado $50 times 50$
  com condições de contorno periódicas (toroidal). Regras:
  - Uma célula viva com 2 ou 3 vizinhos sobrevive;
  - Uma célula viva com menos de 2 ou mais de 3 vizinhos morre;
  - Uma célula morta com exatamente 3 vizinhos nasce.
  Gere a primeira geração aleatoriamente e simule $G$ gerações.

+ Em processamento de imagens, a operação de erosão $3 times 3$
  substitui cada célula pelo mínimo entre ela e seus 8 vizinhos.
  Escreva um programa que lê as dimensões e os valores de uma
  matriz e imprime o resultado da erosão. A vizinhança é válida
  apenas dentro da matriz (sem padding). Para a matriz $5 times 5$ a seguir, o resultado esperado é:
  $
  mat(1,1,1,1,0;1,1,1,1,1;1,1,0,1,1;1,1,1,1,1;1,1,1,1,1)
  arrow.r
  mat(1,1,1,0,0;1,0,0,0,0;1,0,0,0,1;1,0,0,0,1;1,1,1,1,1)
  $