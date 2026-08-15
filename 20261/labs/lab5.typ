// ============================================================
//  Lab 5 — Comandos de Repetição
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 5", author: "Raoni F. S. Teixeira")
#let atividade(num, tipo, tempo, corpo) = {
  block(
    width: 100%,
    inset: 0pt,
    spacing: 1em,
  )[
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

#let bug(corpo) = block(
  fill: rgb("#fdecea"),
  stroke: (left: 3pt + rgb("#c62828")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#c62828"))[Código com bug] \ #corpo]

#let lacuna(corpo) = block(
  fill: rgb("#f0faf0"),
  stroke: (left: 3pt + rgb("#2e7d32")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#2e7d32"))[Complete o código] \ #corpo]

#let desafio(corpo) = block(
  fill: rgb("#fff8e1"),
  stroke: (left: 3pt + rgb("#e6a817")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#e6a817"))[Desafio opcional] \ #corpo]

#let resposta(linhas) = {
  for _ in range(linhas) {
    block(width: 100%, height: 18pt, stroke: (bottom: 0.5pt + rgb("#999")))[]
  }
}

#let caixa_resposta(altura) = block(
  width: 100%, height: altura,
  stroke: 0.5pt + rgb("#999"),
  radius: 2pt,
  inset: 6pt,
)[]

#let mesa_table(colunas, linhas) = {
  let cols = (auto,) * colunas
  let header_cells = range(colunas).map(_ => 
    table.cell(fill: rgb("#e8eaf6"))[#h(24pt)]
  )
  let body_cells = range(linhas * colunas).map(_ =>
    table.cell(height: 22pt)[]
  )
  table(
    columns: cols,
    stroke: 0.5pt + rgb("#999"),
    inset: 6pt,
    ..header_cells,
    ..body_cells,
  )
}

#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 5],
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

// ── Cabeçalho ────────────────────────────────────────────────
#align(center)[
  #text(size: 15pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Laboratório 5 — Comandos de Repetição
  ]
  #v(2pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Duração: 2 horas  |  Trabalho em dupla  |  Entrega: código-fonte (.c) ao final da aula
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

  1. fazer  o teste de mesa de um laço para prever sua saída; 
  2. identificar e corrigir   loop infinito e condição de parada errada; 
  3. implementar padrões de acumulação   e contagem com laços; 
  4. usar laços aninhados para gerar padrões visuais.
  ],
)
 

