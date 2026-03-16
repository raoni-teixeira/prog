// ============================================================
//  Lab 13b — Ponteiros Avançados
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 13b", author: "Raoni F. S. Teixeira")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 13b],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Ponteiros Avançados],
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
    Laboratório 13b — Ponteiros Avançados
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

  1. declarar e usar ponteiros para ponteiro (`**`) para modificar  um ponteiro do chamador; 
  2. representar e percorrer um vetor de strings como `char **`; 
  3. interpretar `argc` e `argv` e acessar argumentos de linha de comando; 
  4. ler declarações complexas de ponteiros identificando o tipo resultante.
  ],
) 



#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Ponteiro para ponteiro — diagrama e previsao", "25")[
  Leia o programa abaixo *sem executar* e responda.

  ```c
  int x = 10, y = 20;
  int *p  = &x;
  int **pp = &p;

  printf("x=%d  *p=%d  **pp=%d\n", x, *p, **pp);

  *pp = &y;        /* (A) */
  printf("x=%d  y=%d  *p=%d\n", x, y, *p);

  **pp = 99;       /* (B) */
  printf("x=%d  y=%d  *p=%d\n", x, y, *p);
  ```

  *a)* Preencha o diagrama de memoria antes da linha (A),
  usando enderecos fictícios: `x` em 1000, `y` em 1004,
  `p` em 2000, `pp` em 3000:

  #table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 10pt,
    align: center,
    fill: (col, _) =>
      (rgb("#eaf0fb"), rgb("#ddeaf9"), rgb("#e8f5e9"), rgb("#fde8f0")).at(col, default: white),
    [*`x`*\ end:1000\ val:__],
    [*`y`*\ end:1004\ val:__],
    [*`p`*\ end:2000\ val:__],
    [*`pp`*\ end:3000\ val:__],
  )

  *b)* Apos a linha (A) `*pp = &y`, o que mudou no diagrama?
  Qual variavel foi modificada — `x`, `y`, `p` ou `pp`?
  #caixa_resposta(28pt)

  *c)* Apos a linha (B) `**pp = 99`, qual variavel vale 99?
  Rastreie: `pp` aponta para `p`; `p` agora aponta para `y`;
  logo `**pp` acessa `_______`.
  #caixa_resposta(20pt)

  *d)* Preveja as tres linhas de saida e compile para verificar:

  Linha 1: `_____________________________________________`

  Linha 2: `_____________________________________________`

  Linha 3: `_____________________________________________`
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "O problema que motivou ponteiro para ponteiro", "20")[
  Retomando o Lab 13a: uma funcao que aloca memoria e precisa
  devolver o ponteiro ao chamador.

  *Versao incorreta — passagem por valor do ponteiro:*
  ```c
  void aloca_errado(int *v, int n) {
      v = malloc(n * sizeof(int));   /* modifica copia local */
  }

  int main() {
      int *vetor = NULL;
      aloca_errado(vetor, 10);
      printf("%p\n", (void*)vetor);   /* ainda NULL */
      return 0;
  }
  ```

  *a)* Por que `vetor` continua `NULL` apos `aloca_errado`?
  Use o modelo de frames para explicar:
  #caixa_resposta(32pt)

  *b)* Corrija usando `int **v`:
  ```c
  void aloca_certo(int **v, int n) {
      *v = /* ? */;
  }

  int main() {
      int *vetor = NULL;
      aloca_certo(/* ? */, 10);
      /* vetor agora aponta para bloco alocado */
      vetor[0] = 42;
      printf("%d\n", vetor[0]);
      free(vetor);
      return 0;
  }
  ```

  Complete os dois trechos `/* ? */` e explique cada escolha:
  #caixa_resposta(36pt)
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "Vetor de strings e argc/argv", "35")[
  *Parte A — percorrendo um vetor de strings:*

  ```c
  char *frutas[] = {"maca", "banana", "laranja", "uva", NULL};
  ```

  O `NULL` no final funciona como sentinela — o mesmo papel do
  `'\0'` numa string.

  *a)* Escreva dois lacos equivalentes para imprimir todas as frutas:
  um usando indice inteiro e outro usando o sentinela `NULL`:

  ```c
  /* Versao 1: indice */
  int n = 4;
  for (int i = 0; i < n; i++)
      printf("%s\n", frutas[i]);

  /* Versao 2: sentinela — complete */
  for (int i = 0; /* ? */; i++)
      printf("%s\n", frutas[i]);
  ```

  *b)* `frutas[2][3]` acessa qual caractere de qual string?
  `_______` Verifique com `printf("%c\n", frutas[2][3])`.

  *c)* Escreva uma funcao `int total_chars(char *v[], int n)` que
  retorna o total de caracteres em todas as strings do vetor
  (sem contar os terminadores). Para `frutas`, o resultado
  esperado e: `4 + 6 + 7 + 3 = 20`.

  #v(8pt)
  *Parte B — argumentos de linha de comando:*

  Implemente o programa abaixo e execute com diferentes argumentos:

  ```c
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>

  int main(int argc, char *argv[]) {
      if (argc < 2) {
          printf("Uso: %s palavra1 palavra2 ...\n", argv[0]);
          return 1;
      }

      printf("Programa: %s\n", argv[0]);
      printf("Argumentos: %d\n", argc - 1);

      /* imprime cada argumento com seu comprimento */
      for (int i = 1; i < argc; i++)
          printf("  argv[%d] = \"%s\" (len=%d)\n",
                 i, argv[i], (int)strlen(argv[i]));

      /* encontra o argumento mais longo */
      int maior = 1;
      for (int i = 2; i < argc; i++)
          if (strlen(argv[i]) > strlen(argv[maior]))
              maior = i;
      printf("Mais longo: \"%s\"\n", argv[maior]);

      return 0;
  }
  ```

  Execute com: `./prog ola mundo algoritmo C`

  Saida obtida:
  #caixa_resposta(56pt)

  *d)* `argv[argc]` e garantidamente `NULL` pelo padrao C.
  Reescreva o laco principal usando esse sentinela em vez
  de `argc`:
  #caixa_resposta(36pt)
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Lendo declaracoes complexas", "15")[
  Para cada declaracao abaixo, escreva em portugues o que ela declara.
  Aplique a regra: leia o nome, va para a direita (`[]`, `()`
  tem prioridade), depois para a esquerda (`*`).

  #table(
    columns: (auto, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 8pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Declaracao*], [*Leitura em portugues*],
    [`int *p`],         [`p` e ponteiro para `int`],
    [`int *v[]`],       [],
    [`int **pp`],       [],
    [`char *argv[]`],   [],
    [`void (*f)(int)`], [],
    [`int *(*g)(int)`], [],
  )

  *a)* Qual das declaracoes acima descreve o tipo de `argv`
  em `main`? `_______`

  *b)* `int *v[]` e `int **v` sao equivalentes quando usados
  como parametro de funcao. Verifique compilando:
  ```c
  void f(int *v[], int n)  { printf("%d\n", v[0][0]); }
  void g(int **v,  int n)  { printf("%d\n", v[0][0]); }
  ```
  As duas funcoes aceitam o mesmo argumento? Teste com um
  vetor de ponteiros para inteiros.
]

#v(6pt)

#desafio[
  *Vetor de strings alocado dinamicamente e ordenado*

  Escreva as funcoes:
  ```c
  /* Aloca vetor de n strings, le cada uma do teclado */
  char **le_palavras(int n);

  /* Libera vetor de n strings alocado por le_palavras */
  void libera_palavras(char **v, int n);

  /* Ordena v[0..n-1] lexicograficamente (selecao direta) */
  void ordena_palavras(char **v, int n);
  ```

  Em `main`: leia `n`, chame `le_palavras`, ordene, imprima
  e libere. A ordenacao troca *ponteiros*, nao conteudo —
  explique por que isso funciona e por que e eficiente.

  Teste com: `ola`, `mundo`, `algoritmo`, `C`, `ponteiro`.
  Resultado esperado em ordem: `C`, `algoritmo`, `mundo`,
  `ola`, `ponteiro`.
]
