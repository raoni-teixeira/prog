// ============================================================
//  Trabalho Prático — Halftoning de Imagens em Tons de Cinza
//  Introdução a Algoritmos — Raoni F. S. Teixeira
// ============================================================

#set document(title: "Trabalho Prático — Halftoning", author: "Raoni F. S. Teixeira")

#set page(
  paper: "a4",
  margin: (top: 3cm, bottom: 2.5cm, left: 2.8cm, right: 2.8cm),
  header: [
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [*Introdução a Algoritmos* -- Trabalho Prático],
      align(right)[Raoni F. S. Teixeira])
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + rgb("#1a3a5c"))
    #set text(size: 9pt, fill: rgb("#1a3a5c"))
    #grid(columns: (1fr, 1fr),
      [Halftoning de Imagens],
      align(right)[#context counter(page).display("1")])
  ]
)

#set text(font: "Linux Libertine", size: 11pt, lang: "pt")
#set par(justify: true, leading: 0.75em)
#set heading(numbering: "1.")

#let destaque(corpo) = block(
  fill: rgb("#fff8e1"), stroke: (left: 3pt + rgb("#e6a817")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#corpo]

#let caixadef(titulo, corpo) = block(
  fill: rgb("#eaf0fb"), stroke: (left: 3pt + rgb("#1a3a5c")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#1a3a5c"))[#titulo] #linebreak() #corpo]

#let atencao(corpo) = block(
  fill: rgb("#fdecea"), stroke: (left: 3pt + rgb("#c62828")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#c62828"))[Atenção] \ #corpo]

#let etapa(num, titulo, pts, corpo) = {
  block(width: 100%, inset: 0pt, spacing: 1.2em)[
    #block(
      fill: rgb("#1a3a5c"),
      inset: (x: 12pt, y: 7pt),
      radius: (top: 3pt),
      width: 100%,
    )[
      #grid(columns: (1fr, auto),
        text(fill: white, weight: "bold", size: 12pt)[Etapa #num -- #titulo],
        text(fill: rgb("#aaccee"), size: 10pt)[#pts pontos],
      )
    ]
    #block(
      stroke: (left: 3pt + rgb("#1a3a5c"), right: 0.5pt + rgb("#ccc"),
               bottom: 0.5pt + rgb("#ccc")),
      inset: (left: 14pt, top: 12pt, bottom: 12pt, right: 12pt),
      radius: (bottom: 3pt),
      width: 100%,
    )[#corpo]
  ]
}

// ── Título ───────────────────────────────────────────────────

#align(center)[
  #text(size: 17pt, weight: "bold", fill: rgb("#1a3a5c"))[
    Trabalho Prático -- Halftoning de Imagens em Tons de Cinza
  ]
  #v(4pt)
  #text(size: 10pt, fill: rgb("#555"))[
    Trabalho individual  |  Defesa oral individual  |  Linguagem: C (padrão C99)
  ]
]

#v(10pt)

// ── Apresentação ─────────────────────────────────────────────
= Apresentação

Impressoras a laser e jatos de tinta imprimem pontos -- cada ponto é preto
ou branco, sem meios-tons. No entanto, jornais, livros e fotografias impressas
exibem gradações de cinza visualmente convincentes. Como?

A resposta é *halftoning*: a conversão de uma imagem em tons de cinza
(valores 0--255 por pixel) numa imagem binária (0 ou 255 por pixel) que,
quando impressa ou exibida em pequena escala, ilude o olho humano a perceber
gradações de intensidade. Regiões com muitos pontos pretos parecem escuras;
regiões com poucos pontos parecem claras.

Neste trabalho você implementará um programa em C capaz de ler imagens em
formato PGM, aplicar dois algoritmos de halftoning com características
distintas, e analisar quantitativamente a qualidade de cada resultado.

