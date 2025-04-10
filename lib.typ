#let IMAGE_BOX_MAX_WIDTH = 120pt
#let IMAGE_BOX_MAX_HEIGHT = 50pt

#let project(
  title: "",
  subtitle: none,
  school-logo: none,
  company-logo: none,
  author: (),
  mentors: (),
  jury: (),
  french: false,
  show-table-of-contents: true,
  show-table-of-figures: false,
  show-table-of-tables: false,
  department: "",
  sector: "",
  specialization: "",
  body
) = {
  // 1) Document setup
  set document(
    author: author,
    title: title
  )

  set page(
    numbering: none,
    number-align: center
  )

  // 2) Language and dictionary
  let (dict, lang) = if french {
    (json("resources/i18n/fr.json"), "fr")
  } else {
    (json("resources/i18n/en.json"), "en")
  }

  set text(font: "New Computer Modern", lang: lang, size: 13pt)
  set heading(numbering: "1.1")
  set par(justify: true)

  // 3) Custom heading display
  show heading: it => {
    if it.level == 1 {
      v(20pt)
      text(size: 30pt)[#it.body]
      v(20pt)
    } else {
      v(5pt)
      [#it]
      v(12pt)
    }
  }

  // --- Title-page content ---
  // Top-left logo
  box(width: auto)[
    // Replace with your own image path:
    #image("./images/logo.svg", width: 3cm)
  ]

  // Vertical gap before center block
  v(4cm)

  // Main title & subtitle, centered
  set align(center)
  box(width: 100%)[
    #text(size: 22pt, weight: "bold")[
      #title
    ]

    #text(size: 14pt, weight: "bold")[
      #subtitle
    ]
  ]

  v(4cm)

  // Department info
  box(width: 100%)[
    Département #department

    #sector

    Orientation #specialization
  ]

  v(2cm)

  let date = datetime.today

  // Author name & date
  set align(center)
  box(width: auto)[
    #author

    #datetime.today().display("[day] [month repr:long] [year]")
  ]

  v(4cm)

  // Supervisor
  set align(center)
  box(width: 100%)[
      // Mentors column
      #if mentors != none and mentors.len() > 0 {
        align(center)[
          Supervisé par :

          #for mentor in mentors {
            [#mentor #linebreak()]
          }
        ]
      }

      // Jury column
      #if jury != none and jury.len() > 0 {
        align(right)[
          *#dict.jury*
          #linebreak()
          #for prof in jury {
            [#prof #linebreak()]
          }
        ]
      }

  ]

  set page(numbering: "i")
  set align(left)

  let new_page = false

  if show-table-of-contents {
    v(4cm)
    // Bold only level-1 headings in the TOC
    show outline.entry.where(level: 1): set text(weight: "bold")
    set outline.entry(fill: repeat([.], gap: 0.4em))

    // Table of contents
    outline(depth: 3, indent: auto)

    pagebreak()
    new_page = true
  }

  if show-table-of-figures {
    // Table of figures
    outline(
      title: dict.figures_table,
      target: figure.where(kind: image)
    )
    pagebreak()
    new_page = true
  }

  if show-table-of-tables {
    // Table of tables
    outline(
      title: dict.tables_table,
      target: figure.where(kind: table)
    )
    pagebreak()
    new_page = true
  }

  if new_page {
    set page(numbering: none)
    pagebreak()
  }

  set page(numbering: "1")

  counter(page).update(1)

  body
}

