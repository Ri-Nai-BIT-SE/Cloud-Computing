#import "/book.typ": book-page
#show: book-page.with(title: "创建知识图谱")
#import "/util.typ": *

= 创建知识图谱

== 创建项目

#double-table(
  columns: (1fr, 4fr),
  [创建项目],
  horizontal-table(
    [
      在 IntelliJ IDEA 中创建一个新项目，并选择 Maven 作为项目类型。
    ],
    [
      #figure(
        image("imgs/QQ_1747132994445.png"),
        caption: "IntelliJ IDEA 创建项目",
      ),
    ],
  ),
  [导入依赖],
  horizontal-table(
    [在 pom.xml 文件中添加以下依赖：],
    [
      ```xml
      <dependency>
          <groupId>org.neo4j.driver</groupId>
          <artifactId>neo4j-java-driver</artifactId>
          <version>5.19.0</version>
      </dependency>
      ```
    ],
    [
      #figure(
        image("imgs/QQ_1747137377695.png"),
        caption: "IntelliJ IDEA 导入依赖",
      ),
    ],
  ),
)

== 创建知识图谱

#double-table(
  columns: (1fr, 4fr),
  [连接数据库],
  [
    ```java
    Neo4jConnection.connect(uri, username, password);
    ```
  ],
  [执行 `Cypher` 语句],
  [
    ```java
    session.executeWrite(tx -> {tx.run(cql);});
    session.executeRead(tx -> {tx.run(cql);});
    ```
  ],
  [创建知识图谱],
  [
    语法细节不再赘述，详细代码见 `Neo4jDemo` 项目中的文件。
    #figure(
      image("imgs/QQ_1747138661084.png"),
      caption: "Java 连接 Neo4j 创建知识图谱",
    ),
  ],
)