#v(6pt)
#block(
  fill: rgb("#eaf0fb"), stroke: (left: 3pt + rgb("#1a3a5c")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[
  #text(weight: "bold", fill: rgb("#1a3a5c"))[Habilidades avaliadas]
  #linebreak()
  Leitura e escrita de arquivos binários; alocação dinâmica de memória;
  manipulação de matrizes via ponteiros; organização do código em funções
  com responsabilidades separadas; análise quantitativa de resultados;
  capacidade de explicar cada decisão de implementação.
]

// ── Formato PGM ──────────────────────────────────────────────
= O formato PGM (Portable Gray Map)

PGM é um formato de imagem minimalista e ideal para este trabalho: o header
é texto puro e os dados são bytes brutos, sem compressão. O formato binário
(magic number P5) tem a seguinte estrutura:

```
P5\n
<largura> <altura>\n
<valor_maximo>\n
<dados: largura*altura bytes, um byte por pixel, linha a linha>
```

Exemplo de header para uma imagem 320x240 com valores 0--255:
```
P5
320 240
255
<seguido de 76800 bytes de dados>
```

Regras importantes para o parser:
- Linhas começando com `#` são comentários e devem ser ignoradas.
- O valor máximo é sempre 255 neste trabalho (não precisa generalizar).
- Os dados começam imediatamente após o `\n` que termina a linha do valor
  máximo -- não há separador adicional.
- Use `fread` para ler os dados, não `fscanf`.

#block(
  fill: rgb("#eaf0fb"), stroke: (left: 3pt + rgb("#1a3a5c")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[
  #text(weight: "bold", fill: rgb("#1a3a5c"))[Struct recomendada]
  #linebreak()
  ```c
  typedef struct {
      int    largura;
      int    altura;
      unsigned char *pixels;   /* vetor de largura*altura bytes */
  } Imagem;
  ```
  O pixel na linha `i`, coluna `j` está em `pixels[i * largura + j]`.
  Alocação: `malloc(largura * altura * sizeof(unsigned char))`.
]

// ── Etapas ───────────────────────────────────────────────────
= Etapas do trabalho

#etapa("1", "Leitura e escrita de arquivos PGM", "20")[
  Implemente as funções:

  ```c
  /* Le uma imagem PGM (formato P5) do arquivo indicado.
   * Retorna ponteiro para Imagem alocada no heap, ou NULL em caso de erro.
   * O chamador e responsavel por liberar a memoria. */
  Imagem *pgm_ler(const char *caminho);

  /* Escreve img no arquivo indicado no formato PGM P5.
   * Retorna 1 em sucesso, 0 em falha. */
  int pgm_escrever(const Imagem *img, const char *caminho);

  /* Libera a memoria alocada por pgm_ler. */
  void pgm_liberar(Imagem *img);
  ```

  *Verificação obrigatória:* leia uma imagem fornecida, escreva-a de volta
  num arquivo de saída, e confirme que os dois arquivos são idênticos:

  ```bash
  diff imagem_original.pgm imagem_relida.pgm   # deve ser silencioso
  ```

  *Tratamento de erros:* `pgm_ler` deve retornar `NULL` e imprimir uma
  mensagem descritiva em `stderr` se o arquivo não existir, se o magic
  number não for "P5", ou se a alocação falhar.

  *Questões para a defesa:*
  - Por que usar `fread` em vez de `fscanf` para os dados de pixel?
  - O que acontece se você trocar `unsigned char` por `char` no campo
    `pixels`? Para quais valores de pixel isso faz diferença?
  - Como seu parser trata comentários no header? Mostre o trecho do código.
]

#etapa("2", "Halftoning por limiar fixo", "20")[
  O algoritmo mais simples: para cada pixel, compare com um limiar `t`.
  Se o valor for >= `t`, o pixel de saída é 255 (branco); caso contrário,
  é 0 (preto).

  ```c
  /* Aplica halftoning por limiar a src, armazenando o resultado em dst.
   * dst deve ter as mesmas dimensoes que src e ja estar alocado.
   * limiar deve estar no intervalo [0, 255]. */
  void halftone_limiar(const Imagem *src, Imagem *dst, int limiar);
  ```

  *Experimentos obrigatórios:*

  Execute com limiares 64, 128 e 192 sobre cada imagem de teste. Para cada
  combinação, registre o MSE (calculado na Etapa 4) e inclua as imagens
  geradas no relatório.

  *Casos extremos -- analise e documente no relatório:*
  - O que acontece com limiar = 0? E com limiar = 255?
  - O que acontece com uma imagem de gradiente perfeito (pixels
    variando de 0 a 255 linearmente)?
  - O que acontece com uma imagem de ruído aleatório uniforme?

  *Questões para a defesa:*
  - Qual limiar minimiza o MSE em média para as imagens fornecidas?
    Era o valor que você esperava? Por que 128 não é necessariamente ótimo?
  - Dado um pixel de valor `v` e limiar `t`, qual é o erro cometido
    pela quantização? Escreva a expressão.
  - Para uma imagem com histograma concentrado num único valor, qual
    é o comportamento do algoritmo?
]

