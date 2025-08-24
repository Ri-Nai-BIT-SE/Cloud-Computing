// Removed dependency on local package for compatibility


#let table-align(x, y) = {
  if x == 0 {
    return center + horizon
  }
  return left + horizon
}

#let inside-table(..args) = table.cell(
  inset: 0em,
  table(
    ..args
  ),
)

#let double-table(..args) = inside-table(
  align: table-align,
  columns: (auto, 1fr),
  ..args,
)

#let horizontal-table(..args) = inside-table(columns: 1fr, ..args)
