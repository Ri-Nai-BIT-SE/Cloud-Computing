#import "/book.typ": book-page
#show: book-page.with(title: "实验一：云服务体验")

#block(
  fill: rgb("#fdffe0"),
  inset: 10pt,
  radius: 5pt,
  stroke: blue + 1pt,
  width: 100%,
)[
  更好的阅读体验：#link(
    "https://Ri-Nai.github.io/Hugo-Blog/post/2025/03/10/云计算及应用-实验一-云服务体验/",
    text(blue)[我的个人博客]
  )
]

#include "Linux-VM.typ"
#include "Windows-VM.typ"
