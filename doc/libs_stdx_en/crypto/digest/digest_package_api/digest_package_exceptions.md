# Exception Classes

## class CryptoException

```cangjie
public class CryptoException <: Exception {
    public init()
    public init(message: String)
}
```

Function: This class represents exceptions thrown when errors occur during digest or encryption/decryption operations.

Parent Type:

- Exception

### init()

```cangjie
public init()
```

Function: Parameterless constructor that creates a [CryptoException](digest_package_exceptions.md#class-cryptoexception) instance.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs a [CryptoException](digest_package_exceptions.md#class-cryptoexception) object with the specified error message.

Parameters:

- message: String - The exception message.