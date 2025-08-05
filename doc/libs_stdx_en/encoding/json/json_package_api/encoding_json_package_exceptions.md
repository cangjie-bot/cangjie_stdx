# Exceptions

## class JsonException

```cangjie
public class JsonException <: Exception {
    public init()
    public init(message: String)
}
```

Function: The exception class for the JSON package, used in scenarios where exceptions occur during the usage of [JsonValue](encoding_json_package_classes.md#class-jsonvalue) type.

Parent Type:

- Exception

### init()

```cangjie
public init()
```

Function: Constructs a [JsonException](encoding_json_package_exceptions.md#class-jsonexception) instance without any exception message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs a [JsonException](encoding_json_package_exceptions.md#class-jsonexception) instance with the specified exception message.

Parameters:

- message: String - The specified exception message.