// ============================================================
//  Lab 10 — Strings
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 10", author: "Raoni F. S. Teixeira")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 10],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Strings],
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
    Laboratório 10 — Strings
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

  1. calcular o tamanho de buffer necessário para uma string e explicar o papel do terminador `'\0'`; 
  2. percorrer uma string usando o terminador como condição de parada, implementando funções de string do zero; 
  3. distinguir `char s[]` de `char *s` e identificar qual pode ser modificado; (4) usar `strcmp` corretamente para comparar strings, explicando por que `==` não pode ser usado.
  ],
) 


#v(10pt)

// ── Atividade 1 ──────────────────────────────────────────────
#atividade("1", "O terminador e o espaco adicional", "20")[
  *a)* Para cada string abaixo, preencha a tabela indicando o conteudo
  byte a byte, o tamanho do buffer necessario e o que `strlen` retornaria.

  #table(
    columns: (auto, auto, auto, auto),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 7pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
    [*Literal*], [*Bytes armazenados (incluindo terminador)*],
    [*Buffer minimo*], [*`strlen` retorna*],
    [`"ola"`],      [`'o','l','a','\0'`],              [`4`], [`3`],
    [`"UFMT"`],     [],                                [],    [],
    [`"C99"`],      [],                                [],    [],
    [`""`],         [],                                [],    [],
    [`"a"`],        [],                                [],    [],
    [`"ab\ncd"`],   [],                                [],    [],
  )

  *b)* O que e diferente entre `strlen` e o tamanho do buffer declarado?
  Explique com o exemplo `char s[20] = "ola"`:
  #caixa_resposta(32pt)

  *c)* O programa abaixo declara um buffer pequeno demais. Identifique
  o problema *sem executar*, depois compile e observe o que acontece:

  ```c
  char nome[4] = "UFMT";   /* buffer de 4 para string de 4 caracteres */
  printf("%s\n", nome);
  ```

  O que voce esperava? O que aconteceu?
  #caixa_resposta(32pt)

  *d)* Corrija a declaracao e explique a regra geral para dimensionar
  buffers de string:
  #caixa_resposta(24pt)
]

#v(6pt)

// ── Atividade 2 ──────────────────────────────────────────────
#atividade("2", "Implementando funcoes de string do zero", "35")[
  Implemente cada funcao *sem usar nenhuma funcao de `<string.h>`*.
  Use apenas o terminador `'\0'` como referencia de onde a string acaba.

  Para cada funcao, escreva *antes de implementar*:
  - A condicao de parada do laco;
  - O que muda a cada iteracao.

  *Funcao A — `meu_strlen`*

  ```c
  /* Retorna o numero de caracteres antes do '\0' */
  int meu_strlen(char s[]);
  ```

  Condicao de parada: `_______________________________________`
  O que muda: `_______________________________________________`

  Teste: `meu_strlen("algoritmo")` deve retornar `9`.
  `meu_strlen("")` deve retornar `0`.

  #v(6pt)
  *Funcao B — `meu_strcpy`*

  ```c
  /* Copia src para dest, incluindo o '\0'.
   * Pre-cond.: dest tem espaco suficiente para src */
  void meu_strcpy(char dest[], char src[]);
  ```

  Condicao de parada: `_______________________________________`
  O que muda: `_______________________________________________`

  Teste: apos `meu_strcpy(buf, "ola")`, `buf` deve conter `"ola"`.
  Modifique `buf[0]` e verifique que `src` nao foi alterada.

  #v(6pt)
  *Funcao C — `meu_conta_vogais`*

  ```c
  /* Retorna o numero de vogais (a,e,i,o,u maiusculas e minusculas) */
  int meu_conta_vogais(char s[]);
  ```

  Teste: `meu_conta_vogais("Algoritmo")` deve retornar `4`.
  `meu_conta_vogais("bcdfg")` deve retornar `0`.

  #v(6pt)
  *Verificacao final:* escreva um `main` que leia uma palavra com
  `scanf("%49s", s)` e exiba os resultados das tres funcoes.
  Compare `meu_strlen` com `strlen` de `<string.h>` — os valores
  devem ser identicos.

  #destaque[
    Se `meu_strlen` e `strlen` discordarem, ha um bug na sua
    implementacao. Use esse teste como verificacao automatica.
  ]
]

#v(6pt)

