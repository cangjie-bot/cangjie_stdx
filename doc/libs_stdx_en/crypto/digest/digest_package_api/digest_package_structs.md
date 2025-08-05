# Struct

## struct HashType

```cangjie
public struct HashType <: ToString & Equatable<HashType>
```

Functionality: This struct represents hash algorithm types, where [MD5](digest_package_classes.md#class-md5), [SHA1](digest_package_classes.md#class-sha1), [SHA224](digest_package_classes.md#class-sha224), [SHA256](digest_package_classes.md#class-sha256), [SHA384](digest_package_classes.md#class-sha384), and [SHA512](digest_package_classes.md#class-sha512) are commonly used digest algorithms.

Parent Types:

- ToString
- Equatable\<[HashType](#struct-hashtype)>

### prop MD5

```cangjie
public static prop MD5: HashType
```

Functionality: Returns the [MD5](digest_package_classes.md#class-md5) type.

Type: [HashType](digest_package_structs.md#struct-hashtype)

### prop SHA1

```cangjie
public static prop SHA1: HashType
```

Functionality: Returns the [SHA1](digest_package_classes.md#class-sha1) type.

Type: [HashType](digest_package_structs.md#struct-hashtype)

### prop SHA224

```cangjie
public static prop SHA224: HashType
```

Functionality: Returns the [SHA224](digest_package_classes.md#class-sha224) type.

Type: [HashType](digest_package_structs.md#struct-hashtype)

### prop SHA256

```cangjie
public static prop SHA256: HashType
```

Functionality: Returns the [SHA256](digest_package_classes.md#class-sha256) type.

Type: [HashType](digest_package_structs.md#struct-hashtype)

### prop SHA384

```cangjie
public static prop SHA384: HashType
```

Functionality: Returns the [SHA384](digest_package_classes.md#class-sha384) type.

Type: [HashType](digest_package_structs.md#struct-hashtype)

### prop SHA512

```cangjie
public static prop SHA512: HashType
```

Functionality: Returns the [SHA512](digest_package_classes.md#class-sha512) type.

Type: [HashType](digest_package_structs.md#struct-hashtype)

### prop SM3

```cangjie
public static prop SM3: HashType
```

Functionality: Returns the [SM3](digest_package_classes.md#class-sm3) type.

Type: [HashType](digest_package_structs.md#struct-hashtype)

### func toString()

```cangjie
public func toString(): String
```

Functionality: Gets the name of the hash algorithm.

Return Value:

- String - The name of the hash algorithm.

### operator func ==(HashType)

```cangjie
public override operator func ==(other: HashType): Bool
```

Functionality: Determines whether two [HashType](digest_package_structs.md#struct-hashtype) instances reference the same object.

Parameters:

- other: [HashType](digest_package_structs.md#struct-hashtype) - The HashType to compare.

Return Value:

- Bool - Returns `true` if identical; otherwise, returns `false`.

### operator func !=(HashType)

```cangjie
public override operator func !=(other: HashType): Bool
```

Functionality: Determines whether two [HashType](digest_package_structs.md#struct-hashtype) instances reference different objects.

Parameters:

- other: [HashType](digest_package_structs.md#struct-hashtype) - The HashType to compare.

Return Value:

- Bool - Returns `true` if not identical; otherwise, returns `false`.