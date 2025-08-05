# Interface

## interface ToJson

```cangjie
public interface ToJson {
    static func fromJson(jv: JsonValue): DataModel
    func toJson(): JsonValue
}
```

Function: Used for bidirectional conversion between [JsonValue](encoding_json_package_classes.md#class-jsonvalue) and [DataModel](../../../serialization/serialization_package_api/serialization_package_classes.md#class-datamodel).

### static func fromJson(JsonValue)

```cangjie
static func fromJson(jv: JsonValue): DataModel
```

Function: Converts [JsonValue](encoding_json_package_classes.md#class-jsonvalue) into a [DataModel](../../../serialization/serialization_package_api/serialization_package_classes.md#class-datamodel) object.

Parameters:

- jv: [JsonValue](encoding_json_package_classes.md#class-jsonvalue) - The [JsonValue](encoding_json_package_classes.md#class-jsonvalue) to be converted.

Return Value:

- [DataModel](../../../serialization/serialization_package_api/serialization_package_classes.md#class-datamodel) - The converted [DataModel](../../../serialization/serialization_package_api/serialization_package_classes.md#class-datamodel).

### func toJson()

```cangjie
func toJson(): JsonValue
```

Function: Converts itself into a [JsonValue](encoding_json_package_classes.md#class-jsonvalue).

Return Value:

- [JsonValue](encoding_json_package_classes.md#class-jsonvalue) - The converted [JsonValue](encoding_json_package_classes.md#class-jsonvalue).

Exceptions:

- [JsonException](encoding_json_package_exceptions.md#class-jsonexception) - Throws an exception if conversion fails.

### extend DataModel <: ToJson

```cangjie
extend DataModel <: ToJson
```

Function: Implements the ToJson interface for [DataModel](../../../serialization/serialization_package_api/serialization_package_classes.md#class-datamodel) type.

Parent Type:

- [ToJson](#interface-tojson)

#### static func fromJson(JsonValue)

```cangjie
public static func fromJson(jv: JsonValue): DataModel
```

Function: Converts [JsonValue](encoding_json_package_classes.md#class-jsonvalue) into a [DataModel](../../../serialization/serialization_package_api/serialization_package_classes.md#class-datamodel) object.

Parameters:

- jv: [JsonValue](encoding_json_package_classes.md#class-jsonvalue) - The [JsonValue](encoding_json_package_classes.md#class-jsonvalue) to be converted.

Return Value:

- [DataModel](../../../serialization/serialization_package_api/serialization_package_classes.md#class-datamodel) - The converted [DataModel](../../../serialization/serialization_package_api/serialization_package_classes.md#class-datamodel).

#### func toJson()

```cangjie
public func toJson(): JsonValue
```

Function: Converts itself into a [JsonValue](encoding_json_package_classes.md#class-jsonvalue).

Return Value:

- [JsonValue](encoding_json_package_classes.md#class-jsonvalue) - The converted [JsonValue](encoding_json_package_classes.md#class-jsonvalue).

Exceptions:

- [JsonException](encoding_json_package_exceptions.md#class-jsonexception) - Throws an exception if conversion fails.