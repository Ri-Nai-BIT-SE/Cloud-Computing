#import "/book.typ": book-page
#show: book-page.with(title: "Windows 虚拟机")

= Windows 虚拟机

== 安装系统

首先再次重装系统

#figure(
  image("imgs/重装Windows系统.png"),
  caption: "重装Windows系统",
)

== 连接服务器

=== 使用腾讯云终端远程桌面

腾讯云同样提供了远程桌面的功能，可以直接在浏览器中连接

#figure(
  image("imgs/腾讯云远程桌面.png"),
  caption: "腾讯云远程桌面",
)

填入用户名和密码，即可连接

#figure(
  image("imgs/远程桌面登录界面.png"),
  caption: "远程桌面登录界面",
)

连接成功

#figure(
  image("imgs/windows-server网页端.png"),
  caption: "Windows Server网页端",
)

=== 使用 windows 自带的远程桌面
在 `搜索` 中 输入 `远程桌面连接` （或者 `Remote`）
或者 `win + r` 输入 `mstsc`

#figure(
  image("imgs/windows远程桌面.png"),
  caption: "Windows远程桌面",
)

连接时修改 `更多选项` 将，`用户名` 和 `密码` 填入

#figure(
  image("imgs/凭证.png"),
  caption: "输入凭证",
)

连接成功

#figure(
  image("imgs/成功连接.png"),
  caption: "成功连接到Windows服务器",
)