#etapa("3", "Halftoning por dithering ordenado (matriz de Bayer)", "35")[
  O halftoning por limiar trata cada pixel independentemente, o que produz
  regiões uniformes nas imagens resultantes. O dithering ordenado varia
  o limiar espacialmente usando uma *matriz de Bayer*, produzindo padrões
  que simulam melhor os tons intermediários.

  A matriz de Bayer de ordem 2 (2x2) é:

  $ M_2 = frac(1, 4) mat(0, 2; 3, 1) $

  E pode ser construída recursivamente. A matriz de ordem 4 (4x4),
  usada neste trabalho, é:

  $ M_4 = frac(1, 16) mat(
     0,  8,  2, 10;
    12,  4, 14,  6;
     3, 11,  1,  9;
    15,  7, 13,  5
  ) $

  O algoritmo aplica um limiar *variável* a cada pixel `(i, j)`:

  $ "saida"(i,j) = cases(255 & "se" "pixel"(i,j) >= M_4[i mod 4][j mod 4] times 255, 0 & "caso contrário") $

  Na prática, como os valores de pixel e da matriz são inteiros,
  a comparação é feita como:

  ```c
  /* bayer4[r][c] contem os valores inteiros 0..15 da matriz de Bayer 4x4 */
  int threshold = (bayer4[i % 4][j % 4] * 255) / 15;
  saida = (pixel >= threshold) ? 255 : 0;
  ```

  ```c
  /* A matriz de Bayer 4x4 (valores inteiros 0..15) */
  static const int bayer4[4][4] = {
      { 0,  8,  2, 10},
      {12,  4, 14,  6},
      { 3, 11,  1,  9},
      {15,  7, 13,  5}
  };

  /* Aplica dithering ordenado com matriz de Bayer 4x4. */
  void halftone_bayer(const Imagem *src, Imagem *dst);
  ```

  *Experimentos obrigatórios:*

  - Aplique `halftone_bayer` a todas as imagens de teste.
  - Compare visualmente e pelo MSE com `halftone_limiar(128)`.
  - Aplique às imagens de gradiente e de ruído. O que você observa?

  *Análise obrigatória no relatório:*

  - Por que o operador `%` é central neste algoritmo?
    O que ele garante espacialmente?
  - O que acontece se você usar `bayer4[i % 2][j % 2]` em vez de `% 4`?
    Implemente e mostre o resultado.
  - A matriz de Bayer tem a propriedade de que, para um pixel de valor `v`,
    a fração de pixels brancos no resultado é aproximadamente `v/255`.
    Verifique isso empiricamente para valores v = 64, 128, 192 numa
    imagem uniforme (todos os pixels com o mesmo valor `v`).

  *Questões para a defesa:*
  - Explique linha a linha o que faz `(bayer4[i % 4][j % 4] * 255) / 15`.
    Por que multiplicar por 255 e dividir por 15?
  - Por que `static const` na declaração da matriz de Bayer?
    O que cada qualificador significa?
  - Como o dithering ordenado se comporta em regiões de borda entre
    áreas claras e escuras? Compare com o limiar fixo.
]

