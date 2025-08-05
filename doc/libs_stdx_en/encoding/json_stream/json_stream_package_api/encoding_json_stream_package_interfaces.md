# Interface

## interface JsonDeserializable\<T>

```cangjie
public interface JsonDeserializable<T> {
    static func fromJson(r: JsonReader): T
}
```

Functionality: This interface is used to implement reading a Cangjie object from [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).

Supported object types include:

- Basic data types: integer types, floating-point types, boolean type, string type.

- Collection types: Array, ArrayList, HashMap, Option.

- BigInt, Decimal types.

- DateTime type.

### static func fromJson(JsonReader)

```cangjie
static func fromJson(r: JsonReader): T
```

Functionality: Reads a `T` type object from the [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance specified by parameter `r`.

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return value:

- T - An instance of type `T`.

Exceptions:

- IllegalStateException - Thrown if the JSON data in the input stream does not conform to the required format.

### extend BigInt <: JsonDeserializable\<BigInt>

```cangjie
extend BigInt <: JsonDeserializable<BigInt>
```

Functionality: Implements the JsonDeserializable interface for BigInt type.

Parent type:

- [JsonDeserializable](#interface-jsondeserializablet)\<BigInt>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): BigInt
```

Functionality: Reads a BigInt from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return value:

- BigInt - An instance of BigInt type.

### extend Bool <: JsonDeserializable\<Bool>

```cangjie
extend Bool <: JsonDeserializable<Bool>
```

Functionality: Implements the JsonDeserializable interface for Bool type.

Parent type:

- [JsonDeserializable](#interface-jsondeserializablet)\<Bool>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): Bool
```

Functionality: Reads a Bool from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return value:

- Bool - An instance of Bool type.

### extend DateTime <: JsonDeserializable\<DateTime>

```cangjie
extend DateTime <: JsonDeserializable<DateTime>
```

Functionality: Implements the JsonDeserializable interface for DateTime type.

Parent type:

- [JsonDeserializable](#interface-jsondeserializablet)\<DateTime>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): DateTime
```

Functionality: Reads a DateTime instance from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

This function will parse the read string according to the `RFC3339` specification, which may include fractional seconds format. The function behavior refers to DateTime's func parse(String).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return value:

- DateTime - An instance of DateTime type.

Exceptions:

- TimeParseException - Thrown when parsing fails.

### extend Decimal <: JsonDeserializable\<Decimal>

```cangjie
extend Decimal <: JsonDeserializable<Decimal>
```

Functionality: Implements the [JsonDeserializable](./encoding_json_stream_package_interfaces.md#interface-jsondeserializablet) interface for Decimal type.

Parent type:

- [JsonDeserializable](#interface-jsondeserializablet)\<Decimal>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): Decimal
```

Functionality: Reads a Decimal from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return value:

- Decimal - An instance of Decimal type.

### extend Float16 <: JsonDeserializable\<Float16>

```cangjie
extend Float16 <: JsonDeserializable<Float16>
```

Functionality: Implements the JsonDeserializable interface for Float16 type.

Parent type:

- [JsonDeserializable](#interface-jsondeserializablet)\<Float16>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): Float16
```

Functionality: Reads a Float16 from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return value:

- Float16 - An instance of Float16 type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend Float32 <: JsonDeserializable\<Float32>

```cangjie
extend Float32 <: JsonDeserializable<Float32>
```

Functionality: Implements the JsonDeserializable interface for Float32 type.

Parent type:

- [JsonDeserializable](#interface-jsondeserializablet)\<Float32>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): Float32
```

Functionality: Reads a Float32 from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return value:

- Float32 - An instance of Float32 type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend Float64 <: JsonDeserializable\<Float64>

```cangjie
extend Float64 <: JsonDeserializable<Float64>
```

Functionality: Implements the JsonDeserializable interface for Float64 type.

Parent type:

- [JsonDeserializable](#interface-jsondeserializablet)\<Float64>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): Float64
```

Functionality: Reads a Float64 from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return value:

- Float64 - An instance of Float64 type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend String <: JsonDeserializable\<String>

```cangjie
extend String <: JsonDeserializable<String>
```

Functionality: Implements the JsonDeserializable interface for String type.

Parent type:

- [JsonDeserializable](#interface-jsondeserializablet)\<String>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): String
```

Functionality: Reads a String from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

The deserialization result of `String` will vary depending on the next `JsonToken`:

- When the next `JsonToken` is `JsonString`, the deserialization process will escape the read `String` according to the standard [ECMA-404 The JSON Data Interchange Standard](https://www.ecma-international.org/publications-and-standards/standards/ecma-404/).
- When the next `JsonToken` is one of `JsonNumber`, `JsonBool`, or `JsonNull`, the raw string of the next `value` field will be read and returned.
- When the next `JsonToken` is of another type, calling this interface will throw an exception.

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return value:

- String - An instance of String type.

### extend Int16 <: JsonDeserializable\<Int16>

```cangjie
extend Int16 <: JsonDeserializable<Int16>
```

Functionality: Implements the JsonDeserializable interface for Int16 type.

Parent type:- [JsonDeserializable](#interface-jsondeserializablet)\<Int16>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): Int16
```

Function: Reads an Int16 from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialized results.

Return Value:

- Int16 - An instance of Int16 type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend Int32 <: JsonDeserializable\<Int32>

```cangjie
extend Int32 <: JsonDeserializable<Int32>
```

Function: Implements the JsonDeserializable interface for Int32 type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<Int32>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): Int32
```

Function: Reads an Int32 from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialized results.

Return Value:

- Int32 - An instance of Int32 type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend Int64 <: JsonDeserializable\<Int64>

```cangjie
extend Int64 <: JsonDeserializable<Int64>
```

Function: Implements the JsonDeserializable interface for Int64 type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<Int64>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): Int64
```

Function: Reads an Int64 from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialized results.

Return Value:

- Int64 - An instance of Int64 type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend Int8 <: JsonDeserializable\<Int8>

```cangjie
extend Int8 <: JsonDeserializable<Int8>
```

Function: Implements the JsonDeserializable interface for Int8 type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<Int8>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): Int8
```

Function: Reads an Int8 from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialized results.

Return Value:

- Int8 - An instance of Int8 type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend IntNative <: JsonDeserializable\<IntNative>

```cangjie
extend IntNative <: JsonDeserializable<IntNative>
```

Function: Implements the JsonDeserializable interface for IntNative type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<IntNative>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): IntNative
```

Function: Reads an IntNative from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialized results.

Return Value:

- IntNative - An instance of IntNative type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend UInt16 <: JsonDeserializable\<UInt16>

```cangjie
extend UInt16 <: JsonDeserializable<UInt16>
```

Function: Implements the JsonDeserializable interface for UInt16 type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<UInt16>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): UInt16
```

Function: Reads a UInt16 from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialized results.

Return Value:

- UInt16 - An instance of UInt16 type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend UInt32 <: JsonDeserializable\<UInt32>

```cangjie
extend UInt32 <: JsonDeserializable<UInt32>
```

Function: Implements the JsonDeserializable interface for UInt32 type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<UInt32>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): UInt32
```

Function: Reads a UInt32 from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialized results.

Return Value:

- UInt32 - An instance of UInt32 type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend UInt64 <: JsonDeserializable\<UInt64 >

```cangjie
extend UInt64 <: JsonDeserializable<UInt64>
```

Function: Implements the JsonDeserializable interface for UInt64 type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<UInt64>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): UInt64
```

Function: Reads a UInt64 from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialized results.

Return Value:

- UInt64 - An instance of UInt64 type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend UInt8 <: JsonDeserializable\<UInt8>

```cangjie
extend UInt8 <: JsonDeserializable<UInt8>
```

Function: Implements the JsonDeserializable interface for UInt8 type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<UInt8>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): UInt8
```

Function: Reads a UInt8 from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - The [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialized results.

Return Value:

- UInt8 - An instance of UInt8 type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend UIntNative <: JsonDeserializable\<UIntNative>

```cangjie
extend UIntNative <: JsonDeserializable<UIntNative>
```

Function: Implements the JsonDeserializable interface for UIntNative type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<UIntNative>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): UIntNative
```

Function: Reads a UIntNative from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - A [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return Value:

- UIntNative - An instance of UIntNative type.

Exceptions:

- OverflowException - Thrown when the read data exceeds the valid range.

### extend\<T> Array\<T> <: JsonDeserializable\<Array\<T>> where T <: JsonDeserializable\<T>

```cangjie
extend<T> Array<T> <: JsonDeserializable<Array<T>> where T <: JsonDeserializable<T>
```

Function: Implements the JsonDeserializable interface for Array\<T> type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<Array\<T>>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): Array<T>
```

Function: Reads an Array from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - A [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return Value:

- Array\<T> - An instance of Array type.

### extend\<T> ArrayList\<T> <: JsonDeserializable\<ArrayList\<T>> where T <: JsonDeserializable\<T>

```cangjie
extend<T> ArrayList<T> <: JsonDeserializable<ArrayList<T>> where T <: JsonDeserializable<T>
```

Function: Implements the JsonDeserializable interface for ArrayList type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<ArrayList\<T>>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): ArrayList<T>
```

Function: Reads an ArrayList from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - A [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return Value:

- ArrayList\<T> - An instance of ArrayList type.

### extend\<T> Option\<T> <: JsonDeserializable\<Option\<T>> where T <: JsonDeserializable\<T>

```cangjie
extend<T> Option<T> <: JsonDeserializable<Option<T>> where T <: JsonDeserializable<T>
```

Function: Implements the JsonDeserializable interface for Option type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<Option\<T>>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): Option<T>
```

Function: Reads an Option from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - A [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return Value:

- Option\<T> - An instance of Option type.

### extend\<T> HashMap\<String, T> <: JsonDeserializable\<HashMap\<String, T>> where T <: JsonDeserializable\<T>

```cangjie
extend<T> HashMap<String, T> <: JsonDeserializable<HashMap<String, T>> where T <: JsonDeserializable<T>
```

Function: Implements the JsonDeserializable interface for HashMap type.

Parent Type:

- [JsonDeserializable](#interface-jsondeserializablet)\<HashMap\<String, T>>

#### static func fromJson(JsonReader)

```cangjie
public static func fromJson(r: JsonReader): HashMap<String, T>
```

Function: Reads a HashMap from [JsonReader](../json_stream_package_api/encoding_json_stream_package_classes.md#class-jsonreader).

Parameters:

- r: [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) - A [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) instance for reading deserialization results.

Return Value:

- HashMap\<String, T> - An instance of HashMap\<String, T> type.

## interface JsonSerializable

```cangjie
public interface JsonSerializable {
    func toJson(w: JsonWriter): Unit
}
```

Function: Provides an interface for serializing types to JSON data streams.

Used in conjunction with [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter), which can write types implementing the [JsonSerializable](encoding_json_stream_package_interfaces.md#interface-jsonserializable) interface to a Stream.

### func toJson(JsonWriter)

```cangjie
func toJson(w: JsonWriter): Unit
```

Function: Writes the type implementing the [JsonSerializable](encoding_json_stream_package_interfaces.md#interface-jsonserializable) interface to the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - A [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialization results.

### extend BigInt <: JsonSerializable

```cangjie
extend BigInt <: JsonSerializable
```

Function: Provides an interface for serializing BigInt type to JSON data streams.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the BigInt type to the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - A [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialization results.

### extend Bool <: JsonSerializable

```cangjie
extend Bool <: JsonSerializable
```

Function: Provides an interface for serializing Bool type to JSON data streams.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the Bool type to the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - A [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialization results.

### extend DateTime <: JsonSerializable

```cangjie
extend DateTime <: JsonSerializable
```

Function: Implements the JsonSerializable interface for DateTime type.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Provides serialization capability for DateTime type to streams.

This interface's functionality is related to the [dateTimeFormat](./encoding_json_stream_package_structs.md#prop-datetimeformat) property in [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter)'s [writeConfig](./encoding_json_stream_package_classes.md#var-writeconfig). It will output DateTime to the target stream according to the format specified in [dateTimeFormat](./encoding_json_stream_package_structs.md#prop-datetimeformat). Different format controls can be achieved by modifying [dateTimeFormat](./encoding_json_stream_package_structs.md#prop-datetimeformat).

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - A [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialization results.

### extend Decimal <: JsonSerializable

```cangjie
extend Decimal <: JsonSerializable
```

Function: Provides an interface for serializing Decimal type to JSON data streams.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the Decimal type to the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - A [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialization results.

### extend Float16 <: JsonSerializable

```cangjie
extend Float16 <: JsonSerializable
```

Function: Provides an interface for serializing Float16 type to JSON data streams.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the Float16 type to the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - A [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialization results.

### extend Float32 <: JsonSerializable

```cangjie
extend Float32 <: JsonSerializable
```

Function: Provides an interface for serializing Float32 type to JSON data streams.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the Float32 type to the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - A [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialization results.

### extend Float64 <: JsonSerializable

```cangjie
extend Float64 <: JsonSerializable
```

Function: Provides an interface for serializing Float64 type to JSON data streams.Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the Float64 type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend String <: JsonSerializable

```cangjie
extend String <: JsonSerializable
```

Function: Provides an interface for serializing String type to JSON data stream.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the String type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`. The written String

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend Int16 <: JsonSerializable

```cangjie
extend Int16 <: JsonSerializable
```

Function: Provides an interface for serializing Int16 type to JSON data stream.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the Int16 type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend Int32 <: JsonSerializable

```cangjie
extend Int32 <: JsonSerializable
```

Function: Provides an interface for serializing Int32 type to JSON data stream.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the Int32 type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend Int64 <: JsonSerializable

```cangjie
extend Int64 <: JsonSerializable
```

Function: Provides an interface for serializing Int64 type to JSON data stream.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the Int64 type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend Int8 <: JsonSerializable

```cangjie
extend Int8 <: JsonSerializable
```

Function: Provides an interface for serializing Int8 type to JSON data stream.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the Int8 type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend IntNative <: JsonSerializable

```cangjie
extend IntNative <: JsonSerializable
```

Function: Provides an interface for serializing IntNative type to JSON data stream.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the IntNative type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend UInt16 <: JsonSerializable

```cangjie
extend UInt16 <: JsonSerializable
```

Function: Provides an interface for serializing UInt16 type to JSON data stream.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the UInt16 type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend UInt32 <: JsonSerializable

```cangjie
extend UInt32 <: JsonSerializable
```

Function: Provides an interface for serializing UInt32 type to JSON data stream.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the UInt32 type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend UInt64 <: JsonSerializable

```cangjie
extend UInt64 <: JsonSerializable
```

Function: Provides an interface for serializing UInt64 type to JSON data stream.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the UInt64 type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend UInt8 <: JsonSerializable

```cangjie
extend UInt8 <: JsonSerializable
```

Function: Provides an interface for serializing UInt8 type to JSON data stream.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the UInt8 type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend UIntNative <: JsonSerializable

```cangjie
extend UIntNative <: JsonSerializable
```

Function: Provides an interface for serializing UIntNative type to JSON data stream.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the UIntNative type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend\<T> Array\<T> <: JsonSerializable where T <: JsonSerializable

```cangjie
extend<T> Array<T> <: JsonSerializable where T <: JsonSerializable
```

Function: Provides an interface for serializing Array\<T> type to JSON data stream.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the Array\<T> type into the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend\<T> ArrayList\<T> <: JsonSerializable where T <: JsonSerializable

```cangjie
extend<T> ArrayList<T> <: JsonSerializable where T <: JsonSerializable
```

Function: Provides serialization interface to JSON stream for ArrayList\<T> type.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the ArrayList\<T> type to the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend\<T> Option\<T> <: JsonSerializable where T <: JsonSerializable

```cangjie
extend<T> Option<T> <: JsonSerializable where T <: JsonSerializable
```

Function: Provides serialization interface to JSON stream for Option\<T> type.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the Option\<T> type to the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.

### extend\<V> HashMap\<String, V> <: JsonSerializable where V <: JsonSerializable

```cangjie
extend<V> HashMap<String, V> <: JsonSerializable where V <: JsonSerializable
```

Function: Provides serialization interface to JSON stream for HashMap\<String, T> type.

Parent Type:

- [JsonSerializable](#interface-jsonserializable)

#### func toJson(JsonWriter)

```cangjie
public func toJson(w: JsonWriter): Unit
```

Function: Writes the HashMap\<String, T> type to the [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance specified by parameter `w`.

Parameters:

- w: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - The [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) instance for writing serialized results.