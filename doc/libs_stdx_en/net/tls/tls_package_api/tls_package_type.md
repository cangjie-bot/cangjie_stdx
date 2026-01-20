# Type Aliases

## type KeylessDecryptFunc

```cangjie
public type KeylessDecryptFunc = (cipherText: Array<Byte>) -> Array<Byte> 
```

Function: Decryption callback function type for keyless handshake.

## type KeylessSignFunc

```cangjie
public type KeylessSignFunc = (hashValue: Array<Byte>) -> Array<Byte>
```

Function: Signature callback function type for keyless handshake.
