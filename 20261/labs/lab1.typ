// ============================================================
//  Lab 1 — Primeiro Programa em C
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 1", author: "Raoni F. S. Teixeira")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 1],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Primeiro Programa em C],
      align(right)[#context counter(page).display("1")])
  ]
)

#set text(font: "Linux Libertine", size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.75em)
#set heading(numbering: "1.")

// ── Macros ───────────────────────────────────────────────────

#let atividade(num, tipo, tempo, corpo) = {
  block(width: 100%, inset: 0pt, spacing: 1em)[
    #block(
      fill: rgb("#1a3a5c"),
      inset: (x: 10pt, y: 6pt),
      radius: (top: 3pt),
      width: 100%,
    )[
      #grid(columns: (1fr, auto),
        text(fill: white, weight: "bold")[Atividade #num — #tipo],
        text(fill: rgb("#aaccee"), size: 9pt)[#tempo min],
      )
    ]
    #block(
      stroke: (left: 3pt + rgb("#1a3a5c"), right: 0.5pt + rgb("#ccc"),
               bottom: 0.5pt + rgb("#ccc")),
      inset: (left: 12pt, top: 10pt, bottom: 10pt, right: 10pt),
      radius: (bottom: 3pt),
      width: 100%,
    )[#corpo]
  ]
}

#let bug(titulo, corpo) = block(
  fill: rgb("#fdecea"), stroke: (left: 3pt + rgb("#c62828")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#c62828"))[Bug — #titulo] \ #corpo]

#let destaque(corpo) = block(
  fill: rgb("#fff8e1"), stroke: (left: 3pt + rgb("#e6a817")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#corpo]

#let desafio(corpo) = block(
  fill: rgb("#fff8e1"), stroke: (left: 3pt + rgb("#e6a817")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#e6a817"))[Desafio opcional] \ #corpo]

#let caixa_resposta(altura) = block(
  width: 100%, height: altura,
  stroke: 0.5pt + rgb("#999"),
  radius: 2pt, inset: 6pt,
)[]

// ── Título ───────────────────────────────────────────────────

#align(center)[
  #text(size: 15pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Laboratório 1 — Primeiro Programa em C
  ]
  #v(2pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Duração: 2 horas  |  Trabalho individual  |  Entrega: arquivos .c ao final da aula
  ]
]

#v(8pt)

#let caixa(titulo, cor-borda, cor-fundo, corpo) = block(
  width: 100%,
  fill: cor-fundo,
  stroke: (left: 3pt + cor-borda),
  inset: (left: 10pt, right: 10pt, top: 8pt, bottom: 8pt),
  radius: (right: 3pt),
)[
  #text(weight: "bold", fill: cor-borda)[#titulo] \
  #corpo
]
#let cinza    = luma(245)
#caixa(
  "Objetivos deste laboratório",
  rgb("#555555"),
  cinza,
  [
    Ao final deste laboratório, a dupla deve ser capaz de:

  1. escrever, compilar e executar um programa C simples no ambiente escolhido; 
  2. identificar e corrigir erros de compilação lendo as  mensagens do compilador; 
  3. descrever o que cada parte de um programa   mínimo em C faz; 
  4. distinguir os três tipos de erro — sintaxe,   execução e lógica — a partir de exemplos concretos.
  ],
) 


