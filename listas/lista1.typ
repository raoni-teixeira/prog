// ============================================================
//  Lista de Exercícios — Aula 1
//  Introdução a Algoritmos
//  Raoni F. S. Teixeira
// ============================================================

#set document(
  title: "Lista de Exercícios — Aula 1",
  author: "Raoni F. S. Teixeira"
)
#set page(
  paper: "a4",
  margin: (top: 3cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos*],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Lista de Exercícios — Aula 1],
      align(right)[#context counter(page).display("1")])
  ]
)
#set text(font: "Linux Libertine", size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.75em)
#set heading(numbering: none)

// ── Macros ───────────────────────────────────────────────────

#let campo_resposta(linhas) = {
  for _ in range(linhas) {
    block(
      width: 100%, height: 18pt,
      stroke: (bottom: 0.5pt + rgb("#999")),
    )[]
  }
}

#let secao(titulo, subtitulo) = {
  v(1.2em)
  block(
    fill: rgb("#1a3a5c"),
    inset: (x: 12pt, y: 8pt),
    radius: 3pt,
    width: 100%,
  )[
    #text(fill: white, weight: "bold", size: 13pt)[#titulo]
    #if subtitulo != "" [
      #h(8pt)#text(fill: rgb("#aaccee"), size: 10pt)[#subtitulo]
    ]
  ]
  v(0.4em)
}

#let subsecao(titulo) = {
  v(0.6em)
  text(weight: "bold", fill: rgb("#1a3a5c"), size: 11pt)[#titulo]
  v(0.2em)
}

#let destaque(corpo) = block(
  fill: rgb("#fff8e1"), stroke: (left: 3pt + rgb("#e6a817")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#corpo]

#let nota(corpo) = block(
  fill: rgb("#eaf0fb"), stroke: (left: 3pt + rgb("#1a3a5c")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(fill: rgb("#1a3a5c"), style: "italic")[#corpo]]

// ── Título ───────────────────────────────────────────────────

#align(center)[
  #text(size: 17pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Lista de Exercícios — Aula 1
  ]
  #v(3pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Introdução a Algoritmos  | Raoni F. S. Teixeira
  ]
]

#v(10pt)

// ============================================================
//  LISTA 1 — INTRODUÇÃO A ALGORITMOS
// ============================================================

#secao("Lista 1", "Introdução a Algoritmos")

#nota[
  Os exercícios desta lista não exigem código em C. O objetivo é
  desenvolver o raciocínio algorítmico — a capacidade de descrever
  uma solução de forma precisa e passo a passo, antes de traduzir
  para qualquer linguagem.
]

#v(6pt)

#subsecao("Parte A — Problemas clássicos de lógica")

+ *Travessia do rio.* Um fazendeiro precisa atravessar um rio numa
  canoa que comporta apenas ele e mais um item por vez. Ele tem
  consigo um lobo, uma cabra e um maço de repolhos. Se deixados
  sozinhos, o lobo come a cabra e a cabra come o repolho. Descreva um algoritmo (sequência numerada de passos) que leve
  todos ao outro lado sem perdas. Quantas travessias são necessárias
  no mínimo?

  //#campo_resposta(10)

+ *A moeda falsa.* Você tem 9 moedas aparentemente idênticas,
  mas uma delas é falsa e pesa ligeiramente menos. Você dispõe de
  uma balança de dois pratos (sem pesos), que apenas indica qual
  lado é mais pesado ou se estão equilibrados.
  *a)* Descreva um algoritmo que identifica a moeda falsa usando
  no máximo 2 pesagens.
  //#campo_resposta(8)

  *b)* Se houvesse 27 moedas, quantas pesagens seriam necessárias?
  Generalize: para $3^n$ moedas, quantas pesagens são suficientes?
  //#campo_resposta(4)

+ *Os missionários e os canibais.* Três missionários e três
  canibais precisam atravessar um rio numa canoa com capacidade para
  duas pessoas. Se em qualquer margem (ou na canoa) os canibais
  superarem em número os missionários, os missionários serão comidos.
  Descreva um algoritmo que leve todos ao outro lado em segurança.
  _(Dica: represente o estado como (missionários na margem esquerda,
  canibais na margem esquerda, posição da canoa).)_

  //#campo_resposta(12)

+ *O jarro d'água.* Você tem dois jarros sem marcação: um de 5
  litros e um de 3 litros. Você dispõe de uma fonte ilimitada de
  água. Descreva um algoritmo para obter exatamente 4 litros num
  dos jarros.
  //#campo_resposta(8)

+ *A lâmpada e os interruptores.* Você está numa sala com três
  interruptores. Em outra sala (inacessível com os interruptores
  ligados) há três lâmpadas, cada uma controlada por um dos
  interruptores. Você pode entrar na segunda sala apenas uma vez.
  Descreva um algoritmo para descobrir qual interruptor controla
  qual lâmpada.
  _(Este problema exige uma observação além do estado liga/desliga.
  Qual propriedade física de uma lâmpada ligada por tempo suficiente
  pode ser usada?)_

  //#campo_resposta(6)

#v(6pt)
#subsecao("Parte B — Algoritmos do cotidiano")

+ Descreva um algoritmo detalhado para ordenar um baralho de 52
  cartas por naipe (copas, ouros, paus, espadas) e, dentro de cada
  naipe, em ordem crescente de valor (A, 2, 3, ..., 10, J, Q, K).
  Quais são as entradas e saídas do seu algoritmo?

  //#campo_resposta(8)

+ Descreva um algoritmo para encontrar o número de telefone de
  uma pessoa numa lista telefônica impressa (ordenada
  alfabeticamente por sobrenome). Compare com a estratégia de
  procurar página por página desde o início — qual é mais eficiente?
  //#campo_resposta(6)

+ Considere o seguinte algoritmo em pseudocódigo para um jogo:

'''
leia um chute do jogador
se chute == numero_secreto:
imprima "Acertou!"
ganhou = verdadeiro
senao se chute < numero_secreto:
imprima "Muito baixo"
senao:
imprima "Muito alto"
'''

*a)* Este algoritmo sempre termina? Justifique.

//#campo_resposta(3)

*b)* Modifique o algoritmo para limitar o número de tentativas a 7.
O jogador consegue sempre adivinhar um número entre 1 e 100 em
7 tentativas com uma estratégia ótima? Por quê?

//#campo_resposta(5)

#v(6pt)
#subsecao("Parte C — Tipos de erro")

+ Classifique cada situação abaixo em erro de *sintaxe*, de
*execução* ou de *lógica*. Justifique cada resposta.

#table(
  columns: (1fr, auto, 1fr),
  stroke: 0.5pt + rgb("#aaa"),
  inset: 8pt,
  fill: (_, row) => if row == 0 { rgb("#eaf0fb") } else { white },
  [*Situação*], [*Tipo de erro*], [*Justificativa*],
  [Esquecer o `;` ao final de uma instrução em C], [], [],
  [Dividir um número pelo valor lido, sem tratar o caso em que o usuário digita zero], [], [],
  [Calcular a média de N notas como `soma / N` quando `soma` e `N` são ambos `int` e N = 3], [], [],
  [Escrever `if (x = 5)` em vez de `if (x == 5)`], [], [],
  [Usar uma variável antes de declará-la], [], [],
  [Um programa de caixa eletrônico que funciona para saques normais mas trava quando o saldo é exatamente zero], [], [],
)