// ============================================================
//  Lab 9 — Vetores
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 9", author: "Raoni F. S. Teixeira")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 9],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Vetores],
      align(right)[#context counter(page).display("1")])
  ]
)
#set text(font: "Linux Libertine", size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.75em)

// ── Preamble ─────────────────────────────────────────────────

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

#let lacuna(corpo) = block(
  fill: rgb("#f0faf0"), stroke: (left: 3pt + rgb("#2e7d32")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#2e7d32"))[Complete o código] \ #corpo]

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

// ── Cabeçalho ────────────────────────────────────────────────
#align(center)[
  #text(size: 15pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Laboratório 9 — Vetores
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

  1. rastrear um laço sobre vetor índice a índice;
  2. identificar e corrigir os três bugs mais comuns com vetores;
  3. implementar busca exaustiva sobre pares de elementos;
  4. organizar o código em funções com responsabilidades separadas.
  ],
)
 



#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Teste de mesa — rastreando um laço sobre vetor", "20")[
  Antes de qualquer compilação, faça o teste de mesa do programa abaixo
  para o vetor `v = {3, 1, 4, 1, 5}` e `n = 5`.

  ```c
  int v[] = {3, 1, 4, 1, 5};
  int n = 5;
  int a = v[0], b = 0;

  for (int i = 1; i < n; i++) {
      if (v[i] > a) {
          a = v[i];
          b = i;
      }
  }
  printf("a=%d  b=%d\n", a, b);
  ```

  Preencha a tabela rastreando cada iteração:

  #table(
    columns: (auto, auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#e8eaf6") } else { white },
    [*`i`*], [*`v[i]`*], [*`v[i] > a`?*], [*`a`*], [*`b`*],
    [—],  [—],  [—],  [`3`], [`0`],
    [`1`],[#v(10pt)],[],[],[],
    [`2`],[#v(10pt)],[],[],[],
    [`3`],[#v(10pt)],[],[],[],
    [`4`],[#v(10pt)],[],[],[],
  )

  #v(4pt)
  Saída prevista: `_______________`  #h(8pt)  Saída real: `_______________`

  #v(4pt)
  O que este programa calcula?
  #caixa_resposta(32pt)
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "Caça aos bugs — três problemas clássicos com vetores", "35")[
  Cada trecho abaixo tem exatamente um bug. Para cada um: (a) compile e
  execute para observar o comportamento; (b) explique o problema; (c) corrija.

  // Bug 1
  #bug("Índice fora dos limites")[
    ```c
    #include <stdio.h>
    #define N 5

    int main() {
        int v[N];
        int soma = 0;

        for (int i = 0; i <= N; i++) {
            scanf("%d", &v[i]);
        }
        for (int i = 0; i <= N; i++) {
            soma += v[i];
        }
        printf("Soma: %d\n", soma);
        return 0;
    }
    ```
    *a)* Teste com os valores `1 2 3 4 5`. O que acontece?
    #caixa_resposta(28pt)

    *b)* Explique o problema. Em que posição o acesso é inválido e por quê?
    #caixa_resposta(36pt)

    *c)* Corrija o programa. A mudança é mínima — uma única alteração em
    cada laço. Qual é ela?
    #caixa_resposta(28pt)
  ]

  #v(8pt)

  // Bug 2
  #bug("Vetor não inicializado")[
    ```c
    #include <stdio.h>
    #define N 5

    float maior(float v[], int n) {
        float m = v[0];
        for (int i = 1; i < n; i++)
            if (v[i] > m) m = v[i];
        return m;
    }

    int main() {
        float v[N];
        printf("Maior: %.1f\n", maior(v, N));

        printf("Digite %d valores:\n", N);
        for (int i = 0; i < N; i++)
            scanf("%f", &v[i]);

        printf("Maior: %.1f\n", maior(v, N));
        return 0;
    }
    ```
    *a)* Execute o programa. A primeira chamada a `maior` produz um resultado
    confiável? Por quê?
    #caixa_resposta(36pt)

    *b)* A segunda chamada está correta? Explique a diferença entre as duas.
    #caixa_resposta(28pt)

    *c)* Corrija o programa movendo a chamada incorreta para o lugar certo.
  ]

  #v(8pt)

  // Bug 3
  #bug("Confusão entre modificar o ponteiro e modificar o conteúdo")[
    O programa abaixo pretende preencher um vetor com zeros usando uma função.
    Ele compila sem erros, mas o vetor em `main` continua com os valores originais.

    ```c
    #include <stdio.h>
    #define N 5

    void zera(int *v, int n) {
        int aux[N];
        for (int i = 0; i < n; i++)
            aux[i] = 0;
        v = aux;   /* tenta "substituir" o vetor */
    }

    int main() {
        int v[N] = {1, 2, 3, 4, 5};
        zera(v, N);
        for (int i = 0; i < N; i++)
            printf("%d ", v[i]);
        printf("\n");
        return 0;
    }
    ```
    *a)* O que a linha `v = aux` faz dentro de `zera`? Por que não afeta `main`?
    _(Relembre o modelo de passagem por valor da Aula 7 e o que é um ponteiro
    da Aula 8.)_
    #caixa_resposta(48pt)

    *b)* Corrija `zera` para que ela realmente ponha zeros no vetor original.
    A correção não precisa de `aux` nem de reatribuir `v`.
    #caixa_resposta(56pt)
  ]
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "Implementação progressiva — par com soma mais próxima do alvo", "45")[
  Dado um vetor de `n` inteiros e um valor alvo `T`, encontre o par de
  índices `(i, j)` com `i < j` tal que `|v[i] + v[j] - T|` seja mínimo —
  ou seja, cuja soma seja a mais próxima possível de `T`.

  *Exemplo:* vetor `{1, 4, 7, 3, 9}`, alvo `T = 10`.
  Todos os pares e suas somas:
  #table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") }
                      else if row == 4 { rgb("#e8f5e9") }
                      else { white },
    [*Par*], [*Soma*], [*Distância de 10*], [*Melhor?*],
    [`(1,4)`],  [`5`],  [`5`], [],
    [`(1,7)`],  [`8`],  [`2`], [],
    [`(1,3)`],  [`4`],  [`6`], [],
    [`(1,9)`],  [`10`], [`0`], [Sim],
    [`(4,7)`],  [`11`], [`1`], [],
    [`(4,3)`],  [`7`],  [`3`], [],
    [`(4,9)`],  [`13`], [`3`], [],
    [`(7,3)`],  [`10`], [`0`], [Sim],
    [`(7,9)`],  [`16`], [`6`], [],
    [`(3,9)`],  [`12`], [`2`], [],
  )
  Resultado: dois pares empatam com distância 0 — `(1,9)` e `(7,3)`.
  Retorne qualquer um dos dois.

  *Parte A — estrutura básica (15 min)*

  Complete o programa abaixo que lê o vetor e o alvo:

  #lacuna[
    ```c
    #include <stdio.h>
    #define MAX 100

    int main() {
        int v[MAX], n, T;

        printf("Tamanho do vetor: ");
        scanf(/* ? */, &n);

        for (/* ? */) {
            printf("v[%d]: ", i);
            scanf("%d", /* ? */);
        }

        printf("Alvo T: ");
        scanf("%d", &T);

        /* Parte B sera adicionada aqui */

        return 0;
    }
    ```
  ]

  *Parte B — busca exaustiva (20 min)*

  Adicione a busca ao programa da Parte A. Use a estrutura de busca exaustiva
  da Aula 6: inicialize `melhor` com o pior caso possível e atualize a cada
  par que melhorar o resultado.

  Antes de implementar, responda as três perguntas do laço:
  - O que se repete? #h(1fr) `_________________________________`
  - Quantas vezes? #h(1fr) `_________________________________`
  - O que muda? #h(1fr) `_________________________________`

  #v(4pt)
  A busca exige dois laços aninhados. O laço interno deve começar em `j = i + 1`
  — por quê? Escreva a resposta antes de implementar:
  #caixa_resposta(32pt)

  Saída esperada para o exemplo acima (vetor `1 4 7 3 9`, alvo `10`):
  ```
  Par encontrado: v[0] + v[3] = 1 + 9 = 10  (distancia = 0)
  ```
  _(O par `(2,3)` = `7+3` também é válido — sua implementação pode retornar
  qualquer dos pares com distância mínima.)_

  *Parte C — organização em funções (10 min)*

  Extraia a busca para uma função com a seguinte assinatura:

  ```c
  /*
   * Encontra o par (i, j) com i < j cuja soma v[i]+v[j]
   * e mais proxima de T. Escreve os indices em *ri e *rj.
   * Pre-cond.: n >= 2
   */
  void par_mais_proximo(int v[], int n, int T, int *ri, int *rj);
  ```

  Por que esta função usa ponteiros para `ri` e `rj` em vez de retornar
  diretamente os índices? Escreva a resposta como comentário no código.
]

