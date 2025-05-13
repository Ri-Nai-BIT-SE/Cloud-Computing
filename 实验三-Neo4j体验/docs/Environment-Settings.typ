= 配置环境
== 安装Neo4j

下载在*乐学*上公布的资源：#link("https://lexue.bit.edu.cn/pluginfile.php/722566/mod_assign/introattachment/0/neo4j-community-5.19.0-windows.zip?forcedownload=1", [neo4j-community-5.19.0-windows.zip])。

#figure(
  image("imgs/QQ_1747056264731.png"),
  caption: "压缩包",
)

== 解压至指定位置

我们选择将压缩包解压至 `C:\Program Files\Neo4j` 目录下。

#figure(
  image("imgs/QQ_1747056409388.png"),
  caption: "解压",
)

== 配置环境变量

```powershell
# 设置系统变量 NEO4J_HOME
[Environment]::SetEnvironmentVariable("NEO4J_HOME", "C:\Program Files\Neo4j\neo4j-community-5.19.0", "Machine")

# 将 %NEO4J_HOME%\bin 添加到系统 PATH 的最前面
[Environment]::SetEnvironmentVariable("Path", "%NEO4J_HOME%\bin;" + [Environment]::GetEnvironmentVariable("Path", "Machine"), "Machine")
```

#figure(
  image("imgs/QQ_1747057052456.png"),
  caption: "配置环境变量",
)

== 启动Neo4j

```powershell
neo4j console
```

#figure(
  image("imgs/QQ_1747062571348.png"),
  caption: "启动Neo4j",
)

== 访问Neo4j

在浏览器中访问 #link("http://localhost:7474")，可以看到Neo4j的控制台界面。

#figure(
  image("imgs/QQ_1747062802235.png"),
  caption: "访问Neo4j",
)

=== 登录

在 Username 和 Password 中都输入 `neo4j`，然后会要求你设置密码。

#figure(
  image("imgs/QQ_1747063049258.png"),
  caption: "设置密码",
)

主页面如下：

#figure(
  image("imgs/QQ_1747063278125.png"),
  caption: "主页面",
)

