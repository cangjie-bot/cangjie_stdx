# Exception Classes

## class LogException

```cangjie
public open class LogException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Used to handle log-related exceptions.

Parent Type:

- Exception

### init()

```cangjie
public init()
```

Function: Parameterless constructor.

### init(String)

```cangjie
public init(message: String)
```

Function: Creates a [LogException](log_package_exceptions.md#class-logexception) instance with the specified exception message.

Parameters:

- message: String - The exception message.