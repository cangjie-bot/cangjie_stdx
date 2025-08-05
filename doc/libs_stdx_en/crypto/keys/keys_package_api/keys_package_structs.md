# Structs

## struct OAEPOption

```cangjie
public struct OAEPOption {
    public init(hash: Digest, mgfHash: Digest, label!: String = "")
}
```

Function: This struct represents the parameters required for [OAEP](./keys_package_enums.md#enum-padoption) padding mode.

### init(Digest, Digest, String)

```cangjie
public init(hash: Digest, mgfHash: Digest, label!: String = "")
```

Function: Initializes OAEP padding parameters.

Parameters:

- hash: Digest - The digest method used for hashing the label.
- mgfHash: Digest - The digest method used in the MGF1 function.
- label!: String - An optional parameter (defaults to empty string) that can distinguish different encryption operations.

## struct PSSOption

```cangjie
public struct PSSOption {
    public init(saltLen: Int32)
}
```

Function: This struct represents the parameters required for [PSS](./keys_package_enums.md#enum-padoption) padding mode.

### init(Int32)

```cangjie(Int32)
public init(saltLen: Int32)
```

Function: Initializes PSS padding parameters.

Parameters:

- saltLen: Int32 - The salt length in bytes. Should be ≥0 and ≤(RSA_length - digest_length - 2). Excessive length will cause signature failure.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown when salt length is less than 0.