// ============================================================
//  Lab 7 — Funções
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 7", author: "Raoni F. S. Teixeira")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 7],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Funções],
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
    Laboratório 7 — Funções
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

  1. identificar cada parte da assinatura de uma função pelo nome correto;
  2. decompor um programa com código duplicado em funções com responsabilidade única; 
  3. demonstrar que passagem por valor não modifica variáveis do chamador e explicar por que; 
  4. usar o valor de retorno como alternativa à modificação de variáveis externas.
  ],
) 

#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Anatomia de uma funcao — nomenclatura", "20")[
  Leia as funções abaixo e preencha as tabelas identificando cada
  parte pelo nome correto. *Não execute ainda — apenas leia.*

  ```c
  float media(float soma, int n) {
      return soma / n;
  }

  void imprime_linha(int largura) {
      for (int i = 0; i < largura; i++)
          printf("-");
      printf("\n");
  }

  int maior(int a, int b) {
      if (a > b) return a;
      return b;
  }
  ```

  #table(
    columns: (auto, auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Funcao*], [*Tipo de retorno*], [*Nome*], [*Parametros*], [*Retorna valor?*],
    [`media`],        [], [], [], [],
    [`imprime_linha`],[], [], [], [],
    [`maior`],        [], [], [], [],
  )

  *a)* O que significa o tipo de retorno `void`? Quando ele e usado?
  #caixa_resposta(28pt)

  *b)* Escreva uma chamada valida para cada funcao, supondo que existam
  variaveis adequadas declaradas em `main`:

  - `media(...)` : `_____________________________________________`
  - `imprime_linha(...)` : `______________________________________`
  - `maior(...)` : `____________________________________________`

  *c)* O que acontece se voce chamar `imprime_linha(0)`?
  Preveja antes de testar: `_______________________________________`
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "Refatoracao — eliminando codigo duplicado", "30")[
  O programa abaixo calcula o IMC de tres pessoas. Ele funciona
  corretamente, mas repete o mesmo raciocinio tres vezes. Sua tarefa
  e *refatorar* o programa usando funcoes, sem alterar o comportamento.

  ```c
  #include <stdio.h>

  int main() {
      float peso, altura, imc;

      printf("Pessoa 1 — peso e altura: ");
      scanf("%f %f", &peso, &altura);
      imc = peso / (altura * altura);
      printf("IMC: %.2f — ", imc);
      if      (imc < 18.5) printf("Abaixo do peso\n");
      else if (imc < 25.0) printf("Peso normal\n");
      else if (imc < 30.0) printf("Sobrepeso\n");
      else                 printf("Obesidade\n");

      printf("Pessoa 2 — peso e altura: ");
      scanf("%f %f", &peso, &altura);
      imc = peso / (altura * altura);
      printf("IMC: %.2f — ", imc);
      if      (imc < 18.5) printf("Abaixo do peso\n");
      else if (imc < 25.0) printf("Peso normal\n");
      else if (imc < 30.0) printf("Sobrepeso\n");
      else                 printf("Obesidade\n");

      printf("Pessoa 3 — peso e altura: ");
      scanf("%f %f", &peso, &altura);
      imc = peso / (altura * altura);
      printf("IMC: %.2f — ", imc);
      if      (imc < 18.5) printf("Abaixo do peso\n");
      else if (imc < 25.0) printf("Peso normal\n");
      else if (imc < 30.0) printf("Sobrepeso\n");
      else                 printf("Obesidade\n");

      return 0;
  }
  ```

  *a)* Antes de refatorar, identifique os dois calculos repetidos e
  escreva a assinatura (apenas a linha de declaracao, sem o corpo)
  da funcao que voce criaria para cada um:

  Funcao 1: `____________________________________________`

  Funcao 2: `____________________________________________`

  *b)* Implemente as duas funcoes e reescreva `main` usando-as.
  O `main` resultante deve ter no maximo 10 linhas.

  *c)* Compile e teste com os valores: pessoa 1 = (50kg, 1.70m),
  pessoa 2 = (80kg, 1.75m), pessoa 3 = (100kg, 1.60m).
  Os resultados devem ser identicos ao programa original.

  *d)* Se o criterio de classificacao mudasse — por exemplo, o limite
  de obesidade passasse de 30 para 35 — quantas linhas voce precisaria
  alterar na versao refatorada? E na versao original?

  Refatorada: `_______`   Original: `_______`

  #destaque[
    Essa diferenca e o principal argumento para usar funcoes.
    Codigo que precisa mudar em varios lugares ao mesmo tempo
    e codigo esperando por um bug.
  ]
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "O experimento da passagem por valor", "25")[
  Esta atividade reproduz o experimento da Aula 7 com uma variacao.
  Execute cada trecho, observe a saida e responda as perguntas.

  *Trecho A — a funcao que nao troca:*
  ```c
  #include <stdio.h>

  void troca(int a, int b) {
      int temp = a;
      a = b;
      b = temp;
      printf("Dentro de troca: a=%d, b=%d\n", a, b);
  }

  int main() {
      int x = 10, y = 20;
      printf("Antes:  x=%d, y=%d\n", x, y);
      troca(x, y);
      printf("Depois: x=%d, y=%d\n", x, y);
      return 0;
  }
  ```

  Saida obtida:
  #caixa_resposta(40pt)

  *a)* A troca aconteceu dentro de `troca`? E em `main`? Explique
  por que os resultados sao diferentes.
  #caixa_resposta(40pt)

  *b)* Desenhe os dois "mundos" de memoria (frame de `main` e frame
  de `troca`) no momento em que `troca` esta executando, mostrando
  os valores de `x`, `y`, `a` e `b`:
  #caixa_resposta(56pt)

  *Trecho B — solucao sem ponteiros (usando retorno):*

  A restricao e: resolva o problema de calcular o dobro de um valor
  *sem usar ponteiros*, apenas com `return`. Implemente a funcao
  `int dobra(int x)` e use-a em `main` para dobrar uma variavel.

  ```c
  /* complete e teste */
  int dobra(int x) {
      /* ? */
  }

  int main() {
      int v = 7;
      v = dobra(v);
      printf("%d\n", v);   /* deve imprimir 14 */
      return 0;
  }
  ```

  *c)* Esta abordagem funciona para trocar dois valores? Por que sim
  ou por que nao?
  #caixa_resposta(32pt)
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Implementacao — calculadora modular", "30")[
  Escreva um programa de calculadora organizado em funcoes, onde
  cada operacao e uma funcao separada. O programa deve:

  + Ler dois numeros reais e um operador (`+`, `-`, `*`, `/`);
  + Chamar a funcao correspondente à operacao;
  + Exibir o resultado com duas casas decimais;
  + Para divisao, verificar divisao por zero antes de calcular.

  *Assinaturas obrigatorias:*

  ```c
  float soma(float a, float b);
  float subtracao(float a, float b);
  float multiplicacao(float a, float b);
  float divisao(float a, float b);   /* retorna 0 e imprime erro se b==0 */
  void  exibe_resultado(float a, char op, float b, float res);
  ```

  *Requisitos de organizacao:*
  - `main` deve ter no maximo 10 linhas;
  - cada funcao deve ter no maximo 5 linhas;
  - use `switch` ou `if-else-if` em `main` para selecionar a funcao.

  *Casos de teste:*
  #table(
    columns: (auto, auto, auto, auto, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*`a`*], [*`b`*], [*`op`*], [*Esperado*], [*Obtido*],
    [`7.0`],  [`2.0`],  [`+`], [`7.00 + 2.00 = 9.00`],  [],
    [`7.0`],  [`2.0`],  [`-`], [`7.00 - 2.00 = 5.00`],  [],
    [`7.0`],  [`2.0`],  [`*`], [`7.00 * 2.00 = 14.00`], [],
    [`7.0`],  [`2.0`],  [`/`], [`7.00 / 2.00 = 3.50`],  [],
    [`7.0`],  [`0.0`],  [`/`], [`Erro: divisao por zero`], [],
  )
]

#v(6pt)

// ── Desafio ──────────────────────────────────────────────────
#desafio[
  *Funcoes que chamam funcoes — MMC a partir do MDC*

  Implemente as seguintes funcoes em ordem, onde cada uma usa a anterior:

  ```c
  /* Retorna 1 se n e primo, 0 caso contrario */
  int eh_primo(int n);

  /* Retorna o MDC de a e b pelo algoritmo de Euclides */
  int mdc(int a, int b);

  /* Retorna o MMC de a e b usando a formula: mmc = a*b / mdc(a,b) */
  int mmc(int a, int b);

  /* Retorna 1 se a e b sao coprimos (MDC == 1), 0 caso contrario */
  int sao_coprimos(int a, int b);
  ```

  Escreva `main` que leia dois inteiros e imprima: se cada um e primo,
  o MDC, o MMC e se sao coprimos.

  Teste com os pares: (12, 18), (7, 13), (100, 75), (17, 19).
]
