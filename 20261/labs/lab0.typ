// ============================================================
//  Lab 0 — O Processo de Compilação em C
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Lab 0", author: "Raoni F. S. Teixeira")
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* — Laboratório 0],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [O Processo de Compilação em C],
      align(right)[#context counter(page).display("1")])
  ]
)

#set text(font: "Linux Libertine", size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.75em)
#set heading(numbering: "1.")

// ── Macros ───────────────────────────────────────────────────

#let destaque(corpo) = block(
  fill: rgb("#fff8e1"), stroke: (left: 3pt + rgb("#e6a817")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#corpo]

#let atencao(corpo) = block(
  fill: rgb("#fdecea"), stroke: (left: 3pt + rgb("#c62828")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#c62828"))[Atenção] \ #corpo]

#let passo(num, titulo, corpo) = block(
  width: 100%, inset: 0pt, spacing: 0.8em,
)[
  #block(
    fill: rgb("#1a3a5c"),
    inset: (x: 10pt, y: 6pt),
    radius: (top: 3pt),
    width: 100%,
  )[
    #grid(
      columns: (auto, 1fr),
      gutter: 8pt,
      block(
        fill: rgb("#e6a817"),
        inset: (x: 7pt, y: 3pt),
        radius: 2pt,
      )[#text(weight: "bold", fill: rgb("#1a3a5c"), size: 10pt)[Fase #num]],
      text(fill: white, weight: "bold")[#titulo],
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

#let caixa_resposta(altura) = block(
  width: 100%, height: altura,
  stroke: 0.5pt + rgb("#999"),
  radius: 2pt, inset: 6pt,
)[]

// ── Título ───────────────────────────────────────────────────

#align(center)[
  #text(size: 15pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Laboratório 0 — O Processo de Compilação em C
  ]
  #v(2pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Duração: 2 horas  |  Trabalho individual  |  Sem entrega formal — registre suas observações neste roteiro
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

   1. descrever as quatro fases do processo de compilação em C e o papel   de cada uma; 
  2. compilar e executar programas usando compilador online,   GCC no terminal e CodeBlocks; 
  3. ler e interpretar mensagens de erro do   compilador, localizando a linha e a causa do problema; 
  4. explicar o que   é o linker e por que ele é necessário.
  ],
)





#v(10pt)

// ============================================================
= Do texto ao executável: uma visão geral
// ============================================================

Quando você escreve um programa em C e aperta "compilar", parece que um
único passo transforma seu código num executável. Na realidade, acontecem
*quatro fases* distintas, cada uma produzindo um tipo diferente de arquivo:

#v(6pt)

#block(
  fill: rgb("#f5f5f5"), stroke: 0.5pt + rgb("#999"),
  inset: 12pt, radius: 4pt, width: 100%,
)[
  #set text(size: 10pt)
  #table(
    columns: (1fr, auto, 1fr, auto, 1fr, auto, 1fr),
    stroke: none,
    inset: 5pt,
    align: center,
    fill: (col, row) =>
      if row == 0 and calc.even(col) {
        (rgb("#eaf0fb"), rgb("#fff8e1"), rgb("#e8f5e9"), rgb("#fde8f0")).at(
          calc.div-euclid(col, 2), default: white)
      } else { none },
    [*`.c`*],            [*->*], [*`.i`*],          [*->*], [*`.s`*],     [*->*], [*`.o`*],
    [Código-fonte],      [],     [Pré-processado],  [],     [Assembly],  [],     [Objeto],
    [_você escreve_],    [],     [_fase 1_],        [],     [_fase 2/3_],[],     [_fase 3_],
  )
  #v(6pt)
  #align(center)[
    *`.o` + `.o` + bibliotecas* #h(6pt) *->* #h(6pt) *executável* #h(16pt) _fase 4 (linker)_
  ]
]

#v(8pt)

// ── Fase 1 ───────────────────────────────────────────────────

#passo("1", "Pré-processamento")[
  O pré-processador (`cpp`) processa as diretivas que começam com `#`
  *antes* de qualquer compilação. Ele não entende C — apenas faz
  substituição de texto.

  O que ele faz:
  - `#include <stdio.h>` — copia o conteúdo do arquivo `stdio.h` no lugar da diretiva;
  - `#define PI 3.14159` — substitui cada ocorrência de `PI` pelo texto `3.14159`;
  - `#ifdef`, `#ifndef`, `#endif` — incluem ou excluem blocos condicionalmente;
  - Remove comentários.

  O resultado é um arquivo `.i` — C puro, sem nenhuma diretiva `#`, que
  pode ser muito maior que o original (o `stdio.h` tem centenas de linhas).

  Para ver o resultado do pré-processamento sem continuar:
  ```
  gcc -E hello.c -o hello.i
  ```

  #destaque[
    *Por que isso importa?* Se você usar `#include` de um arquivo errado,
    ou se um `#define` substituir algo inesperado, o erro vai aparecer no
    contexto do pré-processado. Saber que essa fase existe ajuda a
    entender mensagens de erro que mencionam linhas em arquivos `.h`.
  ]
]

#v(4pt)

// ── Fase 2+3 ─────────────────────────────────────────────────

