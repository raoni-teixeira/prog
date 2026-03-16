// ============================================================
//  Introdução a Algoritmos — Aula 4 (revisada)
//  Raoni F. S. Teixeira
// ============================================================

#set document(title: "Aula 4 – Lógica, switch e Legibilidade", author: "Raoni F. S. Teixeira")

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
      [Aula 4 — Lógica, switch e Legibilidade],
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
    Aula 4 — Expressões Lógicas, switch e Legibilidade
  ]
]
#v(0.5em)

// ============================================================
= Combinando condições: operadores lógicos
// ============================================================

Na aula anterior, cada condição testava *uma única relação* — por exemplo,
`x > 0` ou `n == 42`. Muitos problemas reais exigem condições mais complexas:
"o usuário é maior de idade *e* tem carteira de motorista" ou "o produto está
em promoção *ou* o cliente tem cupom de desconto".

Para expressar essas condições compostas, C oferece os *operadores lógicos*.

#definicao("Expressão Lógica")[
  Uma expressão lógica combina duas ou mais expressões booleanas por meio de
  operadores lógicos (E, OU, NÃO) e produz um resultado booleano (verdadeiro ou
  falso).
]

Os três operadores lógicos de C são:

#table(
  columns: (auto, auto, 1fr),
  stroke: 0.5pt + rgb("#aaa"),
  inset: 8pt,
  fill: (col, row) => if row == 0 { rgb("#1a3a5c") } else if calc.odd(row) { rgb("#eaf0fb") } else { white },
  [#text(fill: white, weight: "bold")[Operador]],
  [#text(fill: white, weight: "bold")[Nome]],
  [#text(fill: white, weight: "bold")[Resultado]],
  [`&&`], [E lógico (AND)],   [Verdadeiro somente se *ambas* as expressões forem verdadeiras],
  [`||`], [OU lógico (OR)],   [Verdadeiro se *pelo menos uma* das expressões for verdadeira],
  [`!`],  [NÃO lógico (NOT)], [Inverte o valor: transforma verdadeiro em falso e vice-versa],
)

== Tabelas-verdade

As tabelas-verdade mostram o resultado de cada operador para todas as combinações
de entrada:

#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 12pt,
  // Tabela AND
  [
    #table(
      columns: (auto, auto, auto),
      stroke: 0.5pt + rgb("#aaa"),
      inset: 7pt,
      fill: (col, row) => if row == 0 { rgb("#1a3a5c") } else if calc.odd(row) { rgb("#eaf0fb") } else { white },
      [#text(fill: white)[`A`]], [#text(fill: white)[`B`]], [#text(fill: white)[`A && B`]],
      [V], [V], [*V*],
      [V], [F], [F],
      [F], [V], [F],
      [F], [F], [F],
    )
    #align(center)[_Operador AND_]
  ],
  // Tabela OR
  [
    #table(
      columns: (auto, auto, auto),
      stroke: 0.5pt + rgb("#aaa"),
      inset: 7pt,
      fill: (col, row) => if row == 0 { rgb("#1a3a5c") } else if calc.odd(row) { rgb("#eaf0fb") } else { white },
      [#text(fill: white)[`A`]], [#text(fill: white)[`B`]], [#text(fill: white)[`A \|\| B`]],
      [V], [V], [*V*],
      [V], [F], [*V*],
      [F], [V], [*V*],
      [F], [F], [F],
    )
    #align(center)[_Operador OR_]
  ],
  // Tabela NOT
  [
    #table(
      columns: (auto, auto),
      stroke: 0.5pt + rgb("#aaa"),
      inset: 7pt,
      fill: (col, row) => if row == 0 { rgb("#1a3a5c") } else if calc.odd(row) { rgb("#eaf0fb") } else { white },
      [#text(fill: white)[`A`]], [#text(fill: white)[`!A`]],
      [V], [F],
      [F], [*V*],
    )
    #align(center)[_Operador NOT_]
  ],
)

== Exemplos práticos

```c
int idade = 20, tem_habilitacao = 1;

/* Pode dirigir? Precisa ter 18+ E habilitação */
if (idade >= 18 && tem_habilitacao) {
    printf("Pode dirigir.\n");
}

/* Tem desconto? Sócio OU compra acima de R$200 */
float total = 150.0;
int eh_socio = 0;
if (eh_socio || total > 200.0) {
    printf("Desconto aplicado.\n");
}

/* Número fora do intervalo [0, 100] */
int n = 110;
if (n < 0 || n > 100) {
    printf("Valor inválido.\n");
}
```

== Avaliação em curto-circuito

C avalia expressões lógicas da esquerda para a direita e *para assim que o
resultado for determinado*:

- Em `A && B`: se `A` for falso, `B` *não é avaliado* — o resultado já é falso.
- Em `A || B`: se `A` for verdadeiro, `B` *não é avaliado* — o resultado já é verdadeiro.

Esse comportamento — chamado de *avaliação em curto-circuito* — é importante quando
a segunda expressão tem efeitos colaterais ou pode causar erro:

```c
/* Seguro: só divide se denominador != 0 */
if (b != 0 && a / b > 2) {
    printf("Quociente maior que 2.\n");
}
```

Se `b` for zero, a condição `b != 0` é falsa e a divisão `a / b` *nunca é
executada*, evitando uma divisão por zero.

== Simplificações úteis

As negações de expressões relacionais têm formas equivalentes mais simples:

#table(
  columns: (auto, auto),
  stroke: 0.5pt + rgb("#aaa"),
  inset: 8pt,
  fill: (col, row) => if row == 0 { rgb("#1a3a5c") } else if calc.odd(row) { rgb("#eaf0fb") } else { white },
  [#text(fill: white, weight: "bold")[Expressão original]],
  [#text(fill: white, weight: "bold")[Forma equivalente]],
  [`!(a == b)`],  [`a != b`],
  [`!(a != b)`],  [`a == b`],
  [`!(a > b)`],   [`a <= b`],
  [`!(a < b)`],   [`a >= b`],
  [`!(a >= b)`],  [`a < b`],
  [`!(a <= b)`],  [`a > b`],
)

== Simplificando ifs aninhados

Operadores lógicos permitem substituir ifs aninhados por uma única condição,
tornando o código mais claro:

```c
/* Versão com ifs aninhados — difícil de ler */
if (cond1) {
    if (cond2) {
        if (!cond3) {
            instrucao;
        }
    }
}

/* Versão equivalente com operadores lógicos — clara */
if (cond1 && cond2 && !cond3) {
    instrucao;
}
```

// ============================================================
= O comando switch: decisões sobre um único valor
// ============================================================

A estrutura `if-else-if` é versátil, mas quando todos os casos testam o *mesmo
valor* contra constantes diferentes, ela pode ser substituída pelo comando `switch`,
que é mais legível e, em alguns compiladores, mais eficiente.

```c
switch (expressao) {
    case valor1:
        instrucoes;
        break;
    case valor2:
        instrucoes;
        break;
    default:
        instrucoes;  /* executado se nenhum case corresponder */
}
```

#exemplo("Menu de opções")[
  ```c
  int opcao;
  printf("1-Novo  2-Abrir  3-Salvar  0-Sair\n");
  scanf("%d", &opcao);

  switch (opcao) {
      case 1:
          printf("Criando novo arquivo...\n");
          break;
      case 2:
          printf("Abrindo arquivo...\n");
          break;
      case 3:
          printf("Salvando arquivo...\n");
          break;
      case 0:
          printf("Saindo...\n");
          break;
      default:
          printf("Opção inválida.\n");
  }
  ```
]

== O papel do break — e o que acontece sem ele

O comando `break` encerra a execução do `switch` e pula para a instrução seguinte.
Sem ele, a execução *cai* para o próximo `case` — comportamento chamado de
*fall-through*.

```c
switch (x) {
    case 1:
        printf("um\n");
        /* sem break — execução continua! */
    case 2:
        printf("dois\n");
        break;
    case 3:
        printf("três\n");
        break;
}
/* Para x == 1, imprime "um" E "dois" */
```

O fall-through é raramente intencional em programas iniciantes e quase sempre
representa um bug. Sempre inclua `break` ao final de cada `case`, a menos que
você tenha uma razão explícita para não fazê-lo (e, nesse caso, documente com
um comentário).

#atencao[
  O `switch` só aceita valores inteiros (incluindo `char`). Não é possível usar
  `switch` com `float`, `double` ou strings — para esses casos, use `if-else-if`.
]

