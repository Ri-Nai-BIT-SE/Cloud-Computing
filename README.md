# 云计算及应用实验报告

这是一个基于 [Shiroa](https://github.com/Myriad-Dreamin/shiroa) 架构的云计算课程实验报告项目。

## 项目结构

```
Cloud-Computing/
├── book.typ              # 主要的书籍配置文件
├── ebook.typ             # 电子书模板
├── build.sh              # Linux/macOS 构建脚本
├── build.bat             # Windows 构建脚本
├── templates/            # 模板文件
│   ├── page.typ          # 页面模板
│   └── theme-style.toml  # 主题配置
├── pages/                # 内容页面
│   ├── Introduction.typ  # 项目介绍
│   ├── experiments/      # 实验报告
│   │   ├── 1/           # 实验一：云服务体验
│   │   └── 3/           # 实验三：Neo4j体验
│   └── assignments/      # 大作业
│       └── ...          # 词频统计大作业
├── util.typ              # 工具函数
└── dist/                 # 构建输出目录
```

## 内容概览

### 实验部分
- **实验一**: 云服务体验 - 体验Linux和Windows虚拟机的使用
- **实验三**: Neo4j体验 - 学习图数据库的使用和CQL查询语言

### 大作业部分  
- **词频统计**: 使用Scala和Hadoop实现分布式词频统计程序

## 如何构建

### 前提条件
确保已安装：
- [Typst](https://typst.app/)
- [Shiroa](https://github.com/Myriad-Dreamin/shiroa)

### 构建命令

**Linux/macOS:**
```bash
./build.sh
```

**Windows:**
```bat
build.bat
```

构建完成后，生成的网站将在 `dist/` 目录中。

## 技术栈

- **Typst**: 现代化的排版系统
- **Shiroa**: 基于Typst的静态网站生成器
- **云计算技术**: 腾讯云、Linux、Windows Server、Neo4j、Hadoop、Scala
