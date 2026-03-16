// ============================================================
//  Introdução a Algoritmos — Aula 3 (revisada)
//  Raoni F. S. Teixeira
// ============================================================

#set document(title: "Aula 3 – Decisões", author: "Raoni F. S. Teixeira")

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
      [Aula 3 — Decisões],
      align(right)[#context counter(page).display("1")])
  ]
)

#set text(font: "Linux Libertine", size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.75em)
#set heading(numbering: "1.")

// ── Macros ───────────────────────────────────────────────────

#let definicao(titulo, corpo) = block(
  fill: rgb("#eaf0fb"), stroke: (left: 3pt + rgb("#1a3a5c")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#1a3a5c"))[Definição — #titulo] \ #corpo]

#let destaque(corpo) = block(
  fill: rgb("#fff8e1"), stroke: (left: 3pt + rgb("#e6a817")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#corpo]

#let exemplo(titulo, corpo) = block(
  fill: rgb("#f0faf0"), stroke: (left: 3pt + rgb("#2e7d32")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#2e7d32"))[Exemplo — #titulo] \ #corpo]

#let atencao(corpo) = block(
  fill: rgb("#fdecea"), stroke: (left: 3pt + rgb("#c62828")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#c62828"))[Atenção] \ #corpo]

// ── Título ───────────────────────────────────────────────────

#align(center)[
  #text(size: 16pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Aula 3 — Decisões: Expressões Relacionais e Comandos Condicionais
  ]
]
#v(0.5em)

// ============================================================
= A peça "decisão": escolher um caminho
// ============================================================

Nas duas primeiras aulas, nossos programas executavam todas as instruções sempre, na
mesma ordem. Mas a maioria dos problemas reais exige que o programa *tome decisões*:
calcular desconto apenas se o valor ultrapassar um limite, exibir mensagem de erro
apenas se a entrada for inválida, seguir um caminho diferente dependendo do valor
lido.

Essa capacidade — executar instruções seletivamente, dependendo de uma condição —
é a peça "decisão" do nosso quebra-cabeça. Em C, ela é implementada pelo comando
`if`.

Para que o `if` funcione, precisamos antes entender como expressar condições. Isso
nos leva ao conceito de *valor booleano* e às *expressões relacionais*.

// ============================================================
= Valores booleanos
// ============================================================

#definicao("Valor Booleano")[
  Um valor booleano representa o resultado de uma afirmação lógica: ele pode ser
  *verdadeiro* ou *falso* — e nada mais. O nome homenageia George Boole (1815–1864),
  matemático britânico que formalizou a álgebra da lógica.
]

Exemplos de afirmações e seus valores booleanos:

- "O céu é azul." → *verdadeiro*
- "2 + 2 = 5." → *falso*
- "O número 7 é par." → *falso*
- "A variável `x` contém um valor maior que zero." → *depende do valor de `x`*

O último exemplo é fundamental: em programação, as condições geralmente envolvem
variáveis cujo valor só é conhecido em tempo de execução. O programa precisa avaliá-
las *enquanto roda*, e não no momento em que foi escrito.

== Booleanos em C

C não tem um tipo booleano nativo (ele foi adicionado apenas no padrão C99, com
`<stdbool.h>`). Por convenção histórica, C usa inteiros:

- *0* representa falso;
- *qualquer valor diferente de zero* representa verdadeiro.

Isso significa que a expressão `if (5)` é equivalente a `if (verdadeiro)`, e o bloco
sempre será executado. Esse comportamento é usado em alguns idiomas avançados de C,
mas deve ser evitado por iniciantes.

// ============================================================
= Expressões relacionais
// ============================================================

Uma expressão relacional *compara* dois valores e produz um resultado booleano
(0 ou 1 em C). Os operadores relacionais de C são:

#table(
  columns: (auto, auto, 1fr),
  stroke: 0.5pt + rgb("#aaa"),
  inset: 8pt,
  fill: (col, row) => if row == 0 { rgb("#1a3a5c") } else if calc.odd(row) { rgb("#eaf0fb") } else { white },
  [#text(fill: white, weight: "bold")[Operador]],
  [#text(fill: white, weight: "bold")[Significado]],
  [#text(fill: white, weight: "bold")[Verdadeiro quando…]],
  [`==`], [Igualdade],         [`a` e `b` têm o mesmo valor],
  [`!=`], [Diferença],         [`a` e `b` têm valores distintos],
  [`>`],  [Maior que],         [`a` é estritamente maior que `b`],
  [`<`],  [Menor que],         [`a` é estritamente menor que `b`],
  [`>=`], [Maior ou igual],    [`a` é maior que ou igual a `b`],
  [`<=`], [Menor ou igual],    [`a` é menor que ou igual a `b`],
)

#atencao[
  *A confusão mais comum em C:* `=` é atribuição; `==` é comparação. Escrever
  `if (x = 5)` em vez de `if (x == 5)` *não gera erro de compilação* — o compilador
  interpreta como "atribua 5 a x e teste se o resultado é verdadeiro" (que sempre
  será, pois 5 ≠ 0). O programa compila e roda, mas se comporta de forma errada.
  Muitos compiladores emitem um *aviso* para isso — sempre leia os avisos.
]

// ============================================================
= O comando if
// ============================================================

O comando `if` executa um bloco de instruções *somente se* uma condição for
verdadeira.

```c
if (condicao) {
    /* executado apenas se condicao for verdadeira */
    instrucao1;
    instrucao2;
}
```

Se o bloco contiver apenas uma instrução, as chaves são tecnicamente opcionais.
No entanto, omiti-las é uma fonte frequente de bugs — a prática recomendada é
*sempre usar chaves*.

#exemplo("Verificar se um número é ímpar")[
  ```c
  int n;
  scanf("%d", &n);
  if (n % 2 != 0) {
      printf("O número é ímpar.\n");
  }
  ```
  O operador `%` calcula o resto da divisão. Se o resto da divisão por 2 for
  diferente de zero, o número é ímpar.
]

// ============================================================
= O comando if/else
// ============================================================

Muitas vezes queremos executar ações *diferentes* dependendo da condição — não apenas
agir quando ela é verdadeira, mas também quando é falsa. Para isso, usamos `if/else`:

```c
if (condicao) {
    /* executado se verdadeiro */
} else {
    /* executado se falso */
}
```

Exatamente um dos dois blocos será executado — nunca ambos, nunca nenhum.

#exemplo("Classificar número como positivo ou não-positivo")[
  ```c
  int n;
  scanf("%d", &n);
  if (n > 0) {
      printf("Número positivo.\n");
  } else {
      printf("Número negativo ou zero.\n");
  }
  ```
]

