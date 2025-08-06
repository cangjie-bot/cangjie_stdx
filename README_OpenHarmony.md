# cangjie_stdx

仓颉编程语言提供了 `stdx` 模块，该模块提供了网络、安全等领域的通用能力。`stdx` 的 API 详细说明请参见[资料](./doc/libs_stdx/summary_cjnative.md)。

## 目录结构

```
/stdx
├─ build                        # 工程构建目录，编译构建工具、脚本等
├─ build_temp                   # 工程构建的临时目录
├─ doc                          # STDX 库资料目录
├─ src                          # STDX 各个包代码目录                        
│   └─ stdx                     
│       ├── aspectCJ            # 提供 AOP 功能
│       ├── compress            # 提供压缩和解压缩功能
│       ├── crypto              # 提供安全相关能力
│       ├── dynamicLoader       # Openssl 动态加载模块
│       ├── encoding            # 提供 JSON 和字符串编码相关能力。
│       ├── fuzz                # 提供基于覆盖率反馈的仓颉 fuzz 引擎及对应的接口
│       ├── log                 # 提供了日志记录相关的能力
│       ├── logger              # 提供文本格式和 JSON 格式日志打印功能
│       ├── net                 # 提供网络通信等能力
│       ├── serialization       # 提供序列化和反序列化能力
│       └─  unittest            # 提供单元测试扩展能力
│
├─ third_party                  # 第三方组件目录
└─ target                       # 编译构建产物目录
```

## OpenHarmony如何使用stdx

`stdx` 提供静态和动态两种二进制 ，两者独立使用，OpenHarmony下开发者可根据实际情况引用。

## OpenHarmony如何集成stdx

stdx编译出二进制，在代码工程的 `cjpm.toml` 进行配置导入。

### 1. stdx的编译

参考[OHOS 仓颉SDK构建指导书 (Ubuntu 22.04)](https://gitcode.com/Cangjie/cangjie_build/blob/dev/docs/linux_ohos_zh.md)

### 2. 使用stdx

开发者使用 DevEco Studio 开发时， `cjpm.toml` 配置文件中会自带 `target` 信息，因此，该场景仅需要修改 `path-option` 表示的 `stdx` 路径。

由于真机和模拟器的环境信息不同（真机系统信息为 `target.aarch64-linux-ohos`，模拟器为 `target.x86_64-linux-ohos` ），所以请根据程序实际编译调测的环境修改对应位置的配置信息。

```toml
[target]
  [target.aarch64-linux-ohos]
    compile-option = ""
    [target.aarch64-linux-ohos.bin-dependencies]
      path-option = [ "D:\\cangjiestdx\\linux_ohos_aarch64_llvm\\dynamic\\stdx" ]  # 手机调测在此处配置，stdx 路径根据实际情况配置
      [target.aarch64-linux-ohos.bin-dependencies.package-option]
  [target.x86_64-linux-ohos]
    compile-option = ""
    [target.x86_64-linux-ohos.bin-dependencies]
      path-option = ["D:\\cangjiestdx\\linux_ohos_x86_64_llvm\\dynamic\\stdx" ]    # 模拟器调测在此处配置，stdx 路径根据实际情况配置
```

**配置示例**：此处给出 Windows 环境（架构为 x86_64）下，使用 DevEco Studio 开发，且程序在真机环境编译调测的 `cjpm.toml` 配置示例。

```toml
[target]
  [target.aarch64-linux-ohos]
    compile-option = ""
    [target.aarch64-linux-ohos.bin-dependencies]
      path-option = [  "D:\\cangjiestdx\\linux_ohos_aarch64_llvm\\dynamic\\stdx" ] # stdx 路径根据实际情况配置
      [target.aarch64-linux-ohos.bin-dependencies.package-option]
  [target.x86_64-linux-ohos]
    compile-option = ""
    [target.x86_64-linux-ohos.bin-dependencies]
      path-option = []
  [target.x86_64-unknown-windows-gnu]
    [target.x86_64-unknown-windows-gnu.bin-dependencies]
      path-option = []
      [target.x86_64-unknown-windows-gnu.bin-dependencies.package-option]

[package]
  cjc-version = "0.48.2"
  compile-option = "--dy-std"
  description = "CangjieUI Application"
  link-option = ""
  name = "ohos_app_cangjie_entry"
  output-type = "dynamic"
  src-dir = "./src/main/cangjie"
  target-dir = ""
  version = "1.0.0"
  [package.package-configuration]
  [package.scripts]

[profile]
  [profile.build]
    incremental = true
    lto = ""
    [profile.build.combined]
      ohos_app_cangjie_entry = "dynamic"
  [profile.customized-option]
    debug = "-g -Woff all"
    release = "--fast-math -O2 -s -Woff all"
  [profile.test]
```

## License 许可

本项目开源许可请参阅 [LICENSE](LICENSE)。