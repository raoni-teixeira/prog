// ============================================================
//  Lab 6 — Teste de Mesa, Força Bruta e Mega-Sena
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 6", author: "Raoni F. S. Teixeira")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 6],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Teste de Mesa, Força Bruta e Mega-Sena],
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
    Laboratório 6 — Teste de Mesa, Força Bruta e Mega-Sena
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

  1. construir um teste de mesa para laços aninhados, rastreando dois contadores simultaneamente; 
  2. identificar e corrigir bugs de inicialização de acumulador e off-by-one em laços; 
  3. explicar o que é força bruta e implementar uma busca exaustiva sobre um espaço finito;
  4. estimar o custo de uma busca exaustiva contando o número de iterações antes de executar o programa.
  ],
) 



#v(10pt)

// ── O que é força bruta ──────────────────────────────────────

#block(
  fill: rgb("#f0f4ff"), stroke: 0.5pt + rgb("#1a3a5c"),
  inset: 12pt, radius: 4pt, width: 100%,
)[
  *O que é força bruta?*

  Força bruta (ou busca exaustiva) é a estratégia de resolver um problema
  testando *todas as possibilidades* dentro do espaço de busca e
  verificando quais satisfazem as condições desejadas. Não exige
  inteligência especial — apenas organização e paciência computacional.

  A estrutura é sempre a mesma:

  ```c
  melhor = PIOR_CASO;
  for (/* todas as possibilidades */) {
      if (/* possibilidade valida */ && /* e melhor que a atual */)
          melhor = /* atualiza */;
  }
  ```

  Força bruta é *garantidamente correta* — nunca perde a solução ótima.
  Sua limitação é o custo: se o espaço de busca for grande, pode ser
  lenta. Mas para espaços pequenos é a primeira estratégia a tentar,
  e serve de referência para verificar algoritmos mais sofisticados.
]

