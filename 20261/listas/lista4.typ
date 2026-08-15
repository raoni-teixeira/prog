// ============================================================
//  Lista de Exercícios — Aula 4
//  Introdução a Algoritmos
//  Raoni F. S. Teixeira
// ============================================================

#set document(
  title: "Lista de Exercícios — Aula 4",
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
      [Lista de Exercícios — Aula 4],
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
    Lista de Exercícios — Aula 4
  ]
  #v(3pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Introdução a Algoritmos  | Raoni F. S. Teixeira
  ]
]

#v(10pt)

// ============================================================
//  LISTA 4 — LÓGICA, SWITCH E LEGIBILIDADE
// ============================================================

#secao("Lista 4", "Expressões Lógicas, switch e Legibilidade")

+ Simplifique cada expressão usando operadores lógicos, de modo que
  o `if` resultante não tenha `else-if` aninhado:

  *a)* Um número `x` está no intervalo $[10, 20]$ ou no intervalo
  $[30, 40]$:
  ```c
  /* versao com ifs */
  if (x >= 10 && x <= 20)
      valido = 1;
  else if (x >= 30 && x <= 40)
      valido = 1;
  else
      valido = 0;
  ```
  Versão simplificada (uma única atribuição):
  
  `valido = `#campo_resposta(1)

  *b)* Um ano `a` é bissexto se divisível por 4, exceto se divisível
  por 100, a menos que também seja divisível por 400:

  `bissexto = `#campo_resposta(1)

  *c)* Um caractere `c` é uma letra maiúscula, ou uma letra minúscula,
  ou um dígito (sem usar funções de `<ctype.h>`):

  `alfanum = `#campo_resposta(1)

+ Avalie as expressões abaixo, sabendo que `int x=3, y=5, z=0`:

  #table(
    columns: (1fr, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 8pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Expressão*], [*Valor (0 ou 1)*],
    [`x > 2 && y < 10`],             [],
    [`x == 3 || z == 1`],            [],
    [`!(x > y)`],                    [],
    [`x > 0 && y > 0 && z > 0`],    [],
    [`x > 0 || y > 0 || z > 0`],    [],
    [`!(x == 3 && y == 5)`],         [],
    [`x < y && y < z || x == 3`],   [],
  )

+ *Análise de algoritmo — avaliação em curto-circuito.*

  ```c
  int x = 0, y = 10;
  if (x != 0 && y / x > 2)     /* linha 3 */
      printf("A\n");
  if (x == 0 || y / x > 2)     /* linha 5 */
      printf("B\n");
  ```

  *a)* A linha 3 executa a divisão `y/x`? Por quê?
  //#campo_resposta(3)

  *b)* A linha 5 executa a divisão `y/x`? Por quê?
  //#campo_resposta(3)

  *c)* O que seria impresso se as ordens das condições fosse
  invertidas em ambas as linhas?
  //#campo_resposta(3)

+ Escreva um programa com `switch` que leia um número de 1 a 12
  e imprima o nome do mês, o número de dias (sem considerar
  bissexto) e a estação do ano correspondente no hemisfério sul.
  Use fall-through intencional para os meses com 31 dias.

+ *Revisão de código — aplique os quatro pilares.*
  O programa abaixo está funcional mas ilegível. Reescreva-o:

  ```c
  #include<stdio.h>
  int main(){int a,b,c,x;scanf("%d%d%d",&a,&b,&c);
  x=a+b+c;if(x%2==0)if(x>100)printf("gp\n");else
  printf("gn\n");else if(x>100)printf("ip\n");
  else printf("in\n");return 0;}
  ```

  *a)* Sem executar: o que este programa calcula?
  //#campo_resposta(3)

  *b)* Reescreva com nomes descritivos, indentação e comentários:

  //#campo_resposta(16)