#v(6pt)

// ── Desafio ──────────────────────────────────────────────────
#desafio[
  *Extensões da busca de pares*

  Escolha uma ou mais das extensões abaixo e implemente-as como funções
  separadas, adicionando-as ao programa da Atividade 3.

  *Extensão 1 — contar pares exatos:*
  Escreva `int conta_pares(int v[], int n, int T)` que retorna quantos pares
  distintos `(i, j)` com `i < j` têm soma *exatamente igual* a `T`.
  Teste com o vetor `{1, 3, 2, 5, 4, 3}` e alvo `6` — resultado esperado: 4.
  _(Identifique os quatro pares antes de implementar.)_

  *Extensão 2 — par mais próximo em vetor ordenado:*
  Se o vetor estiver em ordem crescente, existe uma estratégia mais eficiente
  do que testar todos os pares: use dois índices, um no início (`esq = 0`) e
  um no fim (`dir = n-1`). Se a soma for menor que `T`, avance `esq`; se for
  maior, recue `dir`; se for igual, encontrou. Implemente essa estratégia e
  compare o número de comparações com a busca exaustiva para `n = 10`.

  *Extensão 3 — três elementos:*
  Generalize para encontrar o trio `(i, j, k)` com `i < j < k` cuja soma
  `v[i] + v[j] + v[k]` seja mais próxima de `T`. Quantos laços são necessários?
  Quantas combinações existem para `n = 10`?
]