#passo("2 e 3", "Compilação e Montagem (assembly)")[
  O compilador (`cc1` internamente) traduz o C pré-processado para
  *linguagem de montagem* (assembly) — instruções próximas do hardware,
  como `mov`, `add`, `call`. O resultado é um arquivo `.s`, ainda texto.

  Em seguida, o montador (`as`) traduz o assembly para *código de máquina
  binário*, produzindo um arquivo *objeto* (`.o` no Linux/macOS,
  `.obj` no Windows).

  Um arquivo objeto contém o código compilado de *um único arquivo* `.c`,
  com referências a funções externas (como `printf`) ainda não resolvidas.

  ```
  gcc -S hello.c -o hello.s   /* para apos o assembly */
  gcc -c hello.c -o hello.o   /* para apos o objeto   */
  ```

  É nesta fase que *erros de sintaxe* são detectados — o compilador
  verifica se o C está gramaticalmente correto.
]

#v(4pt)

// ── Fase 4 ───────────────────────────────────────────────────

#passo("4", "Ligação (link)")[
  O linker (`ld`) combina um ou mais arquivos `.o` com as *bibliotecas*
  necessárias (como `libc`) e produz o executável final. É ele que resolve
  as referências pendentes: quando `hello.o` chama `printf`, o linker
  encontra o código de `printf` na `libc` e conecta os dois.

  Se você esquecer um arquivo `.o` ou chamar uma função inexistente,
  o *erro de linker* aparece aqui:
  ```
  undefined reference to 'nome_da_funcao'
  ```

  #atencao[
    Erros de compilação mencionam uma *linha* do seu código. Erros de
    linker mencionam um *símbolo* (nome de função) que não foi encontrado.
    Saber distinguir os dois acelera muito a depuração.
  ]
]

// ============================================================
= Os três ambientes de desenvolvimento
// ============================================================

O programa de referência para todos os exercícios desta seção:

```c
/* hello.c */
#include <stdio.h>

int main() {
    printf("Ola, mundo!\n");
    return 0;
}
```

// ── Online ───────────────────────────────────────────────────
== Compilador online (onlinegdb.com)

O compilador online é a forma mais rápida de começar — sem instalação.

*Passo a passo:*
+ Acesse *onlinegdb.com* no navegador.
+ Confirme que a linguagem selecionada é *C* (não C++).
+ Cole o código no editor e clique em *Run*.
+ Para compilar sem executar: seta ao lado de Run > *Compile only*.

#destaque[
  *Configuração recomendada:* clique na engrenagem (Settings) e ative
  *Extra warnings*. Equivale a `gcc -Wall -Wextra` no terminal.
]

// ── GCC ──────────────────────────────────────────────────────
== GCC no terminal (Linux / macOS / WSL)

*Verificar instalação:*
```
gcc --version
```
Se não estiver instalado: `sudo apt install gcc` (Ubuntu/Debian) ou
`xcode-select --install` (macOS).

*Compilar e executar:*
```
gcc -Wall -Wextra -std=c99 hello.c -o hello
./hello
```

