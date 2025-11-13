# 类

## class Tar

```cangjie
public class Tar {}
```

功能：归档和提取目录或流。

### static func archive(String, String, Bool)

```cangjie
public static func archive(fromDir!: String, destFile!: String, includeBaseDirectory!: Bool): Unit
```

功能：将指定目录归档为 .tar 文件。

参数：

- fromDir!: String - 待归档的目录路径。

- destFile!: String - 生成的 .tar 文件路径。

- includeBaseDirectory!: Bool - 是否包含目录本身作为顶级目录。若为 true，归档包内包含该目录；若为 false，仅包含其内容。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 归档时发生错误，抛出异常。

### static func archive(Path, Path, Bool)

```cangjie
public static func archive(fromDir!: Path, destFile!: Path, includeBaseDirectory!: Bool): Unit
```

功能：将指定目录归档为 .tar 文件。

参数：

- fromDir!: Path - 待归档的目录路径。

- destFile!: Path - 生成的 .tar 文件路径。

- includeBaseDirectory!: Bool - 是否包含目录本身作为顶级目录。若为 true，归档包内包含该目录；若为 false，仅包含其内容。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 归档时发生错误，抛出异常。

### static func archive\<T>(String, T, Bool) where T <: OutputStream

```cangjie
public static func archive<T>(fromDir!: String, destStream!: T, includeBaseDirectory!: Bool): Unit where T <: OutputStream
```

功能：将目录归档为 .tar 数据并写入指定输出流。

> **注意：**
>
> 函数不负责 destStream 资源的释放，调用方需自行管理该输出流的生命周期。

参数：

- fromDir!: String - 待归档的目录路径。

- destStream!: T - 归档后数据的输出流。

- includeBaseDirectory!: Bool - 是否包含根目录。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 归档时发生错误，抛出异常。

### static func archive\<T>(Path, T, Bool) where T <: OutputStream

```cangjie
public static func archive<T>(fromDir!: Path, destStream!: T, includeBaseDirectory!: Bool): Unit where T <: OutputStream
```

功能：将目录归档为 .tar 数据并写入指定输出流。

> **注意：**
>
> 函数不负责 destStream 资源的释放，调用方需自行管理该输出流的生命周期。

参数：

- fromDir!: Path - 待归档的目录路径。

- destStream!: T - 归档后数据的输出流。

- includeBaseDirectory!: Bool - 是否包含根目录。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 归档时发生错误，抛出异常。

### static func archive(String, (String) -> Bool, String, Bool)

```cangjie
public static func archive(fromDir!: String, filter!: (String) -> Bool, destFile!: String, includeBaseDirectory!: Bool): Unit
```

功能：配合过滤函数选择性地将指定目录归档为 .tar 文件。

参数：

- fromDir!: String - 待归档目录。

- filter!: (String) -> Bool - 过滤函数，会传入遍历到的目录、文件和软链接路径，返回 true 表示保留，否则丢弃。

- destFile!: String - 输出的 .tar 文件路径。

- includeBaseDirectory!: Bool - 是否包含根目录。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 归档时发生错误，抛出异常。

### static func archive(Path, (Path) -> Bool, Path, Bool)

```cangjie
public static func archive(fromDir!: Path, filter!: (Path) -> Bool, destFile!: Path, includeBaseDirectory!: Bool): Unit
```

功能：配合过滤函数选择性地将指定目录归档为 .tar 文件。

参数：

- fromDir!: Path - 待归档目录。

- filter!: (Path) -> Bool - 过滤函数，会传入遍历到的目录、文件和软链接路径，返回 true 表示保留，否则丢弃。

- destFile!: Path - 输出的 .tar 文件路径。

- includeBaseDirectory!: Bool - 是否包含根目录。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 归档时发生错误，抛出异常。

### static func extract(String, String, Bool)

```cangjie
public static func extract(fromTar!: String, destDir!: String, overwrite!: Bool): Unit
```

功能：将 .tar 文件提取至指定目录。

参数：

- fromTar!: String - 待提取的 .tar 文件路径。

- destDir!: String - 提取目标目录。

- overwrite!: Bool - 若为 true，允许覆盖已存在文件、目录；否则遇到重名文件、目录将抛出异常。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 提取时发生错误，抛出异常。

### static func extract(Path, Path, Bool)

