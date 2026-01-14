# 源码集成使用

## 两种集成方式

### 方式1：git 源码依赖

在您工程的 `cjpm.toml` 文件中，新增如下源码依赖配置：

```
[dependencies]
  stdx = {git = "https://gitcode.com/Cangjie/cangjie_stdx.git",branch = "dev",output-type = "dynamic" }
```

在您工程的 cjpm.toml 文件所在目录，执行 `cjpm update` 命令即可同步更新本仓源码。

### 方式2：本地源码依赖

如果不希望通过 git 依赖本仓，您也可以直接下载本仓库的全量源码（包括本仓库的 cjpm.toml 配置文件），然后在您工程的 cjpm.toml 文件中添加本地模块依赖。

```
[dependencies]
  stdx = {path = "/path/cangjie_stdx",output-type="dynamic"}
```

然后，您就可以在您项目中使用stdx了

### 包列表

目前源码依赖集成的 stdx 不包含 aspectCJ 和 syntax，同时在 windows 平台上没有 fuzz 包。

## 交叉编译ohos

linux 和 mac 平台交叉编译 ohos 需要配置交叉编译工具链的环境变量（非deveco项目），[请参考编译ohos-x86_64、ohos-aarch64工具链](https://gitcode.com/Cangjie/cangjie_build/blob/dev/docs/linux_ohos_toolchain.md)

1.OHOS_TOOLCHAIN_PATH (编译工具链中 Clang/LLVM 编译器的二进制目录, 如 /opt/buildtools/ohos_root/prebuilts/clang/ohos/linux-x86_64/llvm/bin)

2.OHOS_SYSROOT_PATH (ohos 系统头文件目录， 如 /opt/buildtools/ohos_root/out/sdk/obj/third_party/musl/sysroot)

windows 上 交叉编译 ohos 需要使用 deveco
deveco 自带 ohos 工具链，无需设置上面的环境变量

注：win平台的deveco 需要准备 openssl 头文件，放入deveco的sysroot下, 如 C:\Program Files\Huawei\DevEco Studio\sdk\default\openharmony\native\sysroot\usr\include\openssl

openssl下载地址 : https://slproweb.com/products/Win32OpenSSL.html

## 依赖

由于stdx 需要拉取并编译外部开源 C 库，也有涉及 C 互操作的包，目前构建有一些额外依赖（使用deveco除外，deveco自带了下面的工具），提前准备好下面的依赖，同时配置好环境变量。

### python: >3.7

### cmake: >=3.16.5 且 <4

stdx依赖一些外部三方库，如zlib、boundscheck，所以需要cmake

### ninja: >1.10

### openssl: >3

### clang: >=15.0.4 且 <16 (linux | macos)

### mingw-w64 (windows)

mingw-w64 推荐下载地址：[x86_64-12.2.0-release-posix-seh-msvcrt-rt_v10-rev2.7z](https://github.com/niXman/mingw-builds-binaries/releases/download/12.2.0-rt_v10-rev2/x86_64-12.2.0-release-posix-seh-msvcrt-rt_v10-rev2.7z)