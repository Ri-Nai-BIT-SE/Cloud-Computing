#import "../../util.typ": *

= 解题过程

== 题目描述

#double-table(
  columns: (1fr, 5fr),
  [
    词频统计进阶版
  ],
  horizontal-table(
    [
      给定一个包含多行文本的RDD，统计每个单词的出现频率
    ],
    double-table(
      [要求],
      horizontal-table(
        [
          过滤长度小于3的单词
        ],
        [
          #set par(first-line-indent: 0em)
          排除停用词

          给定集合：
          ```scala
          val stopwords = Set("the", "and", "of", "to")
          ```
        ],
        [
          按词频降序排列，输出前10个结果
        ],
      ),
    ),
  ),
)

== 解题思路


=== 总体逻辑


这本质上是一个 *`MapReduce` 模型* 的典型应用：
- *Map阶段*：将每行文本拆分成单词，并清洗、过滤；
- *Shuffle/Reduce阶段*：对相同单词进行计数；
- *排序和输出*：按照频率排序并取 Top 10。


=== 流程详解

#double-table(
  columns: (1fr, 5fr),
  [初始化 Spark 环境],
  horizontal-table(
    [
      创建并配置 `SparkConf` 对象：
    ],
    [
      ```scala
      val conf = new SparkConf()
                    .setAppName("WordCountAdvanced")
                    .setMaster("local[*]")
      val sc = new SparkContext(conf)
      ```
    ],
    [
      `SparkConf()`：创建配置对象，用于设置Spark应用的各种参数
    ],
    [
      `setAppName()`：设置应用名称，在Spark UI中显示
    ],
    [
      `setMaster("local[*]")`：指定运行模式，这里是本地模式并使用所有可用核心
    ],
    [
      #set par(first-line-indent: 0em)

      实例化 `SparkContext`：

      `SparkContext`：Spark的主入口点，负责与集群连接并协调资源分配
      一个Spark应用只能有一个活跃的SparkContext实例
    ],
  ),
  [读取输入数据],
  horizontal-table(
    [
      使用 `textFile` 方法加载文本数据：
    ],
    [
      ```scala
      val textRDD = sc.textFile(inputPath)
      ```
    ],
    [
      #set par(first-line-indent: 0em)

      `textFile`：SparkContext的方法，从外部存储（本地文件系统、HDFS等）读取文本文件

      返回类型为 `RDD[String]`，每行文本作为RDD的一个元素
    ],
    [
      RDD（弹性分布式数据集）是Spark的核心数据结构，支持并行操作且具有容错性
    ],
  ),
  [数据保存辅助函数],
  horizontal-table(
    [
      使用自定义函数保存数据到本地文件：
    ],
    [
      ```scala
      saveToFile(textRDD.collect(), "output/raw_data.txt")
      ```
    ],
    [
      #set par(first-line-indent: 0em)

      `collect()`：RDD的行动算子，将分布在各节点的数据收集到驱动程序内存中

      注意：在大数据场景下应谨慎使用collect()，因为可能导致内存溢出
    ],
    [
      `saveToFile`：自定义方法，封装了Java IO操作，用于将数据写入指定路径的文件
    ],
  ),
  [定义停用词集合],
  horizontal-table(
    [
      创建不可变集合存储停用词：
    ],
    [
      ```scala
      val stopwords = Set("the", "and", "of", "to")
      ```
    ],
    [
      #set par(first-line-indent: 0em)
      `Set`：Scala的不可变集合类型，存储唯一元素且无序

      适合用于快速查找（如contains操作），时间复杂度为O(1)

      这里定义的停用词将在后续过滤步骤中使用
    ],
  ),
  [核心处理逻辑],
  double-table(
    columns: (1fr, 5fr),

    [ 分割成单词 ],
    horizontal-table(
      [
        使用 `flatMap` 将文本行转换为单词流：
      ],
      [
        ```scala
        .flatMap(line => line.split("\\s+"))
        ```
      ],
      [
        `flatMap`：转换算子，将每个输入元素映射为0到多个输出元素
      ],
      [
        `split("\\s+")`：Java字符串方法，使用正则表达式按一个或多个空白字符分割字符串
      ],
      [
        `\\s+`：正则表达式，匹配一个或多个空白字符（空格、制表符、换行符等）
      ],
      [
        最终将每行文本展平为单词序列，便于后续处理
      ],
    ),
    [ 清洗所有非字母数字字符 ],
    horizontal-table(
      [
        使用 `map` 对每个单词进行标准化和清洗：
      ],
      [
        ```scala
        .map(word => word.toLowerCase.replaceAll("[^a-z0-9]", ""))
        ```
      ],

      [
        `map`：转换算子，对RDD中的每个元素应用给定函数
      ],
      [
        `toLowerCase()`：Java字符串方法，将所有字符转换为小写
      ],
      [
        `replaceAll("[^a-z0-9]", "")`：使用正则表达式替换所有非字母数字字符
      ],
      [
        `[^a-z0-9]`：正则表达式，匹配任何不是小写字母或数字的字符
      ],
    ),
    [ 过滤长度小于3的单词 ],
    horizontal-table(
      [
        使用 `filter` 筛选出符合长度要求的单词：
      ],
      [
        ```scala
        .filter(word => word.length >= 3)
        ```
      ],
      [
        `filter`：转换算子，保留满足指定条件的元素
      ],
      [
        `word.length`：Java字符串属性，返回字符串的长度
      ],
      [
        这里保留长度大于等于3的单词，过滤掉短单词
      ],
    ),
    [ 过滤停用词 ],
    horizontal-table(
      [
        使用 `filter` 移除常见的停用词：
      ],
      [
        ```scala
        .filter(word => !stopwords.contains(word))
        ```
      ],
      [
        `stopwords.contains(word)`：集合方法，检查元素是否存在于集合中
      ],
      [
        `!` 运算符对结果取反，保留不在停用词集合中的单词
      ],
    ),
    [ 过滤空字符串 ],
    horizontal-table(
      [
        使用 `filter` 移除清洗后可能产生的空字符串：
      ],
      [
        ```scala
        .filter(word => word.nonEmpty)
        ```
      ],
      [
        #set par(first-line-indent: 0em)
        `nonEmpty`：Scala集合与字符串的方法，检查是否不为空

        等价于 `!word.isEmpty`，但更符合Scala的函数式风格
      ],
    ),
    [ 映射为键值对 ],
    horizontal-table(
      [
        使用 `map` 将单词转换为计数键值对：
      ],
      [
        ```scala
        .map(word => (word, 1))
        ```
      ],
      [
        #set par(first-line-indent: 0em)
        `(word, 1)`：Scala元组表示法，创建包含单词和初始计数1的二元组

        这种转换为后续的归约操作做准备
      ],
    ),
    [ 合并相同单词 ],
    horizontal-table(
      [
        使用 `reduceByKey` 聚合相同单词的计数：
      ],
      [
        ```scala
        .reduceByKey(_ + _)
        ```
      ],
      [
        `reduceByKey`：键值对RDD的转换算子，按键聚合值
      ],
      [
        #set par(first-line-indent: 0em)

        `_ + _`：Scala简写语法，表示将相同键的值相加

        完整形式为 `(count1, count2) => count1 + count2`
      ],
      [
        操作结果是每个单词及其在文本中的总出现次数
      ],
    ),
  ),
  [ 排序与取 Top 10 ],
  horizontal-table(
    [
      使用排序和限制操作获取频率最高的单词：
    ],
    [
      ```scala
      .sortBy(-_._2)
      .take(10)
      ```
    ],
    [
      `sortBy`：转换算子，根据指定函数对RDD元素排序
    ],
    [
      `-_._2`：Scala表达式，取元组的第二个元素（计数值）并取负，实现降序排序
    ],
    [
      `_._2` 引用元组的第二个元素，前置负号使大值排在前面
    ],
    [
      #set par(first-line-indent: 0em)

      `take(n)`：行动算子，从RDD中获取前n个元素

      与`collect()`不同，`take()`只返回指定数量的元素，更加高效
    ],
  ),
  [ 输出结果 ],
  horizontal-table(
    [
      在程序运行时突出显示统计结果
    ],
    [
      ```scala
      println("\n" + "=" * 50)
      println("【词频统计结果】前10个高频词：")
      println("=" * 50)
      topWords.foreach(word => println(s"${word._1}: ${word._2}"))
      println("=" * 50 + "\n")
      ```
    ],
  ),
  [ 停止 SparkContext ],
  horizontal-table(
    [
      结束Spark应用程序生命周期：
    ],
    [
      ```scala
      sc.stop()
      ```
    ],
  ),
)


