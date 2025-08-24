#import "@preview/shiroa:0.2.2": *

#show: book

#book-meta(
  title: "云计算及应用实验报告",
  description: "云计算及应用课程实验报告",
  repository: "https://github.com/Ri-Nai/Interests",
  authors: ("叶子宁",),
  summary: [
    #prefix-chapter("pages/Introduction.typ")[Introduction]
    = 云计算及应用实验
    - #chapter("pages/experiments/1/实验一-云服务体验.typ")[实验一：云服务体验]
      - #chapter("pages/experiments/1/Linux-VM.typ")[Linux 虚拟机]
      - #chapter("pages/experiments/1/Windows-VM.typ")[Windows 虚拟机]
    - #chapter("pages/experiments/3/实验三-Neo4j体验.typ")[实验三：Neo4j体验]
      - #chapter("pages/experiments/3/Environment-Settings.typ")[环境配置]
      - #chapter("pages/experiments/3/Experience-CQL.typ")[体验 CQL 语句]
      - #chapter("pages/experiments/3/Create-Knowledge-Graph.typ")[创建知识图谱]
    = 云计算及应用大作业
    - #chapter("pages/assignments/大作业-词频统计.typ")[大作业：词频统计]
      - #chapter("pages/assignments/environment.typ")[环境配置]
      - #chapter("pages/assignments/solution.typ")[解决方案]
      - #chapter("pages/assignments/result.typ")[运行结果]
  ],
)

// re-export page template
#import "/templates/page.typ": project
#let book-page = project
