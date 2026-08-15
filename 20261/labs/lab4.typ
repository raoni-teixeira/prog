// ============================================================
//  Lab 4 — Expressões Lógicas, switch e Legibilidade
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 4", author: "Raoni F. S. Teixeira")
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
      [*Introdução a Algoritmos* — Laboratório 4],
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
    Laboratório 4 — Expressões Lógicas, switch e Legibilidade
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

  1. combinar condições com `&&`, `||` e `!`; 
  2. usar `switch` corretamente, com atenção ao   `break`; 
  3. identificar e corrigir fall-through indesejado; 
  4. aplicar os   quatro pilares da legibilidade na revisão de código alheio.
  ],
)


#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Aquecimento — Simplifique as condições", "20")[
  Reescreva cada bloco usando operadores lógicos para eliminar os `if`s
  aninhados. O comportamento deve ser *idêntico* ao original.

  *Versão A — original:*
  ```c
  if (x > 0) {
      if (x < 100) {
          if (x % 2 == 0) {
              printf("par entre 1 e 99\n");
          }
      }
  }
  ```
  *Versão A — simplificada:*
  ```c
  if (/* ? */) {
      printf("par entre 1 e 99\n");
  }
  ```

  #v(8pt)
  *Versão B — original:*
  ```c
  if (ano % 4 == 0) {
      if (ano % 100 != 0) {
          bissexto = 1;
      } else {
          if (ano % 400 == 0) {
              bissexto = 1;
          } else {
              bissexto = 0;
          }
      }
  } else {
      bissexto = 0;
  }
  ```
  *Versão B — simplificada (use uma única atribuição):*
  ```c
  bissexto = /* ? */;
  ```
  _(Dica: o resultado de uma expressão relacional em C é 0 ou 1.)_
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "Caça ao bug — Fall-through no switch", "25")[
  O programa abaixo converte um número de mês (1–12) para o número de dias
  daquele mês (ignorando anos bissextos). Ele compila sem erros, mas retorna
  valores incorretos para vários meses.

  #bug[
    ```c
    #include <stdio.h>
    int main() {
        int mes, dias;
        printf("Mes (1-12): ");
        scanf("%d", &mes);

        switch (mes) {
            case 1: case 3: case 5: case 7:
            case 8: case 10: case 12:
                dias = 31;
            case 4: case 6: case 9: case 11:
                dias = 30;
            case 2:
                dias = 28;
            default:
                printf("Mes invalido\n");
                dias = -1;
        }

        if (dias > 0)
            printf("%d dias\n", dias);
        return 0;
    }
    ```
  ]

  *a)* Teste com os meses 3, 4, 2 e 13. Preencha a tabela:
  #table(
    columns: (auto, auto, 1fr, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Entrada*], [*Saída esperada*], [*Saída obtida*], [*Correto?*],
    [`3`],  [`31 dias`],       [], [],
    [`4`],  [`30 dias`],       [], [],
    [`2`],  [`28 dias`],       [], [],
    [`13`], [`Mes invalido`],  [], [],
  )

  *b)* Explique o que é fall-through e por que ocorre aqui:
  #caixa_resposta(40pt)

  *c)* Corrija o programa adicionando os `break`s necessários. Verifique que
  o `default` também funciona corretamente após a correção.
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "Implementação — Calculadora com menu", "35")[
  Escreva uma calculadora que leia dois números reais e uma operação, e exiba
  o resultado. Use `switch` para selecionar a operação.

  *Operações suportadas:*
  - `+` soma
  - `-` subtração
  - `*` multiplicação
  - `/` divisão (trate divisão por zero como erro)
  - `%` resto da divisão inteira (converta os operandos para `int`)

  *Saída esperada para `7.0`, `2.0`, `/`:*
  ```
  7.00 / 2.00 = 3.50
  ```

  *Saída esperada para `7.0`, `0.0`, `/`:*
  ```
  Erro: divisao por zero.
  ```

  *Saída esperada para `7.0`, `2.0`, `%`:*
  ```
  7 % 2 = 1
  ```

  *Requisitos:*
  + Leia a operação como `char`.
  + Use `switch` com `char` como expressão.
  + Trate operação inválida no `default`.
  + Formate os resultados com 2 casas decimais (exceto `%`, que é inteiro).
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Revisão de código — Aplique os quatro pilares", "20")[
  O programa abaixo está *funcionalmente correto*, mas tem legibilidade muito
  ruim. Reescreva-o aplicando os quatro pilares: nomes descritivos, indentação
  consistente, comentários que acrescentam (não repetem), e cabeçalho de
  documentação.

  ```c
  #include<stdio.h>
  int main(){float a,b,c,x;scanf("%f%f%f",&a,&b,&c);
  x=a*b*c;if(x>1000)printf("g\n");else if(x>100)printf("m\n");
  else if(x>10)printf("p\n");else printf("mp\n");return 0;}
  ```

  *Dica:* antes de reescrever, compile e teste o original para entender o que
  ele faz. Escolha nomes e comentários que deixem isso claro sem explicação externa.

  *Sua versão legível:*
  #caixa_resposta(160pt)
]

#v(6pt)

// ── Desafio ──────────────────────────────────────────────────
#desafio[
  *Validador de senha*

  Escreva um programa que leia uma senha (número inteiro de 4 dígitos, portanto
  entre 1000 e 9999) e verifique se ela atende aos seguintes critérios,
  imprimindo uma mensagem para cada item:

  - O primeiro dígito é par?
  - O último dígito é ímpar?
  - A soma de todos os dígitos é maior que 15?
  - Os dois dígitos do meio são iguais?

  *Dica:* extraia os dígitos com `/` e `%`. Por exemplo, para a senha 1234:
  - Milhar: `senha / 1000` = 1
  - Centena: `(senha / 100) % 10` = 2
  - Dezena: `(senha / 10) % 10` = 3
  - Unidade: `senha % 10` = 4

  *Exemplo de saída para senha 2448:*
  ```
  Primeiro digito par:       SIM
  Ultimo digito impar:       NAO
  Soma dos digitos > 15:     SIM  (soma = 18)
  Digitos do meio iguais:    SIM
  ```
]
