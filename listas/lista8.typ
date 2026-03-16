// ============================================================
//  Lista de Exercícios — Aula 8
//  Introdução a Algoritmos
//  Raoni F. S. Teixeira
// ============================================================

#set document(
  title: "Lista de Exercícios — Aula 8",
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
      [Lista de Exercícios — Aula 8],
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
    Lista de Exercícios — Aula 8
  ]
  #v(3pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Introdução a Algoritmos  | Raoni F. S. Teixeira
  ]
]

#v(10pt)

// ============================================================
//  LISTA 8 — PONTEIROS
// ============================================================

#secao("Lista 8", "Ponteiros e Passagem por Referência")


+ Dadas as declarações abaixo, determine o valor de cada expressão.
  Use os endereços indicados: `x` em FFA0, `y` em FFB4, `px` em FFF0,
  `py` em FFC6, `ppx` em FFD4, `ppy` em FFA6.
  ```c
  int x = 10, *px = &x, **ppx = &px;
  float y = 5.9, *py = &y, **ppy = &py;
  ```

  #table(
    columns: (auto, 1fr, auto, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Expressão*], [*Valor*], [*Expressão*], [*Valor*],
    [`x`],      [], [`&x`],    [],
    [`*py`],    [], [`&y`],    [],
    [`px`],     [], [`*ppx`],  [],
    [`*px`],    [], [`py`],    [],
    [`y`],      [], [`**ppy`], [],
    [`&ppy`],   [], [`*&px`],  [],
    [`**ppx`],  [], [`&ppx`],  [],
  )

+ Qual o problema da função `troca` abaixo? Corrija-a:
  ```c
  void troca(int *i, int *j) {
      int *temp;
      *temp = *i;
      *i = *j;
      *j = *temp;
  }
  ```

+ Suponha que cada `int` ocupa 4 bytes e que `v[0]` está no
  endereço 55000. Qual o valor da expressão `v + 3`?

+ Descreva em português a sequência de operações para calcular
  `v[i + 9]`, dado que `v` é um vetor de inteiros e `i` é
  uma variável inteira.

+ Descreva a diferença conceitual entre `v[3]` e `v + 3`,
  sendo `v` um vetor.

+ O que faz a função abaixo?
  ```c
  void imprime(char *v, int n) {
      char *c;
      for (c = v; c < v + n; c++)
          printf("%c", *c);
  }
  ```

+ Analise o programa:
  ```c
  void func1(int x)    { x = 9 * x; }
  void func2(int v[])  { v[0] = 9 * v[0]; }

  int main(void) {
      int x = 111, v[2];
      v[0] = 111;
      func1(x);
      printf("x: %d\n", x);
      func2(v);   printf("v[0]: %d\n", v[0]);
      return 0;
  }
  ```
  Explique por que o programa produz `x: 111` e `v[0]: 999`.

+ Explique por que o trecho abaixo está incorreto para comparar
  strings lexicograficamente:
  ```c
  char *a = "abacate", *b = "uva";
  if (a < b)
      printf("%s vem antes de %s\n", a, b);
  ```