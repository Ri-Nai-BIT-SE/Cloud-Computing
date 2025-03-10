
= Linux 虚拟机

== 购买服务器

先前在寒假期间购置了一台 腾讯云 的轻量应用服务器，想自己试试把博客搭建在上面，同时学习一下 `docker` 的使用。

配置在图中有显示：

#figure(
  image("imgs/消费记录.png"),
  caption: "消费记录",
)

== 安装系统

由于目前在上面有我几个比较常用的服务，因此需要先将当前的服务器制作为镜像，以便于后续的使用。

在实例列表中找到正在运行的实例，并点击制作镜像：

#figure(
  image("imgs/制作镜像.png"),
  caption: "制作镜像",
)

过了大概 10 分钟，镜像制作完成，我们选择重装系统

#figure(
  image("imgs/重装系统.png"),
  caption: "重装系统",
)

个人使用，出于习惯选了 `Ubuntu 24.04` ，然后设置密码

#figure(
  image("imgs/选择系统.png"),
  caption: "选择系统",
)

#figure(
  image("imgs/设置密码.png"),
  caption: "设置密码",
)

可以看到正在重装中

#figure(
  image("imgs/正在重装.png"),
  caption: "正在重装",
)

看到系统盘只剩 `5G` 左右的占用，代表重装完成了

#figure(
  image("imgs/重装完成.png"),
  caption: "重装完成",
)

== 连接服务器

=== 使用腾讯云终端

腾讯云提供了一个在线的终端 `WebUI` ，可以直接在浏览器中连接服务器

#figure(
  image("imgs/腾讯云终端入口.png"),
  caption: "腾讯云终端入口",
)

点击登录，即可连接到服务器

#figure(
  image("imgs/腾讯云终端.png"),
  caption: "腾讯云终端",
)

=== 使用 `ssh` 连接

输入命令 ```bash ssh ubuntu@<server-ip>```

#figure(
  image("imgs/不配置使用ssh连接.png"),
  caption: "未配置使用SSH连接",
)

翻阅资料，需要删除旧的配置。

输入命令 `ssh-keygen -R <server-ip>`

#figure(
  image("imgs/删除旧配置.png"),
  caption: "删除旧配置",
)

然后再次 `ssh` 连接，输入密码即可

#figure(
  image("imgs/连接成功1.png"),
  caption: "连接成功1",
)

#figure(
  image("imgs/连接成功2.png"),
  caption: "连接成功2",
)

=== 使用 `VSCode-SSH` 连接

对于一些文件操作，我还是更喜欢用图形化的界面，而 `VSCode` 对于远程开发的支持非常好，平时一般都是用它来连接服务器。

#figure(
  image("imgs/新建VSCode窗口.png"),
  caption: "新建VSCode窗口",
)

点击左下角的 `打开远程窗口`，然后点击 `连接到主机-Remote-SSH`

#figure(
  image("imgs/VSCode远程连接.png"),
  caption: "VSCode远程连接",
)

点击 `添加新的 SSH 主机`

输入 ```bash ssh ubuntu@<server-ip>```

然后选择存 `ssh` 密钥的文件，我这里选择在用户目录下的

#figure(
  image("imgs/设置配置.png"),
  caption: "设置配置",
)

然后就可以连接了

选择打开文件夹

#figure(
  image("imgs/打开文件夹.png"),
  caption: "打开文件夹",
)

默认打开到 `/home/ubuntu(username)` 目录下，即 `~` 目录

可以看到侧边栏的文件树已经显示了服务器上的文件

#figure(
  image("imgs/服务器的文件.png"),
  caption: "服务器的文件",
)

== 简单的使用

课件内提到的命令有这些：

1. 通过 ```bash mkdir``` 新建一个以姓名全拼命名的文件夹；
2. 通过 ```bash cd``` 进如文件夹，使用 ```bash vim``` 在文件夹中新建 `hello` 文件；
3. 在 `hello` 输入中输入 ```bash echo "Hello Cloud Computing"``` ；
4. 使用 ```bash ls``` 查看文件；
5. 为 `hello` 文件增加执行权限 ```bash chmod +x hello```；
6. 执行 ```bash ./hello``` 查看结果；
7. 使用 ```bash rm``` 删除文件夹 ```bash rm -rf 文件夹名```。

以下是我在服务器上的操作

#figure(
  image("imgs/操作打码.png"),
  caption: "操作演示",
)

#figure(
  image("imgs/vim-use.png"),
  caption: "使用vim",
)

== 简单的配置

因为我习惯用 `zsh`，所以安装了 `zsh` 和 `oh-my-zsh`，主要是为了好看以及方便使用。（优秀的自动补全和高亮插件）

=== `zsh`
```bash
sudo apt install -y zsh # 安装 zsh
sudo usermod -s /bin/zsh ubuntu # 切换默认 shell
```

=== `oh-my-zsh`

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

=== 插件

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
```

修改 `.zshrc` 文件，添加插件
```bash
sudo vim ~/.zshrc
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-completions)
```

=== 主题：`Powerlevel10k`

```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

修改 `.zshrc` 文件，添加主题

```bash
ZSH_THEME="powerlevel10k/powerlevel10k"
```
重启终端，根据提示配置主题。

最终效果如下

#figure(
  image("imgs/最终效果.png"),
  caption: "终端最终效果",
)

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
