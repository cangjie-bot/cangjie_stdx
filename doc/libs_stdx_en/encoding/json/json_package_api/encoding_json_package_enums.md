# Enumeration

## enum JsonKind

```cangjie
public enum JsonKind {
    | JsNull
    | JsBool
    | JsInt
    | JsFloat
    | JsString
    | JsArray
    | JsObject
}
```

Function: Represents the concrete type of [JsonValue](encoding_json_package_classes.md#class-jsonvalue).

### JsArray

```cangjie
JsArray
```

Function: Represents the array type in `JSON`.

### JsBool

```cangjie
JsBool
```

Function: Represents the `true` or `false` type.

### JsFloat

```cangjie
JsFloat
```

Function: Represents the `number` type with floating-point values.

### JsInt

```cangjie
JsInt
```

Function: Represents the `number` type with integer values.

### JsNull

```cangjie
JsNull
```

Function: Represents the `null` type.

### JsObject

```cangjie
JsObject
```

Function: Represents the object type in `JSON`.

### JsString

```cangjie
JsString
```

Function: Represents the `string` type.