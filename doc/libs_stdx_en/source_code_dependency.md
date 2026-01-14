# Source Code Integration

## Two Integration Methods: git source code dependency and local Source Code Dependency

### git source code dependency

In your project's `cjpm.toml` file, add the following source code dependency configuration:

```
[dependencies]
  stdx = { git = "https://gitcode.com/Cangjie/cangjie_stdx.git", branch = "dev", output-type = "dynamic" }
```

In the directory where your project's cjpm.toml file is located, execute the `cjpm update` command to synchronously update the source code of this repository.

### local Source Code Dependency

If you do not want to depend on this repository via git, you can also directly download the full source code of this repository (including its cjpm.toml configuration file), and then add a local module dependency in your project's cjpm.toml file.

```
[dependencies]
  stdx = { path = "/path/cangjie_stdx", output-type="dynamic"}
```

Then, you can use stdx in your project.

## Package Scope

Currently, the integrated stdx for source code dependencies does not include aspectCJ and syntax, and there is no fuzz package on the Windows platform.

## Cross-compiling OpenHarmony

Cross-compiling OpenHarmony on Linux and macOS platforms requires configuring environment variables for the cross-compilation toolchain (non DevEco Studio projects). [Please refer to compiling ohos-x86_64 and ohos-aarch64 toolchains](https://gitcode.com/Cangjie/cangjie_build/blob/dev/docs/linux_ohos_toolchain.md)

1. OHOS_TOOLCHAIN_PATH (Binary directory of Clang/LLVM compiler in the compilation toolchain, e.g., /opt/buildtools/ohos_root/prebuilts/clang/ohos/linux-x86_64/llvm/bin)

2. OHOS_SYSROOT_PATH (OpenHarmony system header directory, e.g., /opt/buildtools/ohos_root/out/sdk/obj/third_party/musl/sysroot)

Cross-compiling OpenHarmony on Windows requires using DevEco Studio.
DevEco Studio comes with its own OpenHarmony toolchain, so there is no need to set the environment variables above.

> **Note**:
>
> Some versions of DevEco Studio may lack openssl header files. If the build process reports an error stating that openssl header files cannot be found, you need to prepare the openssl header files and place them in the sysroot of DevEco Studio. openssl [Download Link](https://slproweb.com/products/Win32OpenSSL.html)
>
> - Common Windows paths such as C:\Program Files\Huawei\DevEco Studio\sdk\default\openharmony\native\sysroot\usr\include\openssl.
>
> - Common macOS paths such as  /Applications/DevEco-Studio.app/Contents/sdk/default/openharmony/native/sysroot/usr/include/openssl

## Dependencies

Since stdx needs to pull and compile external open-source C libraries, and there are also packages involving C interoperability, the current build has some additional dependencies (except when using DevEco Studio, which comes with the following tools). Please prepare the following dependencies in advance and configure the environment variables.

- python: >3.7
- cmake: >=3.16.5 and <4
- ninja: >1.10
- openssl: >3
- clang: >=15.0.4 and <16 (Linux or macOS)
- mingw-w64 (Windows) [Download link](https://github.com/niXman/mingw-builds-binaries/releases/download/12.2.0-rt_v10-rev2/x86_64-12.2.0-release-posix-seh-msvcrt-rt_v10-rev2.7z)