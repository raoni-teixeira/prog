// ============================================================
//  Lista de Exercícios — Aula 5
//  Introdução a Algoritmos
//  Raoni F. S. Teixeira
// ============================================================

#set document(
  title: "Lista de Exercícios — Aula 5",
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
      [Lista de Exercícios — Aula 5],
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

#let nota(corpo) = block(
  fill: rgb("#eaf0fb"), stroke: (left: 3pt + rgb("#1a3a5c")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(fill: rgb("#1a3a5c"), style: "italic")[#corpo]]

// ── Título ───────────────────────────────────────────────────

#align(center)[
  #text(size: 17pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Lista de Exercícios — Aula 5
  ]
  #v(3pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Introdução a Algoritmos  | Raoni F. S. Teixeira
  ]
]

#v(10pt)

// ============================================================
//  LISTA 5a — REPETIÇÃO (Somatórios e séries)
// ============================================================

#secao("Lista 5a", "Repetição — Somatórios e Séries")

#nota[*Importante*. Não use funções
de `<math.h>` exceto onde indicado.]

+ Escreva um programa que calcula a soma dos primeiros $N$ números
  naturais:
  $S = 1 + 2 + 3 + dots + N$
  Compare o resultado com a fórmula fechada $S = N(N+1)/2$.

+ Escreva um programa que calcula a soma dos quadrados dos primeiros
  $N$ números naturais:
  $S = 1^2 + 2^2 + 3^2 + dots + N^2$
  Não use funções de `<math.h>`.

+ Escreva um programa que calcula a Série Harmônica truncada:
  $H_N = 1 + frac(1,2) + frac(1,3) + dots + frac(1,N)$
  Observe como a soma cresce lentamente conforme $N$ aumenta.
  Para quais valores de $N$ a soma ultrapassa 5? E 10?

+ Escreva um programa que calcula o produto dos números ímpares
  até $N$:
  $P = 1 times 3 times 5 times dots times N$

+ Escreva um programa que calcula uma aproximação de $e$ usando a
  série de Taylor:
  $e approx sum_(k=0)^(N) frac(1,k!)$
  _(Dica: calcule o fatorial de forma incremental — a cada iteração,
  multiplique o fatorial anterior por $k$, sem recalcular do zero.)_

+ Escreva um programa que calcula a série Alternada de Leibniz para $pi$:
  $frac(pi,4) = 1 - frac(1,3) + frac(1,5) - frac(1,7) + frac(1,9) - dots$
  Teste com $N = 100$, $N = 1000$, $N = 100000$. Observe a convergência.

+ Escreva um programa que calcula a série alternada para $ln(2)$:
  $ln(2) = 1 - frac(1,2) + frac(1,3) - frac(1,4) + dots$
  Implemente um laço que pare quando o termo corrente for menor
  que $10^(-6)$ em valor absoluto.

+ Escreva um programa que calcula a série de Basel (Euler):
  $S = sum_(n=1)^(infinity) frac(1,n^2) = frac(pi^2,6)$
  Calcule até $N = 1000$ e compare com $pi^2/6$.

+ Escreva um programa que calcula a série geométrica:
  $S = 1 + r + r^2 + dots + r^N$
  Leia $r$ e $N$ do teclado.
  Compare com a fórmula fechada
  $S = (r^(N+1) - 1)/(r - 1)$ para $r != 1$.

+ Escreva um programa que calcula o produto de Wallis
  (aproximação de $pi$):
  $frac(pi,2) = product_(n=1)^(infinity) frac(2n dot 2n,(2n-1)(2n+1))$
  Calcule a aproximação de $pi$ para diferentes valores de $N$
  e observe a convergência.

// ============================================================
//  LISTA 5b — REPETIÇÃO (Problemas gerais)
// ============================================================

#secao("Lista 5b", "Repetição — Problemas Gerais")


+ Escreva um programa que lê um número $n$ e, em seguida, lê $n$
  valores inteiros e imprime o maior deles.

+ Escreva um programa que lê um inteiro $n$ e imprime $n!$.
  Se $n$ for negativo, exiba "Entrada incorreta!". Como extra,
  imprima a expressão na forma
  $1 times 2 times 3 times dots times n = n!$.
  Para $n = 7$, imprima `1 * 2 * 3 * 4 * 5 * 6 * 7 = 5040`.