```cangjie
public static func extract(fromTar!: Path, destDir!: Path, overwrite!: Bool): Unit
```

功能：将 .tar 文件提取至指定目录。

参数：

- fromTar!: Path - 待提取的 .tar 文件路径。

- destDir!: Path - 提取目标目录。

- overwrite!: Bool - 若为 true，允许覆盖已存在文件、目录；否则遇到重名文件、目录将抛出异常。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 提取时发生错误，抛出异常。

### static func extract\<T>(T, String, Bool) where T <: InputStream

```cangjie
public static func extract<T>(fromStream!: T, destDir!: String, overwrite!: Bool): Unit where T <: InputStream
```

功能：将 .tar 数据从输入流中读取并提取至指定目录。

参数：

- fromStream!: T - 待提取的 .tar 数据输入流。

- destDir!: String - 提取目标目录。

- overwrite!: Bool - 若为 true，允许覆盖已存在文件、目录；否则遇到重名文件、目录将抛出异常。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 提取时发生错误，抛出异常。

### static func extract\<T>(T, Path, Bool) where T <: InputStream

```cangjie
public static func extract<T>(fromStream!: T, destDir!: Path, overwrite!: Bool): Unit where T <: InputStream
```

功能：将 .tar 数据从输入流中读取并提取至指定目录。

参数：

- fromStream!: T - 待提取的 .tar 数据输入流。

- destDir!: Path - 提取目标目录。

- overwrite!: Bool - 若为 true，允许覆盖已存在文件、目录；否则遇到重名文件、目录将抛出异常。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 tar 提取时发生错误，抛出异常。

## class TarEntry

```cangjie
public abstract class TarEntry {
    protected init(path: String)
    protected init(path: Path)
}
```