#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Anatomia do programa mínimo", "20")[
  O programa abaixo é o menor programa C válido que produz saída.
  Leia-o com atenção antes de digitá-lo.

  ```c
  #include <stdio.h>

  int main() {
      printf("Ola, mundo!\n");
      return 0;
  }
  ```

  *a)* Salve o programa como `ola.c`, compile e execute. Registre o
  comando exato que você usou e a saída obtida:

  #caixa_resposta(36pt)

  *b)* Preencha a tabela relacionando cada elemento do programa ao seu papel:

  #table(
    columns: (auto, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 8pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Elemento*],          [*Papel no programa*],
    [`#include <stdio.h>`],  [],
    [`int main()`],          [],
    [`{ }`],                 [],
    [`printf(...)`],         [],
    [`"\n"`],                [],
    [`return 0`],            [],
  )

  *c)* O que acontece se você remover o `#include <stdio.h>`? Remova,
  compile e anote a mensagem do compilador. Em seguida, restaure.
  #caixa_resposta(32pt)

  *d)* O que acontece se você remover o `return 0`? O programa ainda
  compila? Executa corretamente? O comportamento muda?
  #caixa_resposta(28pt)
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "Os três tipos de erro", "30")[
  Nesta atividade você vai encontrar e corrigir exemplos dos três tipos
  de erro estudados na Aula 1: *sintaxe*, *execução* e *lógica*.

  // Bug 1 — sintaxe
  #bug("Erro de sintaxe")[
    O programa abaixo não compila. Leia as mensagens do compilador,
    identifique *todos* os erros e corrija-os.

    ```c
    #include <stdio.h>

    int main() {
        printf("Valor: %d\n" 42)
        printf("Fim\n");
        return 0
    }
    ```

    Quantos erros o compilador reportou? `_______`

    Liste cada erro, a linha indicada e o que estava errado:
    #caixa_resposta(56pt)

    #destaque[
      *Observação:* um único erro de sintaxe pode fazer o compilador
      reportar vários erros em cascata. Corrija o primeiro, recompile
      e veja se os demais desaparecem antes de tentar corrigi-los
      individualmente.
    ]
  ]

  #v(8pt)

  // Bug 2 — execução
  #bug("Erro de execução")[
    O programa abaixo compila sem erros, mas falha ao executar para
    certas entradas. Descubra qual entrada causa a falha.

    ```c
    #include <stdio.h>

    int main() {
        int a, b;
        printf("Digite dois inteiros: ");
        scanf("%d %d", &a, &b);
        printf("Divisao: %d\n", a / b);
        return 0;
    }
    ```

    *a)* Teste com `a = 10, b = 2`. Resultado: `_______`

    *b)* Teste com `a = 10, b = 0`. O que acontece?
    #caixa_resposta(28pt)

    *c)* Corrija o programa para que ele imprima uma mensagem de erro
    adequada quando `b` for zero, em vez de travar. Escreva o código
    corrigido:
    #caixa_resposta(70pt)
  ]

  #v(8pt)

  // Bug 3 — lógica
  #bug("Erro de lógica")[
    O programa abaixo compila e executa sem problemas, mas produz
    resultados incorretos. Encontre o erro.

    ```c
    #include <stdio.h>

    int main() {
        int celsius;
        float fahrenheit;
        printf("Temperatura em Celsius: ");
        scanf("%d", &celsius);
        fahrenheit = celsius * 9 / 5 + 32;
        printf("%.1f Fahrenheit\n", fahrenheit);
        return 0;
    }
    ```

    *a)* Teste com `celsius = 100`. Resultado esperado: `212.0`.
    Resultado obtido: `_______`. O resultado esta correto?

    *b)* Teste com `celsius = 37`. Resultado esperado: `98.6`.
    Resultado obtido: `_______`. O resultado esta correto?

    *c)* Identifique o erro. _(Dica: releia a Aula 2 sobre divisão
    inteira.)_
    #caixa_resposta(36pt)

    *d)* Corrija o programa e verifique com os dois casos de teste acima.
  ]
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "Algoritmo antes do código", "30")[
  Antes de escrever qualquer programa desta atividade, escreva o
  algoritmo em português estruturado — uma lista de passos numerados
  descrevendo o que o programa deve fazer. Só então implemente em C.

  *Problema A — Área e perímetro de um retângulo*

  Escreva um programa que leia a base e a altura de um retângulo
  e imprima a área e o perímetro com duas casas decimais.

  Algoritmo em português:
  #caixa_resposta(64pt)

  Implemente, compile e teste com: base = 5, altura = 3.
  Resultados esperados: área = 15.00, perímetro = 16.00.

  #v(8pt)

  *Problema B — Troco*

  Escreva um programa que leia o preço de um produto (em reais, como
  número real) e o valor entregue pelo cliente, e calcule o troco.
  Se o valor entregue for menor que o preço, imprima uma mensagem de
  erro. _(Ainda sem usar `if` — apenas calcule e imprima o troco.
  O tratamento de erro será tema do Lab 3.)_

  Algoritmo em português:
  #caixa_resposta(56pt)

  Implemente e teste com: preço = 7.50, valor entregue = 10.00.
  Resultado esperado: troco = 2.50.
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Leitura e interpretação de código alheio", "20")[
  Leia o programa abaixo *sem executá-lo* e responda as perguntas.

  ```c
  #include <stdio.h>

  int main() {
      int n;
      scanf("%d", &n);
      printf("%d %d %d\n", n, n * n, n * n * n);
      return 0;
  }
  ```

  *a)* O que este programa calcula e imprime? Descreva em uma frase.
  #caixa_resposta(24pt)

  *b)* Para qual entrada o programa imprime `5 25 125`?
  `_______`

  *c)* Para `n = 10`, o que será impresso?
  `_______`

  *d)* Para `n = 100`, o terceiro valor impresso é `1000000`.
  Existe algum valor de `n` para o qual o terceiro valor seria
  incorreto? _(Dica: qual é o valor máximo de um `int`?)_
  #caixa_resposta(32pt)

  *e)* Compile e execute para verificar suas respostas. Havia alguma
  discrepância? Se sim, explique o motivo.
  #caixa_resposta(28pt)
]

#v(6pt)

// ── Desafio ──────────────────────────────────────────────────
#desafio[
  *Calculadora de IMC*

  Escreva um programa que leia o peso (kg) e a altura (m) de uma pessoa
  e calcule o IMC (peso dividido pelo quadrado da altura). Exiba o
  resultado com duas casas decimais e uma faixa de classificação
  baseada apenas em comparações com constantes — sem usar `if`
  por enquanto, apenas calcule e exiba o valor.

  Depois, responda: qual seria o problema em usar `int` em vez de
  `float` ou `double` para guardar o IMC? Escreva a resposta como
  comentário no código.
]
