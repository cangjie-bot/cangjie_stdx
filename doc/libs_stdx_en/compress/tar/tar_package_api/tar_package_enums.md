# Enums

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

Function: tar entry type.

This enum defines all types of tar file entries, corresponding to the `typeflag` field in the tar header.

### V7RegularFile

```cangjie
V7RegularFile
```

Function: Construct a V7 format regular file type enum instance, corresponding to the early Unix V7 format (typeflag `\0`).

### RegularFile

```cangjie
RegularFile
```

Function: Construct a standard regular file type enum instance, corresponding to regular files in POSIX/USTAR format (typeflag `'0'`).

### ContiguousFile

```cangjie
ContiguousFile
```

Function: Construct a contiguous file type enum instance, representing files whose data is arranged contiguously on the storage medium (typeflag `'7'`).

### HardLink

```cangjie
HardLink
```

Function: Construct a hard link type enum instance, corresponding to typeflag `'1'`.

### Symlink

```cangjie
Symlink
```

Function: Construct a symbolic link type enum instance, corresponding to typeflag `'2'`.

### CharDevice

```cangjie
CharDevice
```

Function: Construct a character device file type enum instance, corresponding to typeflag `'3'`.

### BlockDevice

```cangjie
BlockDevice
```

Function: Construct a block device file type enum instance, corresponding to typeflag `'4'`.

### Directory

```cangjie
Directory
```

Function: Construct a directory type enum instance, corresponding to typeflag `'5'`.

### Fifo

```cangjie
Fifo
```

Function: Construct a named pipe (FIFO) type enum instance, corresponding to typeflag `'6'`.

### ExtendedHeader

```cangjie
ExtendedHeader
```

Function: Construct a PAX extended header type enum instance, corresponding to typeflag `'x'`, used to store additional metadata.

### GlobalExtendedHeader

```cangjie
GlobalExtendedHeader
```

Function: Construct a PAX global extended header type enum instance, corresponding to typeflag `'g'`, applicable to global meta-information affecting the entire archive.

### GnuLongName

```cangjie
GnuLongName
```

Function: Construct a GNU long file name extension type enum instance, corresponding to typeflag `'L'`.

### GnuLongLink

```cangjie
GnuLongLink
```

Function: Construct a GNU long link name extension type enum instance, corresponding to typeflag `'K'`.

### GnuSparse

```cangjie
GnuSparse
```

Function: Construct a GNU sparse file type enum instance, corresponding to typeflag `'S'`.

### GnuDumpDir

```cangjie
GnuDumpDir
```

Function: Construct a GNU Dump directory type enum instance, corresponding to typeflag `'D'`.

### GnuMultiVolume

```cangjie
GnuMultiVolume
```

Function: Construct a GNU multi-volume archive entry type enum instance, corresponding to typeflag `'M'`.

### GnuName

```cangjie
GnuName
```

Function: Construct a GNU file name table entry type enum instance, corresponding to typeflag `'N'`.

### GnuVolumeHeader

```cangjie
GnuVolumeHeader
```

Function: Construct a GNU volume header entry type enum instance, corresponding to typeflag `'V'`.

### Unknown(UInt8)

```cangjie
Unknown(UInt8)
```

Function: Construct an unknown type entry enum instance, used to preserve unrecognized or custom `typeflag` byte values.

### prop flag

```cangjie
public prop flag: UInt8
```

Function: Gets the `typeflag` byte value of the current entry.

Type: UInt8

### static func fromFlag(UInt8)

```cangjie
public static func fromFlag(flag: UInt8): TarEntryType
```

Function: Construct the corresponding `TarEntryType` enum instance based on the provided `typeflag` byte value.

Parameters:

- flag: UInt8 - The byte value of `typeflag` in the tar header.

Return value:

- TarEntryType - The corresponding entry type enum instance. If unrecognized, returns `Unknown(flag)`.

## func toString(): String

```cangjie
public func toString(): String
```

Function: Returns the string representation of the current entry type enum instance.

Return value:

- String - The string representation of the current entry type enum instance.

### operator func ==(TarEntryType): Bool

```cangjie
operator func ==(rhs: TarEntryType): Bool
```

Function: Determine whether the current entry type enum instance is equal to the provided entry type enum instance.

Parameters:

- rhs: TarEntryType - The entry type enum instance to compare.

Return value:

- Bool - Returns true if the two entry type enum instances are equal; otherwise, returns false.

### operator func !=(TarEntryType): Bool

```cangjie
operator func !=(rhs: TarEntryType): Bool
```

Function: Determine whether the current entry type enum instance is not equal to the provided entry type enum instance.

Parameters:

- rhs: TarEntryType - The entry type enum instance to compare.

Return value:

- Bool - Returns true if the two entry type enum instances are not equal; otherwise, returns false.

## enum TarEntryFormat

```cangjie
public enum TarEntryFormat {
    | V7
    | Ustar
    | Pax
    | Gnu
}
```

Function: tar entry format.

This enum represents different versions of tar file header formats, used to distinguish the level of support for metadata and extension fields among various formats.

### V7

```cangjie
V7
```

Function: Construct a V7 format enum instance, representing the original UNIX Version 7 tar format (1979).

### Ustar

```cangjie
Ustar
```

Function: Construct a USTAR format enum instance, representing the standard format defined by POSIX.1-1988.

### Pax

```cangjie
Pax
```

Function: Construct a PAX format enum instance, representing the POSIX.1-2001 extended format, compatible with USTAR, and capable of recording additional metadata through extended headers.

### Gnu

```cangjie
Gnu
```

Function: Construct a GNU extended format enum instance.

## func toString(): String

```cangjie
public func toString(): String
```

Function: Returns the string representation of the current tar file header format enum instance.

Return value:

- String - The string representation of the current tar file header format enum instance.

## operator func ==(TarEntryFormat): Bool

```cangjie
operator func ==(rhs: TarEntryFormat): Bool
```

Function: Determine whether the current tar file header format enum instance is equal to the provided tar file header format enum instance.

Parameters:

- rhs: TarEntryFormat - The tar file header format enum instance to compare.

Return value:

- Bool - Returns true if the two tar file header format enum instances are equal; otherwise, returns false.

## operator func !=(TarEntryFormat): Bool

```cangjie
operator func !=(rhs: TarEntryFormat): Bool
```

Function: Determine whether the current tar file header format enum instance is not equal to the provided tar file header format enum instance.

Parameters:

- rhs: TarEntryFormat - The tar file header format enum instance to compare.

Return value:

- Bool - Returns true if the two tar file header format enum instances are not equal; otherwise, returns false.
