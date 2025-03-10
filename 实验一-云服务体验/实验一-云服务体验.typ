#import "@preview/bit-undergraduate-thesis-template:0.1.0" as template
#show: template.paper.with(
  subject: "云计算及应用实验报告",
  title: "实验一  云服务体验",
  title-en: "",
  has_declear: false,
  has_contents: false,
  info-columns: (
    ("专业", "软件工程"),
    ("班级", "软工2301班"),
    ("姓名", "叶子宁"),
    ("学号", "1120231313"),
  ),
  header: "云计算及应用实验报告",
  date: datetime(year: 2025, month: 3, day: 3),
)
#let numberfunc = (..args, last) => {
  if args.pos().len() >= 1 {
    numbering("1.1.1.1.", ..args.pos().slice(1), last)
  }
}
#set heading(numbering: numberfunc)

#show figure: set block(breakable: true)
#show raw: set block(breakable: true)
#show image: set block(breakable: true)
#show raw: set text(font: ("JetBrains Mono", "Noto Sans SC"))


#block(
  fill: rgb("#fdffe0"),
  inset: 10pt,
  radius: 5pt,
  stroke: blue + 1pt,
  width: 100%
)[
  #template.indent()
  更好的阅读体验：#link(
  "https://Ri-Nai.github.io/Hugo-Blog/post/2025/03/10/云计算及应用-实验一-云服务体验/"
)[#text(blue)[我的个人博客]]
]

#include "page.typ"