#table(
  columns: (auto, 1fr),
  stroke: 0.5pt + rgb("#aaa"),
  inset: 8pt,
  fill: (_, row) => if row == 0 { rgb("#1a3a5c") }
                    else if calc.odd(row) { rgb("#eaf0fb") }
                    else { white },
  [#text(fill: white, weight: "bold")[Flag]],
  [#text(fill: white, weight: "bold")[Significado]],
  [`-Wall`],    [Ativa os avisos mais importantes],
  [`-Wextra`],  [Ativa avisos adicionais úteis],
  [`-std=c99`], [Usa o padrão C99 (adotado neste curso)],
  [`-o nome`],  [Define o nome do executável],
  [`-E`],       [Para após pré-processamento, gera `.i`],
  [`-S`],       [Para após compilação, gera `.s`],
  [`-c`],       [Para após montagem, gera `.o`],
  [`-lm`],      [Linka a biblioteca matemática (`math.h`)],
)

// ── CodeBlocks ───────────────────────────────────────────────
== CodeBlocks (Windows / Linux)

*Instalação (Windows):* baixe em *codeblocks.org* o instalador com
MinGW: `codeblocks-XX.XX-mingw-setup.exe`.

*Criar projeto e executar:*
+ *File > New > Project > Console Application > C*
+ Dê nome e pasta ao projeto, clique em *Finish*.
+ O `main.c` já vem com um Hello World. Edite e pressione *F9*.

#table(
  columns: (auto, auto, 1fr),
  stroke: 0.5pt + rgb("#aaa"),
  inset: 8pt,
  fill: (_, row) => if row == 0 { rgb("#1a3a5c") }
                    else if calc.odd(row) { rgb("#eaf0fb") }
                    else { white },
  [#text(fill: white, weight: "bold")[Atalho]],
  [#text(fill: white, weight: "bold")[Ação]],
  [#text(fill: white, weight: "bold")[Observação]],
  [`F9`],       [Build and Run], [Compila e executa],
  [`Ctrl+F9`],  [Build],         [Compila sem executar],
  [`Ctrl+F10`], [Build log],     [Mostra mensagens do compilador],
)

#destaque[
  *Flags no CodeBlocks:* vá em *Project > Build options > Compiler
  settings > Other compiler options* e adicione `-Wall -Wextra`.
]

// ============================================================
= Lendo mensagens de erro do compilador
// ============================================================

O formato de uma mensagem de erro do GCC:
```
arquivo.c:linha:coluna: tipo: mensagem
```

Exemplo:
```
hello.c:5:5: error: expected ';' before 'return'
```

Linha 5, coluna 5: falta `;` antes de `return`. A causa provável está
na linha *anterior* — o compilador detecta o problema quando encontra
o `return` inesperado, mas a falta do `;` está na linha 4.

#atencao[
  *O erro raramente está na linha indicada.* Sempre olhe a linha apontada
  *e* as linhas imediatamente anteriores.
]

Avisos (`warning:`) não impedem a compilação, mas indicam código suspeito.
Trate-os como erros desde o início.

#table(
  columns: (1fr, 1fr),
  stroke: 0.5pt + rgb("#aaa"),
  inset: 8pt,
  fill: (_, row) => if row == 0 { rgb("#1a3a5c") }
                    else if calc.odd(row) { rgb("#eaf0fb") }
                    else { white },
  [#text(fill: white, weight: "bold")[Mensagem do GCC]],
  [#text(fill: white, weight: "bold")[Causa mais provável]],
  [`expected ';' before ...`],
    [Falta ponto e vírgula na linha anterior],
  [`undeclared identifier 'x'`],
    [Variável usada antes de declarar, ou nome digitado errado],
  [`undefined reference to 'f'`],
    [Função chamada mas não definida em nenhum arquivo (erro de linker)],
  [`implicit declaration of function 'f'`],
    [Falta `#include` ou protótipo da função],
  [`format '%d' expects 'int', but argument is 'double'`],
    [Especificador de formato errado no printf/scanf],
  [`unused variable 'x'`],
    [Variável declarada mas nunca usada — indica bug lógico potencial],
)

// ============================================================
= Exercícios
// ============================================================

*Exercício 1 — Hello World nos três ambientes*

Compile e execute `hello.c` no compilador online, no GCC e no CodeBlocks.
Para cada ambiente, registre o comando ou botão usado e se houve algum
aviso ou erro:

#caixa_resposta(64pt)

*Exercício 2 — Inspecionando as fases (GCC no terminal)*

```
gcc -E hello.c -o hello.i
gcc -S hello.c -o hello.s
gcc -c hello.c -o hello.o
```

a) Abra `hello.i`. Quantas linhas tem? O que aparece antes de `main`?
#caixa_resposta(36pt)

b) Abra `hello.s`. Você consegue identificar a chamada a `printf`?
#caixa_resposta(28pt)

c) Tente abrir `hello.o` num editor de texto. O que você vê e por quê?
#caixa_resposta(28pt)

*Exercício 3 — Lendo mensagens de erro*

O programa abaixo tem quatro erros. Sem compilar, tente identificá-los.
Depois compile e compare as mensagens com suas previsões.

```c
#include <stdio.h>

int main() {
    int x = 10
    float y = 3.14;
    printf("x = %f, y = %d\n", x, y);
    printf("soma = %d\n", x + z);
    return 0
}
```

#table(
  columns: (auto, auto, 1fr, 1fr),
  stroke: 0.5pt + rgb("#aaa"),
  inset: 7pt,
  fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
  [*Linha*], [*Tipo previsto*], [*Erro previsto*], [*Mensagem real*],
  [`4`],  [], [], [],
  [`6`],  [], [], [],
  [`7`],  [], [], [],
  [`8`],  [], [], [],
)

*Exercício 4 — O linker e a biblioteca matemática*

a) Compile o programa abaixo *sem* `-lm` e registre a mensagem de erro:

```c
#include <stdio.h>
#include <math.h>

int main() {
    printf("%.4f\n", sqrt(2.0));
    return 0;
}
```

#caixa_resposta(28pt)

b) Adicione `-lm` e compile novamente. Por que a `libc` é linkada
   automaticamente mas a `libm` precisa ser especificada?
#caixa_resposta(36pt)

*Exercício 5 — Compilação em etapas com dois arquivos*

Crie os arquivos abaixo e compile-os separadamente:

`saudacao.c`:
```c
#include <stdio.h>
void diz_ola(char *nome) {
    printf("Ola, %s!\n", nome);
}
```

`principal.c`:
```c
void diz_ola(char *nome);

int main() {
    diz_ola("UFMT");
    return 0;
}
```

```
gcc -c saudacao.c  -o saudacao.o
gcc -c principal.c -o principal.o
gcc saudacao.o principal.o -o programa
./programa
```

a) O que acontece se você remover o protótipo de `diz_ola` em
   `principal.c` antes de compilar? Registre a mensagem:
#caixa_resposta(28pt)

b) O que acontece se você omitir `saudacao.o` no último comando?
#caixa_resposta(28pt)

c) Em uma frase, qual é o papel do linker neste exemplo?
#caixa_resposta(24pt)