== Quando usar switch vs. if-else-if

#table(
  columns: (1fr, 1fr),
  stroke: 0.5pt + rgb("#aaa"),
  inset: 8pt,
  fill: (col, row) => if row == 0 { rgb("#1a3a5c") } else if calc.even(row) { rgb("#eaf0fb") } else { white },
  [#text(fill: white, weight: "bold")[Use `switch` quando…]],
  [#text(fill: white, weight: "bold")[Use `if-else-if` quando…]],
  [Todos os casos testam *o mesmo valor inteiro* contra constantes],
  [As condições envolvem *intervalos* ou *expressões* diferentes],
  [O número de casos é grande e bem definido (menus, estados, códigos)],
  [As condições envolvem `float`, `double` ou strings],
  [Você quer aproveitar o fall-through intencionalmente],
  [As condições são complexas ou combinadas com `&&` e `||`],
)

// ============================================================
= Legibilidade de código
// ============================================================

Até aqui falamos sobre *o que* o código faz. Nesta seção, discutimos *como* ele
deve ser escrito para que outros — e você mesmo, no futuro — possam entendê-lo
facilmente.

#definicao("Legibilidade")[
  Legibilidade é a qualidade de um código que permite seu entendimento rápido e
  preciso por qualquer programador familiarizado com a linguagem, sem necessidade
  de explicações adicionais.
]

