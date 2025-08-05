# Exception Classes

## class DataModelException

```cangjie
public class DataModelException <: Exception {
    public init()
    public init(message: String)
}
```

Function: The exception class for [DataModel](serialization_package_classes.md#class-datamodel).

Parent Type:

- Exception

### init()

```cangjie
public init()
```

Function: Creates a [DataModelException](serialization_package_exceptions.md#class-datamodelexception) instance.

### init(String)

```cangjie
public init(message: String)
```

Function: Creates a [DataModelException](serialization_package_exceptions.md#class-datamodelexception) instance with the specified error message.

Parameters:

- message: String - The error message string.