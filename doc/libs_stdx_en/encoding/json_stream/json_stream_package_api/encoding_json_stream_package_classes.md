# Classes

## class JsonReader

```cangjie
public class JsonReader {
    public init(inputStream: InputStream)
}
```

Functionality: This class provides deserialization capability from JSON data stream to Cangjie objects.

Usage examples can be found at [Deserialization using Json Stream](../json_stream_samples/sample_json_reader.md)

### init(InputStream)

```cangjie
public init(inputStream: InputStream)
```

Functionality: Creates a [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) from an input stream. When reading data from the input stream, [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader) will skip whitespace characters ('\0', '\t', '\n', '\r') that are not within [JsonString](../../json/json_package_api/encoding_json_package_classes.md#class-jsonstring).

Parameters:

- inputStream: InputStream - The input JSON data stream.

### func endArray()

```cangjie
public func endArray(): Unit
```

Functionality: Consumes a ']' character after skipping whitespace from the current position of the input stream. Each [endArray](encoding_json_stream_package_classes.md#func-endarray) must have a corresponding [startArray](encoding_json_stream_package_classes.md#func-startarray).

Exceptions:

- IllegalStateException - Thrown if the JSON data in the input stream does not conform to the expected format.

### func endObject()

```cangjie
public func endObject(): Unit
```

Functionality: Consumes a '}' character after skipping whitespace from the current position of the input stream. Each [endObject](encoding_json_stream_package_classes.md#func-endobject) must have a corresponding [startObject](encoding_json_stream_package_classes.md#func-startobject).

Exceptions:

- IllegalStateException - Thrown if the JSON data in the input stream does not conform to the expected format.

### func peek()

```cangjie
public func peek(): Option<JsonToken>
```

Functionality: Gets the type of the next [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken) from the input stream, without guaranteeing the correctness of the next [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken)'s format.

Example: If the next character in the input stream is 't', the obtained [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken) will be [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken).Bool, but calling readValue\<Bool>() may not necessarily succeed.

Return value:

- Option\<[JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken)> - The type of the next [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken) obtained. Returns None if the end of the input stream is reached.

Exceptions:

- IllegalStateException - Thrown if the next character in the input stream is not within the following range: (n, t, f, ", 0~9, -, {, }, [, ]).

### func readName()

```cangjie
public func readName(): String
```

Functionality: Reads a name from the current position of the input stream.

Return value:

- String - The name value read.

Exceptions:

- IllegalStateException - Thrown if the JSON data in the input stream does not conform to the expected format.

### func readValue\<T>() where T <: JsonDeserializable\<T>

```cangjie
public func readValue<T>(): T where T <: JsonDeserializable<T>
```

Functionality: Reads a value from the current position of the input stream.

> **Note:**
>
> When the generic type T is String, the return value of this function will vary depending on the next [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken):
>
> - When the next [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken) is [JsonString](../../json/json_package_api/encoding_json_package_classes.md#class-jsonstring), the deserialization process will escape the read String according to the standard [ECMA-404 The JSON Data Interchange Standard](https://www.ecma-international.org/publications-and-standards/standards/ecma-404/).
>
> - When the next [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken) is [JsonInt](../../json/json_package_api/encoding_json_package_classes.md#class-jsonint), [JsonFloat](../../json/json_package_api/encoding_json_package_classes.md#class-jsonfloat), [JsonBool](../../json/json_package_api/encoding_json_package_classes.md#class-jsonbool), or [JsonNull](../../json/json_package_api/encoding_json_package_classes.md#class-jsonnull), the raw string of the next `value` field will be read and returned.
>
> - When the next [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken) is of another type, calling this interface will throw an exception.

Return value:

- T - The value read.

Exceptions:

- IllegalStateException - Thrown if the JSON data in the input stream does not conform to the expected format.

### func readValueBytes()

```cangjie
public func readValueBytes(): Array<Byte>
```

Functionality: Reads the next set of raw data (byte array) from the input stream without performing any escaping operations.

> **Description:**
>
> The rules for readValueBytes are as follows:
>
> - If the next token is a value, reads all raw bytes of this value until the terminating symbol (e.g., ',', '}', ']') is encountered.
>
> - If the next token is a Name, reads the raw byte array of the (name + value) combination.
>
> - If the next token is BeginArray, reads all raw bytes within the Array.
>
> - If the next token is BeginObject, reads all raw bytes within the Object.
>
> - If the next token is EndArray, EndObject, or None, performs no operation and returns an empty array. Subsequent peek() calls will still return EndArray, EndObject, or None.

Return value:

- Array\<Byte> - The raw byte data corresponding to the next set of data.

Exceptions:

- IllegalStateException - Thrown if the JSON data in the input stream does not conform to the expected format.

### func skip()

```cangjie
public func skip(): Unit
```

Functionality: Skips a set of data from the current position of the input stream.

> **Description:**
>
> The rules for skip are as follows:
>
> - If the next token is a value, skips this value without checking its format correctness.
>
> - If the next token is a Name, skips the (name + value) combination.
>
> - If the next token is BeginArray, skips this array.
>
> - If the next token is BeginObject, skips this object.
>
> - If the next token is EndArray, EndObject, or None, performs no operation. Subsequent peek() calls will still return EndArray, EndObject, or None.

Exceptions:

- IllegalStateException - Thrown if the JSON data in the input stream does not conform to the expected format.

### func startArray()

```cangjie
public func startArray(): Unit
```

Functionality: Consumes a '[' character after skipping whitespace from the current position of the input stream.

Exceptions:

- IllegalStateException - Thrown if the JSON data in the input stream does not conform to the expected format.

### func startObject()

```cangjie
public func startObject(): Unit
```

Functionality: Consumes a '{' character after skipping whitespace from the current position of the input stream.

Exceptions:

- IllegalStateException - Thrown if the JSON data in the input stream does not conform to the expected format.

## class JsonWriter

```cangjie
public class JsonWriter {
    public var writeConfig = WriteConfig.compact
    public init(out: OutputStream)
}
```

Functionality: [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) provides the capability to serialize Cangjie objects to an OutputStream.

[JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) needs to be used in conjunction with the interface [JsonSerializable](encoding_json_stream_package_interfaces.md#interface-jsonserializable). [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) can write types that implement the [JsonSerializable](encoding_json_stream_package_interfaces.md#interface-jsonserializable) interface to the Stream using writeValue.

> **Note:**
>
> [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) uses a buffer to reduce the number of I/O operations when writing to the Stream. Before finishing with [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter), the flush function must be called to ensure all buffered data is written to the Stream.

Example:

Usage examples can be found at [Serialization using Json Stream](../json_stream_samples/sample_json_writer.md)

### var writeConfig

```cangjie
public var writeConfig = WriteConfig.compact
```

Functionality: Serialization format configuration. See [WriteConfig](./encoding_json_stream_package_structs.md#struct-writeconfig) for details.

### init(OutputStream)

```cangjie
public init(out: OutputStream)
```

Functionality: Constructor, creates an instance that writes data to out.

Parameters:

- out: OutputStream - The target stream.

### func endArray()

```cangjie
public func endArray(): Unit
```

Functionality: Ends the serialization of the current JSON array.

Exceptions:

- IllegalStateException - Thrown when there is no matching startArray for the current writer.

### func endObject()

```cangjie
public func endObject(): Unit
```

Functionality: Ends the serialization of the current JSON object.

Exceptions:

- IllegalStateException - Thrown when the current writer's state does not allow ending a JSON object.

### func flush()

```cangjie
public func flush(): Unit
```

Functionality: Writes buffered data to out and calls out's flush method.

### func jsonValue(String)

```cangjie
public func jsonValue(value: String): JsonWriter
```

Functionality: Writes a raw string conforming to JSON value specifications to the stream.

> **Note:**
>
> This function does not escape the value or add double quotes to the input. If users can ensure the input value conforms to the data interchange standard [ECMA-404 The JSON Data Interchange Standard](https://www.ecma-international.org/publications-and-standards/standards/ecma-404/), it is recommended to use this function.

Return value:

- [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - Returns a reference to the current [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) for method chaining.

Exceptions:

- IllegalStateException - Thrown when the current writer's state does not allow writing a value.

### func startArray()

```cangjie
public func startArray(): Unit
```

Functionality: Begins serialization of a new JSON array. Each [startArray](encoding_json_stream_package_classes.md#func-startarray-1) must have a corresponding [endArray](encoding_json_stream_package_classes.md#func-endarray-1).

Exceptions:

- IllegalStateException - Thrown when the current writer's state does not allow writing a JSON array.

### func startObject()

```cangjie
public func startObject(): Unit
```

Function: Begins serializing a new JSON object. Every [startObject](encoding_json_stream_package_classes.md#func-startobject-1) must have a corresponding [endObject](encoding_json_stream_package_classes.md#func-endobject-1).

Exceptions:

- IllegalStateException - Thrown when the current writer's state is inappropriate for writing a JSON object.

### func writeName(String)

```cangjie
public func writeName(name: String): JsonWriter
```

Function: Writes a name within an object structure.

Return value:

- [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - Returns a reference to the current [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter).

Exceptions:

- IllegalStateException - Thrown when the current [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) state is inappropriate for writing the specified `name` parameter.

### func writeNullValue()

```cangjie
public func writeNullValue(): JsonWriter
```

Function: Writes a JSON null value to the stream.

Return value:

- [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - Returns a reference to the current [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) for method chaining convenience.

Exceptions:

- IllegalStateException - Thrown when the current writer's state is inappropriate for writing a value.

### func writeValue\<T>(T) where T <: JsonSerializable

```cangjie
public func writeValue<T>(v: T): JsonWriter where T <: JsonSerializable
```

Function: Writes a type implementing the [JsonSerializable](encoding_json_stream_package_interfaces.md#interface-jsonserializable) interface to the Stream. This interface calls the toJson method of generic type T to write data to the output stream.

The json.stream package has extended [JsonSerializable](encoding_json_stream_package_interfaces.md#interface-jsonserializable) implementation for basic types including Int64, UInt64, Float64, Bool, String, as well as Collection types Array, ArrayList, and HashMap.

Return value:

- [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter) - Returns a reference to the current [JsonWriter](encoding_json_stream_package_classes.md#class-jsonwriter).

Exceptions:

- IllegalStateException - Thrown when the current writer's state is inappropriate for writing a value.
