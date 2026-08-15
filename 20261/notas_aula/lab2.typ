// ============================================================
//  Lab 2 — Variáveis, Tipos e Operações Aritméticas
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 2", author: "Raoni F. S. Teixeira")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 2],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Variáveis, Tipos e Operações],
      align(right)[#context counter(page).display("1")])
  ]
)
#set text(font: "Linux Libertine", size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.75em)

#include "lab_preamble.typ"

// ── Cabeçalho ────────────────────────────────────────────────
#align(center)[
  #text(size: 15pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Laboratório 2 — Variáveis, Tipos e Operações Aritméticas
  ]
  #v(2pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Duração: 2 horas  |  Trabalho em dupla  |  Entrega: código-fonte (.c) ao final da aula
  ]
]

#v(8pt)
#block(
  fill: rgb("#eaf0fb"), stroke: 0.5pt + rgb("#1a3a5c"),
  inset: 10pt, radius: 3pt, width: 100%,
)[
  *Objetivos:* ao final deste laboratório, a dupla deve ser capaz de: (1) declarar
  variáveis com tipos adequados ao problema; (2) identificar e corrigir erros de
  divisão inteira e overflow; (3) usar casting explícito quando necessário;
  (4) formatar saída com `printf` e ler entrada com `scanf`.
]

#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Aquecimento — Complete o código", "20")[
  O programa abaixo lê a base e a altura de um triângulo retângulo e deveria
  calcular a hipotenusa e a área. Complete os trechos marcados com `/* ? */`.

  #lacuna[
    ```c
    #include <stdio.h>
    #include <math.h>

    int main() {
        /* ? */ base, altura;       /* declare com o tipo correto */
        /* ? */ hipotenusa, area;   /* declare com o tipo correto */

        printf("Base: ");
        scanf(/* ? */, &base);

        printf("Altura: ");
        scanf(/* ? */, &altura);

        hipotenusa = sqrt(/* ? */);          /* Teorema de Pitagoras */
        area       = /* ? */;                /* area do triangulo    */

        printf("Hipotenusa: %.4f\n", hipotenusa);
        printf("Area:       %.4f\n", area);
        return 0;
    }
    ```
  ]

  *Compile com:* `gcc triangulo.c -o triangulo -lm`

  *Teste com:* base = 3, altura = 4. Resultados esperados: hipotenusa = 5.0000,
  área = 6.0000.
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "Caça ao bug — Divisão inteira", "25")[
  O programa abaixo calcula a média de três notas, mas produz resultados
  incorretos para muitas entradas. Leia com atenção, identifique o problema
  e corrija-o.

  #bug[
    ```c
    #include <stdio.h>

    int main() {
        int n1, n2, n3;
        float media;

        printf("Nota 1: "); scanf("%d", &n1);
        printf("Nota 2: "); scanf("%d", &n2);
        printf("Nota 3: "); scanf("%d", &n3);

        media = n1 + n2 + n3 / 3;

        printf("Media: %.2f\n", media);
        return 0;
    }
    ```
  ]

  *a)* Teste com as notas 6, 8 e 10. O programa imprime `_________`.
  O resultado correto seria `_________`.

  *b)* Em uma frase, explique por que o programa está errado:

  #caixa_resposta(40pt)

  *c)* Existem dois bugs neste código (um de precedência e um de tipo).
  Corrija ambos e mostre o código corrigido abaixo:

  #caixa_resposta(90pt)

  *d)* Teste o programa corrigido com as notas 7, 0 e 3. Resultado esperado: `3.33`.
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "Implementação — Conversor de unidades", "35")[
  Escreva um programa que leia uma distância em quilômetros e a converta para
  três outras unidades, exibindo os resultados formatados conforme o exemplo.

  *Conversões:*
  - 1 km = 1000 metros
  - 1 km = 100 000 centímetros
  - 1 km = 0.621371 milhas

  *Saída esperada para entrada `2.5`:*
  ```
  2.500 km equivale a:
    2500.000 metros
    250000.000 centimetros
    1.553 milhas
  ```

  *Requisitos:*
  + Use `double` para todas as variáveis (justifique no comentário do programa
    por que `float` poderia ser insuficiente para grandes distâncias).
  + Formate a saída exatamente como no exemplo: 3 casas decimais, alinhamento
    com espaços.
  + Documente o programa com cabeçalho (descrição, entrada, saída, autores).
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Implementação — Conversor de tempo", "25")[
  Escreva um programa que leia um número inteiro de segundos e o decomponha em
  horas, minutos e segundos restantes.

  *Exemplos:*
  #table(
    columns: (auto, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Entrada*], [*Saída esperada*],
    [`3661`],  [`1h 1min 1s`],
    [`7322`],  [`2h 2min 2s`],
    [`59`],    [`0h 0min 59s`],
    [`3600`],  [`1h 0min 0s`],
  )

  *Dica:* use os operadores `/` e `%` sobre inteiros. Não é necessário nenhum
  `if` — apenas três atribuições e um `printf`.

  *Pergunta para reflexão:* qual é o maior número de segundos que seu programa
  suporta corretamente? Por quê? Escreva a resposta como comentário no código.
]

#v(6pt)

// ── Desafio ──────────────────────────────────────────────────
#desafio[
  *Calculadora de IMC com categorias de precisão*

  Escreva um programa que leia peso (kg) e altura (m) como `double` e calcule
  o IMC. Em seguida, calcule também o peso ideal para a altura fornecida,
  definido como o valor de peso que resultaria em IMC = 22.0 (centro da faixa
  normal).

  Exiba:
  - O IMC calculado com 2 casas decimais;
  - A diferença entre o peso atual e o peso ideal (pode ser negativa);
  - Uma mensagem indicando se o usuário está abaixo, dentro ou acima do peso
    ideal (use os limites: abaixo de 18.5, normal entre 18.5 e 24.9,
    sobrepeso acima de 25.0).

  *Atenção:* não use `if` nesta atividade — isso será tema do Lab 3.
  Verifique apenas se os cálculos estão corretos.
]
