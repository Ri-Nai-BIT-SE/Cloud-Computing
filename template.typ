#import "@local/bit-undergraduate-thesis-template:0.1.1" as template

#let book(
  subject: "云计算及应用实验报告",
  title: "",
  title-en: "",
  ..args,
  body,
) = [
  #show: template.paper.with(
    subject: subject,
    title: title,
    title-en: title-en,
    declare: false,
    show-contents: false,
    info-columns: (
      ("专业", "软件工程"),
      ("班级", "软工2301班"),
      ("姓名", "叶子宁"),
      ("学号", "1120231313"),
    ),
    header: "云计算及应用实验报告",
    date: datetime.today(),
    ..args,
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

  #body
]
