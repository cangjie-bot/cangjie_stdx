# Class

## class DebugDataProvider

```cangjie
public class DebugDataProvider <: FuzzDataProvider
```

Functionality: This class inherits from the [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) type and adds additional debugging information.

Parent Type:

- [FuzzDataProvider](#class-fuzzdataprovider)

### func consumeAll()

```cangjie
public override func consumeAll(): Array<UInt8>
```

Functionality: Converts all data into a UInt8 type array.

Return Value:

- Array\<UInt8> - A UInt8 type array.

### func consumeAllAsAscii()

```cangjie
public override func consumeAllAsAscii(): String
```

Functionality: Converts all data into an Ascii String type.

Return Value:

- String - An instance of Ascii String type.

### func consumeAllAsString()

```cangjie
public override func consumeAllAsString(): String
```

Functionality: Converts all data into a utf8 String type.

Return Value:

- String - An instance of utf8 String type.

### func consumeAsciiString(Int64)

```cangjie
public override func consumeAsciiString(maxLength: Int64): String
```

Functionality: Converts data into an Ascii String type instance.

Parameters:

- maxLength: Int64 - The maximum length of the String type.

Return Value:

- String - An instance of String type.

Exceptions:

- IllegalArgumentException - Thrown if maxLength is negative.

### func consumeBool()

```cangjie
public override func consumeBool(): Bool
```

Functionality: Converts data into a Bool type instance.

Return Value:

- Bool - An instance of Bool type.

### func consumeBools(Int64)

```cangjie
public override func consumeBools(count: Int64): Array<Bool>
```

Functionality: Converts a specified amount of data into a Bool type array.

Parameters:

- count: Int64 - The specified amount of data to convert.

Return Value:

- Array\<Bool> - A Bool type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeByte()

```cangjie
public override func consumeByte(): Byte
```

Functionality: Converts data into a Byte type instance.

Return Value:

- Byte - An instance of Byte type.

### func consumeBytes(Int64)

```cangjie
public override func consumeBytes(count: Int64): Array<Byte>
```

Functionality: Converts a specified amount of data into a Byte type array.

Parameters:

- count: Int64 - The specified amount of data to convert.

Return Value:

- Array\<Byte> - A Byte type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeFloat32()

```cangjie
public override func consumeFloat32(): Float32
```

Functionality: Converts data into a Float32 type instance.

Return Value:

- Float32 - An instance of Float32 type.

### func consumeFloat64()

```cangjie
public override func consumeFloat64(): Float64
```

Functionality: Converts data into a Float64 type instance.

Return Value:

- Float64 - An instance of Float64 type.

### func consumeInt16()

```cangjie
public override func consumeInt16(): Int16
```

Functionality: Converts data into an Int16 type instance.

Return Value:

- Int16 - An instance of Int16 type.

### func consumeInt16s(Int64)

```cangjie
public override func consumeInt16s(count: Int64): Array<Int16>
```

Functionality: Converts a specified amount of data into an Int16 type array.

Parameters:

- count: Int64 - The specified amount of data to convert.

Return Value:

- Array\<Int16> - An Int16 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeInt32()

```cangjie
public override func consumeInt32(): Int32
```

Functionality: Converts data into an Int32 type instance.

Return Value:

- Int32 - An instance of Int32 type.

### func consumeInt32s(Int64)

```cangjie
public override func consumeInt32s(count: Int64): Array<Int32>
```

Functionality: Converts a specified amount of data into an Int32 type array.

Parameters:

- count: Int64 - The specified amount of data to convert.

Return Value:

- Array\<Int32> - An Int32 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeInt64()

```cangjie
public override func consumeInt64(): Int64
```

Functionality: Converts data into an Int64 type instance.

Return Value:

- Int64 - An instance of Int64 type.

### func consumeInt64s(Int64)

```cangjie
public override func consumeInt64s(count: Int64): Array<Int64>
```

Functionality: Converts a specified amount of data into an Int64 type array.

Parameters:

- count: Int64 - The specified amount of data to convert.

Return Value:

- Array\<Int64> - An Int64 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeInt8()

```cangjie
public override func consumeInt8(): Int8
```

Functionality: Converts data into an Int8 type instance.

Return Value:

- Int8 - An instance of Int8 type.

### func consumeInt8s(Int64)

```cangjie
public override func consumeInt8s(count: Int64): Array<Int8>
```

Functionality: Converts a specified amount of data into an Int8 type array.

Parameters:

- count: Int64 - The specified amount of data to convert.

Return Value:

- Array\<Int8> - An Int8 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeRune()

```cangjie
public override func consumeRune(): Rune
```

Functionality: Converts data into a Rune type instance.

Return Value:

- Rune - An instance of Rune type.

### func consumeString(Int64)

```cangjie
public override func consumeString(maxLength: Int64): String
```

Function: Converts data into a utf8 String type instance.

Parameters:

- maxLength: Int64 - The maximum length of the String type.

Return Value:

- String - A String type instance.

Exceptions:

- IllegalArgumentException - Thrown if maxLength is negative.

### func consumeUInt16()

```cangjie
public override func consumeUInt16(): UInt16
```

Function: Converts data into a UInt16 type instance.

Return Value:

- UInt16 - A UInt16 type instance.

### func consumeUInt16s(Int64)

```cangjie
public override func consumeUInt16s(count: Int64): Array<UInt16>
```

Function: Converts the specified amount of data into a UInt16 type array.

Parameters:

- count: Int64 - The specified amount of data to convert.

Return Value:

- Array\<UInt16> - A UInt16 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeUInt32()

```cangjie
public override func consumeUInt32(): UInt32
```

Function: Converts data into a UInt32 type instance.

Return Value:

- UInt32 - A UInt32 type instance.

### func consumeUInt32s(Int64)

```cangjie
public override func consumeUInt32s(count: Int64): Array<UInt32>
```

Function: Converts the specified amount of data into a UInt32 type array.

Parameters:

- count: Int64 - The specified amount of data to convert.

Return Value:

- Array\<UInt32> - A UInt32 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeUInt64()

```cangjie
public override func consumeUInt64(): UInt64
```

Function: Converts data into a UInt64 type instance.

Return Value:

- UInt64 - A UInt64 type instance.

### func consumeUInt64s(Int64)

```cangjie
public override func consumeUInt64s(count: Int64): Array<UInt64>
```

Function: Converts the specified amount of data into a UInt64 type array.

Parameters:

- count: Int64 - The specified amount of data to convert.

Return Value:

- Array\<UInt64> - A UInt64 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeUInt8()

```cangjie
public override func consumeUInt8(): UInt8
```

Function: Converts data into a UInt8 type instance.

Return Value:

- UInt8 - A UInt8 type instance.

### func consumeUInt8s(Int64)

```cangjie
public override func consumeUInt8s(count: Int64): Array<UInt8>
```

Function: Converts the specified amount of data into a UInt8 type array.

Parameters:

- count: Int64 - The specified amount of data to convert.

Return Value:

- Array\<UInt8> - A UInt8 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func wrap(FuzzDataProvider)

```cangjie
public static func wrap(dp: FuzzDataProvider): DebugDataProvider
```

Function: Creates a [DebugDataProvider](fuzz_package_classes.md#class-debugdataprovider) instance based on a [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) instance.

Parameters:

- dp: [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) - A [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) type instance.

Return Value:

- [DebugDataProvider](fuzz_package_classes.md#class-debugdataprovider) - A type instance.

## class Fuzzer

```cangjie
public class Fuzzer {
    public init(targetFunction: (Array<UInt8>) -> Int32)
    public init(targetFunction: (Array<UInt8>) -> Int32, args: Array<String>)
    public init(targetFunction: (FuzzDataProvider) -> Int32)
    public init(targetFunction: (FuzzDataProvider) -> Int32, args: Array<String>)
}
```

Function: The [Fuzzer](fuzz_package_classes.md#class-fuzzer) class provides the creation of fuzz tools. Users can provide the target function `targetFunction` to be fuzz-tested and set specific fuzz runtime parameters `args`, such as the number of fuzz executions, initial seeds, maximum data generation length, etc., to create the corresponding type of [Fuzzer](fuzz_package_classes.md#class-fuzzer).

### init((Array\<UInt8>) -> Int32)

```cangjie
public init(targetFunction: (Array<UInt8>) -> Int32)
```

Function: Creates a [Fuzzer](fuzz_package_classes.md#class-fuzzer) instance based on a target function that takes a UInt8 array as a parameter and returns an Int32.

Parameters:

- targetFunction: (Array\<UInt8>) ->Int32 - A target function that takes a UInt8 array as a parameter and returns an Int32.

### init((Array\<UInt8>) -> Int32, Array\<String>)

```cangjie
public init(targetFunction: (Array<UInt8>) -> Int32, args: Array<String>)
```

Function: Creates a [Fuzzer](fuzz_package_classes.md#class-fuzzer) instance based on a target function that takes a UInt8 array as a parameter and returns an Int32, along with fuzz runtime parameters.

Parameters:

- targetFunction: (Array\<UInt8>) ->Int32 - A target function that takes a UInt8 array as a parameter and returns an Int32.
- args: Array\<String> - Fuzz runtime parameters.

### init((FuzzDataProvider) -> Int32)

```cangjie
public init(targetFunction: (FuzzDataProvider) -> Int32)
```

Function: Creates a [Fuzzer](fuzz_package_classes.md#class-fuzzer) instance based on a target function that takes a [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) as a parameter and returns an Int32.

Parameters:

- targetFunction: ([FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider)) ->Int32 - A target function that takes a [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) as a parameter and returns an Int32.

### init((FuzzDataProvider) -> Int32, Array\<String>)

```cangjie
public init(targetFunction: (FuzzDataProvider) -> Int32, args: Array<String>)
```

Function: Creates a [Fuzzer](fuzz_package_classes.md#class-fuzzer) instance based on a target function that takes a [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) as a parameter and returns an Int32, along with fuzz runtime parameters.

Parameters:

- targetFunction: ([FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider)) ->Int32 - A target function that takes a [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) as a parameter and returns an Int32.
- args: Array\<String> - Fuzz runtime parameters.

### func disableDebugDataProvider()

```cangjie
public func disableDebugDataProvider(): Unit
```

Function: Disables the debug information printing feature. When [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider).consumeXXX is called, the return value will not be printed to `stdout`.

### func disableFakeCoverage()

```cangjie
public func disableFakeCoverage(): Unit
```

Function: Disables the impact of calling `enableFakeCoverage` on Fuzz.

### func enableDebugDataProvider()

```cangjie
public func enableDebugDataProvider(): Unit
```

Function: Enables the debug information printing feature. When [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider).consumeXXX is called, the return value will be printed to `stdout`. This feature is disabled by default.

### func enableFakeCoverage()

```cangjie
public func enableFakeCoverage(): Unit
```

Function: Creates a fake coverage feedback area to keep Fuzz running continuously. In [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) mode, the first few runs may lack sufficient data, resulting in no coverage and causing libfuzzer to exit. This feature is disabled by default.

### func getArgs()

```cangjie
public func getArgs(): Array<String>
```

Function: Retrieves the fuzz runtime parameters.

Return Value:

- Array\<String> - The current fuzz runtime parameters.

### func setArgs(Array\<String>)

```cangjie
public func setArgs(args: Array<String>): Unit
```

Function: Sets the fuzz runtime parameters.

Parameters:

- args: Array\<String> - Fuzz runtime parameters.

### func setTargetFunction((Array\<UInt8>) -> Int32)

```cangjie
public func setTargetFunction(targetFunction: (Array<UInt8>) -> Int32): Unit
```

Function: Sets the fuzz target function.

Parameters:

- targetFunction: (Array\<UInt8>) ->Int32 - A target function that takes a UInt8 array as a parameter and returns an Int32.

### func setTargetFunction((FuzzDataProvider) -> Int32)

```cangjie
public func setTargetFunction(targetFunction: (FuzzDataProvider) -> Int32): Unit
```

Function: Sets the fuzz target function.Parameters:

- targetFunction: ([FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider)) ->Int32 - The target function that takes a [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) as parameter and returns Int32.

### func startFuzz()

```cangjie
public func startFuzz(): Unit
```

Function: Executes Fuzz.

## class FuzzerBuilder

```cangjie
public class FuzzerBuilder {
    public init(targetFunction: (Array<UInt8>) -> Int32)
    public init(targetFunction: (FuzzDataProvider) -> Int32)
}
```

Function: This class is used for constructing instances of [Fuzzer](fuzz_package_classes.md#class-fuzzer).

### init((Array\<UInt8>) -> Int32)

```cangjie
public init(targetFunction: (Array<UInt8>) -> Int32)
```

Function: Creates a [FuzzerBuilder](fuzz_package_classes.md#class-fuzzerbuilder) instance based on a target function that takes a UInt8 array as parameter and returns Int32.

Parameters:

- targetFunction: (Array\<UInt8>) ->Int32 - The target function that takes a UInt8 array as parameter and returns Int32.

### init((FuzzDataProvider) -> Int32)

```cangjie
public init(targetFunction: (FuzzDataProvider) -> Int32)
```

Function: Creates a [FuzzerBuilder](fuzz_package_classes.md#class-fuzzerbuilder) instance based on a target function that takes a [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) as parameter and returns Int32.

Parameters:

- targetFunction: ([FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider)) ->Int32 - The target function that takes a [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) as parameter and returns Int32.

### func build()

```cangjie
public func build(): Fuzzer
```

Function: Generates a [Fuzzer](fuzz_package_classes.md#class-fuzzer) instance.

Return Value:

- [Fuzzer](fuzz_package_classes.md#class-fuzzer) - A [Fuzzer](fuzz_package_classes.md#class-fuzzer) instance.

### func setArgs(Array\<String>)

```cangjie
public func setArgs(args: Array<String>): FuzzerBuilder
```

Function: Sets Fuzz runtime parameters.

Parameters:

- args: Array\<String> - Fuzz runtime parameters.

Return Value:

- [FuzzerBuilder](fuzz_package_classes.md#class-fuzzerbuilder) - The current [FuzzerBuilder](fuzz_package_classes.md#class-fuzzerbuilder) instance.

### func setTargetFunction((Array\<UInt8>) -> Int32)

```cangjie
public func setTargetFunction(targetFunction: (Array<UInt8>) -> Int32): FuzzerBuilder
```

Function: Sets the Fuzz target function.

Parameters:

- targetFunction: (Array\<UInt8>) ->Int32 - The target function that takes a UInt8 array as parameter and returns Int32.

Return Value:

- [FuzzerBuilder](fuzz_package_classes.md#class-fuzzerbuilder) - The current [FuzzerBuilder](fuzz_package_classes.md#class-fuzzerbuilder) instance.

### func setTargetFunction((FuzzDataProvider) -> Int32)

```cangjie
public func setTargetFunction(targetFunction: (FuzzDataProvider) -> Int32): FuzzerBuilder
```

Function: Sets the Fuzz target function.

Parameters:

- targetFunction: ([FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider)) ->Int32 - The target function that takes a [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) as parameter and returns Int32.

Return Value:

- [FuzzerBuilder](fuzz_package_classes.md#class-fuzzerbuilder) - The current [FuzzerBuilder](fuzz_package_classes.md#class-fuzzerbuilder) instance.

## class FuzzDataProvider

```cangjie
public open class FuzzDataProvider {
    public let data: Array<UInt8>
    public var remainingBytes: Int64
    public var offset: Int64
}
```

Function: [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) is a utility class designed to convert mutated data byte streams into standard Cangjie basic data types.

Currently supported data structures are as follows:

| Target Type          | API                                  | Description                                               |
|---------------|--------------------------------------|--------------------------------------------------|
| Bool          | consumeBool()                        | Gets 1 Bool, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.         |
| Array\<Bool>   | consumeBools(count: Int64)           | Gets N Bools, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.         |
| Byte          | consumeByte()                        | Gets 1 Byte, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.         |
| Array\<Byte>   | consumeBytes(count: Int64)           | Gets N Bytes, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.         |
| UInt8         | consumeUInt8()                       | Gets 1 UInt8, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.        |
| UInt16        | consumeUInt16()                      | Gets 1 UInt16, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.       |
| UInt32        | consumeUInt32()                      | Gets 1 UInt32, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.       |
| UInt64        | consumeUInt64()                      | Gets 1 UInt64, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.       |
| Int8          | consumeInt8()                        | Gets 1 Int8, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.         |
| Int16         | consumeInt16()                       | Gets 1 Int16, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.        |
| Int32         | consumeInt32()                       | Gets 1 Int32, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.        |
| Int64         | consumeInt64()                       | Gets 1 Int64, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.        |
| Float32         | consumeFloat32()                       | Gets 1 Float32, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.        |
| Float64         | consumeFloat64()                       | Gets 1 Float64, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.        |
| Array\<UInt8>  | consumeUInt8s(count: Int64)          | Gets N UInt8s, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.        |
| Array\<UInt16> | consumeUInt16s(count: Int64)         | Gets N UInt16s, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.       |
| Array\<UInt32> | consumeUInt32s(count: Int64)         | Gets N UInt32s, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.       |
| Array\<UInt64> | consumeUInt64s(count: Int64)         | Gets N UInt64s, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.       |
| Array\<Int8>   | consumeInt8s(count: Int64)           | Gets N Int8s, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.         |
| Array\<Int16>  | consumeInt16s(count: Int64)          | Gets N Int16s, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.        |
| Array\<Int32>  | consumeInt32s(count: Int64)          | Gets N Int32s, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.        |
| Array\<Int64>  | consumeInt64s(count: Int64)          | Gets N Int64s, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.        |
| Rune          | consumeRune()                        | Gets 1 Rune, throws [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) when mutated data is insufficient.         |
| String        | consumeAsciiString(maxLength: Int64) | Gets 1 pure ASCII String with length from 0 to maxLength (can be 0).           |
| String        | consumeString(maxLength: Int64)      | Gets 1 UTF8 String with length from 0 to maxLength (can be 0).             |
| Array\<UInt8>  | consumeAll()                         | Converts all remaining content in [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) into a byte array.                    |
| String        | consumeAllAsAscii()                  | Converts all remaining content in [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) into a pure ASCII String.           |
| String        | consumeAllAsString()                 | Converts all remaining content in [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) into a UTF8 String, with excess characters at the end not consumed. |

When data length is insufficient, most of the above calls will throw [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception). However, when writing fuzz functions, it's usually unnecessary to handle this exception. By default, [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) will be caught by the fuzz framework, informing libfuzzer that this run is invalid and to proceed with the next mutation. As execution time increases, mutated data will gradually lengthen until it meets the requirements of [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider).

If `max_len` is reached and still cannot satisfy [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider)'s requirements, the process will exit. Please modify the fuzz test case (recommended) or increase `max_len` (not recommended).

### let data

```cangjie
public let data: Array<UInt8>
```

Function: Mutated data.

Type: Array\<UInt8>

### var offset

```cangjie
public var offset: Int64
```

Function: Number of bytes already converted.

Type: Int64

### var remainingBytes

```cangjie
public var remainingBytes: Int64
```

Function: Number of remaining bytes.

Type: Int64

### func consumeAll()

```cangjie
public open func consumeAll(): Array<UInt8>
```

Function: Converts all data into a UInt8 array.

Return Value:

- Array\<UInt8> - A UInt8 array.

### func consumeAllAsAscii()

```cangjie
public open func consumeAllAsAscii(): String
```

Function: Converts all data into an Ascii String.

Return Value:

- String - An Ascii String instance.

### func consumeAllAsString()

```cangjie
public open func consumeAllAsString(): String
```

Function: Converts all data into a utf8 String.

Return Value:

- String - A utf8 String instance.

### func consumeAsciiString(Int64)

```cangjie
public open func consumeAsciiString(maxLength: Int64): String
```

Function: Converts data into an Ascii String instance.

Parameters:

- maxLength: Int64 - Maximum length of the String.

Return Value:

- String - A String instance.

Exceptions:

- IllegalArgumentException - Thrown if maxLength is negative.

### func consumeBool()

```cangjie
public open func consumeBool(): Bool
```

Function: Converts data into a Bool instance.

Return Value:

- Bool - A Bool instance.

### func consumeBools(Int64)

```cangjie
public open func consumeBools(count: Int64): Array<Bool>
```

Function: Converts specified amount of data into a Bool array.

Parameters:

- count: Int64 - Specified amount of data to convert.

Return Value:

- Array\<Bool> - A Bool array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.
- Array\<Byte> - Byte type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeFloat32()

```cangjie
public open func consumeFloat32(): Float32
```

Function: Converts data into a Float32 type instance.

Return value:

- Float32 - Float32 type instance.

### func consumeFloat64()

```cangjie
public open func consumeFloat64(): Float64
```

Function: Converts data into a Float64 type instance.

Return value:

- Float64 - Float64 type instance.

### func consumeInt16()

```cangjie
public open func consumeInt16(): Int16
```

Function: Converts data into an Int16 type instance.

Return value:

- Int16 - Int16 type instance.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeInt16s(Int64)

```cangjie
public open func consumeInt16s(count: Int64): Array<Int16>
```

Function: Converts a specified amount of data into an Int16 type array.

Parameters:

- count: Int64 - Specifies the amount of data to convert.

Return value:

- Array\<Int16> - Int16 type array.

### func consumeInt32()

```cangjie
public open func consumeInt32(): Int32
```

Function: Converts data into an Int32 type instance.

Return value:

- Int32 - Int32 type instance.

### func consumeInt32s(Int64)

```cangjie
public open func consumeInt32s(count: Int64): Array<Int32>
```

Function: Converts a specified amount of data into an Int32 type array.

Parameters:

- count: Int64 - Specifies the amount of data to convert.

Return value:

- Array\<Int32> - Int32 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeInt64()

```cangjie
public open func consumeInt64(): Int64
```

Function: Converts data into an Int64 type instance.

Return value:

- Int64 - Int64 type instance.

### func consumeInt64s(Int64)

```cangjie
public open func consumeInt64s(count: Int64): Array<Int64>
```

Function: Converts a specified amount of data into an Int64 type array.

Parameters:

- count: Int64 - Specifies the amount of data to convert.

Return value:

- Array\<Int64> - Int64 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeInt8()

```cangjie
public open func consumeInt8(): Int8
```

Function: Converts data into an Int8 type instance.

Return value:

- Int8 - Int8 type instance.

### func consumeInt8s(Int64)

```cangjie
public open func consumeInt8s(count: Int64): Array<Int8>
```

Function: Converts a specified amount of data into an Int8 type array.

Parameters:

- count: Int64 - Specifies the amount of data to convert.

Return value:

- Array\<Int8> - Int8 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeRune()

```cangjie
public open func consumeRune(): Rune
```

Function: Converts data into a Rune type instance.

Return value:

- Rune - Rune type instance.

### func consumeString(Int64)

```cangjie
public open func consumeString(maxLength: Int64): String
```

Function: Converts data into a utf8 String type instance.

Parameters:

- maxLength: Int64 - Maximum length of the String type.

Return value:

- String - String type instance.

Exceptions:

- IllegalArgumentException - Thrown if maxLength is negative.

### func consumeUInt16()

```cangjie
public open func consumeUInt16(): UInt16
```

Function: Converts data into a UInt16 type instance.

Return value:

- UInt16 - UInt16 type instance.

### func consumeUInt16s(Int64)

```cangjie
public open func consumeUInt16s(count: Int64): Array<UInt16>
```

Function: Converts a specified amount of data into a UInt16 type array.

Parameters:

- count: Int64 - Specifies the amount of data to convert.

Return value:

- Array\<UInt16> - UInt16 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeUInt32()

```cangjie
public open func consumeUInt32(): UInt32
```

Function: Converts data into a UInt32 type instance.

Return value:

- UInt32 - UInt32 type instance.

### func consumeUInt32s(Int64)

```cangjie
public open func consumeUInt32s(count: Int64): Array<UInt32>
```

Function: Converts a specified amount of data into a UInt32 type array.

Parameters:

- count: Int64 - Specifies the amount of data to convert.

Return value:

- Array\<UInt32> - UInt32 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeUInt64()

```cangjie
public open func consumeUInt64(): UInt64
```

Function: Converts data into a UInt64 type instance.

Return value:

- UInt64 - UInt64 type instance.

### func consumeUInt64s(Int64)

```cangjie
public open func consumeUInt64s(count: Int64): Array<UInt64>
```

Function: Converts a specified amount of data into a UInt64 type array.

Parameters:

- count: Int64 - Specifies the amount of data to convert.

Return value:

- Array\<UInt64> - UInt64 type array.

Exceptions:

- IllegalArgumentException - Thrown if count is negative.

### func consumeUInt8()

```cangjie
public open func consumeUInt8(): UInt8
```

Function: Converts data into a UInt8 type instance.

Return value:

- UInt8 - UInt8 type instance.

### func consumeUInt8s(Int64)

```cangjie
public open func consumeUInt8s(count: Int64): Array<UInt8>
```

Function: Converts the specified amount of data into a UInt8 array.

Parameters:

- count: Int64 - Specifies the amount of data to convert.

Return Value:

- Array\<UInt8> - A UInt8 type array.

Exceptions:

- IllegalArgumentException - Throws an exception if count is negative.

### static func withCangjieData(Array\<UInt8>)

```cangjie
public static func withCangjieData(data: Array<UInt8>): FuzzDataProvider
```

Function: Generates a [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) type instance using Array\<UInt8> data.

Parameters:

- data: Array\<UInt8> - Input external data.

Return Value:

- [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) - Constructed [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) type instance.

### static func withNativeData(CPointer\<UInt8>, Int64)

```cangjie
public static unsafe func withNativeData(data: CPointer<UInt8>, length: Int64): FuzzDataProvider
```

Function: Generates a [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) type instance using C pointer data.

Parameters:

- data: CPointer\<UInt8> - Input external data.
- length: Int64 - Data length.

Return Value:

- [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) - Constructed [FuzzDataProvider](fuzz_package_classes.md#class-fuzzdataprovider) type instance.