#etapa("4", "Análise quantitativa: MSE e relatório", "25")[
  == Métrica de qualidade: MSE

  O *Mean Squared Error* (Erro Quadrático Médio) mede a diferença média
  entre pixels correspondentes da imagem original e da imagem resultante:

  $ "MSE" = frac(1, L times A) sum_(i=0)^(L-1) sum_(j=0)^(A-1) ("original"(i,j) - "resultado"(i,j))^2 $

  onde $L$ é a altura e $A$ é a largura da imagem.

  ```c
  /* Calcula o MSE entre duas imagens de mesmas dimensoes.
   * As imagens devem ter dimensoes identicas -- comportamento
   * indefinido caso contrario. */
  double mse(const Imagem *original, const Imagem *resultado);
  ```

  Note que `pixel` é `unsigned char` (0--255), mas a diferença ao quadrado
  pode chegar a 65025. Use `double` ou `long` no acumulador para evitar
  overflow.

  == Programa principal

  O programa deve ser invocado pela linha de comando:

  ```
  ./halftone <imagem.pgm> <limiar> <saida_limiar.pgm> <saida_bayer.pgm>
  ```

  E deve imprimir na saída padrão:

  ```
  Imagem: <nome> (<largura>x<altura>, <total> pixels)
  Limiar fixo  (t=<limiar>): MSE = <valor>
  Bayer 4x4              : MSE = <valor>
  ```

  == Relatório

  O relatório deve ser entregue no template fornecido (arquivo .docx)
  e deve conter obrigatoriamente:

  + *Tabela de resultados:* MSE para cada combinação de imagem x método x
    limiar (onde aplicável). Mínimo: 4 imagens x 3 limiares (limiar) +
    4 imagens (Bayer) = 16 linhas.

  + *Galeria de imagens:* para cada imagem de teste, mostre original,
    resultado por limiar 128 e resultado por Bayer lado a lado.

  + *Análise dos casos extremos:* resultados e explicação para os casos
    pedidos nas Etapas 2 e 3 (limiar 0 e 255, gradiente, ruído, Bayer 2x2).

  + *Discussão:* responda em prosa (mínimo um parágrafo por pergunta):
    - Em que situações o limiar fixo produz MSE menor que Bayer? E maior?
    - Qual método você escolheria para imprimir uma fotografia?
      Para imprimir texto com fontes em cinza? Justifique.
    - Quais limitações do MSE como métrica de qualidade perceptual você
      identificou ao comparar os resultados?

  + *Reflexão sobre o processo:* descreva *uma* decisão de implementação
    que você tomou que não estava explicitada no enunciado, explique por
    que a tomou e o que teria acontecido se tivesse feito diferente.
]

// ── Imagens de teste ─────────────────────────────────────────
= Imagens de teste

Serão fornecidas as seguintes imagens em formato PGM P5:

