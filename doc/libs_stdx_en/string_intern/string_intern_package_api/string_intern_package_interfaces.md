# Interfaces

## interface Internable

```cangjie
public interface Internable {
    static func configInternPool(capacity!: Int64, strMaxLength!: Int64): Unit
    static func intern(array: Array<Byte>): String
    static func intern(str: String): String
}
```

Function: Used to provide a pooled cache extension for the String.

### static func configInternPool(Int64, Int64)

```cangjie
static func configInternPool(capacity!: Int64, strMaxLength!: Int64): Unit
```

Function: Configure the capacity of the string cache pool and the maximum length of the strings to be cached. If not configured, calling the intern method will only return the string object from the constant pool and will not cache new string objects.

Parameters:

- capacity: Int64 - The capacity of the dynamic cache pool.
- strMaxLength: Int64 - The maximum length of each string object in the dynamic cache pool; any string exceeding this length will not be cached.

Exceptions:

- IllegalArgumentException - Thrown when the value of the `capacity` or `strMaxLength` parameter is less than or equal to 0.

### static func intern(Array\<Byte>)

```cangjie
static func intern(array: Array<Byte>): String
```

Function: Obtain a cached string object that matches the content of the input array.

Parameters:

- array: Array\<Byte> - A Byte array created at runtime, intended for use in constructing a string.

Return value:

- String - The string object in the cache pool has a byte array representation that matches the input parameter.

### static func intern(String)

```cangjie
static func intern(str: String): String
```

Function: Retrieve the cached string object that matches the content of the input string.

Parameters:

- str: String - Strings created at runtime.

Return value:

- String - String objects in the cache pool.

### extend String <: Internable

```cangjie
extend String <: Internable
```

Function: Extend [Internable](#interface-internable) interface for String，to achieve String pooling and caching。

Parent types:

- [Internable](#interface-internable)

#### static func configInternPool(Int64, Int64)

```cangjie
static func configInternPool(capacity!: Int64 = 8192, strMaxLength!: Int64 = 512): Unit
```

Function: Configure the capacity of the string cache pool and the maximum length of the strings to be cached. If not configured, calling the intern method will only return the string object from the constant pool and will not cache new string objects.

Parameters:

- capacity!: Int64 - The capacity of the dynamic cache pool, with a default value of 8192.
- strMaxLength!: Int64 - The maximum length of each string object in the dynamic cache pool; any string exceeding this length will not be cached, with a default value of 512.

Exceptions:

- IllegalArgumentException - Thrown when the value of the `capacity` or `strMaxLength` parameter is less than or equal to 0.

#### static func intern(Array\<Byte>)

```cangjie
static func intern(array: Array<Byte>): String
```

Function: Obtain a cached string object that matches the content of the input array.

Parameters:

- str: Array\<Byte> - A Byte array created at runtime, intended for use in constructing a string.

Return value:

- String - The string object in the cache pool has a byte array representation that matches the input parameter.

#### static func intern(String)

```cangjie
static func intern(str: String): String
```

Function: Retrieve the cached string object that matches the content of the input string.

Parameters:

- str: String - Strings created at runtime.

Return value:

- String - String objects in the cache pool.