== O perigo do else sem chaves: o dangling else

Considere o código abaixo — aparentemente correto, mas com um bug sutil:

```c
if (cond1)
    if (cond2)
        printf("A\n");
else
    printf("B\n");   /* a qual if esse else pertence? */
```

Pela indentação, parece que o `else` pertence ao `if (cond1)`. Mas em C, o `else`
*sempre se associa ao if mais próximo que ainda não tem um else*. Portanto, o código
acima é equivalente a:

```c
if (cond1) {
    if (cond2)
        printf("A\n");
    else
        printf("B\n");   /* pertence ao if(cond2), não ao if(cond1) */
}
```

Esse problema — chamado de *dangling else* — é uma das armadilhas mais antigas de C.
A solução é sempre usar chaves:

```c
if (cond1) {
    if (cond2) {
        printf("A\n");
    }
} else {
    printf("B\n");   /* agora inequivocamente do if(cond1) */
}
```

#destaque[
  *Regra prática:* use chaves em todos os blocos de `if` e `else`, mesmo quando
  há apenas uma instrução. O custo é zero; o benefício é eliminar uma classe inteira
  de bugs.
]

// ============================================================
= Estrutura if-else-if
// ============================================================

Quando há três ou mais casos mutuamente exclusivos, encadeamos `if-else-if`:

```c
if (condicao1) {
    /* caso 1 */
} else if (condicao2) {
    /* caso 2 */
} else if (condicao3) {
    /* caso 3 */
} else {
    /* nenhum dos casos anteriores */
}
```

A avaliação ocorre de cima para baixo: assim que uma condição for verdadeira, seu
bloco é executado e os demais são ignorados. O bloco `else` final (sem condição)
serve como caso padrão — ele captura qualquer situação não tratada pelas condições
anteriores.

#exemplo("Classificação de notas")[
  ```c
  float nota;
  scanf("%f", &nota);

  if (nota >= 9.0) {
      printf("Conceito A\n");
  } else if (nota >= 7.0) {
      printf("Conceito B\n");
  } else if (nota >= 5.0) {
      printf("Conceito C\n");
  } else {
      printf("Reprovado\n");
  }
  ```
  Observe que as condições são ordenadas da maior para a menor. Se estivessem na
  ordem inversa (começando por `nota >= 5.0`), uma nota 9.5 seria classificada como
  conceito C — o primeiro `if` que a capturasse, incorretamente.

  *A ordem das condições no if-else-if importa.*
]

== Comparação: ifs independentes vs. if-else-if

Há uma diferença importante entre uma sequência de `if`s independentes e uma cadeia
`if-else-if`:

```c
/* Versão A: ifs independentes — todos os testes são avaliados */
if (x > 0) printf("positivo\n");
if (x > 10) printf("maior que 10\n");
if (x > 100) printf("maior que 100\n");

/* Versão B: if-else-if — para no primeiro verdadeiro */
if (x > 100) {
    printf("maior que 100\n");
} else if (x > 10) {
    printf("entre 11 e 100\n");
} else if (x > 0) {
    printf("entre 1 e 10\n");
}
```

Use ifs independentes quando as condições *não são mutuamente exclusivas* (um valor
pode satisfazer mais de uma). Use `if-else-if` quando os casos são *mutuamente
exclusivos* — só um deles deve ser tratado.

// ============================================================
= Exercícios
// ============================================================

+ Escreva um programa que leia um inteiro e imprima:
  - "SIM" se ele for par e maior que 10, *ou* se for ímpar e menor que 50;
  - "NAO" em qualquer outro caso.
  _(Dica: tente primeiro com ifs aninhados; depois simplifique usando operadores
  lógicos — que veremos em detalhe na próxima aula.)_

+ Escreva um programa que leia três números inteiros e os imprima em ordem crescente.
  _(Sem usar laços — apenas ifs e variáveis auxiliares.)_

+ Analise o código abaixo. Para quais valores de `n` ele produz um resultado
  incorreto? Corrija-o.
  ```c
  int n;
  scanf("%d", &n);
  if (n > 0)
      printf("positivo\n");
  if (n == 0)
      printf("zero\n");
  else
      printf("negativo\n");
  ```
