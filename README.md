# gitbbs

> 一款以github仓库为数据源的开源论坛客户端，客户端使用flutter框架进行开发,3分钟即可搭建一个论坛

### 用途

1. 为你的开源项目搭建一个论坛
2. 搭建一个技术分享的论坛
3. 更多用途等你发掘


### 功能介绍

软件是一款以github仓库为数据源的开源论坛客户端，客户端使用flutter框架进行开发。已支持查看，发布，修改，回复等功能。具体功能请下载体验


### 软件截图

![](https://i.loli.net/2019/04/02/5ca320a8c67f5.png)

[图片较大，更多点击查看](capture.md)

### 下载体验

##### Android 下载

[https://github.com/WrBug/gitbbs-flutter/releases](https://github.com/WrBug/gitbbs-flutter/releases)

##### iOS 下载

暂无下载地址，请自行编译，或者使用Android模拟器


### 创建自己的论坛

假设你已经了解flutter工程的构建，并且有一定的开发能力

1. clone 项目到本地
2. fork [https://github.com/gitbbsgroup/gitbbs-forum](https://github.com/gitbbsgroup/gitbbs-forum) 项目
3. 修改iOS 与 Android 原生工程的图标与包名
4. 修改 `lib/constant` 中各个`.dart`文件的配置，根据注释修改
5. 构建工程

``` shell
#最好有代理
flutter packages get
flutter packages pub run build_runner build
flutter run
```

### BUG反馈

bug反馈请在客户端发帖反馈，或者前往[https://github.com/gitbbsgroup/gitbbs-forum/issues](https://github.com/gitbbsgroup/gitbbs-forum/issues)

