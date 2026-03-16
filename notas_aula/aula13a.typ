// ============================================================
//  Introdução a Algoritmos — Aula 13a (nova)
//  Raoni F. S. Teixeira
// ============================================================

#set document(title: "Aula 13a – Modelo de Memória e Alocação Dinâmica",
              author: "Raoni F. S. Teixeira")

#let azul     = rgb("#003366")
#let destaque = rgb("#1a6bad")
#let cinza    = luma(245)
#let vermelho = rgb("#b04020")
#let verde    = rgb("#1a6b1a")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.2cm),
  header: [
    #set text(size: 8pt, fill: luma(120))
    #grid(
      columns: (1fr, 1fr),
      align(left)[Programação de Computadores],
      align(right)[Aula 13],
    )
    #line(length: 100%, stroke: 0.4pt + luma(180))
  ],
  footer: [
    #line(length: 100%, stroke: 0.4pt + luma(180))
    #set text(size: 8pt, fill: luma(120))
    #grid(
      columns: (1fr, 1fr),
      align(left)[Raoni F. S. Teixeira],
    )
  ],
)

#show heading: set block(below: 2em)

// ---------- tipografia ----------
#set text(font: "Linux Libertine", size: 11pt)
#set par(justify: true, leading: 0.65em)
#set heading(numbering: "1.1")


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

#let complexidade(corpo) = block(
  fill: rgb("#e8f5e9"), stroke: (left: 3pt + rgb("#2e7d32")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#2e7d32"))[Complexidade] \ #corpo]

// ============================================================
//  CAPA DA AULA
// ============================================================
#block(
  width: 100%,
  fill: azul,
  inset: (x: 16pt, y: 20pt),
  radius: 4pt,
)[
  \
  #text(fill: white, size: 18pt, weight: "bold")[Introdução a Algoritmos]
  \
  #text(fill: rgb("#aaccee"), size: 12pt)[#title()]
  \
  #v(4pt)
  #text(fill: luma(200), size: 9pt)[Raoni F. S. Teixeira · 1s/2026]
]

#v(0.8em)


// ── Macros de ambiente ───────────────────────────────────────

#let definicao(titulo, corpo) = block(
  fill: rgb("#eaf0fb"),
  stroke: (left: 3pt + rgb("#1a3a5c")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt,
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#1a3a5c"))[Definição — #titulo] \
  #corpo
]

