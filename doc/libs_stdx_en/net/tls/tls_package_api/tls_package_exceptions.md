# Exception Classes

## class TlsException

```cangjie
public class TlsException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Exception thrown when TLS processing encounters an error.

Parent Type:

- Exception

### init()

```cangjie
public init()
```

Function: Creates a [TlsException](tls_package_exceptions.md#class-tlsexception) instance with an empty exception message.

### init(String)

```cangjie
public init(message: String)
```

Function: Creates a TlsException instance based on the exception message.

Parameters:

- message: String - The exception message.