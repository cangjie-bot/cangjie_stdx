# Enumeration

## enum CompressLevel

```cangjie
public enum CompressLevel {
    | BestCompression
    | BestSpeed
    | DefaultCompression
}
```

Function: Compression level.

The compression level determines the compression ratio and speed. Currently, three compression levels are supported, ordered from smallest to largest compression ratio and from fastest to slowest compression speed as: BestSpeed, DefaultCompression, BestCompression.

### BestCompression

```cangjie
BestCompression
```

Function: Constructs a compression level enumeration instance prioritizing compression ratio, representing the highest compression ratio with relatively slower compression speed.

### BestSpeed

```cangjie
BestSpeed
```

Function: Constructs a compression level enumeration instance prioritizing compression speed, representing the fastest compression speed with relatively lower compression ratio.

### DefaultCompression

```cangjie
DefaultCompression
```

Function: Constructs a compression level enumeration instance representing the default compression level.

## enum WrapType

```cangjie
public enum WrapType {
    | DeflateFormat
    | GzipFormat
}
```

Function: Compressed data format.

Currently supports two formats: DeflateFormat and GzipFormat.

### DeflateFormat

```cangjie
DeflateFormat
```

Function: Constructs an enumeration instance representing the `Deflate` compressed data format.

### GzipFormat

```cangjie
GzipFormat
```

Function: Constructs an enumeration instance representing the `Gzip` compressed data format.