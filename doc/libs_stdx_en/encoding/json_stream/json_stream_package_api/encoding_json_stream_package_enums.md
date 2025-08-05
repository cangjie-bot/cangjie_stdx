# Enumeration

## enum JsonToken

```cangjie
public enum JsonToken <: Equatable<JsonToken> & Hashable{
    | JsonNull
    | JsonBool
    | JsonNumber
    | JsonString
    | BeginArray
    | EndArray
    | BeginObject
    | EndObject
    | Name
}
```

Function: Represents the structure, name, or value type in a JSON-encoded string.

[JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken) is typically used with [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).peek(), where the return value determines the specific processing approach.

Parent Types:

- Equatable\<[JsonToken](#enum-jsontoken)>
- Hashable

### BeginArray

```cangjie
BeginArray
```

Function: Indicates the start of an array in JSON. If [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).peek() returns this type, you can use [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).startArray() to read it.

### BeginObject

```cangjie
BeginObject
```

Function: Indicates the start of an object in JSON. If [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).peek() returns this type, you can use [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).startObject() to read it.

### EndArray

```cangjie
EndArray
```

Function: Indicates the end of an array in JSON. If [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).peek() returns this type, you can use [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).endArray() to read it.

### EndObject

```cangjie
EndObject
```

Function: Indicates the end of an object in JSON. If [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).peek() returns this type, you can use [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).endObject() to read it.

### JsonBool

```cangjie
JsonBool
```

Function: Represents the bool type in JSON. If [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).peek() returns this type, you can use [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).readValue\<Bool>() to read it.

### JsonNull

```cangjie
JsonNull
```

Function: Represents the null type in JSON. If [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).peek() returns this type, you can use [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).readValue\<Option\<T>>() to read it.

### JsonNumber

```cangjie
JsonNumber
```

Function: Represents the number type in JSON. If [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).peek() returns this type, you can use [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).readValue\<Float64>() to read it.

### JsonString

```cangjie
JsonString
```

Function: Represents the string type in JSON. If [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).peek() returns this type, you can use [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).readValue\<String>() to read it.

### Name

```cangjie
Name
```

Function: Represents a name within an object. If [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).peek() returns this type, you can use [JsonReader](encoding_json_stream_package_classes.md#class-jsonreader).readName() to read it.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hashCode value of a [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken) object.

Return Value:

- Int64 - The hashCode value.

### operator func !=(JsonToken)

```cangjie
public operator func !=(that: JsonToken): Bool
```

Function: Inequality comparison.

Parameters:

- that: [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken) - The [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken) object to compare with

Return Value:

- Bool - Returns true if the current instance is not equal to that, otherwise returns false

### operator func ==(JsonToken)

```cangjie
public operator func ==(that: JsonToken): Bool
```

Function: Equality comparison.

Parameters:

- that: [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken) - The [JsonToken](encoding_json_stream_package_enums.md#enum-jsontoken) object to compare with

Return Value:

- Bool - Returns true if the current instance is equal to that, otherwise returns false