#let destaque(corpo) = block(
  fill: rgb("#fff8e1"),
  stroke: (left: 3pt + rgb("#e6a817")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt,
  width: 100%,
)[#corpo]

#let exemplo(titulo, corpo) = block(
  fill: rgb("#f0faf0"),
  stroke: (left: 3pt + rgb("#2e7d32")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt,
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#2e7d32"))[Exemplo — #titulo] \
  #corpo
]

#let atencao(corpo) = block(
  fill: rgb("#fdecea"),
  stroke: (left: 3pt + rgb("#c62828")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt,
  width: 100%,
)[
  #text(weight: "bold", fill: rgb("#c62828"))[Atenção] \
  #corpo
]
#let mesa(corpo) = block(
  fill: rgb("#f5f0ff"), stroke: (left: 3pt + rgb("#6a1b9a")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#6a1b9a"))[Teste de Mesa] \ #corpo]

#let experimento(titulo, corpo) = block(
  fill: rgb("#fff0f6"), stroke: (left: 3pt + rgb("#ad1457")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#ad1457"))[Experimento — #titulo] \ #corpo]

 
// ---------- ambientes ----------
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
#let resolvido(corpo) = block(
  fill: rgb("#f3e5f5"), stroke: (left: 3pt + rgb("#6a1b9a")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#6a1b9a"))[Ponta resolvida] \ #corpo]

#let pontafio(corpo) = block(
  fill: rgb("#f3e5f5"), stroke: (left: 3pt + rgb("#6a1b9a")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#6a1b9a"))[Ponta do fio] \ #corpo]

#caixa(
  "Objetivos desta aula",
  rgb("#555555"),
  cinza,
  [
    Ao final desta aula, você deverá ser capaz de:

    1. Descrever os quatro segmentos de memória de um processo (código,
       dados, stack, heap) e classificar qualquer variável no segmento
       correto conforme sua declaração;
    2. Explicar o mecanismo de frames da stack e por que variáveis locais
       deixam de existir após o retorno da função que as criou;
    3. Alocar e liberar memória no heap com malloc, calloc e free,
       verificando o retorno de malloc antes de usar o ponteiro;
    4. Identificar os três erros fatais com memória dinâmica: uso após
       free, double-free e vazamento de memória.
  ],
)

#v(0.5em)

// ============================================================
= Pontas soltas
// ============================================================

Ao longo do curso, deixamos algumas afirmações sem explicação completa:

- Na Aula 8: "variáveis locais são destruídas quando a função retorna".
  Por quê? O que significa "destruídas"?
- Na Aula 10: "`char *s = \"texto\"` aponta para memória somente-leitura".
  Que memória é essa? Por que é somente-leitura?
- Na Aula 9: "nunca retorne o endereço de uma variável local". Por que
  exatamente isso é perigoso?

Todas essas respostas dependem do mesmo modelo: como a memória de um
processo é organizada. Esta aula constrói esse modelo do zero.

// ============================================================
= Os segmentos de um processo
// ============================================================

Quando o sistema operacional carrega um programa para execução, ele organiza
a memória do processo em regiões com propósitos distintos. Em sistemas Unix
(Linux, macOS) e Windows, a organização clássica tem quatro segmentos principais:

#block(
  fill: rgb("#f5f5f5"),
  stroke: 0.5pt + rgb("#999"),
  inset: 0pt, radius: 4pt, width: 100%,
)[
  #table(
    columns: (auto, 1fr, 1fr),
    stroke: 0.5pt + rgb("#ccc"),
    inset: 10pt,
    fill: (col, row) =>
      if row == 0 { rgb("#1a3a5c") }
      else if row == 1 { rgb("#fde8d8") }
      else if row == 2 { rgb("#ddeaf9") }
      else if row == 3 { rgb("#e8f5e9") }
      else { rgb("#f3e5f5") },
    [#text(fill:white,weight:"bold")[Segmento]],
    [#text(fill:white,weight:"bold")[O que contém]],
    [#text(fill:white,weight:"bold")[Características]],
    [*Código* (text)],
      [Instruções do programa compilado; literais de string],
      [Somente-leitura; tamanho fixo em tempo de compilação],
    [*Dados* (data/bss)],
      [Variáveis globais e estáticas inicializadas e não-inicializadas],
      [Leitura e escrita; tamanho fixo em tempo de compilação],
    [*Stack* (pilha)],
      [Variáveis locais, parâmetros de função, endereços de retorno],
      [Gerenciado automaticamente; cresce e encolhe com chamadas de função],
    [*Heap*],
      [Memória alocada dinamicamente pelo programa],
      [Gerenciado pelo programador; tamanho determinado em tempo de execução],
  )
]

#v(6pt)

Visualizando o espaço de endereços de um processo (endereços crescem para cima):

#block(
  fill: rgb("#f5f5f5"),
  stroke: 0.5pt + rgb("#999"),
  inset: 12pt, radius: 4pt, width: 60%,
)[
  #set text(size: 10pt)
  #set align(center)
  #table(
    columns: (1fr,),
    stroke: 0.5pt + rgb("#888"),
    inset: 8pt,
    fill: (_, row) =>
      if row == 0 { rgb("#f3e5f5") }
      else if row == 1 { rgb("#e8f5e9") }
      else if row == 2 { rgb("#ddeaf9") }
      else { rgb("#fde8d8") },
    [*Stack* (cresce para baixo ↓)],
    [*Heap* (cresce para cima ↑)],
    [*Dados* (globais/estáticas)],
    [*Código* (somente-leitura)],
  )
  #v(4pt)
  _Endereços baixos na base; altos no topo._
]

// ============================================================
= O segmento de código e os literais de string
// ============================================================

O segmento de código contém as instruções geradas pelo compilador — os bytes
que o processador executa. Junto com as instruções, o compilador armazena
nesse segmento os *literais de string* que aparecem no código-fonte.

Quando você escreve:

```c
char *msg = "Erro: valor invalido";
```

O compilador coloca a sequência de bytes `E r r o : ...` no segmento de
código, e `msg` recebe o endereço desse local. O sistema operacional mapeia
o segmento de código como *somente-leitura* — por razões de segurança
(impede que o programa sobrescreva suas próprias instruções) e eficiência
(múltiplos processos podem compartilhar o mesmo segmento).

#resolvido[
  *A ponta solta da Aula 10:* agora sabemos por que `char *s = "texto"`
  aponta para memória somente-leitura — o literal `"texto"` vive no
  segmento de código, que o sistema operacional protege contra escrita.
  Tentar `s[0] = 'T'` tenta escrever nesse segmento protegido — o que
  causa uma violação de acesso imediata.

  `char buf[] = "texto"` é diferente: o compilador *copia* os bytes do
  segmento de código para um buffer na stack local, e esse buffer é
  modificável normalmente.
]

// ============================================================
= A stack: memória automática
// ============================================================

A stack (pilha) é a região onde vivem as variáveis locais e os parâmetros
de função. Ela é gerenciada automaticamente pelo compilador, seguindo um
mecanismo simples: cada chamada de função empilha um *frame* (quadro)
contendo suas variáveis locais; quando a função retorna, o frame é
desempilhado.

== Como a stack funciona

Considere o seguinte código:

```c
int dobro(int x) {
    int resultado = x * 2;   /* (B) frame de dobro: x, resultado */
    return resultado;
}

int main() {
    int a = 5;               /* (A) frame de main: a, b */
    int b = dobro(a);        /* chama dobro */
    printf("%d\n", b);       /* (C) volta para main */
    return 0;
}
```

O estado da stack em cada momento:

#block(
  fill: rgb("#f5f5f5"),
  stroke: 0.5pt + rgb("#999"),
  inset: 12pt, radius: 4pt, width: 100%,
)[
  #set text(size: 10pt)
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 12pt,
    block(stroke: 0.5pt + rgb("#aaa"), inset: 8pt, radius: 3pt, width: 100%)[
      *(A) Durante main, antes da chamada*\
      #v(4pt)
      #table(columns: (1fr,), stroke: 0.5pt + rgb("#888"), inset: 6pt,
        fill: (_, row) => if row <= 1 { rgb("#ddeaf9") } else { white },
        [`a = 5`], [`b = ?`],
        [_frame de main_],
      )
    ],
    block(stroke: 0.5pt + rgb("#aaa"), inset: 8pt, radius: 3pt, width: 100%)[
      *(B) Durante dobro*\
      #v(4pt)
      #table(columns: (1fr,), stroke: 0.5pt + rgb("#888"), inset: 6pt,
        fill: (_, row) => if row <= 1 { rgb("#e8f5e9") } else { rgb("#ddeaf9") },
        [`x = 5`], [`resultado = 10`],
        [_frame de dobro_],
        [`a = 5`], [`b = ?`],
        [_frame de main_],
      )
    ],
    block(stroke: 0.5pt + rgb("#aaa"), inset: 8pt, radius: 3pt, width: 100%)[
      *(C) Após retorno*\
      #v(4pt)
      #table(columns: (1fr,), stroke: 0.5pt + rgb("#888"), inset: 6pt,
        fill: (_, row) => if row <= 1 { rgb("#ddeaf9") } else { white },
        [`a = 5`], [`b = 10`],
        [_frame de main_],
        [_frame de dobro\ destruído_],
      )
    ],
  )
]