Um código é escrito uma vez, mas lido e mantido muitas vezes. Em projetos reais,
mais de 70% do tempo de desenvolvimento é gasto em *manutenção* — corrigindo bugs,
adicionando funcionalidades, adaptando o código a novos requisitos. Código ilegível
torna esse trabalho exponencialmente mais difícil.

== Os quatro pilares da legibilidade

=== 1. Nomes descritivos

Nomes de variáveis e funções devem comunicar sua finalidade sem exigir comentário
adicional.

```c
/* Ruim: o leitor não sabe o que n1, n2 e r representam */
float n1, n2, r;
scanf("%f %f", &n1, &n2);
r = (n1 * 2 + n2 * 3) / 5;

/* Bom: o código se auto-documenta */
float nota_prova, nota_trabalho, media_final;
scanf("%f %f", &nota_prova, &nota_trabalho);
media_final = (nota_prova * 2 + nota_trabalho * 3) / 5;
```

=== 2. Indentação consistente

A indentação revela visualmente a estrutura lógica do programa — quais instruções
estão dentro de quais blocos.

```c
/* Ruim: sem indentação, estrutura oculta */
if(n==1){printf("Unidade");}else if(n>=0){if(n%3)
printf("Deixa resto");else printf("Não deixa");}else{printf("Negativo");}

/* Bom: estrutura clara à primeira vista */
if (n == 1) {
    printf("Unidade\n");
} else if (n >= 0) {
    if (n % 3) {
        printf("Deixa resto\n");
    } else {
        printf("Não deixa\n");
    }
} else {
    printf("Negativo\n");
}
```

=== 3. Comentários que acrescentam, não que repetem

Um comentário ruim repete o que o código já diz. Um comentário bom explica o *porquê*
de uma decisão que não é óbvia.

```c
/* Ruim: o comentário não acrescenta nada */
x = x + 1;  /* soma 1 a x */

/* Bom: explica a razão da operação */
total_lidos++;  /* conta a leitura mesmo que o valor seja inválido */

/* Bom: documenta uma fórmula não-óbvia */
/* Cálculo do índice de massa corporal: peso(kg) / altura(m)^2 */
imc = peso / (altura * altura);
```

=== 4. Documentação do programa

Todo programa deve ter um cabeçalho que responde três perguntas: o que faz, quem
escreveu e quando. Para funções não-triviais, adicionamos também as entradas,
saídas e pré-condições.

```c
/*
 * Descrição: Lê o raio de uma esfera e imprime seu volume.
 * Entrada:   raio (float, em metros)
 * Saída:     volume (em metros cúbicos), com 4 casas decimais
 * Pré-cond.: raio > 0
 * Autor:     Fulano de Tal
 * Data:      março de 2025
 */
```

== Exemplo completo: antes e depois

*Antes — código funcional, mas ilegível:*

```c
#include<stdio.h>
#include<math.h>
int main(){float x,y,z;scanf("%f",&x);scanf("%f",&y);
z=x*x+y*y;z=sqrt(z);printf("%f\n",z);}
```

*Depois — mesmo comportamento, totalmente legível:*

```c
#include <stdio.h>
#include <math.h>

/*
 * Descrição: Calcula a hipotenusa de um triângulo retângulo.
 * Entrada:   comprimentos dos dois catetos (reais positivos)
 * Saída:     comprimento da hipotenusa
 * Pré-cond.: catetos > 0
 */
int main() {
    float cateto_a, cateto_b, hipotenusa;

    /* Leitura dos catetos */
    printf("Cateto a: ");
    scanf("%f", &cateto_a);
    printf("Cateto b: ");
    scanf("%f", &cateto_b);

    /* Teorema de Pitágoras: h² = a² + b² */
    hipotenusa = sqrt(cateto_a * cateto_a + cateto_b * cateto_b);

    printf("Hipotenusa: %f\n", hipotenusa);
    return 0;
}
```

#destaque[
  Legibilidade não é um luxo para quando o código "já estiver funcionando" — é
  uma disciplina que se pratica desde a primeira linha. Código legível é mais
  fácil de depurar, de corrigir e de expandir. Adote os quatro pilares desde
  hoje.
]

// ============================================================
= Exercícios
// ============================================================

+ Reescreva os programas do exercício 1 da aula anterior usando operadores lógicos
  para simplificar os ifs aninhados.

+ Escreva um programa com `switch` que leia um número de 1 a 7 e imprima o nome
  do dia da semana correspondente (1 = segunda, …, 7 = domingo). Para valores fora
  do intervalo, exiba "Dia inválido".

+ Escreva um programa que leia duas datas (dia, mês, ano) e determine qual ocorreu
  primeiro. Cuide da legibilidade: use nomes descritivos e comente as comparações
  não-óbvias.

+ Avalie o código abaixo segundo os quatro pilares de legibilidade e reescreva-o:
  ```c
  int main(){int a,b,c,d;scanf("%d%d%d%d",&a,&b,&c,&d);
  if(a>1900&&a<2100)if(b>=1&&b<=12)if(c>=1&&c<=31)
  printf("ok");else printf("nd");else printf("nm");else printf("na");}
  ```
