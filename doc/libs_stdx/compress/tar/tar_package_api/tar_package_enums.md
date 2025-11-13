# 枚举

## enum TarEntryType

```cangjie
public enum TarEntryType {
    | V7RegularFile
    | RegularFile
    | ContiguousFile
    | HardLink
    | Symlink
    | CharDevice
    | BlockDevice
    | Directory
    | Fifo
    | ExtendedHeader
    | GlobalExtendedHeader
    | GnuLongName
    | GnuLongLink
    | GnuSparse
    | GnuDumpDir
    | GnuMultiVolume
    | GnuName
    | GnuVolumeHeader
    | Unknown(UInt8)
}
```

功能：tar 条目类型。

该枚举定义了所有 tar 文件条目的类型，对应 tar 头部中的 `typeflag` 字段。

### V7RegularFile

```cangjie
V7RegularFile
```

功能：构造一个 V7 格式的普通文件类型枚举实例，对应早期 Unix V7 格式（typeflag `\0`）。

### RegularFile

```cangjie
RegularFile
```

功能：构造一个标准普通文件类型枚举实例，对应 POSIX/USTAR 格式中的普通文件（typeflag `'0'`）。

### ContiguousFile

```cangjie
ContiguousFile
```

功能：构造一个连续文件类型枚举实例，用于表示数据在存储介质上连续排列的文件（typeflag `'7'`）。

### HardLink

```cangjie
HardLink
```

功能：构造一个硬链接类型枚举实例，对应 typeflag `'1'`。

### Symlink

```cangjie
Symlink
```

功能：构造一个符号链接类型枚举实例，对应 typeflag `'2'`。

### CharDevice

```cangjie
CharDevice
```

功能：构造一个字符设备文件类型枚举实例，对应 typeflag `'3'`。

### BlockDevice

```cangjie
BlockDevice
```

功能：构造一个块设备文件类型枚举实例，对应 typeflag `'4'`。

### Directory

```cangjie
Directory
```

功能：构造一个目录类型枚举实例，对应 typeflag `'5'`。

### Fifo

```cangjie
Fifo
```

功能：构造一个命名管道（FIFO）类型枚举实例，对应 typeflag `'6'`。

### ExtendedHeader

```cangjie
ExtendedHeader
```

功能：构造一个 PAX 扩展头类型枚举实例，对应 typeflag `'x'`，用于存储附加元数据。

### GlobalExtendedHeader

```cangjie
GlobalExtendedHeader
```

功能：构造一个 PAX 全局扩展头类型枚举实例，对应 typeflag `'g'`，适用于作用于整个归档的全局元信息。

### GnuLongName

```cangjie
GnuLongName
```

功能：构造一个 GNU 长文件名扩展类型枚举实例，对应 typeflag `'L'`。

### GnuLongLink

```cangjie
GnuLongLink
```

功能：构造一个 GNU 长链接名扩展类型枚举实例，对应 typeflag `'K'`。

### GnuSparse

```cangjie
GnuSparse
```

功能：构造一个 GNU 稀疏文件类型枚举实例，对应 typeflag `'S'`。

### GnuDumpDir

```cangjie
GnuDumpDir
```

功能：构造一个 GNU Dump 目录类型枚举实例，对应 typeflag `'D'`。

### GnuMultiVolume

```cangjie
GnuMultiVolume
```

功能：构造一个 GNU 多卷归档条目类型枚举实例，对应 typeflag `'M'`。

### GnuName

```cangjie
GnuName
```

功能：构造一个 GNU 文件名表条目类型枚举实例，对应 typeflag `'N'`。

### GnuVolumeHeader

```cangjie
GnuVolumeHeader
```

功能：构造一个 GNU 卷头条目类型枚举实例，对应 typeflag `'V'`。

### Unknown(UInt8)

```cangjie
Unknown(UInt8)
```

功能：构造一个未知类型条目枚举实例，用于保留无法识别或自定义的 `typeflag` 字节值。

### prop flag

```cangjie
public prop flag: UInt8
```

功能：获取当前条目的 `typeflag` 字节值。

类型：UInt8

### static func fromFlag(UInt8)

```cangjie
public static func fromFlag(flag: UInt8): TarEntryType
```

功能：根据传入的 `typeflag` 字节值构造对应的 `TarEntryType` 枚举实例。

参数：

- flag: UInt8 - tar 头部中 `typeflag` 的字节值。

返回值：

- TarEntryType - 对应的条目类型枚举实例。如果无法识别，将返回 `Unknown(flag)`。

## func toString(): String

```cangjie
public func toString(): String
```

功能：返回当前条目类型枚举实例的字符串表示。

返回值：

- String - 当前条目类型枚举实例的字符串表示。

### operator func ==(TarEntryType): Bool

```cangjie
operator func ==(rhs: TarEntryType): Bool
```

功能：判断当前条目类型枚举实例是否与传入的条目类型枚举实例相等。

参数：

- rhs: TarEntryType - 要比较的条目类型枚举实例。

返回值：

- Bool - 如果两个条目类型枚举实例相等，则返回 true；否则返回 false。

### operator func !=(TarEntryType): Bool

```cangjie
operator func !=(rhs: TarEntryType): Bool
```

功能：判断当前条目类型枚举实例是否与传入的条目类型枚举实例不相等。

参数：

- rhs: TarEntryType - 要比较的条目类型枚举实例。

返回值：

- Bool - 如果两个条目类型枚举实例不相等，则返回 true；否则返回 false。

## enum TarEntryFormat

```cangjie
public enum TarEntryFormat {
    | V7
    | Ustar
    | Pax
    | Gnu
}
```

功能：tar 条目格式。

该枚举表示不同版本的 tar 文件头部格式，用于区分各格式在元数据与扩展字段上的支持程度。

### V7

```cangjie
V7
```

功能：构造一个 V7 格式枚举实例，表示最初的 UNIX 第七版 tar 格式（1979）。

### Ustar

```cangjie
Ustar
```

功能：构造一个 USTAR 格式枚举实例，表示 POSIX.1-1988 定义的标准格式。

### Pax

```cangjie
Pax
```

功能：构造一个 PAX 格式枚举实例，表示 POSIX.1-2001 扩展格式，兼容 USTAR，并可通过扩展头记录额外元数据。

### Gnu

```cangjie
Gnu
```

功能：构造一个 GNU 扩展格式枚举实例。

## func toString(): String

```cangjie
public func toString(): String
```

功能：返回当前 tar 文件头部格式枚举实例的 字符串表示。

返回值：

- String - 当前 tar 文件头部格式枚举实例的 字符串表示。

## operator func ==(TarEntryFormat): Bool

```cangjie
operator func ==(rhs: TarEntryFormat): Bool
```

功能：判断当前 tar 文件头部格式枚举实例是否与传入的 tar 文件头部格式枚举实例相等。

参数：

- rhs: TarEntryFormat - 要比较的 tar 文件头部格式枚举实例。

返回值：

- Bool - 如果两个 tar 文件头部格式枚举实例相等，则返回 true；否则返回 false。

## operator func !=(TarEntryFormat): Bool

```cangjie
operator func !=(rhs: TarEntryFormat): Bool
```

功能：判断当前 tar 文件头部格式枚举实例是否与传入的 tar 文件头部格式枚举实例不相等。

参数：

- rhs: TarEntryFormat - 要比较的 tar 文件头部格式枚举实例。

返回值：

- Bool - 如果两个 tar 文件头部格式枚举实例不相等，则返回 true；否则返回 false。
