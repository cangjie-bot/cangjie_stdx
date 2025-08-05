# Exception Classes

## class SecureRandomException

```cangjie
public class SecureRandomException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Exception class for secure random number generation in the crypto package.

Parent Type:

- Exception

### init()

```cangjie
public init()
```

Function: Creates a default [SecureRandomException](crypto_package_exceptions.md#class-securerandomexception) instance with an empty exception message.

### init(String)

```cangjie
public init(message: String)
```

Function: Creates a [SecureRandomException](crypto_package_exceptions.md#class-securerandomexception) instance with the specified exception message.

Parameters:

- message: String - The exception message.