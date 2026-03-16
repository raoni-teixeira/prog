// ============================================================
//  Lab 12 — Structs
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 12", author: "Raoni F. S. Teixeira")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 12],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Structs],
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
    Laboratório 12 — Structs
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

  1. declarar structs com typedef e acessar campos com `.` e `->`,   escolhendo o operador correto conforme o contexto; 
  2. substituir vetores paralelos por um vetor de structs, justificando a vantagem;
  3. passar structs para funções por valor e por ponteiro, identificando quando cada abordagem é preferível; 
  4. declarar e acessar structs aninhadas encadeando operadores de acesso.
  ],
) 

#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "Anatomia da struct — acesso com . e ->", "20")[
  Leia o código abaixo e responda *sem executar*.

  ```c
  typedef struct {
      char  nome[50];
      int   matricula;
      float media;
  } Aluno;

  void imprime(Aluno a) {
      printf("%s (%d): %.1f\n", a.nome, a.matricula, a.media);
  }

  void aplica_bonus(Aluno *a, float bonus) {
      a->media += bonus;
      if (a->media > 10.0) a->media = 10.0;
  }
  ```

  *a)* Complete a tabela indicando qual operador usar em cada contexto:

  #table(
    columns: (1fr, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 8pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Contexto*], [*Operador*], [*Por que*],
    [Acessar `media` tendo uma variavel `Aluno a`],     [`.`],  [acesso direto ao campo],
    [Acessar `media` tendo um ponteiro `Aluno *p`],    [`->`], [desreferencia + acesso],
    [Acessar `matricula` em `imprime(a)`],              [],     [],
    [Acessar `nome` em `aplica_bonus(a, b)`],           [],     [],
    [Acessar `media` em `Aluno turma[10]`, posicao `i`],[],     [],
  )

  *b)* `a->media` e `(*a).media` sao equivalentes. Por que a forma
  com `->` e preferida?
  #caixa_resposta(24pt)

  *c)* Em `imprime`, a struct e passada por valor. Se voce modificar
  `a.media` dentro de `imprime`, o valor em `main` muda? Por que?
  #caixa_resposta(24pt)

  *d)* Escreva uma inicializacao valida de um `Aluno` usando lista:
  ```c
  Aluno a1 = /* ? */;
  ```
  #caixa_resposta(20pt)
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "Vetores paralelos vs. vetor de structs", "30")[
  O programa abaixo usa tres vetores paralelos para armazenar dados
  de alunos. Sua tarefa e reescreve-lo usando um vetor de structs.

  ```c
  #include <stdio.h>
  #define MAX 50

  int main() {
      char  nomes[MAX][100];
      int   matriculas[MAX];
      float medias[MAX];
      int   n;

      printf("Quantos alunos? ");
      scanf("%d", &n);

      for (int i = 0; i < n; i++) {
          printf("Nome: ");
          scanf("%99s", nomes[i]);
          printf("Matricula: ");
          scanf("%d", &matriculas[i]);
          printf("Media: ");
          scanf("%f", &medias[i]);
      }

      /* encontra o melhor aluno */
      int idx = 0;
      for (int i = 1; i < n; i++)
          if (medias[i] > medias[idx]) idx = i;

      printf("Melhor: %s (%.1f)\n", nomes[idx], medias[idx]);
      return 0;
  }
  ```

  *a)* Declare um `typedef struct` chamado `Aluno` com os campos
  `nome[100]`, `matricula` e `media`. Reescreva o programa usando
  `Aluno turma[MAX]`.

  *b)* Organize em funcoes:
  ```c
  void le_aluno(Aluno *a);
  void le_turma(Aluno turma[], int n);
  int  indice_melhor(Aluno turma[], int n);
  void imprime_turma(Aluno turma[], int n);
  ```

  *c)* Compile e teste com 3 alunos. Verifique que o comportamento
  e identico ao programa original.

  *d)* Qual e a principal vantagem do vetor de structs sobre os
  vetores paralelos? Descreva um cenario em que os vetores paralelos
  causariam um bug dificil de encontrar:
  #caixa_resposta(36pt)

  *e)* Na funcao `le_aluno`, por que o parametro e `Aluno *a` (ponteiro)
  em vez de `Aluno a` (valor)?
  #caixa_resposta(24pt)
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "Structs aninhadas", "25")[
  Declare as structs abaixo e implemente as funcoes pedidas.

  ```c
  typedef struct {
      int dia;
      int mes;
      int ano;
  } Data;

  typedef struct {
      char  nome[100];
      int   matricula;
      float media;
      Data  nascimento;
  } Aluno;
  ```

  *a)* Escreva o acesso correto para cada campo a partir de um
  `Aluno a` e de um ponteiro `Aluno *p`:

  #table(
    columns: (auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 8pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Campo*], [*Via `Aluno a`*], [*Via `Aluno *p`*],
    [nome],         [`a.nome`],                [`p->nome`],
    [matricula],    [],                        [],
    [media],        [],                        [],
    [dia do nasc.], [`a.nascimento.dia`],      [],
    [mes do nasc.], [],                        [`p->nascimento.mes`],
    [ano do nasc.], [],                        [],
  )

  *b)* Implemente:
  ```c
  /* Retorna a idade em anos completos dado o ano atual */
  int idade(Data nasc, int ano_atual);

  /* Le os dados de um aluno do teclado, incluindo nascimento */
  void le_aluno_completo(Aluno *a);

  /* Imprime nome, matricula, media e idade */
  void imprime_aluno_completo(Aluno a, int ano_atual);
  ```

  *c)* Teste com um aluno nascido em 15/03/2005. Para ano atual = 2025,
  a idade deve ser 20. Para ano atual = 2024, deve ser 19.
  _(Dica: `idade` deve considerar se o aniversario ja passou no ano
  atual ou nao — use `mes` e `dia` para isso.)_

  *d)* Uma funcao pode retornar uma struct diretamente em C:
  ```c
  Data cria_data(int dia, int mes, int ano) {
      Data d;
      d.dia = dia; d.mes = mes; d.ano = ano;
      return d;
  }
  ```
  Isso copia todos os campos. Quando isso e eficiente e quando
  seria melhor retornar um ponteiro?
  #caixa_resposta(28pt)
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Caca ao bug — dois problemas com structs", "20")[

  #bug("Atribuir string com = em vez de strcpy")[
    ```c
    #include <stdio.h>
    #include <string.h>

    typedef struct {
        char nome[50];
        int  codigo;
    } Produto;

    int main() {
        Produto p;
        p.nome = "Arroz";   /* bug */
        p.codigo = 101;
        printf("%s %d\n", p.nome, p.codigo);
        return 0;
    }
    ```

    *a)* Qual e a mensagem de erro do compilador?
    #caixa_resposta(24pt)

    *b)* Por que `p.nome = "Arroz"` nao funciona mas
    `p.codigo = 101` funciona?
    #caixa_resposta(28pt)

    *c)* Corrija usando `strcpy`. Qual e o tamanho maximo de nome
    que o buffer suporta?
    #caixa_resposta(20pt)
  ]

  #v(10pt)

  #bug("Usar . em vez de -> com ponteiro")[
    ```c
    #include <stdio.h>

    typedef struct { float x; float y; } Ponto;

    float distancia_origem(Ponto *p) {
        return p.x * p.x + p.y * p.y;   /* bug */
    }

    int main() {
        Ponto pt = {3.0, 4.0};
        printf("%.1f\n", distancia_origem(&pt));
        return 0;
    }
    ```

    *a)* Qual e a mensagem de erro do compilador?
    #caixa_resposta(20pt)

    *b)* Corrija o programa. O resultado para `(3.0, 4.0)` deve
    ser `25.0` (distancia ao quadrado) ou `5.0` (distancia)?
    Verifique e ajuste a funcao se necessario.
    #caixa_resposta(28pt)
  ]
]

#v(6pt)

#desafio[
  *Ordenacao de turma por media*

  Adicione ao programa da Atividade 2 uma funcao:
  ```c
  void ordena_por_media(Aluno turma[], int n);
  ```
  que ordena o vetor em ordem decrescente de media usando selecao
  direta: encontre o maior, troque com o primeiro; depois o segundo
  maior com o segundo; e assim por diante.

  Observe que trocar dois alunos e uma unica atribuicao de struct:
  ```c
  Aluno temp = turma[i];
  turma[i]   = turma[j];
  turma[j]   = temp;
  ```
  Por que isso funciona sem precisar trocar campo a campo?

  Teste com 5 alunos em ordem aleatoria e verifique que apos a
  ordenacao as medias estao em ordem decrescente.
]