Quando `dobro` retorna, seu frame é simplesmente descartado — o ponteiro
da stack volta para a posição anterior. As variáveis `x` e `resultado`
continuam nos mesmos bytes de memória por um instante, mas aquela região
está agora disponível para ser reutilizada pela próxima chamada de função.

#resolvido[
  *A ponta solta da Aula 8:* "nunca retorne o endereço de uma variável
  local" — porque o frame da função é destruído no retorno. O endereço
  aponta para bytes que serão sobreescritos pela próxima chamada.

  ```c
  int *perigo() {
      int x = 42;
      return &x;    /* x vive no frame de perigo — sera destruido */
  }
  int *p = perigo();
  printf("%d\n", *p);   /* comportamento indefinido: frame ja reutilizado */
  ```
]

== Limites da stack

A stack tem tamanho fixo (tipicamente 1–8 MB em sistemas modernos). Declarar
arrays grandes como variáveis locais pode esgotar a stack:

```c
void f() {
    int matriz[10000][10000];   /* 400 MB na stack — stack overflow! */
}
```

Para dados grandes, a solução é o heap.

// ============================================================
= O heap: memória dinâmica
// ============================================================

O heap é a região de memória que o programa controla explicitamente:
solicita blocos quando precisa e os libera quando termina. Isso resolve
dois problemas que a stack não resolve:

