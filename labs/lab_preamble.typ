// lab_preamble.typ — incluir em cada roteiro
// ============================================================

#let atividade(num, tipo, tempo, corpo) = {
  block(
    width: 100%,
    inset: 0pt,
    spacing: 1em,
  )[
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

#let bug(corpo) = block(
  fill: rgb("#fdecea"),
  stroke: (left: 3pt + rgb("#c62828")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#c62828"))[Código com bug] \ #corpo]

#let lacuna(corpo) = block(
  fill: rgb("#f0faf0"),
  stroke: (left: 3pt + rgb("#2e7d32")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#2e7d32"))[Complete o código] \ #corpo]

#let desafio(corpo) = block(
  fill: rgb("#fff8e1"),
  stroke: (left: 3pt + rgb("#e6a817")),
  inset: (left: 10pt, top: 8pt, bottom: 8pt, right: 10pt),
  radius: 2pt, width: 100%,
)[#text(weight: "bold", fill: rgb("#e6a817"))[Desafio opcional] \ #corpo]

#let resposta(linhas) = {
  for _ in range(linhas) {
    block(width: 100%, height: 18pt, stroke: (bottom: 0.5pt + rgb("#999")))[]
  }
}

#let caixa_resposta(altura) = block(
  width: 100%, height: altura,
  stroke: 0.5pt + rgb("#999"),
  radius: 2pt,
  inset: 6pt,
)[]

#let mesa_table(colunas, linhas) = {
  let cols = (auto,) * colunas
  let header_cells = range(colunas).map(_ => 
    table.cell(fill: rgb("#e8eaf6"))[#h(24pt)]
  )
  let body_cells = range(linhas * colunas).map(_ =>
    table.cell(height: 22pt)[]
  )
  table(
    columns: cols,
    stroke: 0.5pt + rgb("#999"),
    inset: 6pt,
    ..header_cells,
    ..body_cells,
  )
}