+ *Análise de algoritmo — máxima execução de linhas.*
  Considere o programa que lê uma matriz $4 times 4$:

  ```c
  #define N 4
  int m[N][N], soma = 0, k = 0;
  /* leitura da matriz omitida */

  for (int i = 0; i < N; i++) {          /* linha 5  */
      for (int j = 0; j < N; j++) {      /* linha 6  */
          if (m[i][j] > 0) {             /* linha 7  */
              soma += m[i][j];           /* linha 8  */
              if (m[i][j] % 2 == 0) {    /* linha 9  */
                  k++;                   /* linha 10 */
              }                          /* linha 11 */
          }                              /* linha 12 */
      }                                  /* linha 13 */
  }                                      /* linha 14 */
  printf("%d %d\n", soma, k);            /* linha 15 */
  ```

  *a)* Quantas vezes no máximo a linha 8 pode ser executada?
  `_______`   Quando isso ocorre?

  //#campo_resposta(2)

  *b)* Mostre uma matriz $4 times 4$ para a qual as linhas 8 *e* 10
  são executadas o maior número possível de vezes. Preencha:

  #table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 12pt,
    fill: white,
    [], [], [], [],
    [], [], [], [],
    [], [], [], [],
    [], [], [], [],
  )

  Para essa matriz: linha 8 executa `_______` vezes,
  linha 10 executa `_______` vezes.

  *c)* É possível que a linha 10 execute mais vezes que a linha 8?
  Justifique:

  //#campo_resposta(3)

  *d)* Mostre uma matriz para a qual `soma` seja máximo e `k` seja
  zero simultaneamente:

  #table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 12pt,
    fill: white,
    [], [], [], [],
    [], [], [], [],
    [], [], [], [],
    [], [], [], [],
  )

  `soma` = `_______`

+ Escreva um programa que leia o código de um produto (inteiro),
  a quantidade comprada e o preço unitário, e calcule o total.
  Aplique os seguintes descontos usando `switch` sobre o código:
  - Código 1 (alimentos): 5%
  - Código 2 (higiene): 10%
  - Código 3 (eletrônicos): 0%
  - Qualquer outro: mensagem "Codigo invalido"

  Documente o programa com cabeçalho completo (descrição, entradas,
  saídas, pré-condições, autor).

// ============================================================
//  PROBLEMAS INTEGRADORES (Aulas 1–4)
// ============================================================

#secao("Problemas integradores", "Combinam conceitos das Aulas 1 a 4")

+ *Calculadora de progressão aritmética.* Escreva um programa que
  leia o primeiro termo $a_1$, a razão $r$ e o número de termos $n$
  de uma progressão aritmética (PA). Calcule e imprima: o n-ésimo
  termo ($a_n = a_1 + (n-1)r$) e a soma dos $n$ termos
  ($S_n = n(a_1 + a_n)/2$). Trate o caso $n \leq 0$ como entrada
  inválida.

+ *Equação do segundo grau.* Escreva um programa que leia os
  coeficientes $a$, $b$ e $c$ e resolva a equação $a x^2 + b x + c = 0$,
  tratando todos os casos: $a = 0$ (equação linear ou degenerada),
  discriminante negativo (raízes complexas), discriminante zero
  (raiz dupla) e discriminante positivo (duas raízes reais).
  Use `sqrt` de `<math.h>`.

+ *Validador de CPF (dígitos verificadores).* O CPF tem 11 dígitos,
  sendo os últimos dois dígitos verificadores calculados assim:

  - Primeiro verificador: multiplique os 9 primeiros dígitos por
    10, 9, 8, ..., 2 respectivamente, some os produtos, calcule
    o resto da divisão por 11. Se o resto for 0 ou 1, o verificador
    é 0; caso contrário, é $11 - text{"resto"}$.
  - Segundo verificador: igual, mas use os 10 primeiros dígitos
    (incluindo o primeiro verificador) multiplicados por 11, 10, ..., 2.

  Escreva um programa que leia 11 dígitos separados por espaço
  e informe se o CPF é válido. Use apenas variáveis simples e
  operadores aritméticos — sem vetores.

+ *Análise de algoritmo — pré-análise.*
  O programa abaixo lê dois inteiros $a$ e $b$ ($a, b \geq 1$):

  ```c
  int a, b, res = 1;
  scanf("%d %d", &a, &b);

  if (a % 2 == 0 && b % 2 == 0) {      /* linha 4  */
      res = a + b;                     /* linha 5  */
  } else if (a % 2 != 0) {             /* linha 6  */
      if (b > a) {                     /* linha 7  */
          res = b - a;                 /* linha 8  */
      } else {                         /* linha 9  */
          res = a * b;                 /* linha 10 */
      }
  } else {                             /* linha 11 */
      res = a / b;                     /* linha 12 */
  }
  printf("%d\n", res);
  ```

  *a)* Preencha a tabela:
  #table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*`a`*], [*`b`*], [*Linhas executadas*], [*`res` impresso*],
    [`4`],  [`6`],  [], [],
    [`3`],  [`7`],  [], [],
    [`5`],  [`3`],  [], [],
    [`6`],  [`3`],  [], [],
  )

  *b)* Dê um exemplo de entrada para a qual a linha 10 é executada
  e `res` é máximo entre todas as entradas com $a, b \leq 10$:

  $a = $ `_______`   $b = $ `_______`   `res = ` `_______`

  *c)* A linha 12 sempre produz `res = 1`? Quando sim, quando não?

 // #campo_resposta(4)