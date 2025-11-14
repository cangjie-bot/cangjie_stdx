# 类

## class TarGzip

```cangjie
public class TarGzip {}
```

功能：压缩和解压目录或流。

### static func archive(Path, (Path) -> Bool, Path, Bool)

```cangjie
public static func archive(fromDir!: Path, filter!: (Path) -> Bool, destFile!: Path, includeBaseDirectory!: Bool): Unit
```

功能：配合过滤函数选择性地将指定目录压缩为 .tar.gz 文件。内部先以 tar 格式归档目录，再以 gzip 压缩归档结果。

参数：

- fromDir!: Path - 待压缩目录。

- filter!: (Path) -> Bool - 过滤函数，会传入遍历到的目录、文件和软链接路径，返回 true 表示保留，否则丢弃。

- destFile!: Path - 输出的 .tar.gz 文件路径。

- includeBaseDirectory!: Bool - 是否包含根目录。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 归档时发生错误，抛出异常。

- [ZlibException](zlib_package_exceptions.md#class-zlibexception) - 如果 zlib 压缩时发生错误，抛出异常。

### static func archive(Path, Path, Bool)

```cangjie
public static func archive(fromDir!: Path, destFile!: Path, includeBaseDirectory!: Bool): Unit
```

功能：将指定目录压缩为 .tar.gz 文件。内部先以 tar 格式归档目录，再以 gzip 压缩归档结果。

参数：

- fromDir!: Path - 待压缩的目录路径。

- destFile!: Path - 生成的 .tar.gz 文件路径。

- includeBaseDirectory!: Bool - 是否包含目录本身作为顶级目录。若为 true，归档包内包含该目录；若为 false，仅包含其内容。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 归档时发生错误，抛出异常。

- [ZlibException](zlib_package_exceptions.md#class-zlibexception) - 如果 zlib 压缩时发生错误，抛出异常。

### static func archive(String, (String) -> Bool, String, Bool)

```cangjie
public static func archive(fromDir!: String, filter!: (String) -> Bool, destFile!: String, includeBaseDirectory!: Bool): Unit
```

功能：配合过滤函数选择性地将指定目录压缩为 .tar.gz 文件。内部先以 tar 格式归档目录，再以 gzip 压缩归档结果。

参数：

- fromDir!: String - 待压缩目录。

- filter!: (String) -> Bool - 过滤函数，会传入遍历到的目录、文件和软链接路径，返回 true 表示保留，否则丢弃。

- destFile!: String - 输出的 .tar.gz 文件路径。

- includeBaseDirectory!: Bool - 是否包含根目录。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 归档时发生错误，抛出异常。

- [ZlibException](zlib_package_exceptions.md#class-zlibexception) - 如果 zlib 压缩时发生错误，抛出异常。

### static func archive(String, String, Bool)

```cangjie
public static func archive(fromDir!: String, destFile!: String, includeBaseDirectory!: Bool): Unit
```

功能：将指定目录压缩为 .tar.gz 文件。内部先以 tar 格式归档目录，再以 gzip 压缩归档结果。

参数：

- fromDir!: String - 待压缩的目录路径。

- destFile!: String - 生成的 .tar.gz 文件路径。

- includeBaseDirectory!: Bool - 是否包含目录本身作为顶级目录。若为 true，归档包内包含该目录；若为 false，仅包含其内容。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 归档时发生错误，抛出异常。

- [ZlibException](zlib_package_exceptions.md#class-zlibexception) - 如果 zlib 压缩时发生错误，抛出异常。

### static func archive\<T>(Path, T, Bool) where T <: OutputStream

```cangjie
public static func archive<T>(fromDir!: Path, destStream!: T, includeBaseDirectory!: Bool): Unit where T <: OutputStream
```

功能：将目录压缩为 .tar.gz 数据并写入指定输出流。

> **注意：**
>
> 函数不负责 destStream 资源的释放，调用方需自行管理该输出流的生命周期。

参数：

- fromDir!: Path - 待压缩的目录路径。

- destStream!: T - 压缩后数据的输出流。

- includeBaseDirectory!: Bool - 是否包含根目录。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 归档时发生错误，抛出异常。

- [ZlibException](zlib_package_exceptions.md#class-zlibexception) - 如果 zlib 压缩时发生错误，抛出异常。

### static func archive\<T>(String, T, Bool) where T <: OutputStream

```cangjie
public static func archive<T>(fromDir!: String, destStream!: T, includeBaseDirectory!: Bool): Unit where T <: OutputStream
```

功能：将目录压缩为 .tar.gz 数据并写入指定输出流。

> **注意：**
>
> 函数不负责 destStream 资源的释放，调用方需自行管理该输出流的生命周期。

参数：

- fromDir!: String - 待压缩的目录路径。

- destStream!: T - 压缩后数据的输出流。

- includeBaseDirectory!: Bool - 是否包含根目录。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 归档时发生错误，抛出异常。

- [ZlibException](zlib_package_exceptions.md#class-zlibexception) - 如果 zlib 压缩时发生错误，抛出异常。

### static func extract(Path, Path, Bool)

```cangjie
public static func extract(fromTarGzip!: Path, destDir!: Path, overwrite!: Bool): Unit
```

功能：将 .tar.gz 文件解压至指定目录。内部先以 gzip 解压缩，再以 tar 解包。

参数：

- fromTarGzip!: Path - 待解压的 .tar.gz 文件路径。

- destDir!: Path - 解压目标目录。

- overwrite!: Bool - 若为 true，允许覆盖已存在文件、目录；否则遇到重名文件、目录将抛出异常。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 提取时发生错误，抛出异常。

- [ZlibException](zlib_package_exceptions.md#class-zlibexception) - 如果 zlib 解压时发生错误，抛出异常。

### static func extract(String, String, Bool)

```cangjie
public static func extract(fromTarGzip!: String, destDir!: String, overwrite!: Bool): Unit
```

功能：将 .tar.gz 文件解压至指定目录。内部先以 gzip 解压缩，再以 tar 解包。

参数：

- fromTarGzip!: String - 待解压的 .tar.gz 文件路径。

- destDir!: String - 解压目标目录。

- overwrite!: Bool - 若为 true，允许覆盖已存在文件、目录；否则遇到重名文件、目录将抛出异常。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 提取时发生错误，抛出异常。

- [ZlibException](zlib_package_exceptions.md#class-zlibexception) - 如果 zlib 解压时发生错误，抛出异常。

### static func extract\<T>(T, Path, Bool) where T <: InputStream

```cangjie
public static func extract<T>(fromStream!: T, destDir!: Path, overwrite!: Bool): Unit where T <: InputStream
```

功能：将 .tar.gz 数据从输入流中读取并解压至指定目录。

参数：

- fromStream!: T - 待解压的 .tar.gz 数据输入流。

- destDir!: Path - 解压目标目录。

- overwrite!: Bool - 若为 true，允许覆盖已存在文件、目录；否则遇到重名文件、目录将抛出异常。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 提取时发生错误，抛出异常。

- [ZlibException](zlib_package_exceptions.md#class-zlibexception) - 如果 zlib 解压时发生错误，抛出异常。
### static func extract\<T>(T, String, Bool) where T <: InputStream

```cangjie
public static func extract<T>(fromStream!: T, destDir!: String, overwrite!: Bool): Unit where T <: InputStream
```

功能：将 .tar.gz 数据从输入流中读取并解压至指定目录。

参数：

- fromStream!: T - 待解压的 .tar.gz 数据输入流。

- destDir!: String - 解压目标目录。

- overwrite!: Bool - 若为 true，允许覆盖已存在文件、目录；否则遇到重名文件、目录将抛出异常。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 提取时发生错误，抛出异常。

- [ZlibException](zlib_package_exceptions.md#class-zlibexception) - 如果 zlib 解压时发生错误，抛出异常。