== 程序实现


```scala
package org.example.wordcount

import org.apache.spark.{SparkConf, SparkContext}

import java.io.{File, PrintWriter}

object WordCount {
  def main(args: Array[String]): Unit = {
    // 初始化 Spark 上下文
    val conf = new SparkConf().
      setAppName("WordCountAdvanced").
      setMaster("local[*]")
    val sc = new SparkContext(conf)

    // 从文件读取数据
    val inputPath = "input.txt"
    val textRDD = sc.textFile(inputPath)

    // 使用普通文件IO保存原始数据
    saveToFile(textRDD.collect(), "output/raw_data.txt")

    // 停用词集合
    val stopwords = Set("the", "and", "of", "to")

    // 处理流程
    val wordCounts = textRDD
      .map(line => line.replaceAll("[^A-Za-z0-9]", " "))
      .flatMap(line => line.split("\\s+")) // 分割成单词
      .map(word => word.toLowerCase) // 清洗所有非字母数字字符
      .filter(word => word.length >= 3) // 过滤长度小于3的单词
      .filter(word => !stopwords.contains(word)) // 过滤停用词
      .filter(word => word.nonEmpty) // 确保清洗后单词不为空
      .map(word => (word, 1)) // 转换为键值对
      .reduceByKey(_ + _) // 合并相同单词

    // 按照词频降序排序，并取前10个
    val topWords = wordCounts
      .sortBy(-_._2)
      .take(10)

    // 在控制台打印Top10单词及其频率
    println("\n" + "=" * 50)
    println("【词频统计结果】前10个高频词：")
    println("=" * 50)
    topWords.foreach(word => println(s"${word._1}: ${word._2}"))
    println("=" * 50 + "\n")

    // 使用普通文件IO保存top10结果
    saveToFile(topWords.map(p => s"${p._1}: ${p._2}"), "output/top10_words.txt")

    // 使用普通文件IO保存所有单词结果
    val allWordsSorted = wordCounts.sortBy(-_._2).collect()
    saveToFile(allWordsSorted.map(p => s"${p._1}: ${p._2}"), "output/all_words.txt")

    // 停止 SparkContext
    sc.stop()
  }

  // 辅助方法：将数据保存到文件
  private def saveToFile(data: Array[String], filePath: String): Unit = {
    val dir = new File(filePath).getParentFile
    if (!dir.exists()) {
      dir.mkdirs()
    }

    val writer = new PrintWriter(new File(filePath))
    try {
      data.foreach(line => writer.println(line))
    } finally {
      writer.close()
    }
  }

}

```

