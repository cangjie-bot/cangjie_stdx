# Exception Classes

## class ExhaustedException

```cangjie
public class ExhaustedException <: Exception {
    public init()
    public init(message: String)
}
```

Function: This exception is thrown when there is insufficient remaining data during data conversion.

Parent Type:

- Exception

### init()

```cangjie
public init()
```

Function: Creates an [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) instance.

### init(String)

```cangjie
public init(message: String)
```

Function: Creates an [ExhaustedException](fuzz_package_exceptions.md#class-exhaustedexception) instance.

Parameters:

- message: String - Exception message.