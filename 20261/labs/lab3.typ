// ============================================================
//  Lab 3 — Expressões Relacionais e Condicionais
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 3", author: "Raoni F. S. Teixeira")
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
      [*Introdução a Algoritmos* — Laboratório 3],
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
    Laboratório 3 — Expressões Relacionais e Condicionais
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

   1. usar   operadores relacionais corretamente; 
   2. estruturar condicionais `if`, `if/else` e `if-else-if`; 
   3. identificar e corrigir o bug do `dangling else` e a   confusão entre `=` e `==`; 
   4. raciocinar sobre a ordem das condições.
  ],
)




#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Aquecimento — Preveja a saída", "20")[
  *Antes de compilar*, leia cada trecho e escreva o que será impresso para
  a entrada indicada. Depois compile e verifique.

  *Trecho A* — entrada: `n = 4`
  ```c
  int n;
  scanf("%d", &n);
  if (n % 2)
      printf("impar\n");
  if (n > 3)
      printf("maior que 3\n");
  if (n == 4)
      printf("exatamente 4\n");
  ```
  Saída prevista: #h(1fr) `_______________________________`

  #v(6pt)
  *Trecho B* — entrada: `x = 5`
  ```c
  int x;
  scanf("%d", &x);
  if (x > 10)
      printf("A\n");
  else if (x > 3)
      printf("B\n");
  else
      printf("C\n");
  ```
  Saída prevista: #h(1fr) `_______________________________`

  #v(6pt)
  *Trecho C* — entrada: `a = 0`
  ```c
  int a;
  scanf("%d", &a);
  if (a = 5)
      printf("cinco\n");
  else
      printf("nao e cinco\n");
  ```
  Saída prevista: #h(1fr) `_______________________________`

  Após compilar: o resultado foi o esperado? Se não, explique o motivo:
  #caixa_resposta(36pt)
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "Caça ao bug — Dangling else e lógica invertida", "25")[
  O programa abaixo deveria classificar um número inteiro como *negativo*,
  *zero*, *positivo par* ou *positivo ímpar*. Ele compila sem erros, mas
  produz respostas incorretas para várias entradas.

  #bug[
    ```c
    #include <stdio.h>
    int main() {
        int n;
        scanf("%d", &n);
        if (n > 0)
            if (n % 2 == 0)
                printf("positivo par\n");
            else
                printf("positivo impar\n");
        else
            if (n == 0)
                printf("zero\n");
            else
                printf("negativo\n");
        return 0;
    }
    ```
  ]

  *a)* Preencha a tabela testando as entradas abaixo. Compile e execute
  para verificar suas previsões:

  #table(
    columns: (auto, auto, 1fr, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Entrada*], [*Saída esperada*], [*Saída obtida*], [*Correto?*],
    [`5`],  [`positivo impar`], [], [],
    [`4`],  [`positivo par`],   [], [],
    [`0`],  [`zero`],           [], [],
    [`-3`], [`negativo`],       [], [],
  )

  *b)* Identifique o bug. Em que entrada ele se manifesta? Por que acontece?
  #caixa_resposta(45pt)

  *c)* Corrija o programa usando chaves em todos os blocos. Teste novamente
  com todas as quatro entradas da tabela.
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "Complete o código — Classificador de triângulo", "25")[
  Um triângulo com lados `a`, `b`, `c` é válido se cada lado for menor que
  a soma dos outros dois. Se válido, pode ser: *equilátero* (três lados iguais),
  *isósceles* (exatamente dois lados iguais) ou *escaleno* (todos diferentes).

  Complete o programa abaixo:

  #lacuna[
    ```c
    #include <stdio.h>
    int main() {
        float a, b, c;
        printf("Lados a, b, c: ");
        scanf("%f %f %f", &a, &b, &c);

        /* Verifica se forma um triangulo valido */
        if (/* ? */ || /* ? */ || /* ? */) {
            printf("Nao forma triangulo\n");
        } else if (/* ? */) {
            printf("Equilatero\n");
        } else if (/* ? */ || /* ? */ || /* ? */) {
            printf("Isosceles\n");
        } else {
            /* ? */
        }
        return 0;
    }
    ```
  ]

  *Casos de teste obrigatórios:*
  #table(
    columns: (auto, auto, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*a, b, c*],       [*Resultado esperado*],          [*Resultado obtido*],
    [`3, 4, 5`],       [`Escaleno`],                    [],
    [`5, 5, 5`],       [`Equilatero`],                  [],
    [`5, 5, 3`],       [`Isosceles`],                   [],
    [`1, 2, 10`],      [`Nao forma triangulo`],         [],
    [`0, 4, 5`],       [`Nao forma triangulo`],         [],
  )
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Implementação — Calculadora de gorjeta", "30")[
  Restaurantes costumam sugerir gorjetas de 10%, 15% ou 20% dependendo da
  avaliação do serviço. Escreva um programa completo que:

  + Leia o valor total da conta (real positivo);
  + Leia uma avaliação do serviço: 1 (ruim), 2 (regular), 3 (bom), 4 (ótimo);
  + Calcule a gorjeta sugerida:
    - Avaliação 1: 0% (sem gorjeta)
    - Avaliação 2: 10%
    - Avaliação 3: 15%
    - Avaliação 4: 20%
  + Exiba a gorjeta sugerida, o total com gorjeta, e — se a avaliação for
    inválida (fora de 1–4) — uma mensagem de erro.

  *Saída esperada para conta = 85.50, avaliação = 3:*
  ```
  Gorjeta sugerida (15%): R$ 12.82
  Total com gorjeta:      R$ 98.32
  ```

  *Requisitos de implementação:*
  - Use `if-else-if` *ou* `switch` — à escolha da dupla. Comente qual foi
    escolhido e por quê.
  - Trate avaliação inválida com mensagem adequada.
  - Documente o programa com cabeçalho completo.
]

#v(6pt)

// ── Desafio ──────────────────────────────────────────────────
#desafio[
  *Verificador de ano bissexto*

  Um ano é bissexto se: for divisível por 4, *exceto* se for divisível por
  100 — a menos que também seja divisível por 400.

  Exemplos: 2024 é bissexto; 1900 não é; 2000 é.

  Escreva o programa e teste com: 2024, 1900, 2000, 2023, 1600.

  *Desafio adicional:* reescreva a condição inteira em um único `if` sem
  `else-if`, usando apenas operadores lógicos (`&&`, `||`, `!`).
]