+ *Tamanho desconhecido em tempo de compilação* — "quantos alunos?" só
  é sabido em tempo de execução.
+ *Tempo de vida independente de funções* — dados que precisam sobreviver
  além do retorno da função que os criou.

== malloc e calloc

A função `malloc` (memory allocate) reserva um bloco de bytes no heap e
retorna um ponteiro para ele:

```c
#include <stdlib.h>

int *v = malloc(n * sizeof(int));   /* aloca espaco para n inteiros */
```

`malloc` retorna `void *` — um ponteiro genérico que C converte
automaticamente para qualquer tipo de ponteiro. Se a alocação falhar
(memória insuficiente), retorna `NULL`.

`calloc` faz o mesmo, mas *inicializa todos os bytes com zero*:

```c
int *v = calloc(n, sizeof(int));   /* aloca e zera */
```

A diferença: `malloc(n * sizeof(int))` e `calloc(n, sizeof(int))` alocam
o mesmo espaço, mas o segundo garante que todos os elementos começam em 0.

*Verificar o retorno é obrigatório:*

```c
int *v = malloc(n * sizeof(int));
if (v == NULL) {
    fprintf(stderr, "Erro: memoria insuficiente\n");
    return 1;
}
```

== free: devolver a memória

Toda memória alocada com `malloc` ou `calloc` deve ser liberada com `free`
quando não for mais necessária:

```c
free(v);
v = NULL;   /* boa pratica: evita usar o ponteiro apos liberar */
```

`free` informa ao sistema operacional que aquele bloco está disponível
para reutilização. Não liberar memória causa *vazamento de memória*
(memory leak): o processo acumula blocos inutilizados até esgotar a memória
disponível.

#atencao[
  Três erros fatais com o heap:

  + *Usar memória após liberar* (use-after-free): `free(v); v[0] = 1;`
    — comportamento indefinido, frequentemente causa crash ou corrupção.
  + *Liberar duas vezes* (double-free): `free(v); free(v);`
    — corrompe as estruturas internas do alocador.
  + *Não liberar* (memory leak): em programas longos, acumula memória
    até o sistema matar o processo.

  Por isso, atribuir `NULL` ao ponteiro após `free` é boa prática: um
  segundo `free(NULL)` é inofensivo, e `NULL` é fácil de detectar.
]

// ============================================================
= Usando malloc na prática
// ============================================================

== Vetor de tamanho dinâmico

```c
#include <stdio.h>
#include <stdlib.h>

int main() {
    int n;
    printf("Quantos elementos? ");
    scanf("%d", &n);

    /* aloca n inteiros no heap */
    int *v = malloc(n * sizeof(int));
    if (v == NULL) { fprintf(stderr, "Sem memoria\n"); return 1; }

    for (int i = 0; i < n; i++)
        scanf("%d", &v[i]);         /* v[i] funciona igual a um array */

    int soma = 0;
    for (int i = 0; i < n; i++)
        soma += v[i];

    printf("Soma: %d\n", soma);

    free(v);     /* devolve a memoria ao sistema */
    v = NULL;
    return 0;
}
```