+ Escreva um programa que lê um inteiro positivo $n$ e imprime
  $n$ linhas do triângulo de Floyd:
  ```
  1
  2 3
  4 5 6
  7 8 9 10
  ...
  ```

+ Escreva um programa que recebe $n$ e imprime $n$ sequências
  de inteiros, alternando entre a sequência crescente e a invertida.
  Para $n = 4$:
  ```
  1 2 3 4
  4 3 2 1
  1 2 3 4
  4 3 2 1
  ```

+ Um número inteiro $n$ é dito subnúmero de $m$ se os dígitos
  de $n$ aparecem na mesma sequência em $m$. Escreva um programa
  que lê $n$ e $m$ e imprime "SIM" ou "NAO".

+ Escreva um programa que lê $n$ e uma sequência $S$ de $n$
  inteiros e imprime o comprimento da maior subsequência crescente
  contígua em $S$. Para $S = [4, 1, 2, 3, 0, 5, 7, 8]$, a maior
  subsequência crescente contígua é $[1, 2, 3]$ com comprimento 3.
  _(Nota: subsequência contígua, não subconjunto.)_

+ Escreva um programa que lê $n$ e imprime $n$ sequências onde
  a primeira é $1\ 2\ dots\ n$ e cada seguinte omite o primeiro
  elemento da anterior. Para $n = 3$:
  ```
  1 2 3
  2 3
  3
  ```

+ Suponha que seu computador só execute soma e subtração. Escreva
  programas que, dados dois inteiros $a$ e $b$ (não necessariamente
  positivos), calculem:
  *(a)* o produto $a dot b$;
  *(b)* o quociente e o resto da divisão de $a$ por $b$.

+ Escreva um programa que lê um inteiro e imprime a quantidade
  de dígitos decimais desse número.

+ Escreva um programa que recebe $l$, $c$, $i$ e $j$ e imprime
  um retângulo de $l$ linhas e $c$ colunas com `'-'` em todas
  as posições exceto $(i, j)$, onde imprime $i dot j$.
  Trate entradas inválidas. Para $l=4, c=3, i=2, j=2$:
  ```
  - - -
  - 4 -
  - - -
  - - -
  ```

+ Escreva um programa que, dado $n$, calcule a soma repetida
  dos dígitos de $n$ — soma os dígitos repetidamente até obter
  um número de um único dígito. Para $n = 9999$: $9+9+9+9=36$,
  depois $3+6=9$. Imprima 9.

+ Escreva um programa para determinar se uma sequência de $n$
  números está ordenada crescentemente.

+ Calcule a raiz quadrada de um número positivo $Y$ usando o
  método de Newton: $x_1 = Y/2$ e
  $x_(n+1) = x_n - f(x_n)/f'(x_n)$ onde $f(x) = x^2 - Y$.
  Imprima a vigésima aproximação.

+ Um número triangular é da forma $T_n = n(n+1)/2$.
  Os primeiros são: 1, 3, 6, 10, 15, 21, ...
  Escreva um programa que lê $n$ e imprime a soma dos $n$
  primeiros números triangulares.

+ Um apostador supersticioso da Mega-Sena só faz jogos em que
  o 1º número é par, o 2º ímpar, o 3º par, o 4º ímpar, o 5º par
  e o 6º ímpar. Imprima todos os jogos possíveis.

+ Escreva um programa que lê um inteiro positivo e determina se
  seus dígitos estão em ordem crescente da esquerda para a direita.
  Os números 1357 e 13399 estão ordenados; 110 e 17787, não.

+ Escreva um programa que lê um inteiro positivo e imprime sua
  representação em algarismos romanos.

+ Escreva um programa que lê $n$ e calcula as seguintes
  aproximações de $pi$:

  $frac(pi,2) = frac(2,1) dot frac(2,3) dot frac(4,3) dot frac(4,5) dot frac(6,5) dot frac(6,7) dots$

  $frac(pi,2) = product_(k=1)^(n) frac((2k)^2,(2k)^2 - 1)$

  $pi = sum_(k=0)^(n-1) frac(4 dot (-1)^k, 2k+1)$

  $pi = 3 + frac(4,2 dot 3 dot 4) - frac(4,4 dot 5 dot 6) + frac(4,6 dot 7 dot 8) dots$

+ Escreva um programa que lê $n$ inteiros e calcula a frequência
  de ocorrência de cada valor na sequência, *sem usar vetores
  ou estruturas*.