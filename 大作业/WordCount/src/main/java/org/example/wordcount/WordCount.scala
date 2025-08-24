package org.example.wordcount

import org.apache.spark.{SparkConf, SparkContext}

import java.io.{File, PrintWriter}

object WordCount {
  def main(args: Array[String]): Unit = {
    // 初始化 Spark 上下文
    val conf = new SparkConf()
      .setAppName("WordCountAdvanced")
      .setMaster("local[*]")
      .set("spark.ui.port", "8088")  // 设置UI端口为8088

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
