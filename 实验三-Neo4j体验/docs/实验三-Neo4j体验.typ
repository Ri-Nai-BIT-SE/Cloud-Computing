#import "../../template.typ": book
#import "../../util.typ": *
#import "@preview/zebraw:0.5.4": *

#show: book.with(
  title: "实验三  Neo4j体验",
  title-en: "Experiment 3  Neo4j Experience",
  auto-pagebreak: true,
)

// #set figure(placement: bottom)
#set raw(syntaxes: "PowerShell.sublime-syntax")
#set raw(syntaxes: "Cypher.sublime-syntax")
#show link: set text(fill: blue)

#include "Environment-Settings.typ"
#include "Experience-CQL.typ"
#include "Create-Knowledge-Graph.typ"