`v[i]` funciona exatamente como em um array estático — porque `v` é um
ponteiro para o primeiro elemento, e `v[i]` é `*(v + i)`, como vimos na
Aula 9. A única diferença é onde a memória vive (heap vs. stack) e quem
gerencia seu tempo de vida (programador vs. compilador).

== Struct alocada dinamicamente

```c
typedef struct { char nome[100]; float media; } Aluno;

Aluno *cria_aluno(char *nome, float media) {
    Aluno *a = malloc(sizeof(Aluno));
    if (a == NULL) return NULL;
    strncpy(a->nome, nome, 99);
    a->nome[99] = '\0';
    a->media = media;
    return a;    /* seguro: a memoria vive no heap, nao no frame desta funcao */
}

int main() {
    Aluno *a = cria_aluno("Maria", 8.5);
    if (a != NULL) {
        printf("%s: %.1f\n", a->nome, a->media);
        free(a);
    }
    return 0;
}
```

`cria_aluno` retorna um ponteiro para o heap — seguro, porque a memória
no heap sobrevive ao retorno da função. Contraste com retornar `&local`:
a variável local estaria na stack e seria destruída.

// ============================================================
= Resumo: onde vive cada dado
// ============================================================

#block(
  fill: rgb("#f5f5f5"),
  stroke: 0.5pt + rgb("#999"),
  inset: 12pt, radius: 4pt, width: 100%,
)[
  #table(
    columns: (1fr, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 8pt,
    fill: (col, row) => if row == 0 { rgb("#1a3a5c") }
                        else if calc.odd(row) { rgb("#f5f5f5") }
                        else { white },
    [#text(fill:white,weight:"bold")[Declaração]],
    [#text(fill:white,weight:"bold")[Segmento]],
    [#text(fill:white,weight:"bold")[Tempo de vida]],
    [#text(fill:white,weight:"bold")[Gerenciado por]],
    [`int x = 5;` (dentro de função)],   [Stack],  [Duração da função],      [Compilador],
    [`int x = 5;` (fora de função)],     [Dados],  [Duração do programa],    [Compilador],
    [`static int x = 5;`],               [Dados],  [Duração do programa],    [Compilador],
    [`char *s = "texto";`],              [Código], [Duração do programa],    [Compilador (somente-leitura)],
    [`malloc(n * sizeof(int))`],         [Heap],   [Até `free()` ser chamado], [Programador],
  )
]

// ============================================================
= Exercícios
// ============================================================

+ Explique o que está errado em cada trecho e o que pode acontecer
  em tempo de execução:

  *a)*
  ```c
  int *aloca_vetor(int n) {
      int v[100];
      return v;
  }
  ```

  *b)*
  ```c
  int *v = malloc(10 * sizeof(int));
  free(v);
  v[0] = 42;
  ```

  *c)*
  ```c
  char *s = "Ola";
  s[0] = 'o';
  ```

+ Reescreva a função do item (a) corretamente, usando `malloc`. Quem
  é responsável por chamar `free` no ponteiro retornado?

+ Escreva uma função `float *le_vetor(int n)` que aloca um vetor de
  `n` floats no heap, lê `n` valores do teclado e retorna o ponteiro.
  Escreva `main` de forma que: (a) chame `le_vetor`; (b) calcule e
  imprima a média; (c) libere a memória corretamente.

+ _(Desafio)_ Escreva uma função
  `Aluno *le_turma(int *n)` que: (a) leia `*n` do teclado; (b) aloque
  um vetor de `*n` structs `Aluno` no heap; (c) preencha cada struct;
  (d) retorne o ponteiro. Em `main`, use o vetor, depois libere. Por que
  o parâmetro `n` é `int *` e não `int`?
