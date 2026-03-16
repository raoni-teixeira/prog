// ============================================================
//  Lista de Exercícios — Aula 2
//  Introdução a Algoritmos
//  Raoni F. S. Teixeira
// ============================================================

#set document(
  title: "Lista de Exercícios — Aula 2",
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
      [Lista de Exercícios — Aula 2],
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
    Lista de Exercícios — Aula 2
  ]
  #v(3pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Introdução a Algoritmos  | Raoni F. S. Teixeira
  ]
]

#v(10pt)

// ============================================================
//  LISTA 2 — VARIÁVEIS, TIPOS E OPERAÇÕES
// ============================================================

#secao("Lista 2", "Variáveis, Tipos e Operações Aritméticas")

+ Para cada declaração abaixo, indique: (a) se é válida em C;
  (b) o tipo da variável; (c) o valor armazenado após a instrução, se houver.
  #table(
    columns: (1fr, auto, auto, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Declaração*], [*Válida?*], [*Tipo*], [*Valor*],
    [`int x = 3.7;`],               [], [], [],
    [`float y = 1 / 4;`],           [], [], [],
    [`float z = 1.0 / 4;`],         [], [], [],
    [`char c = 65;`],               [], [], [],
    [`int a = 2000000000 + 1000;`], [], [], [],
    [`double d = 1 / 3;`],          [], [], [],
    [`int n = 017;`],               [], [], [],
  )

+ Sem executar, determine o valor impresso por cada `printf`:

  *a)*
  ```c
  int a = 10, b = 3;
  printf("%d %d %f\n", a/b, a%b, (float)a/b);
  ```
  Saída: `_____________________________________________`

  *b)*
  ```c
  int x = 5;
  printf("%d %d\n", x++, ++x);
  ```
  Saída: `_____________________________________________`
  
  _(Atenção: a ordem de avaliação de argumentos de função em C
  é indefinida. O que isso significa na prática?)_

  //#campo_resposta(3)

  *c)*
  ```c
  int a = 7;
  a += 3;
  a *= 2;
  a -= a/4;
  printf("%d\n", a);
  ```
  Saída: `_____________________________________________`

+ Uma fórmula comum em física é $v = v_0 + a t$. Escreva um programa
  que leia $v_0$ (velocidade inicial em m/s), $a$ (aceleração em
  m/s²) e $t$ (tempo em s) e calcule e imprima $v$, a distância
  percorrida $s = v_0 t + 1/2 a t^2$ e a energia cinética
  $E_k = 1/2 m v^2$ para uma massa $m$ também lida do teclado.
  Use `double` para todas as variáveis.

+ Escreva um programa que leia um inteiro de 4 dígitos e extraia
  cada dígito separadamente usando apenas `/` e `%`. Para a entrada
  `2025`, imprima `2 0 2 5`.
  
  _(Dica: o dígito das unidades é `n % 10`. Como obter os demais?)_

+ *Análise de algoritmo.* Considere o trecho abaixo:

  ```c
  int a, b, c;
  scanf("%d %d %d", &a, &b, &c);

  int t1 = a * b + b * c;         /* linha 5 */
  int t2 = (a + c) * (a + c);     /* linha 6 */
  int res = t1 - t2 / 4;          /* linha 7 */
  printf("%d\n", res);
  ```

  *a)* Para a entrada `a=2, b=3, c=4`, qual é o valor impresso?
  //#campo_resposta(3)

  *b)* Existe alguma entrada inteira para a qual `res` seja negativo?
  Se sim, dê um exemplo. Se não, justifique.

  //#campo_resposta(4)

  *c)* O resultado seria diferente se `t2` fosse declarado como
  `float`? Para quais entradas a diferença importa?

  //#campo_resposta(4)

+ Escreva um programa que leia o valor de uma compra em reais e
  calcule o troco mínimo em cédulas e moedas (R\$100, R\$50, R\$20,
  R\$10, R\$5, R\$2, R\$1, R\$0,50, R\$0,25, R\$0,10, R\$0,05, R\$0,01).
  Use apenas operações de divisão inteira e resto. Assuma que o
  valor pago é sempre maior que o valor da compra e que ambos são
  múltiplos de R\$0,01.