#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Teste de mesa — Antes de compilar", "25")[
  Para cada trecho abaixo, faça o teste de mesa completo na tabela fornecida
  e escreva a saída prevista. Só compile para verificar *depois* de preencher.

  *Trecho A* — entrada: `n = 4`
  ```c
  int i = 0, s = 0, n;
  scanf("%d", &n);
  while (i < n) {
      s = s + i * i;
      i++;
  }
  printf("%d\n", s);
  ```

  #table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#e8eaf6") } else { white },
    [*`i`*], [*`s`*], [*`i*i`*], [*`i < n`*],
    table.cell()[], [], [], [],
    table.cell()[], [], [], [],
    table.cell()[], [], [], [],
    table.cell()[], [], [], [],
    table.cell()[], [], [], [],
  )
  Saída prevista: `_______`  #h(8pt) Saída real: `_______`

  #v(10pt)
  *Trecho B* — entrada: `n = 5`
  ```c
  int i = 1, p = 1, n;
  scanf("%d", &n);
  while (i <= n) {
      p = p * i;
      i++;
  }
  printf("%d\n", p);
  ```

  #table(
    columns: (auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#e8eaf6") } else { white },
    [*`i`*], [*`p`*], [*`i <= n`*],
    table.cell()[], [], [],
    table.cell()[], [], [],
    table.cell()[], [], [],
    table.cell()[], [], [],
    table.cell()[], [], [],
    table.cell()[], [], [],
  )
  Saída prevista: `_______`  #h(8pt) Saída real: `_______`

  O que o Trecho B calcula? `___________________________________`
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "Caça ao bug — Condição de parada e loop infinito", "25")[
  O programa abaixo deveria ler números inteiros positivos até o usuário
  digitar zero, e então imprimir a média dos valores lidos (excluindo o zero).
  Ele tem dois bugs distintos.

  #bug[
    ```c
    #include <stdio.h>
    int main() {
        int x, soma = 0, cont = 0;

        printf("Digite numeros (0 para parar):\n");

        while (x != 0) {
            scanf("%d", &x);
            soma = soma + x;
            cont++;
        }

        printf("Media: %.2f\n", soma / cont);
        return 0;
    }
    ```
  ]

  *a)* O primeiro bug impede que o programa funcione *antes mesmo de ler qualquer
  valor*. Qual é ele? (Dica: pense nas três perguntas de um laço.)
  #caixa_resposta(36pt)

  *b)* Mesmo corrigindo o primeiro bug, a média calculada ainda está errada.
  Por quê? (Considere o que acontece com `x = 0` no final.)
  #caixa_resposta(36pt)

  *c)* A divisão `soma / cont` tem um terceiro problema silencioso. Qual é e
  quando ele acontece? Como corrigir?
  #caixa_resposta(36pt)

  *d)* Escreva a versão corrigida com os três problemas resolvidos:
  #caixa_resposta(120pt)
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "Implementação — Sequência de Collatz", "30")[
  Dado um inteiro positivo `n`, a sequência de Collatz é gerada pelas regras:
  - Se `n` é par: próximo valor = `n / 2`
  - Se `n` é ímpar: próximo valor = `3 * n + 1`
  - A sequência termina quando `n` chega a 1.

  Exemplo para `n = 6`: 6 → 3 → 10 → 5 → 16 → 8 → 4 → 2 → 1 (8 passos).

  Escreva um programa que:
  + Leia `n` (inteiro positivo maior que 1);
  + Imprima todos os valores da sequência, separados por ` → `;
  + Ao final, imprima o número de passos necessários para chegar a 1.

  *Saída esperada para `n = 6`:*
  ```
  6 -> 3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
  Passos: 8
  ```

  *Antes de implementar*, responda as três perguntas do laço:
  - O que se repete? `_______________________________________________`
  - Até quando? `___________________________________________________`
  - O que muda? `___________________________________________________`

  *Teste obrigatório:* `n = 27` deve produzir 111 passos. Verifique.
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Implementação — Padrões com laços aninhados", "20")[
  Usando laços aninhados, gere os padrões abaixo para `n` lido do teclado.
  Implemente cada padrão em um arquivo `.c` separado.

  *Padrão A* — triângulo de números (n = 4):
  ```
  1
  1 2
  1 2 3
  1 2 3 4
  ```

  *Padrão B* — quadrado com bordas (n = 5):
  ```
  * * * * *
  *       *
  *       *
  *       *
  * * * * *
  ```
  _(Dica: imprima `*` se estiver na primeira/última linha ou primeira/última coluna;
  caso contrário, imprima um espaço.)_

  *Antes de implementar o Padrão B*, responda:
  - Qual é a condição para imprimir `*`? `_____________________________`
  - Qual é a condição para imprimir espaço? `_________________________`
]

#v(6pt)

// ── Desafio ──────────────────────────────────────────────────
#desafio[
  *Adivinhe o número*

  Escreva um programa que "pense" em um número fixo (use `int secreto = 42;`)
  e peça ao usuário para adivinhar, dando dicas a cada tentativa:

  - Se o chute for menor que o número: imprima `"Muito baixo! Tente de novo:"`;
  - Se o chute for maior: imprima `"Muito alto! Tente de novo:"`;
  - Se acertar: imprima `"Parabens! Voce acertou em X tentativas."`.

  O laço deve repetir até o usuário acertar. Conte o número de tentativas.

  *Extensão:* modifique o programa para gerar o número secreto a partir de
  uma operação aritmética com dois valores lidos no início (por exemplo,
  `secreto = (a * b) % 100 + 1`). Isso simula um número "aleatório" sem
  usar a biblioteca `stdlib.h`.
]