// ── Atividade 3 ──────────────────────────────────────────────
#atividade("3", "char[] vs char* — qual pode ser modificado", "20")[
  Execute os trechos abaixo um por vez e registre o que acontece.
  *Nao execute todos juntos* — cada trecho e um experimento separado.

  *Trecho A:*
  ```c
  char buf[] = "ola";
  buf[0] = 'O';
  printf("%s\n", buf);   /* esperado: "Ola" */
  ```
  Resultado: `_______`    Funcionou? `_______`

  #v(6pt)
  *Trecho B:*
  ```c
  char *msg = "ola";
  msg[0] = 'O';           /* tentativa de modificar */
  printf("%s\n", msg);
  ```
  Resultado: `_______`    O que aconteceu?
  #caixa_resposta(24pt)

  #v(6pt)
  *Trecho C:*
  ```c
  char *msg = "ola";
  msg = "OLA";            /* redireciona o ponteiro */
  printf("%s\n", msg);
  ```
  Resultado: `_______`    Por que isso funciona mas o Trecho B nao?
  #caixa_resposta(28pt)

  *a)* Preencha a tabela comparativa:

  #table(
    columns: (auto, 1fr, 1fr),
    stroke: 0.5pt + rgb("#aaa"),
    inset: 8pt,
    fill: (_, row) => if row == 0 { rgb("#eaf0fb") }
                      else if calc.odd(row) { rgb("#f5f5f5") }
                      else { white },
    [*Aspecto*],              [*`char buf[]`*],  [*`char *msg`*],
    [Conteudo modificavel?],  [],                [],
    [Ponteiro redirecionavel?],[],               [],
    [Onde os dados vivem?],   [],                [],
    [Quando usar?],           [],                [],
  )

  *b)* O compilador com `-Wall` emite um aviso para o Trecho B?
  Qual e a mensagem exata?
  #caixa_resposta(24pt)
]

#v(6pt)

// ── Atividade 4 ──────────────────────────────────────────────
#atividade("4", "Caca ao bug — erros classicos com strings", "20")[

  #bug("Comparar strings com ==")[
    ```c
    #include <stdio.h>
    int main() {
        char s1[] = "ola";
        char s2[] = "ola";
        if (s1 == s2)
            printf("iguais\n");
        else
            printf("diferentes\n");
        return 0;
    }
    ```

    *a)* O que voce esperava que imprimisse? O que imprimiu?
    #caixa_resposta(24pt)

    *b)* `s1 == s2` compara o *conteudo* ou os *enderecos*?
    Use `printf("%p %p\n", s1, s2)` para confirmar:
    #caixa_resposta(24pt)

    *c)* Corrija o programa usando `strcmp`. Lembre que `strcmp`
    retorna 0 quando as strings sao iguais.
  ]

  #v(10pt)

  #bug("Buffer overflow em strcpy")[
    ```c
    #include <stdio.h>
    #include <string.h>
    int main() {
        char destino[5];
        strcpy(destino, "algoritmo");   /* "algoritmo" tem 9 caracteres */
        printf("%s\n", destino);
        return 0;
    }
    ```

    *a)* O buffer `destino` tem espaco suficiente? Calcule:
    espaco disponivel = `_______`, espaco necessario = `_______`.

    *b)* O que pode acontecer ao executar?
    #caixa_resposta(24pt)

    *c)* Corrija declarando o buffer com tamanho adequado.
    Como voce determinaria o tamanho correto em geral?
    #caixa_resposta(24pt)
  ]

  #v(10pt)

  #bug("Tres erros num so programa")[
    O programa abaixo tem tres erros envolvendo strings.
    Identifique cada um, explique e corrija.

    ```c
    #include <stdio.h>
    #include <string.h>
    int main() {
        char *s1 = "Ola";
        char s2[3];
        strcpy(s2, s1);
        s1[0] = 'o';
        if (s1 == s2)
            printf("iguais\n");
        return 0;
    }
    ```

    Erro 1 (linha `____`): `_______________________________________`
    Erro 2 (linha `____`): `_______________________________________`
    Erro 3 (linha `____`): `_______________________________________`
  ]
]

#v(6pt)

// ── Desafio ──────────────────────────────────────────────────
#desafio[
  *Verificador de anagrama*

  Duas palavras sao anagramas se contem os mesmos caracteres com as
  mesmas frequencias, em qualquer ordem. Por exemplo: "roma" e "amor",
  "listen" e "silent".

  Implemente `int eh_anagrama(char s1[], char s2[])` que retorna 1
  se `s1` e `s2` sao anagramas e 0 caso contrario. Restricoes:
  - Nao use funcoes de `<string.h>` exceto `strlen`;
  - Nao modifique as strings originais;
  - Trate letras maiusculas e minusculas como equivalentes
    (`'A'` == `'a'`).

  _(Dica: crie um vetor de 26 posicoes — uma para cada letra do
  alfabeto. Para cada letra de `s1` incremente a posicao
  correspondente; para cada letra de `s2` decremente. Se todas as
  posicoes forem zero ao final, as palavras sao anagramas.)_

  Teste com: ("roma", "amor"), ("listen", "silent"),
  ("hello", "world"), ("Ola", "alo").
]