#table(
  columns: (auto, auto, 1fr),
  stroke: 0.5pt + rgb("#aaa"),
  inset: 8pt,
  fill: (_, row) => if row == 0 { rgb("#1a3a5c") }
                    else if calc.odd(row) { rgb("#eaf0fb") }
                    else { white },
  [#text(fill:white,weight:"bold")[Arquivo]],
  [#text(fill:white,weight:"bold")[Tamanho]],
  [#text(fill:white,weight:"bold")[Características]],
  [`retrato.pgm`],    [256x256],  [Fotografia com muitos tons intermediários],
  [`gradiente.pgm`],  [256x64],   [Gradiente horizontal perfeito de 0 a 255],
  [`texto.pgm`],      [320x80],   [Texto branco sobre fundo preto (alto contraste)],
  [`ruido.pgm`],      [256x256],  [Ruído uniforme aleatório],
)

O aluno deve *obrigatoriamente* adicionar ao menos *duas imagens próprias*
(fotografias, capturas de tela convertidas para PGM, ou imagens sintéticas
geradas por código). Essas imagens devem ser incluídas no relatório com
justificativa de escolha.

Para converter uma imagem qualquer para PGM P5 no Linux/macOS:
```bash
convert entrada.jpg -colorspace Gray -depth 8 saida.pgm
```
ou com Python:
```python
from PIL import Image
Image.open("entrada.jpg").convert("L").save("saida.pgm")
```

// ── Organização do código ────────────────────────────────────
= Organização e requisitos técnicos

*Estrutura de arquivos obrigatória:*
```
halftone/
    halftone.c       # programa principal e todas as funcoes
    Makefile         # ou instrucoes de compilacao no relatorio
    relatorio.docx   # preenchido com o template fornecido
    imagens/
        retrato.pgm  gradiente.pgm  texto.pgm  ruido.pgm
        <imagem_propria_1>.pgm
        <imagem_propria_2>.pgm
        saidas/      # resultados gerados pelo programa
```

*Requisitos de implementação:*
- Todo o código deve compilar sem warnings com `gcc -Wall -Wextra -std=c99`.
- Toda memória alocada com `malloc` deve ser liberada com `free` antes
  do programa terminar. Verifique com Valgrind se disponível.
- Funções não devem ter mais de 40 linhas. Se ultrapassar, quebre em
  funções auxiliares.
- O programa deve terminar com código de saída 0 em sucesso e 1 em erro.
- Não use variáveis globais, exceto a matriz `bayer4` que pode ser
  declarada como `static const`.

*O que não é permitido:*
- Bibliotecas externas de processamento de imagem (libpng, OpenCV, etc.).
- Funções prontas de halftoning de qualquer biblioteca.
- Código copiado sem compreensão -- a defesa verificará isso.

#atencao[
  O uso de LLMs e ferramentas de geração de código é *permitido*, desde
  que todo o código entregue seja *compreendido e explicável* pelo aluno.
  Na defesa, qualquer trecho do código pode ser questionado: "o que esta
  linha faz?", "por que você usou esse tipo aqui?", "o que acontece se
  este `if` for removido?". Código que o aluno não consegue explicar
  resulta em nota zero na etapa correspondente.
]

// ── Avaliação ────────────────────────────────────────────────
= Avaliação

A nota final é composta por código + defesa:

#table(
  columns: (1fr, auto, auto),
  stroke: 0.5pt + rgb("#aaa"),
  inset: 8pt,
  fill: (_, row) => if row == 0 { rgb("#1a3a5c") }
                    else if calc.odd(row) { rgb("#eaf0fb") }
                    else { white },
  [#text(fill:white,weight:"bold")[Critério]],
  [#text(fill:white,weight:"bold")[Pontos]],
  [#text(fill:white,weight:"bold")[Como é avaliado]],
  [Etapa 1 -- PGM leitura/escrita], [20], [Código + defesa],
  [Etapa 2 -- Limiar fixo],         [20], [Código + experimentos + defesa],
  [Etapa 3 -- Bayer],               [35], [Código + análise + defesa],
  [Etapa 4 -- MSE e relatório],     [25], [Relatório + programa principal],
  [*Total*], [*100*], [],
)

#v(6pt)

*Critérios de desconto:*
- Código que não compila: -50% na etapa correspondente.
- Vazamento de memória detectado: -10% por função com leak.
- Relatório sem galeria de imagens: -10%.
- Ausência de imagens próprias: -10%.
- Funções com mais de 40 linhas sem justificativa: -5% por função.

*Na defesa*, o professor pode pedir ao aluno:
- Explicar qualquer trecho do código linha a linha.
- Modificar o código ao vivo para testar uma variante.
- Prever o resultado para uma entrada específica antes de executar.
- Explicar o que aconteceria se uma função fosse implementada diferente.

A defesa não tem duração fixa -- termina quando o professor tiver
evidência suficiente para avaliar a compreensão do aluno.
