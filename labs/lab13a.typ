// ============================================================
//  Lab 13a — Modelo de Memória e Alocação Dinâmica
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 13a", author: "Raoni F. S. Teixeira")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 13a],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Modelo de Memória e Alocação Dinâmica],
      align(right)[#context counter(page).display("1")])
  ]
)

#set text(font: "Linux Libertine", size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.75em)
#set heading(numbering: "1.")

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

#align(center)[
  #text(size: 15pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Laboratório 13a — Modelo de Memória e Alocação Dinâmica
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

  1. classificar qualquer variável no segmento de memória correto   (código, dados, stack, heap); 
  2. explicar por que variáveis locais deixam de existir após o fim da função, usando o modelo de frames;
  3. alocar e liberar memória com `malloc`, `calloc` e `free`, verificando o valor devolvido  antes de usar; 
  4. identificar os três erros  fatais com memória dinâmica: uso após free, double-free e memory leak.
  ],
) 



#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Classificando variaveis nos segmentos", "20")[
  Para cada declaracao abaixo, indique em qual segmento a variavel
  ou dado vive, e qual e seu tempo de vida.

  #table(
    columns: (1fr, auto, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 8pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Declaracao / contexto*], [*Segmento*], [*Tempo de vida*],
    [`int x = 5;` dentro de `main`],
      [], [],
    [`int x = 5;` fora de qualquer funcao],
      [], [],
    [`static int contador = 0;` dentro de funcao],
      [], [],
    [`char *msg = "erro";`],
      [], [],
    [`"erro"` (o literal em si)],
      [], [],
    [`malloc(10 * sizeof(int))`],
      [], [],
    [parametro `int n` de uma funcao],
      [], [],
  )

  *a)* Uma variavel `static` local e inicializada apenas uma vez
  e persiste entre chamadas da funcao. Em qual segmento ela vive?
  Verifique com o programa abaixo — o que ele imprime?

  ```c
  void conta() {
      static int n = 0;
      n++;
      printf("%d\n", n);
  }
  int main() {
      conta(); conta(); conta();
      return 0;
  }
  ```
  Saida prevista: `_______`   Saida real: `_______`

  *b)* Por que `static int n = 0` nao reinicia `n` a cada chamada,
  mas `int n = 0` reiniciaria?
  #caixa_resposta(28pt)
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "A stack em acao — frames e tempo de vida", "25")[
  *Parte A — rastreando frames:*

  Para o programa abaixo, desenhe o estado da stack no momento
  indicado por `/* AQUI */`.

  ```c
  int soma(int a, int b) {
      int resultado = a + b;   /* AQUI */
      return resultado;
  }

  int dobro(int x) {
      int r = soma(x, x);
      return r;
  }

  int main() {
      int v = 5;
      int d = dobro(v);
      printf("%d\n", d);
      return 0;
  }
  ```

  Desenhe os frames (do mais recente para o mais antigo, de cima
  para baixo), indicando as variaveis e seus valores:

  #block(
    fill: rgb("#f5f5f5"), stroke: 0.5pt + rgb("#999"),
    inset: 16pt, radius: 4pt, width: 60%,
  )[
    #table(
      columns: (1fr,),
      stroke: 0.5pt + rgb("#aaa"),
      inset: 14pt,
      fill: (_, row) =>
        (rgb("#e8f5e9"), rgb("#ddeaf9"), rgb("#fff8e1")).at(row, default: white),
      [frame de `soma`\ `a=___  b=___`\ `resultado=___`],
      [frame de `dobro`\ `x=___  r=___`],
      [frame de `main`\ `v=___  d=___`],
    )
  ]

  *a)* Quantos frames existem simultaneamente neste momento? `_______`

  *b)* O que acontece com o frame de `soma` apos ele retornar?
  #caixa_resposta(24pt)

  *Parte B — o perigo de retornar endereco local:*

  ```c
  int *perigo() {
      int x = 42;
      return &x;
  }

  int main() {
      int *p = perigo();
      printf("%d\n", *p);   /* pode imprimir 42... ou nao */
      printf("%d\n", *p);   /* segunda leitura — pode ser diferente */
      return 0;
  }
  ```

  *c)* Execute o programa duas vezes. O resultado e sempre o mesmo?
  #caixa_resposta(20pt)

  *d)* Explique por que o resultado e imprevisivel usando o modelo
  de frames da stack:
  #caixa_resposta(32pt)

  *e)* Como corrigir `perigo()` para retornar um ponteiro valido
  *sem usar `malloc`*? _(Dica: onde deve ser declarado `x`?)_
  #caixa_resposta(24pt)
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "malloc, calloc e free na pratica", "35")[
  *Parte A — vetor de tamanho dinamico:*

  Implemente o programa abaixo, que so e possivel com alocacao
  dinamica — o tamanho `n` e desconhecido em tempo de compilacao.

  ```c
  /*
   * Le n inteiros do teclado, calcula a media e lista os
   * elementos acima da media. Libera a memoria ao final.
   */
  #include <stdio.h>
  #include <stdlib.h>

  int main() {
      int n;
      printf("Quantos valores? ");
      scanf("%d", &n);

      int *v = malloc(/* ? */);
      if (/* ? */) {
          fprintf(stderr, "Erro: sem memoria\n");
          return 1;
      }

      for (int i = 0; i < n; i++)
          scanf("%d", &v[i]);

      float soma = 0;
      for (int i = 0; i < n; i++) soma += v[i];
      float media = soma / n;

      printf("Media: %.2f\n", media);
      printf("Acima da media:");
      for (int i = 0; i < n; i++)
          if (v[i] > media) printf(" %d", v[i]);
      printf("\n");

      free(v);
      v = NULL;
      return 0;
  }
  ```

  Complete os trechos marcados com `/* ? */`.

  *a)* Por que e necessario `v = NULL` apos `free(v)`?
  #caixa_resposta(24pt)

  *b)* Qual e a diferenca entre `malloc(n * sizeof(int))` e
  `calloc(n, sizeof(int))`? Quando cada um e preferivel?
  #caixa_resposta(28pt)

  *Parte B — struct alocada dinamicamente:*

  Implemente a funcao abaixo e use-a em `main`:

  ```c
  typedef struct { char nome[100]; float media; } Aluno;

  /*
   * Aloca um Aluno no heap, preenche nome e media,
   * e retorna o ponteiro. Retorna NULL em caso de erro.
   * O chamador e responsavel pelo free.
   */
  Aluno *cria_aluno(char *nome, float media);
  ```

  *c)* Por que e seguro retornar um ponteiro para memoria do heap,
  mas nao para memoria da stack?
  #caixa_resposta(28pt)
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Caca ao bug — tres erros fatais com heap", "20")[

  #bug("Uso apos free")[
    ```c
    int *v = malloc(5 * sizeof(int));
    for (int i = 0; i < 5; i++) v[i] = i;
    free(v);
    printf("%d\n", v[2]);   /* uso apos free */
    ```
    *a)* O que pode acontecer? Por que o resultado e imprevisivel?
    #caixa_resposta(28pt)

    *b)* Como `v = NULL` apos o `free` ajuda a detectar esse erro
    mais cedo?
    #caixa_resposta(24pt)
  ]

  #v(8pt)

  #bug("Vazamento de memoria em laco")[
    ```c
    for (int i = 0; i < 1000; i++) {
        int *v = malloc(100 * sizeof(int));
        /* usa v... */
        /* esqueceu o free! */
    }
    ```
    *a)* Quantos bytes sao vazados ao final do laco?
    `_______`

    *b)* O programa termina? O que acontece com a memoria vazada
    quando o processo encerra?
    #caixa_resposta(28pt)

    *c)* Corrija adicionando `free(v)` no lugar correto.
    Onde exatamente dentro do laco ele deve ficar?
    #caixa_resposta(20pt)
  ]

  #v(8pt)

  #bug("malloc sem verificar retorno")[
    ```c
    int n = 1000000000;   /* 1 bilhao de inteiros */
    int *v = malloc(n * sizeof(int));
    v[0] = 42;   /* crash se malloc falhou */
    ```
    *a)* Quanto de memoria esse `malloc` tenta alocar em gigabytes?
    `_______`

    *b)* Se `malloc` falhar, o que ele retorna? O que acontece
    na linha seguinte sem a verificacao?
    #caixa_resposta(24pt)

    *c)* Corrija o programa verificando o retorno de `malloc`.
  ]
]

#v(6pt)

#desafio[
  *Vetor de structs alocado dinamicamente*

  Implemente a funcao:
  ```c
  /*
   * Le *n do teclado, aloca um vetor de *n structs Aluno no heap,
   * preenche cada struct e retorna o ponteiro.
   * Retorna NULL em caso de erro de alocacao.
   */
  Aluno *le_turma(int *n);
  ```

  Em `main`: chame `le_turma`, calcule a media da turma, imprima
  os alunos acima da media e libere toda a memoria.

  Por que o parametro `n` e `int *` e nao `int`?
  Que aconteceria se fosse `int`?
]
