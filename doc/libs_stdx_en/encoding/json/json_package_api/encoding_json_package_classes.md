# Classes

## class JsonArray

```cangjie
public class JsonArray <: JsonValue {
    public init()
    public init(list: ArrayList<JsonValue>)
    public init(list: Array<JsonValue>)
}
```

Functionality: This class implements a subclass of [JsonValue](encoding_json_package_classes.md#class-jsonvalue), primarily used for encapsulating array-type JSON data.

Parent Type:

- [JsonValue](#class-jsonvalue)

Example:

For usage examples, see [JsonArray Usage Samples](../json_samples/json_array_sample.md).

### init()

```cangjie
public init()
```

Functionality: Creates an empty [JsonArray](encoding_json_package_classes.md#class-jsonarray).

### init(ArrayList\<JsonValue>)

```cangjie
public init(list: ArrayList<JsonValue>)
```

Functionality: Encapsulates the specified ArrayList instance into a [JsonArray](encoding_json_package_classes.md#class-jsonarray) instance.

Parameters:

- list: ArrayList\<[JsonValue](encoding_json_package_classes.md#class-jsonvalue)> - The ArrayList used to create the [JsonArray](encoding_json_package_classes.md#class-jsonarray).

### init(Array\<JsonValue>)

```cangjie
public init(list: Array<JsonValue>)
```

Functionality: Encapsulates the specified Array instance into a [JsonArray](encoding_json_package_classes.md#class-jsonarray) instance.

Parameters:

- list: Array\<[JsonValue](encoding_json_package_classes.md#class-jsonvalue)> - The Array used to create the [JsonArray](encoding_json_package_classes.md#class-jsonarray).

### func add(JsonValue)

```cangjie
public func add(jv: JsonValue): JsonArray
```

Functionality: Adds a [JsonValue](encoding_json_package_classes.md#class-jsonvalue) to the [JsonArray](encoding_json_package_classes.md#class-jsonarray).

Parameters:

- jv: [JsonValue](encoding_json_package_classes.md#class-jsonvalue) - The [JsonValue](encoding_json_package_classes.md#class-jsonvalue) to be added.

Return Value:

- [JsonArray](encoding_json_package_classes.md#class-jsonarray) - The [JsonArray](encoding_json_package_classes.md#class-jsonarray) after adding the data.

### func get(Int64)

```cangjie
public func get(index: Int64): Option<JsonValue>
```

Functionality: Retrieves the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) at the specified index in the [JsonArray](encoding_json_package_classes.md#class-jsonarray), encapsulated in an Option\<[JsonValue](encoding_json_package_classes.md#class-jsonvalue)>.

Parameters:

- index: Int64 - The specified index.

Return Value:

- Option\<[JsonValue](encoding_json_package_classes.md#class-jsonvalue)> - The encapsulated [JsonValue](encoding_json_package_classes.md#class-jsonvalue) at the corresponding index.

### func getItems()

```cangjie
public func getItems(): ArrayList<JsonValue>
```

Functionality: Retrieves the items data from the [JsonArray](encoding_json_package_classes.md#class-jsonarray).

Return Value:

- ArrayList\<[JsonValue](encoding_json_package_classes.md#class-jsonvalue)> - The items data of the [JsonArray](encoding_json_package_classes.md#class-jsonarray).

### func kind()

```cangjie
public func kind(): JsonKind
```

Functionality: Returns the [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsArray) to which the current [JsonArray](encoding_json_package_classes.md#class-jsonarray) belongs.

Return Value:

- [JsonKind](encoding_json_package_enums.md#enum-jsonkind) - The [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsArray) to which the current [JsonArray](encoding_json_package_classes.md#class-jsonarray) belongs.

### func size()

```cangjie
public func size(): Int64
```

Functionality: Gets the number of [JsonValue](encoding_json_package_classes.md#class-jsonvalue) items in the [JsonArray](encoding_json_package_classes.md#class-jsonarray).

Return Value:

- Int64 - The number of [JsonValue](encoding_json_package_classes.md#class-jsonvalue) items in the [JsonArray](encoding_json_package_classes.md#class-jsonarray).

### func toJsonString()

```cangjie
public func toJsonString(): String
```

Functionality: Converts the [JsonArray](encoding_json_package_classes.md#class-jsonarray) into a JSON-formatted string (with spaces and line breaks).

Return Value:

- String - The converted JSON-formatted string.

### func toJsonString(Int64, Bool, String)

```cangjie
public func toJsonString(depth: Int64, bracketInNewLine!: Bool = false, indent!: String = "  "): String
```

Functionality: Converts the [JsonArray](encoding_json_package_classes.md#class-jsonarray) into a JSON-formatted string. This function specifies the initial indentation depth, whether the first bracket should be on a new line, and the indentation string.

Parameters:

- depth: Int64 - The specified indentation depth.
- bracketInNewLine!: Bool - Whether the first bracket should be on a new line. If `true`, the first bracket will start on a new line with the specified indentation depth.
- indent!: String - The specified indentation string, which can only contain combinations of spaces and tabs. Defaults to two spaces.

Return Value:

- String - The converted JSON-formatted string.

Exceptions:

- IllegalArgumentException - Thrown if depth is negative or if indent contains characters other than ' ' and '\t'.

### func toString()

```cangjie
public func toString(): String
```

Functionality: Converts the [JsonString](encoding_json_package_classes.md#class-jsonstring) into a string.

Return Value:

- String - The converted string.

### operator func []\(Int64)

```cangjie
public operator func [](index: Int64): JsonValue
```

Functionality: Retrieves the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) at the specified index in the [JsonArray](encoding_json_package_classes.md#class-jsonarray).

Parameters:

- index: Int64 - The specified index.

Return Value:

- [JsonValue](encoding_json_package_classes.md#class-jsonvalue) - The [JsonValue](encoding_json_package_classes.md#class-jsonvalue) at the corresponding index.

Exceptions:

- [JsonException](encoding_json_package_exceptions.md#class-jsonexception) - Thrown if the index is not a valid index for the [JsonArray](encoding_json_package_classes.md#class-jsonarray).

## class JsonBool

```cangjie
public class JsonBool <: JsonValue {
    public init(bv: Bool)
}
```

Functionality: This class implements a subclass of [JsonValue](encoding_json_package_classes.md#class-jsonvalue), primarily used for encapsulating JSON data of type true or false.

Parent Type:

- [JsonValue](#class-jsonvalue)

### init(Bool)

```cangjie
public init(bv: Bool)
```

Functionality: Encapsulates the specified Bool instance into a [JsonBool](encoding_json_package_classes.md#class-jsonbool) instance.

### func getValue()

```cangjie
public func getValue(): Bool
```

Functionality: Retrieves the actual value of the [JsonBool](encoding_json_package_classes.md#class-jsonbool).

Return Value:

- Bool - The actual value.

### func kind()

```cangjie
public func kind(): JsonKind
```

Functionality: Returns the [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsBool) to which the current [JsonBool](encoding_json_package_classes.md#class-jsonbool) belongs.

Return Value:

- [JsonKind](encoding_json_package_enums.md#enum-jsonkind) - The [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsBool) to which the current [JsonBool](encoding_json_package_classes.md#class-jsonbool) belongs.

### func toJsonString()

```cangjie
public func toJsonString(): String
```

Functionality: Converts the [JsonBool](encoding_json_package_classes.md#class-jsonbool) into a JSON-formatted string (with spaces and line breaks).

Return Value:

- String - The converted JSON-formatted string.

### func toString()

```cangjie
public func toString(): String
```

Functionality: Converts the [JsonBool](encoding_json_package_classes.md#class-jsonbool) into a string.

Return Value:

- String - The converted string.

## class JsonFloat

```cangjie
public class JsonFloat <: JsonValue {
    public init(fv: Float64)
    public init(v: Int64)
}
```

Functionality: This class implements a subclass of [JsonValue](encoding_json_package_classes.md#class-jsonvalue), primarily used for encapsulating floating-point type JSON data.

Parent Type:

- [JsonValue](#class-jsonvalue)

### init(Float64)

```cangjie
public init(fv: Float64)
```

Functionality: Encapsulates the specified Float64 instance into a [JsonFloat](encoding_json_package_classes.md#class-jsonfloat) instance.

Parameters:

- fv: Float64 - Float64 type.

### init(Int64)

```cangjie
public init(v: Int64)
```

Functionality: Encapsulates the specified Int64 instance into a [JsonFloat](encoding_json_package_classes.md#class-jsonfloat) instance.

Parameters:

- v: Int64 - Int64 type.

### func getValue()

```cangjie```markdown
public func getValue(): Float64
```

Function: Gets the actual value of the value in [JsonFloat](encoding_json_package_classes.md#class-jsonfloat).

Return value:

- Float64 - The actual value of the value.

### func kind()

```cangjie
public func kind(): JsonKind
```

Function: Returns the [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsFloat) to which the current [JsonFloat](encoding_json_package_classes.md#class-jsonfloat) belongs.

Return value:

- [JsonKind](encoding_json_package_enums.md#enum-jsonkind) - The [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsFloat) to which the current [JsonFloat](encoding_json_package_classes.md#class-jsonfloat) belongs.

### func toJsonString()

```cangjie
public func toJsonString(): String
```

Function: Converts [JsonFloat](encoding_json_package_classes.md#class-jsonfloat) into a JSON-formatted string (with spaces and line breaks).

Return value:

- String - The converted JSON-formatted string.

### func toString()

```cangjie
public func toString(): String
```

Function: Converts [JsonFloat](encoding_json_package_classes.md#class-jsonfloat) into a string.

Return value:

- String - The converted string.

## class JsonInt

```cangjie
public class JsonInt <: JsonValue {
    public init(iv: Int64)
}
```

Function: This class is an implementation subclass of [JsonValue](encoding_json_package_classes.md#class-jsonvalue), primarily used to encapsulate integer-type JSON data.

Parent type:

- [JsonValue](#class-jsonvalue)

### init(Int64)

```cangjie
public init(iv: Int64)
```

Function: Encapsulates the specified Int64 instance into a [JsonInt](encoding_json_package_classes.md#class-jsonint) instance.

Parameters:

- iv: Int64 - The Int64 used to create [JsonInt](encoding_json_package_classes.md#class-jsonint).

### func getValue()

```cangjie
public func getValue(): Int64
```

Function: Gets the actual value of the value in [JsonInt](encoding_json_package_classes.md#class-jsonint).

Return value:

- Int64 - The actual value of the value.

### func kind()

```cangjie
public func kind(): JsonKind
```

Function: Returns the [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsInt) to which the current [JsonInt](encoding_json_package_classes.md#class-jsonint) belongs.

Return value:

- [JsonKind](encoding_json_package_enums.md#enum-jsonkind) - The [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsInt) to which the current [JsonInt](encoding_json_package_classes.md#class-jsonint) belongs.

### func toJsonString()

```cangjie
public func toJsonString(): String
```

Function: Converts [JsonInt](encoding_json_package_classes.md#class-jsonint) into a JSON-formatted string (with spaces and line breaks).

Return value:

- String - The converted JSON-formatted string.

### func toString()

```cangjie
public func toString(): String
```

Function: Converts [JsonInt](encoding_json_package_classes.md#class-jsonint) into a string.

Return value:

- String - The converted string.

## class JsonNull

```cangjie
public class JsonNull <: JsonValue
```

Function: This class is an implementation subclass of [JsonValue](encoding_json_package_classes.md#class-jsonvalue), primarily used to encapsulate null JSON data.

Parent type:

- [JsonValue](#class-jsonvalue)

### func kind()

```cangjie
public func kind(): JsonKind
```

Function: Returns the [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsNull) to which the current [JsonNull](encoding_json_package_classes.md#class-jsonnull) belongs.

Return value:

- [JsonKind](encoding_json_package_enums.md#enum-jsonkind) - The [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsNull) to which the current [JsonNull](encoding_json_package_classes.md#class-jsonnull) belongs.

### func toJsonString()

```cangjie
public func toJsonString(): String
```

Function: Converts [JsonNull](encoding_json_package_classes.md#class-jsonnull) into a JSON-formatted string (with spaces and line breaks).

Return value:

- String - The converted JSON-formatted string.

### func toString()

```cangjie
public func toString(): String
```

Function: Converts [JsonNull](encoding_json_package_classes.md#class-jsonnull) into a string.

Return value:

- String - The converted string.

## class JsonObject

```cangjie
public class JsonObject <: JsonValue {
    public init()
    public init(map: HashMap<String, JsonValue>)
}
```

Function: This class is an implementation subclass of [JsonValue](encoding_json_package_classes.md#class-jsonvalue), primarily used to encapsulate object-type JSON data.

Parent type:

- [JsonValue](#class-jsonvalue)

### init()

```cangjie
public init()
```

Function: Creates an empty [JsonObject](encoding_json_package_classes.md#class-jsonobject).

### init(HashMap\<String, JsonValue>)

```cangjie
public init(map: HashMap<String, JsonValue>)
```

Function: Encapsulates the specified HashMap instance into a [JsonObject](encoding_json_package_classes.md#class-jsonobject) instance.

### func containsKey(String)

```cangjie
public func containsKey(key: String): Bool
```

Function: Determines whether the key exists in [JsonObject](encoding_json_package_classes.md#class-jsonobject).

Parameters:

- key: String - The specified key.

Return value:

- Bool - Returns true if the key exists, otherwise false.

### func get(String)

```cangjie
public func get(key: String): Option<JsonValue>
```

Function: Gets the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) corresponding to the key in [JsonObject](encoding_json_package_classes.md#class-jsonobject), encapsulated in Option\<[JsonValue](encoding_json_package_classes.md#class-jsonvalue)>.

Parameters:

- key: String - The specified key.

Return value:

- Option\<[JsonValue](encoding_json_package_classes.md#class-jsonvalue)> - The encapsulated form of the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) corresponding to the key.

### func getFields()

```cangjie
public func getFields(): HashMap<String, JsonValue>
```

Function: Gets the fields data in [JsonObject](encoding_json_package_classes.md#class-jsonobject).

Return value:

- HashMap\<String, [JsonValue](encoding_json_package_classes.md#class-jsonvalue)> - The fields data of [JsonObject](encoding_json_package_classes.md#class-jsonobject).

### func kind()

```cangjie
public func kind(): JsonKind
```

Function: Returns the [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsObject) to which the current [JsonObject](encoding_json_package_classes.md#class-jsonobject) belongs.

Return value:

- [JsonKind](encoding_json_package_enums.md#enum-jsonkind) - The [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsObject) to which the current [JsonObject](encoding_json_package_classes.md#class-jsonobject) belongs.

### func put(String, JsonValue)

```cangjie
public func put(key: String, v: JsonValue): Unit
```

Function: Adds key-[JsonValue](encoding_json_package_classes.md#class-jsonvalue) data to [JsonObject](encoding_json_package_classes.md#class-jsonobject).

Parameters:

- key: String - The key to be added.
- v: [JsonValue](encoding_json_package_classes.md#class-jsonvalue) - The [JsonValue](encoding_json_package_classes.md#class-jsonvalue) corresponding to the key.

### func size()

```cangjie
public func size(): Int64
```

Function: Gets the number of string-[JsonValue](encoding_json_package_classes.md#class-jsonvalue) pairs stored in the fields of [JsonObject](encoding_json_package_classes.md#class-jsonobject).

Return value:

- Int64 - The size of the fields in [JsonObject](encoding_json_package_classes.md#class-jsonobject).

### func toJsonString()

```cangjie
public func toJsonString(): String
```

Function: Converts [JsonObject](encoding_json_package_classes.md#class-jsonobject) into a JSON-formatted string (with spaces and line breaks).

Return value:

- String - The converted JSON-formatted string.

### func toJsonString(Int64, Bool, String)

```cangjie
public func toJsonString(depth: Int64, bracketInNewLine!: Bool = false, indent!: String = "  "): String
```

Function: Converts [JsonObject](encoding_json_package_classes.md#class-jsonobject) into a JSON-formatted string. This function specifies the initial indentation depth, whether to start a new line after the first bracket, and the indentation string.

Parameters:```markdown
- depth: Int64 - Indentation depth.
- bracketInNewLine!: Bool - Whether the first bracket should be on a new line. If `true`, the first bracket will start on a new line and be indented to the specified depth.
- indent!: String - The specified indentation string. The indentation string can only contain combinations of spaces and tabs. Defaults to two spaces.

Return Value:

- String - The converted JSON-formatted string.

Exceptions:

- IllegalArgumentException - Thrown if depth is negative, or if indent contains characters other than ' ' and '\t'.

### func toString()

```cangjie
public func toString(): String
```

Function: Converts a [JsonObject](encoding_json_package_classes.md#class-jsonobject) to a string.

Return Value:

- String - The converted string.

### operator func [](String)

```cangjie
public operator func [](key: String): JsonValue
```

Function: Retrieves the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) associated with the specified key in the [JsonObject](encoding_json_package_classes.md#class-jsonobject).

Parameters:

- key: String - The specified key.

Return Value:

- [JsonValue](encoding_json_package_classes.md#class-jsonvalue) - The [JsonValue](encoding_json_package_classes.md#class-jsonvalue) associated with the key.

Exceptions:

- [JsonException](encoding_json_package_exceptions.md#class-jsonexception) - Thrown if the key is not a valid key in the [JsonObject](encoding_json_package_classes.md#class-jsonobject).

## class JsonString

```cangjie
public class JsonString <: JsonValue {
    public init(sv: String)
}
```

Function: This class is a subclass implementation of [JsonValue](encoding_json_package_classes.md#class-jsonvalue), primarily used to encapsulate string-type JSON data.

Parent Type:

- [JsonValue](#class-jsonvalue)

### init(String)

```cangjie
public init(sv: String)
```

Function: Encapsulates the specified String instance into a [JsonString](encoding_json_package_classes.md#class-jsonstring) instance.

### func getValue()

```cangjie
public func getValue(): String
```

Function: Retrieves the actual value of the [JsonString](encoding_json_package_classes.md#class-jsonstring).

Return Value:

- String - The actual value.

### func kind()

```cangjie
public func kind(): JsonKind
```

Function: Returns the [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsString) to which the current [JsonString](encoding_json_package_classes.md#class-jsonstring) belongs.

Return Value:

- [JsonKind](encoding_json_package_enums.md#enum-jsonkind) - The [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type (JsString) of the current [JsonString](encoding_json_package_classes.md#class-jsonstring).

### func toJsonString()

```cangjie
public func toJsonString(): String
```

Function: Converts the [JsonString](encoding_json_package_classes.md#class-jsonstring) into a JSON-formatted string (with spaces and line breaks).

Return Value:

- String - The converted JSON-formatted string.

### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [JsonString](encoding_json_package_classes.md#class-jsonstring) to a string.

Return Value:

- String - The converted string.

## class JsonValue

```cangjie
sealed abstract class JsonValue <: ToString
```

Function: This class serves as the JSON data layer, primarily used for mutual conversion between [JsonValue](encoding_json_package_classes.md#class-jsonvalue) and String data.

The abstract class [JsonValue](encoding_json_package_classes.md#class-jsonvalue) provides interfaces for converting between String and specific JSON types, as well as functionality for determining specific JSON types.

Parent Type:

- ToString

Example:

Usage examples can be found in [JsonValue and String Conversion](../json_samples/json_value_sample.md).

### static func fromStr(String)

```cangjie
public static func fromStr(s: String): JsonValue
```

Function: Parses string data into a [JsonValue](encoding_json_package_classes.md#class-jsonvalue). For integers, prefixes '0b', '0o', and '0x' (case-insensitive) are supported, representing binary, octal, and hexadecimal, respectively. If string parsing fails, the erroneous character and its line and column numbers will be printed, where the column count starts from the first non-space character in the line.

When parsing a String into [JsonValue](encoding_json_package_classes.md#class-jsonvalue), the escape character \\ must be followed only by JSON-supported escape characters (b, f, n, r, t, u, \\, \", \/). The format for \\u is: \\uXXXX, where X is a hexadecimal digit. For example, \\u0041 represents the character 'A'.

Parameters:

- s: String - The input string. Currently, "?" and special characters are not supported.

Return Value:

- [JsonValue](encoding_json_package_classes.md#class-jsonvalue) - The converted [JsonValue](encoding_json_package_classes.md#class-jsonvalue).

Exceptions:

- [JsonException](encoding_json_package_exceptions.md#class-jsonexception) - Thrown if memory allocation fails or string parsing fails.

Example:

```cangjie
import stdx.encoding.json.*

main() {
    println(JsonString("\b | \f | \n | \r | \t | A | \\ | \" | /").toString())
    println(JsonValue.fromStr("\"\\b\"").toString())
    println(JsonValue.fromStr("\"\\f\"").toString())
    println(JsonValue.fromStr("\"\\n\"").toString())
    println(JsonValue.fromStr("\"\\r\"").toString())
    println(JsonValue.fromStr("\"\\t\"").toString())
    println(JsonValue.fromStr("\"\\u0041\"").toString())
    println(JsonValue.fromStr("\"\\\\\"").toString())
    println(JsonValue.fromStr("\"\\\"\"").toString())
    println(JsonValue.fromStr("\"\\/\"").toString())
}
```

Output:

```text
"\b | \f | \n | \r | \t | A | \\ | \" | /"
"\b"
"\f"
"\n"
"\r"
"\t"
"A"
"\\"
"\""
"/"
```

### func asArray()

```cangjie
public func asArray(): JsonArray
```

Function: Converts the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) into [JsonArray](encoding_json_package_classes.md#class-jsonarray) format.

Return Value:

- [JsonArray](encoding_json_package_classes.md#class-jsonarray) - The converted [JsonArray](encoding_json_package_classes.md#class-jsonarray).

Exceptions:

- [JsonException](encoding_json_package_exceptions.md#class-jsonexception) - Thrown if conversion fails.

### func asBool()

```cangjie
public func asBool(): JsonBool
```

Function: Converts the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) into [JsonBool](encoding_json_package_classes.md#class-jsonbool) format.

Return Value:

- [JsonBool](encoding_json_package_classes.md#class-jsonbool) - The converted [JsonBool](encoding_json_package_classes.md#class-jsonbool).

Exceptions:

- [JsonException](encoding_json_package_exceptions.md#class-jsonexception) - Thrown if conversion fails.

### func asFloat()

```cangjie
public func asFloat(): JsonFloat
```

Function: Converts the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) into [JsonFloat](encoding_json_package_classes.md#class-jsonfloat) format.

Return Value:

- [JsonFloat](encoding_json_package_classes.md#class-jsonfloat) - The converted [JsonFloat](encoding_json_package_classes.md#class-jsonfloat).

Exceptions:

- [JsonException](encoding_json_package_exceptions.md#class-jsonexception) - Thrown if conversion fails.

### func asInt()

```cangjie
public func asInt(): JsonInt
```

Function: Converts the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) into [JsonInt](encoding_json_package_classes.md#class-jsonint) format.

Return Value:

- [JsonInt](encoding_json_package_classes.md#class-jsonint) - The converted [JsonInt](encoding_json_package_classes.md#class-jsonint).

Exceptions:

- [JsonException](encoding_json_package_exceptions.md#class-jsonexception) - Thrown if conversion fails.

### func asNull()

```cangjie
public func asNull(): JsonNull
```

Function: Converts the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) into [JsonNull](encoding_json_package_classes.md#class-jsonnull) format.

Return Value:

- [JsonNull](encoding_json_package_classes.md#class-jsonnull) - The converted [JsonNull](encoding_json_package_classes.md#class-jsonnull).

Exceptions:

- [JsonException](encoding_json_package_exceptions.md#class-jsonexception) - Thrown if conversion fails.

### func asObject()

```cangjie
public func asObject(): JsonObject
```

Function: Converts the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) into [JsonObject](encoding_json_package_classes.md#class-jsonobject) format.

Return Value:

- [JsonObject](encoding_json_package_classes.md#class-jsonobject) - The converted [JsonObject](encoding_json_package_classes.md#class-jsonobject).

Exceptions:

- [JsonException](encoding_json_package_exceptions.md#class-jsonexception) - Thrown if conversion fails.

### func asString()

```cangjie
public func asString(): JsonString
```

Function: Converts the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) into [JsonString](encoding_json_package_classes.md#class-jsonstring) format.

Return Value:

- [JsonString](encoding_json_package_classes.md#class-jsonstring) - The converted [JsonString](encoding_json_package_classes.md#class-jsonstring).

Exceptions:

- [JsonException](encoding_json_package_exceptions.md#class-jsonexception) - Thrown if conversion fails.
```### func kind()

```cangjie
public func kind(): JsonKind
```

Function: Returns the [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type of the current [JsonValue](encoding_json_package_classes.md#class-jsonvalue).

Return Value:

- [JsonKind](encoding_json_package_enums.md#enum-jsonkind) - The [JsonKind](encoding_json_package_enums.md#enum-jsonkind) type of the current [JsonValue](encoding_json_package_classes.md#class-jsonvalue).

### func toJsonString()

```cangjie
public func toJsonString(): String
```

Function: Converts the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) into a JSON-formatted string (with spaces and line breaks).

Return Value:

- String - The converted JSON-formatted string.

### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [JsonValue](encoding_json_package_classes.md#class-jsonvalue) into a string.

Return Value:

- String - The converted string.