#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Teste de mesa — laço aninhado com contador", "25")[
  Faça o teste de mesa do programa abaixo *antes de compilar*.
  O programa conta pares ordenados `(i, j)` com `i < j` dentro
  de um intervalo.

  ```c
  #include <stdio.h>
  int main() {
      int n = 4, cont = 0;
      for (int i = 1; i <= n; i++) {
          for (int j = i + 1; j <= n; j++) {
              cont++;
          }
      }
      printf("Pares: %d\n", cont);
      return 0;
  }
  ```

  *a)* Preencha a tabela rastreando cada vez que `cont++` é executado:

  #table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#e8eaf6") } else { white },
    [*`i`*], [*`j`*], [*`j <= n`*], [*`cont` apos*],
    [`1`], [`2`], [`V`], [`1`],
    [`1`], [`3`], [`V`], [],
    [`1`], [`4`], [`V`], [],
    [`1`], [`5`], [`F — encerra j`], [],
    [`2`], [`3`], [`V`], [],
    [`2`], [`4`], [],   [],
    [`2`], [`5`], [],   [],
    [`3`], [`4`], [],   [],
    [`3`], [`5`], [],   [],
    [`4`], [`5`], [],   [],
  )

  Saída prevista: `_______`   Saída real: `_______`

  #v(6pt)
  *b)* Sem executar, responda: qual seria a saída para `n = 5`?
  _(Dica: o número de pares `(i,j)` com `i < j` e `1 <= i,j <= n`
  é dado por $n(n-1)/2$.)_

  Para `n = 5`: `_______`   Para `n = 60`: `_______`

  #v(6pt)
  *c)* O que este programa calcula geometricamente? _(Pense em `n` pontos
  num plano — o que cada par `(i, j)` poderia representar?)_
  #caixa_resposta(28pt)
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "Caca ao bug — dois problemas classicos", "25")[

  #bug("Acumulador inicializado com constante arbitraria")[
    O programa abaixo deveria encontrar o menor número entre os digitados
    pelo usuário, mas produz resultados errados para muitas entradas.

    ```c
    #include <stdio.h>
    int main() {
        int n, x, menor;
        printf("Quantos numeros? ");
        scanf("%d", &n);
        menor = 0;   /* inicializa com zero */
        for (int i = 0; i < n; i++) {
            printf("Numero %d: ", i + 1);
            scanf("%d", &x);
            if (x < menor) menor = x;
        }
        printf("Menor: %d\n", menor);
        return 0;
    }
    ```

    *a)* Teste com a sequência `3 7 2 9`. Resultado obtido: `_______`
    Resultado esperado: `_______`

    *b)* Para qual tipo de sequência o programa funciona corretamente
    por acidente?
    #caixa_resposta(28pt)

    *c)* Explique o bug em uma frase e corrija o programa:
    #caixa_resposta(48pt)
  ]

  #v(10pt)

  #bug("Off-by-one no limite do laco")[
    O programa abaixo deveria imprimir todos os pares `(i, j)` com
    `1 <= i < j <= n` e contar quantos existem. Ele compila sem erros
    mas produz resultado incorreto.

    ```c
    #include <stdio.h>
    int main() {
        int n = 5, cont = 0;
        for (int i = 1; i <= n; i++) {
            for (int j = i; j <= n; j++) {   /* bug aqui */
                printf("(%d, %d)\n", i, j);
                cont++;
            }
        }
        printf("Total: %d pares\n", cont);
        return 0;
    }
    ```

    *a)* Para `n = 3`, o programa imprime os seguintes pares:
    #caixa_resposta(32pt)

    *b)* Quais pares foram impressos que não deveriam? Por que o bug
    acontece?
    #caixa_resposta(32pt)

    *c)* Corrija o programa com uma mudança mínima — uma única
    palavra ou símbolo. Qual foi a correção?
    #caixa_resposta(20pt)
  ]
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "Forca bruta — pares com soma alvo", "25")[
  Nesta atividade você aplicará força bruta a um problema concreto:
  encontrar pares de números inteiros cuja soma seja igual a um alvo.

  *Problema:* dados dois inteiros `n` e `T`, contar quantos pares
  `(i, j)` com `1 <= i < j <= n` têm soma `i + j == T`.

  *Antes de implementar*, responda as três perguntas:
  - O que se repete? #h(1fr) `_________________________________`
  - Quantas vezes (espaço de busca)? #h(1fr) `_________________________________`
  - O que muda? #h(1fr) `_________________________________`

  #v(6pt)
  *a)* Para `n = 10`, `T = 11`, enumere *na mão* todos os pares
  `(i, j)` com `i < j` e `i + j = 11`:
  #caixa_resposta(32pt)

  Quantos pares você encontrou? `_______`

  *b)* Implemente o programa usando força bruta com dois laços aninhados.
  Estrutura sugerida:

  ```c
  #include <stdio.h>
  int main() {
      int n, T, cont = 0;
      scanf("%d %d", &n, &T);
      for (int i = 1; i <= n; i++) {
          for (int j = /* ? */; j <= n; j++) {
              if (/* ? */) {
                  printf("(%d, %d)\n", i, j);
                  cont++;
              }
          }
      }
      printf("Total: %d par(es)\n", cont);
      return 0;
  }
  ```

  *c)* Teste com `n = 10, T = 11`. O resultado confere com o item (a)?

  *d)* Teste com `n = 60, T = 61`. Quantos pares existem? `_______`

  #destaque[
    *Reflexao:* para `n = 60`, quantas vezes o `if` dentro do laço é
    avaliado? Calcule antes de executar: `_______`
    Isso é pouco ou muito para um computador moderno?
  ]
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Verificador de bilhete da Mega-Sena", "35")[
  Na Mega-Sena, o apostador escolhe 6 números distintos entre 1 e 60.
  No sorteio, 6 números são sorteados. Ganha quem acertar 4, 5 ou 6
  dos números sorteados.

  *Problema:* dado um bilhete (6 números do apostador) e o resultado
  do sorteio (6 números sorteados), contar quantos números do bilhete
  coincidem com o sorteio.

  *Estratégia:* força bruta sobre dois conjuntos pequenos. Para cada
  número do bilhete, percorra todos os números sorteados verificando
  se há coincidência. Dois laços aninhados, 6x6 = 36 comparações no
  máximo.

  *a)* Antes de implementar, escreva o algoritmo em português:
  #caixa_resposta(56pt)

  *b)* Implemente o programa. O bilhete e o sorteio devem ser lidos
  do teclado. Use dois vetores de tamanho 6.

  Estrutura sugerida:
  ```c
  #include <stdio.h>
  int main() {
      int bilhete[6], sorteio[6], acertos = 0;

      printf("Bilhete (6 numeros): ");
      for (int i = 0; i < 6; i++)
          scanf("%d", &bilhete[i]);

      printf("Sorteio (6 numeros): ");
      for (int i = 0; i < 6; i++)
          scanf("%d", &sorteio[i]);

      /* forca bruta: compare cada numero do bilhete com cada sorteado */
      for (int i = 0; i < 6; i++) {
          for (int j = 0; j < 6; j++) {
              if (/* ? */) {
                  acertos++;
                  /* pode parar de comparar este numero do bilhete */
              }
          }
      }

      printf("Acertos: %d\n", acertos);
      if      (acertos == 6) printf("SENA!\n");
      else if (acertos == 5) printf("Quina!\n");
      else if (acertos == 4) printf("Quadra!\n");
      else                   printf("Nao premiado.\n");

      return 0;
  }
  ```

  *c)* Teste com os casos abaixo e preencha a tabela:

  #table(
    columns: (1fr, 1fr, auto, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Bilhete*], [*Sorteio*], [*Acertos esperados*], [*Obtido*],
    [`1 2 3 4 5 6`],    [`1 2 3 4 5 6`],    [`6 (Sena)`],   [],
    [`1 2 3 4 5 6`],    [`1 2 3 7 8 9`],    [`3`],          [],
    [`10 20 30 40 50 60`], [`10 20 30 40 50 60`], [`6 (Sena)`], [],
    [`1 2 3 4 5 6`],    [`7 8 9 10 11 12`], [`0`],          [],
    [`5 10 15 20 25 30`], [`5 10 15 20 25 31`], [`5 (Quina)`], [],
  )

  *d)* Existe algum caso em que seu programa contaria o mesmo numero
  do bilhete duas vezes? Quando isso aconteceria e como evitar?
  #caixa_resposta(40pt)
]

#v(6pt)

// ── Desafio ──────────────────────────────────────────────────
#desafio[
  *Quantos bilhetes da Mega-Sena tem soma maior que 200?*

  Um bilhete valido tem 6 numeros distintos entre 1 e 60, com
  `n1 < n2 < n3 < n4 < n5 < n6`. Usando forca bruta com seis lacos
  aninhados, conte quantos bilhetes validos tem soma dos seis numeros
  estritamente maior que 200.

  *Antes de implementar*, estime:
  - Quantos bilhetes validos existem no total?
    _(O numero de combinacoes de 60 numeros tomados 6 a 6 e
    $binom(60, 6) = 50.063.860$.)_
  - Quantas iteracoes o laco mais interno sera executado, no pior caso?
  - Quanto tempo voce estima que o programa vai demorar?

  Execute e registre: quantos bilhetes tem soma > 200? `_______`
  Quanto tempo o programa levou para executar? `_______`

  _(Dica para medir o tempo no terminal: `time ./programa`)_

  *Reflexao:* se cada iteracao do laco mais interno levasse 1 nanossegundo,
  quanto tempo levaria percorrer $10^{18}$ iteracoes? O que isso diz sobre
  os limites da forca bruta?
]
