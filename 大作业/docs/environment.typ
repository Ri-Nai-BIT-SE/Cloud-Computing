#import "../../util.typ": *

= 环境配置

#double-table(
  columns: (1fr, 4fr),
  [安装 Scala],
  [
    #link("https://github.com/scala/scala/releases/download/v2.12.14/scala-2.12.14.msi")
  ],
  [下载插件],
  horizontal-table(
    [下载 `Scala` 插件和 `Spark` 插件],
    [
      #grid(
        columns: 2,
        figure(
          image("imgs/QQ_1747903374649.png"),
          caption: "下载 Scala 插件",
        ),
        figure(
          image("imgs/QQ_1747908280124.png"),
          caption: "下载 Spark 插件",
        ),
      )
    ],
  ),
  [新建项目],
  horizontal-table(
    figure(
      image("imgs/QQ_1747905884373.png", width: 88.8%),
      caption: "IntelliJ IDEA 创建项目",
    ),
    [
      在 IntelliJ IDEA 中创建一个新项目，并选择 `Java` + `Maven` 作为项目类型。

      由于 `Scala` 和 `Java` 一样是 JVM 语言，所以可以直接在 `Java` 项目中使用 `Scala` 语言并运行。

      不使用 `Scala` + `sbt` 的原因是个人导入 `sbt` 失败了，可能是网络原因。
    ],
  ),
  [配置文件 \ `pom.xml`],
  [
    主要要注意的就是里面的 `properties` 和 `dependencies` 标签中的内容。

    `dependencies` 标签中需要添加 `Scala` 和 `Spark` 的依赖，`properties` 标签中需要添加 `Scala` 和 `Spark` 的版本。
    
    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <project xmlns="http://maven.apache.org/POM/4.0.0"
             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
        <modelVersion>4.0.0</modelVersion>

        <groupId>org.example.wordcount</groupId>
        <artifactId>WordCount</artifactId>
        <version>1.0-SNAPSHOT</version>

        <properties>
            <maven.compiler.source>17</maven.compiler.source>
            <maven.compiler.target>17</maven.compiler.target>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            <scala.version>2.12.14</scala.version>
            <spark.version>3.3.2</spark.version>
        </properties>

        <dependencies>
            <!-- Scala 标准库 -->
            <dependency>
                <groupId>org.scala-lang</groupId>
                <artifactId>scala-library</artifactId>
                <version>${scala.version}</version>
            </dependency>


            <!-- Spark Core 示例（可选） -->
            <dependency>
                <groupId>org.apache.spark</groupId>
                <artifactId>spark-core_2.12</artifactId>
                <version>${spark.version}</version>
            </dependency>

        </dependencies>
    </project>
    ```
  ],
)