功能：表示一个 tar 文件中的条目，用于和 [TarReader](tar_package_classes.md#class-tarreader) 和 [TarWriter](tar_package_classes.md#class-tarwriter) 进行交互。可从 [TarReader](tar_package_classes.md#class-tarreader) 中获取 [TarEntry](tar_package_classes.md#class-tarentry) 实例，表示 tar 归档文件中的一个条目。也可通过 [TarWriter](tar_package_classes.md#class-tarwriter) 将其写入到 tar 归档文件中。

### prop stream: ?InputStream

```cangjie
public prop stream: ?InputStream
```

功能：获取当前条目的输入流。如果实例由 [TarReader](tar_package_classes.md#class-tarreader) 创建，则本属性返回流中为条目的数据，若条目没有数据则返回 None。如果实例由构造函数创建，则本属性返回的是创建的文件流，传入 [TarWriter](tar_package_classes.md#class-tarwriter) 时会调用该属性用于写入条目数据。

类型：Option\<InputStream>

### prop name: String

```cangjie
public mut prop name: String
```

功能：获取当前条目的文件名。

类型：String

### prop mode: Int32

```cangjie
public mut prop mode: Int32
```

功能：获取当前条目的权限模式。

类型：Int32

### prop uid: Int32

```cangjie
public mut prop uid: Int32
```

功能：获取当前条目的用户 ID。

类型：Int32

### prop gid: Int32

```cangjie
public mut prop gid: Int32
```

功能：获取当前条目的组 ID。

类型：Int32

### prop size: Int64

```cangjie
public prop size: Int64
```

功能：获取当前条目的大小。

类型：Int64

### prop modificationTime: DateTime

```cangjie
public prop modificationTime: DateTime
```

功能：获取当前条目的最后修改时间。

类型：DateTime

### prop entryType: TarEntryType

```cangjie
public prop entryType: TarEntryType
```

功能：获取当前条目的条目类型。

类型：[TarEntryType](tar_package_enums.md#enum-tarentrytype)

### init(String)

```cangjie
protected init(path: String)
```

功能：从文件、目录、软链接构造一个 tar 文件条目。

参数：

- path: String - 文件、目录、软链接的路径。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 path 参数指定的目标不存在或不是文件、目录、软链接，则抛出异常。

- FSException - 如果读取目标信息或创建目标文件流失败，则抛出异常。

### init(Path)

```cangjie
protected init(path: Path)
```

功能：从文件、目录、软链接构造一个 tar 文件条目。

参数：

- path: Path - 文件、目录、软链接的路径。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 path 参数指定的目标不存在或不是文件、目录、软链接，则抛出异常。

- FSException - 如果读取目标信息或创建目标文件流失败，则抛出异常。

### func writeTo(OutputStream)

```cangjie
public open func writeTo(target: OutputStream): Unit
```

功能：将当前条目写入到指定的输出流中。

参数：

- target: OutputStream - 指定输出流。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果字段超出格式要求或写入失败，则抛出异常。

## class V7TarEntry

```cangjie
public class V7TarEntry <: TarEntry {
    public init(filePath: String)
    public init(filePath: Path)
}
```

功能：表示 V7 tar 文件条目。

父类型：

- [TarEntry](#class-tarentry)

### init(String)

```cangjie
public init(filePath: String)
```

功能：从文件、目录、软链接构造一个 V7 tar 文件条目。

参数：

- filePath: String - 文件、目录、软链接的路径。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 filePath 参数指定的目标不存在或不是文件、目录、软链接，则抛出异常。

- FSException - 如果读取目标信息或创建目标文件流失败，则抛出异常。

### init(Path)

```cangjie
public init(filePath: Path)
```

功能：从文件、目录、软链接构造一个 V7 tar 文件条目。

参数：

- filePath: Path - 文件、目录、软链接的路径。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 filePath 参数指定的目标不存在或不是文件、目录、软链接，则抛出异常。

- FSException - 如果读取目标信息或创建目标文件流失败，则抛出异常。

## class PosixTarEntry

```cangjie
public abstract class PosixTarEntry <: TarEntry {
    protected init(path: String)
    protected init(path: Path)
}
```

功能：表示含有 Ustar Gnu Pax 格式共有字段的 tar 文件条目。

父类型：

- [TarEntry](#class-tarentry)

### prop userName: String

```cangjie
public prop userName: String
```

功能：获取当前条目的用户名。

类型：String

### prop groupName: String

```cangjie
public prop groupName: String
```

功能：获取当前条目的组名。

类型：String

### prop deviceMajor: Int32

```cangjie
public prop deviceMajor: Int32
```

功能：获取当前条目的设备主编号。

类型：Int32

### prop deviceMinor: Int32

```cangjie
public prop deviceMinor: Int32
```

功能：获取当前条目的设备次编号。

类型：Int32

### init(String)

```cangjie
public init(path: String)
```

功能：从文件、目录、软链接构造一个 tar 文件条目。

参数：

- path: String - 文件、目录、软链接的路径。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 path 参数指定的目标不存在或不是文件、目录、软链接，则抛出异常。

- FSException - 如果读取目标信息或创建目标文件流失败，则抛出异常。

### init(Path)

```cangjie
public init(path: Path)
```

功能：从文件、目录、软链接构造一个 tar 文件条目。

参数：

- path: Path - 文件、目录、软链接的路径。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 path 参数指定的目标不存在或不是文件、目录、软链接，则抛出异常。

- FSException - 如果读取目标信息或创建目标文件流失败，则抛出异常。

## class UstarTarEntry

```cangjie
public class UstarTarEntry <: PosixTarEntry {
    public init(path: String)
    public init(path: Path)
}
```

功能：表示 Ustar tar 文件条目。

父类型：

- [PosixTarEntry](#class-posixtarentry)

### init(String)

```cangjie
public init(path: String)
```

功能：从文件、目录、软链接构造一个 Ustar tar 文件条目。

参数：

- path: String - 文件、目录、软链接的路径。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 path 参数指定的目标不存在或不是文件、目录、软链接，则抛出异常。

- FSException - 如果读取目标信息或创建目标文件流失败，则抛出异常。

### init(Path)

```cangjie
public init(path: Path)
```

功能：从文件、目录、软链接构造一个 Ustar tar 文件条目。

参数：

- path: Path - 文件、目录、软链接的路径。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 path 参数指定的目标不存在或不是文件、目录、软链接，则抛出异常。

- FSException - 如果读取目标信息或创建目标文件流失败，则抛出异常。

### func writeTo(OutputStream)

```cangjie
public override func writeTo(target: OutputStream): Unit
```

功能：将当前条目写入到指定的输出流中。

参数：

- target: OutputStream - 指定输出流。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果字段超出格式要求或写入失败，则抛出异常。

## class GnuTarEntry

```cangjie
public class GnuTarEntry <: PosixTarEntry {
    public init(path: String)
    public init(path: Path)
}
```

功能：表示 Gnu tar 文件条目。

父类型：

- [PosixTarEntry](#class-posixtarentry)

### prop accessTime: DateTime

```cangjie
public prop accessTime: DateTime
```

功能：获取当前条目的访问时间。

类型：DateTime

### prop changeTime: DateTime

```cangjie
public prop changeTime: DateTime
```

功能：获取当前条目的修改时间。

类型：DateTime

### init(String)

```cangjie
public init(path: String)
```

功能：从文件、目录、软链接构造一个 Gnu tar 文件条目。

参数：

- path: String - 文件、目录、软链接的路径。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 path 参数指定的目标不存在或不是文件、目录、软链接，则抛出异常。

- FSException - 如果读取目标信息或创建目标文件流失败，则抛出异常。

### init(Path)

```cangjie
public init(path: Path)
```

功能：从文件、目录、软链接构造一个 Gnu tar 文件条目。

参数：

- path: Path - 文件、目录、软链接的路径。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 path 参数指定的目标不存在或不是文件、目录、软链接，则抛出异常。

- FSException - 如果读取目标信息或创建目标文件流失败，则抛出异常。

### func writeTo(OutputStream)

```cangjie
public override func writeTo(target: OutputStream): Unit
```

功能：将当前条目写入到指定的输出流中。

参数：

- target: OutputStream - 指定输出流。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果字段超出格式要求或写入失败，则抛出异常。

## class PaxTarEntry

```cangjie
public class PaxTarEntry <: PosixTarEntry {
    public init(path: String)
    public init(path: Path)
}
```

功能：表示 Pax tar 文件条目。

父类型：

- [PosixTarEntry](#class-posixtarentry)

### init(String)

```cangjie
public init(path: String)
```

功能：从文件、目录、软链接构造一个 Pax tar 文件条目。

参数：

- path: String - 文件、目录、软链接的路径。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 path 参数指定的目标不存在或不是文件、目录、软链接，则抛出异常。

- FSException - 如果读取目标信息或创建目标文件流失败，则抛出异常。

### init(Path)

```cangjie
public init(path: Path)
```

功能：从文件、目录、软链接构造一个 Pax tar 文件条目。

参数：

- path: Path - 文件、目录、软链接的路径。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果 path 参数指定的目标不存在或不是文件、目录、软链接，则抛出异常。

- FSException - 如果读取目标信息或创建目标文件流失败，则抛出异常。

### func getPaxData(String)

```cangjie
public func getPaxData(key: String): ?String
```

功能：获取当前条目的 Pax 数据。

参数：

- key: String - Pax 数据的键。

返回值：

- Option\<String> - 如果存在对应键的 Pax 数据，则返回其值，否则返回 None。

### func writeTo(OutputStream)

```cangjie
public override func writeTo(target: OutputStream): Unit
```

功能：将当前条目写入到指定的输出流中。

参数：

- target: OutputStream - 指定输出流。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果字段超出格式要求或写入失败，则抛出异常。

## class TarReader

```cangjie
public class TarReader<T> <: Iterable<TarEntry> where T <: InputStream {
    public init(stream: T)
}
```

功能：从流中按照 tar 格式读取条目。

### init(T)

```cangjie
public init(stream: T)
```

功能：从指定的流中创建一个 tar 文件读取器。

参数：

- stream: T - 指定的输入流。

### func iterator()

```cangjie
public func iterator(): Iterator<TarEntry>
```

功能：返回一个迭代器，迭代 tar 文件中的条目。

返回值：

- Iterator\<TarEntry> - 一个 [TarEntry](tar_package_classes.md#class-tarentry) 的迭代器。

### extend\<T> TarReader\<T> <: Resource where T <: Resource

```cangjie
extend<T> TarReader<T> <: Resource where T <: Resource
```

功能：为 [TarReader](tar_package_classes.md#class-tarreader) 实现 Resource 接口，该类型对象可在 `try-with-resource` 语法上下文中实现自动资源释放。

父类型：

- Resource

#### func close()

```cangjie
public func close(): Unit
```

功能：关闭内部流。

> **注意：**
>
> 调用此方法后不可再调用 [TarReader](tar_package_classes.md#class-tarreader) 的其他接口，否则会造成不可期现象。

#### func isClosed()

```cangjie
public func isClosed(): Bool
```

功能：判断内部流是否关闭。

返回值：

- Bool - 如果内部流已经被关闭，返回 true，否则返回 false。

## class TarWriter

```cangjie
public class TarWriter<T> where T <: OutputStream {
    public init(stream: T)
    public init(stream: T, format: TarEntryFormat)
}
```

功能：将条目写入到流中，并完成 tar 文件的写入。

### prop format: TarEntryFormat

```cangjie
public prop format: TarEntryFormat
```

功能：获取当前 tar 文件的条目格式。

类型：[TarEntryFormat](tar_package_enums.md#enum-tarentryformat)

### init(T)

```cangjie
public init(stream: T)
```

功能：从指定的流中创建一个 tar 文件写入器，默认为 Pax 格式。

参数：

- stream: T - 指定的输出流。

### init(T, TarEntryFormat)

```cangjie
public init(stream: T, format: TarEntryFormat)
```

功能：从指定的流中创建一个 tar 文件写入器。

参数：

- stream: T - 指定的输出流。

- format: [TarEntryFormat](tar_package_enums.md#enum-tarentryformat) - tar 文件的条目格式。

### func write(String, String)

```cangjie
public func write(path!: String, entryName!: String): Unit
```

功能：将指定文件、目录、软链接写入到内部流中。

参数：

- path!: String - 指定文件、目录、软链接的路径。

- entryName!: String - tar 文件中的条目名。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果写入已结束，或者创建或写入条目失败，则抛出异常。

- FSException - 如果创建文件流失败，则抛出异常。

### func write(Path, String)

```cangjie
public func write(path: Path, entryName!: String): Unit
```

功能：将指定文件、目录、软链接写入到内部流中。

参数：

- path: Path - 指定文件、目录、软链接路径。

- entryName!: String - tar 文件中的条目名。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果写入已结束，或者创建或写入条目失败，则抛出异常。

- FSException - 如果创建文件流失败，则抛出异常。

### func write(FileInfo, String)

```cangjie
public func write(info: FileInfo, entryName!: String): Unit
```

功能：将指定文件、目录、软链接写入到内部流中。

参数：

- info: FileInfo - 待写入的文件、目录、软链接信息。

- entryName!: String - tar 文件中的条目名。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果写入已结束，或者创建或写入条目失败，则抛出异常。

- FSException - 如果创建文件流失败，则抛出异常。

### func write(TarEntry)

```cangjie
public func write(entry: TarEntry): Unit
```

功能：将指定 tar 文件条目写入到内部流中。

参数：

- entry: [TarEntry](tar_package_classes.md#class-tarentry) - 待写入的 tar 文件条目。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果写入已结束，或者写入条目失败，则抛出异常。

### func write(it: Iterable\<TarEntry>)

```cangjie
public func write(it: Iterable<TarEntry>): Unit
```

功能：将指定 tar 文件条目列表写入到内部流中。

参数：

- it: Iterable<[TarEntry](tar_package_classes.md#class-tarentry)> - 待写入的 tar 文件条目列表。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果写入已结束，或者写入条目失败，则抛出异常。

### func flush()

```cangjie
public func flush(): Unit
```

功能：刷新内部流。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果写入已结束，则抛出异常。

### func finish()

```cangjie
public func finish(): Unit
```

功能：写入 tar 结尾标志，即 1024 个空字节，结束 tar 格式的写入。

异常：

- [TarException](tar_package_exceptions.md#class-tarexception) - 如果写入已结束，或者写入失败，则抛出异常。

### extend\<T> TarWriter\<T> <: Resource where T <: Resource

```cangjie
extend<T> TarWriter<T> <: Resource where T <: Resource
```

功能：为 [TarWriter](tar_package_classes.md#class-tarwriter) 实现 Resource 接口，该类型对象可在 `try-with-resource` 语法上下文中实现自动资源释放。

父类型：

- Resource

#### func close()

```cangjie
public func close(): Unit
```

功能：写入 tar 结尾标志，并关闭内部流。

> **注意：**
>
> 调用此方法后不可再调用 [TarWriter](tar_package_classes.md#class-tarwriter) 的其他接口，否则会造成不可期现象。

#### func isClosed()

```cangjie
public func isClosed(): Bool
```

功能：判断内部流是否关闭。

返回值：

- Bool - 如果内部流已经被关闭，返回 true，否则返回 false。
