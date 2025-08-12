# Classes

## class ECDSAPrivateKey

```cangjie
public class ECDSAPrivateKey <: PrivateKey {
    public init(curve: Curve)
}
```

Functionality: ECDSA private key class that provides the capability to generate ECDSA private keys. ECDSA private keys support signing operations and can be encoded/decoded in both PEM and DER formats. For usage examples, see [ECDSA Key Examples](../keys_samples/sample_keys.md#ecdsa-key-example).

Parent Types:

- [PrivateKey](../../x509/x509_package_api/x509_package_interfaces.md#interface-privatekey)

### init(Curve)

```cangjie
public init(curve: Curve)
```

Functionality: Initializes and generates a private key.

Parameters:

- curve: [Curve](keys_package_enums.md#enum-curve) - The type of elliptic curve.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if initialization fails.

### static func decodeDer(DerBlob)

```cangjie
public static func decodeDer(blob: DerBlob): ECDSAPrivateKey
```

Functionality: Decodes a private key from DER format.

Parameters:

- blob: [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - The binary-format private key object.

Return Value:

- [ECDSAPrivateKey](keys_package_classes.md#class-ecdsaprivatekey) - The decoded ECDSA private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if decoding fails.

### static func decodeDer(DerBlob, ?String)

```cangjie
public static func decodeDer(blob: DerBlob, password!: ?String): ECDSAPrivateKey
```

Functionality: Decodes an encrypted private key from DER format.

Parameters:

- blob: [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - The binary-format private key object.
- password!: ?String - The password required to decrypt the private key. If the password is None, decryption is not performed.

Return Value:

- [ECDSAPrivateKey](keys_package_classes.md#class-ecdsaprivatekey) - The decoded ECDSA private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if decoding fails, decryption fails, or if the password parameter is an empty string.

### static func decodeFromPem(String)

```cangjie
public static func decodeFromPem(text: String): ECDSAPrivateKey
```

Functionality: Decodes a private key from PEM format.

Parameters:

- text: String - The PEM-format private key character stream.

Return Value:

- [ECDSAPrivateKey](keys_package_classes.md#class-ecdsaprivatekey) - The decoded ECDSA private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if decoding fails, the character stream does not conform to PEM format, or the file header does not meet the private key header standard.

### static func decodeFromPem(String, ?String)

```cangjie
public static func decodeFromPem(text: String, password!: ?String): ECDSAPrivateKey
```

Functionality: Decodes a private key from PEM format.

Parameters:

- text: String - The PEM-format private key character stream.
- password!: ?String - The password required to decrypt the private key. If the password is None, decryption is not performed.

Return Value:

- [ECDSAPrivateKey](keys_package_classes.md#class-ecdsaprivatekey) - The decoded ECDSA private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if decoding fails, decryption fails, the password parameter is an empty string, the character stream does not conform to PEM format, or the file header does not meet the private key header standard.

### func encodeToDer()

```cangjie
public override func encodeToDer(): DerBlob
```

Functionality: Encodes the private key into DER format.

Return Value:

- [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - The encoded DER-format private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if encoding fails.

### func encodeToDer(?String)

```cangjie
public func encodeToDer(password!: ?String): DerBlob
```

Functionality: Encrypts the private key using AES-256-CBC and encodes it into DER format.

Parameters:

- password!: ?String - The password required to encrypt the private key. If the password is None, encryption is not performed.

Return Value:

- [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - The encoded DER-format private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if encoding fails, encryption fails, or if the password parameter is an empty string.

### func encodeToPem()

```cangjie
public override func encodeToPem(): PemEntry
```

Functionality: Encodes the private key into PEM format.

Return Value:

- [PemEntry](../../x509/x509_package_api/x509_package_structs.md#struct-pementry) - The PEM-format private key object.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if encoding fails.

### func sign(Array\<Byte>)

```cangjie
public func sign(digest: Array<Byte>): Array<Byte>
```

Functionality: Signs the digest result of the data.

Parameters:

- digest: Array\<Byte> - The digest result of the data.

Return Value:

- Array\<Byte> - The signed data.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if signing fails.

### func toString

```cangjie
public override func toString(): String
```

Functionality: Outputs the type of private key.

Return Value:

- String - The description of the key type.

## class ECDSAPublicKey

```cangjie
public class ECDSAPublicKey <: PublicKey {
    public init(pri: ECDSAPrivateKey)
}
```

Functionality: ECDSA public key class that provides the capability to generate ECDSA public keys. ECDSA public keys support signature verification and can be encoded/decoded in both PEM and DER formats. For usage examples, see [ECDSA Key Examples](../keys_samples/sample_keys.md#ecdsa-key-example).

Parent Types:

- [PublicKey](../../x509/x509_package_api/x509_package_interfaces.md#interface-publickey)

### init(ECDSAPrivateKey)

```cangjie
public init(pri: ECDSAPrivateKey)
```

Functionality: Initializes the public key by extracting it from the corresponding private key.

Parameters:

- pri: [ECDSAPrivateKey](keys_package_classes.md#class-ecdsaprivatekey) - The ECDSA private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if initialization fails.

### static func decodeDer(DerBlob)

```cangjie
public static func decodeDer(blob: DerBlob): ECDSAPublicKey
```

Functionality: Decodes a public key from DER format.

Parameters:

- blob: [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - The binary-format public key object.

Return Value:

- [ECDSAPublicKey](keys_package_classes.md#class-ecdsapublickey) - The decoded ECDSA public key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if encoding fails.

### static func decodeFromPem(String)

```cangjie
public static func decodeFromPem(text: String): ECDSAPublicKey
```

Functionality: Decodes a public key from PEM format.

Parameters:

- text: String - The PEM-format public key character stream.

Return Value:

- [ECDSAPublicKey](keys_package_classes.md#class-ecdsapublickey) - The decoded ECDSA public key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if decoding fails, the character stream does not conform to PEM format, or the file header does not meet the public key header standard.

### func encodeToDer()

```cangjie
public override func encodeToDer(): DerBlob
```

Functionality: Encodes the public key into DER format.

Return Value:

- [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - The encoded DER-format public key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if encoding fails.

### func encodeToPem()

```cangjie
public override func encodeToPem(): PemEntry
```

Functionality: Encodes the public key into PEM format.

Return Value:

- [PemEntry](../../x509/x509_package_api/x509_package_structs.md#struct-pementry) - The [PemEntry](../../x509/x509_package_api/x509_package_structs.md#struct-pementry) object.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception if encoding fails.

### func toString

```cangjie
public override func toString(): String
```

Function: Outputs the type of public key.

Return Value:

- String - Description of the key type.

### func verify(Array\<Byte>, Array\<Byte>)

```cangjie
public func verify(digest: Array<Byte>, sig: Array<Byte>): Bool
```

Function: Verifies the signature result.

Parameters:

- digest: Array\<Byte> - Digest result of the data.
- sig: Array\<Byte> - Signature result of the data.

Return Value:

- Bool - Returns true if verification succeeds, false if it fails.

## class RSAPrivateKey

```cangjie
public class RSAPrivateKey <: PrivateKey{
    public init(bits: Int32)
    public init(bits: Int32, e: BigInt)
}
```

Function: RSA private key class, providing the capability to generate RSA private keys. RSA private keys support signing and decryption operations, and can be encoded/decoded in PEM and DER formats, complying with the PKCS1 standard. For usage examples, see [RSA Key Example](../keys_samples/sample_keys.md#rsa-key-example).

Parent Type:

- [PrivateKey](../../x509/x509_package_api/x509_package_interfaces.md#interface-privatekey)

### init(Int32)

```cangjie
public init(bits: Int32)
```

Function: Initializes and generates a private key with a default public exponent value of 65537, which is industry-recommended. The size of the public exponent (e) directly affects the security and encryption efficiency of the RSA algorithm. Generally, a smaller e value results in faster encryption but lower security.

Parameters:

- bits: Int32 - Key length, which must be greater than or equal to 512 bits and less than or equal to 16384 bits.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown if the key length does not meet requirements or initialization fails.

### init(Int32, BigInt)

```cangjie
public init(bits: Int32, e: BigInt)
```

Function: Initializes and generates a private key, allowing the user to specify the public exponent.

Parameters:

- bits: Int32 - Key length, which must be greater than or equal to 512 bits and less than or equal to 16384 bits. A key length of at least 3072 bits is recommended.
- e: BigInt - Public exponent, which must be an odd number in the range [3, 2^256-1].

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown if the key length or public exponent does not meet requirements, or if initialization fails.

### static func decodeDer(DerBlob)

```cangjie
public static func decodeDer(blob: DerBlob): RSAPrivateKey
```

Function: Decodes a private key from DER format.

Parameters:

- blob: [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - Binary-format private key object.

Return Value:

- [RSAPrivateKey](keys_package_classes.md#class-rsaprivatekey) - Decoded RSA private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown if decoding fails.

### static func decodeDer(DerBlob, ?String)

```cangjie
public static func decodeDer(blob: DerBlob, password!: ?String): RSAPrivateKey
```

Function: Decodes an encrypted private key from DER format.

Parameters:

- blob: [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - Binary-format private key object.
- password!: ?String - Password required to decrypt the private key. If None, no decryption is performed.

Return Value:

- [RSAPrivateKey](keys_package_classes.md#class-rsaprivatekey) - Decoded RSA private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown if decoding fails, decryption fails, or the password parameter is an empty string.

### static func decodeFromPem(String)

```cangjie
public static func decodeFromPem(text: String): RSAPrivateKey
```

Function: Decodes a private key from PEM format.

Parameters:

- text: String - PEM-format private key character stream.

Return Value:

- [RSAPrivateKey](keys_package_classes.md#class-rsaprivatekey) - Decoded RSA private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown if decoding fails, decryption fails, the character stream does not conform to PEM format, or the file header does not meet private key header standards.

### static func decodeFromPem(String, ?String)

```cangjie
public static func decodeFromPem(text: String, password!: ?String): RSAPrivateKey
```

Function: Decodes a private key from PEM format.

Parameters:

- text: String - PEM-format private key character stream.
- password!: ?String - Password required to decrypt the private key. If None, no decryption is performed.

Return Value:

- [RSAPrivateKey](keys_package_classes.md#class-rsaprivatekey) - Decoded RSA private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown if decoding fails, decryption fails, the password parameter is an empty string, the character stream does not conform to PEM format, or the file header does not meet private key header standards.

### func decrypt(InputStream, OutputStream, PadOption)

```cangjie
public func decrypt(input: InputStream, output: OutputStream, padType!: PadOption): Unit
```

Function: Decrypts the original data.

Parameters:

- input: InputStream - Encrypted data.
- output: OutputStream - Decrypted data.
- padType!: [PadOption](keys_package_enums.md#enum-padoption) - Padding mode, which can be PKCS1 or OAEP. PSS mode is not supported. For higher security requirements, OAEP padding mode is recommended.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown if setting the padding mode fails or decryption fails.

### func encodeToDer()

```cangjie
public override func encodeToDer(): DerBlob
```

Function: Encodes the private key into DER format.

Return Value:

- [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - Encoded DER-format private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown if encoding fails.

### func encodeToDer(?String)

```cangjie
public func encodeToDer(password!: ?String): DerBlob
```

Function: Encrypts the private key using AES-256-CBC and encodes it into DER format.

Parameters:

- password!: ?String - Password required to encrypt the private key. If None, no encryption is performed.

Return Value:

- [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - Encoded DER-format private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown if encoding fails, encryption fails, or the password parameter is an empty string.

### func encodeToPem()

```cangjie
public override func encodeToPem(): PemEntry
```

Function: Encodes the private key into PEM format.

Return Value:

- [PemEntry](../../x509/x509_package_api/x509_package_structs.md#struct-pementry) - PEM-format private key object.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown if encoding fails.

### func sign(Digest, Array\<Byte>, PadOption)

```cangjie
public func sign(hash: Digest, digest: Array<Byte>, padType!: PadOption): Array<Byte>
```

Function: Signs the digest result of the data.

Parameters:

- hash: Digest - Digest method used to obtain the digest result.
- digest: Array\<Byte> - Digest result of the data.
- padType!: [PadOption](keys_package_enums.md#enum-padoption) - Padding mode, which can be PKCS1 or PSS. OAEP mode is not supported. For higher security requirements, PSS padding mode is recommended.

Return Value:

- Array\<Byte> - Signed data.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown if setting the digest method fails, setting the padding mode fails, or signing fails.

### func toString()

```cangjie
public override func toString(): String
```

Function: Outputs the type of private key.

Return Value:

- String - Description of the key type.

## class RSAPublicKey

```cangjie
public class RSAPublicKey <: PublicKey {
    public init(pri: RSAPrivateKey)
}
```

Function: RSA public key class, providing the capability to generate RSA public keys. RSA public keys support signature verification and encryption operations, and can be encoded/decoded in PEM and DER formats. For usage examples, see [RSA Key Example](../keys_samples/sample_keys.md#rsa-key-example).

Parent Type:

- [PublicKey](../../x509/x509_package_api/x509_package_interfaces.md#interface-publickey)

### init(RSAPrivateKey)

```cangjie
public init(pri: RSAPrivateKey)
```

Function: Initializes the public key by extracting it from the corresponding private key.

Parameters:

- pri: [RSAPrivateKey](keys_package_classes.md#class-rsaprivatekey) - RSA private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Thrown if initialization fails.

### static func decodeDer(DerBlob)

```cangjie
public static func decodeDer(blob: DerBlob): RSAPublicKey
```

Function: Decodes a public key from DER format.Parameters:

- blob: [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - Public key object in binary format.

Return Value:

- [RSAPublicKey](keys_package_classes.md#class-rsapublickey) - Decoded RSA public key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when decoding fails.

### static func decodeFromPem(String)

```cangjie
public static func decodeFromPem(text: String): RSAPublicKey
```

Function: Decodes public key from PEM format.

Parameters:

- text: String - Public key character stream in PEM format.

Return Value:

- [RSAPublicKey](keys_package_classes.md#class-rsapublickey) - Decoded RSA public key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when decoding fails, the character stream does not conform to PEM format, or the file header does not meet public key header standards.

### func encodeToDer()

```cangjie
public override func encodeToDer(): DerBlob
```

Function: Encodes public key to DER format.

Return Value:

- [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - Encoded public key in DER format.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when encoding fails.

### func encodeToPem()

```cangjie
public override func encodeToPem(): PemEntry
```

Function: Encodes public key to PEM format.

Return Value:

- [PemEntry](../../x509/x509_package_api/x509_package_structs.md#struct-pementry) - Returns a [PemEntry](../../x509/x509_package_api/x509_package_structs.md#struct-pementry) object.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when encoding fails.

### func encrypt(InputStream, OutputStream, PadOption)

```cangjie
public func encrypt(input: InputStream, output: OutputStream, padType!: PadOption): Unit
```

Function: Encrypts a data segment.

Parameters:

- input: InputStream - Data to be encrypted.
- output: OutputStream - Encrypted data.
- padType!: [PadOption](keys_package_enums.md#enum-padoption) - Padding mode, which can be PKCS1 or OAEP mode (PSS mode is not supported). For higher security scenarios, OAEP padding mode is recommended.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when setting padding mode fails or encryption fails.

### func toString()

```cangjie
public override func toString(): String
```

Function: Outputs public key type.

Return Value:

- String - Description of key category.

### func verify(Digest, Array\<Byte>, Array\<Byte>, PadOption)

```cangjie
public func verify(hash: Digest, digest: Array<Byte>, sig: Array<Byte>, padType!: PadOption): Bool
```

Function: Verifies signature result.

Parameters:

- hash: Digest - Digest method, the digest method used to obtain the digest result.
- digest: Array\<Byte> - Digest result of the data.
- sig: Array\<Byte> - Signature result of the data.
- padType!: [PadOption](keys_package_enums.md#enum-padoption) - Padding mode, which can be PKCS1 or PSS mode (OAEP mode is not supported). For higher security scenarios, PSS padding mode is recommended.

Return Value:

- Bool - Returns true if verification succeeds, false otherwise.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when setting padding mode fails or verification fails.

## class SM2PrivateKey

```cangjie
public class SM2PrivateKey <: PrivateKey {
    public init()
}
```

Function: SM2 private key class, providing the capability to generate SM2 private keys. SM2 private keys support signing and decryption operations, and support encoding/decoding in PEM and DER formats, complying with PKCS1 standards. For usage examples, see [SM2 Key Examples](../keys_samples/sample_keys.md#sm2-key-examples).

Parent Type:

- [PrivateKey](../../x509/x509_package_api/x509_package_interfaces.md#interface-privatekey)

### init()

```cangjie
public init()
```

Function: Initializes and generates a private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when initialization fails.

### static func decodeDer(DerBlob)

```cangjie
public static func decodeDer(blob: DerBlob): SM2PrivateKey
```

Function: Decodes private key from DER format.

Parameters:

- blob: [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - Private key object in binary format.

Return Value:

- [SM2PrivateKey](keys_package_classes.md#class-sm2privatekey) - Decoded SM2 private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when decoding fails.

### static func decodeDer(DerBlob, ?String)

```cangjie
public static func decodeDer(blob: DerBlob, password!: ?String): SM2PrivateKey
```

Function: Decodes encrypted private key from DER format.

Parameters:

- blob: [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - Private key object in binary format.
- password!: ?String - Password required to decrypt the private key. If the password is None, no decryption is performed.

Return Value:

- [SM2PrivateKey](keys_package_classes.md#class-sm2privatekey) - Decoded SM2 private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when decoding fails, decryption fails, or the password parameter is an empty string.

### static func decodeFromPem(String)

```cangjie
public static func decodeFromPem(text: String): SM2PrivateKey
```

Function: Decodes private key from PEM format.

Parameters:

- text: String - Private key character stream in PEM format.

Return Value:

- [SM2PrivateKey](keys_package_classes.md#class-sm2privatekey) - Decoded SM2 private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when decoding fails, decryption fails, the character stream does not conform to PEM format, or the file header does not meet private key header standards.

### static func decodeFromPem(String, ?String)

```cangjie
public static func decodeFromPem(text: String, password!: ?String): SM2PrivateKey
```

Function: Decodes private key from PEM format.

Parameters:

- text: String - Private key character stream in PEM format.
- password!: ?String - Password required to decrypt the private key. If the password is None, no decryption is performed.

Return Value:

- [SM2PrivateKey](keys_package_classes.md#class-sm2privatekey) - Decoded SM2 private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when decoding fails, decryption fails, the password parameter is an empty string, the character stream does not conform to PEM format, or the file header does not meet private key header standards.

### func decrypt(Array\<Byte>)

```cangjie
public func decrypt(input: Array<Byte>): Array<Byte>
```

Function: Decrypts the original data. The ciphertext to be decrypted must follow ASN.1 encoding rules.

Parameters:

- input: Array\<Byte> - Encrypted data.

Return Value:

- Array\<Byte> - Decrypted data.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when decryption fails.

### func encodeToDer()

```cangjie
public func encodeToDer(): DerBlob
```

Function: Encodes private key to DER format.

Return Value:

- [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - Encoded private key in DER format.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when encoding fails.

### func encodeToDer(?String)

```cangjie
public func encodeToDer(password!: ?String): DerBlob
```

Function: Encrypts the private key using AES-256-CBC and encodes it to DER format.

Parameters:

- password!: ?String - Password required to encrypt the private key. If the password is None, no encryption is performed.

Return Value:

- [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - Encoded public key in DER format.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws exception when encoding fails, encryption fails, or the password parameter is an empty string.

### func encodeToPem(?String)

```cangjie
public func encodeToPem(password!: ?String): PemEntry 
```

Function: Encodes the encrypted private key to PEM format.

Parameters:

- password!: ?String - Password required to encrypt the private key. If the password is None, no encryption is performed.

Return Value:

- [PemEntry](../../x509/x509_package_api/x509_package_structs.md#struct-pementry) - Private key object in PEM format.

Exceptions:- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception when encoding fails, encryption fails, or the parameter password is an empty string.

### func encodeToPem()

```cangjie
public func encodeToPem(): PemEntry
```

Function: Encodes the private key into PEM format.

Return value:

- [PemEntry](../../x509/x509_package_api/x509_package_structs.md#struct-pementry) - The private key object in PEM format.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception when encoding fails.

### func sign(Array\<Byte>)

```cangjie
public func sign(data: Array<Byte>): Array<Byte>
```

Function: Signs the data using the [SM3](../../digest/digest_package_api/digest_package_classes.md#class-sm3) digest algorithm for SM2.

Parameters:

- data: Array\<Byte> - The data to be signed.

Return value:

- Array\<Byte> - The signed data.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception when signing fails.

### func toString

```cangjie
public override func toString(): String
```

Function: Outputs the type of private key.

Return value:

- String - Description of the key type.

## class SM2PublicKey

```cangjie
public class SM2PublicKey <: PublicKey {
    public init(pri: SM2PrivateKey)
}
```

Function: SM2 public key class, providing the capability to generate SM2 public keys. SM2 public keys support signature verification and encryption operations, with encoding/decoding in PEM and DER formats. For usage examples, see [SM2 Key Example](../keys_samples/sample_keys.md#sm2-key-example).

Parent type:

- [PublicKey](../../x509/x509_package_api/x509_package_interfaces.md#interface-publickey)

### init(SM2PrivateKey)

```cangjie
public init(pri: SM2PrivateKey)
```

Function: Initializes the public key by deriving it from the corresponding private key.

Parameters:

- pri: [SM2PrivateKey](keys_package_classes.md#class-sm2privatekey) - The SM2 private key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception when initialization fails.

### static func decodeDer(DerBlob)

```cangjie
public static func decodeDer(blob: DerBlob): SM2PublicKey
```

Function: Decodes the public key from DER format.

Parameters:

- blob: [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - The public key object in binary format.

Return value:

- [SM2PublicKey](keys_package_classes.md#class-sm2publickey) - The decoded SM2 public key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception when decoding fails.

### static func decodeFromPem(String)

```cangjie
public static func decodeFromPem(text: String): SM2PublicKey
```

Function: Decodes the public key from PEM format.

Parameters:

- text: String - The public key character stream in PEM format.

Return value:

- [SM2PublicKey](keys_package_classes.md#class-sm2publickey) - The decoded SM2 public key.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception when decoding fails, the character stream does not conform to PEM format, or the file header does not meet public key header standards.

### func encodeToDer()

```cangjie
public func encodeToDer(): DerBlob
```

Function: Encodes the public key into DER format.

Return value:

- [DerBlob](../../x509/x509_package_api/x509_package_structs.md#struct-derblob) - The encoded public key in DER format.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception when encoding fails.

### func encodeToPem()

```cangjie
public func encodeToPem(): PemEntry
```

Function: Encodes the public key into PEM format.

Return value:

- [PemEntry](../../x509/x509_package_api/x509_package_structs.md#struct-pementry) - Returns a [PemEntry](../../x509/x509_package_api/x509_package_structs.md#struct-pementry) object.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception when encoding fails.

### func encrypt(Array\<Byte>)

```cangjie
public func encrypt(input: Array<Byte>): Array<Byte> 
```

Function: Encrypts a segment of data, with the output ciphertext following ASN.1 encoding rules.

Parameters:

- input: Array\<Byte> - The data to be encrypted.

Return value:

- Array\<Byte> - The encrypted data.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception when encryption fails.

### func toString()

```cangjie
public override func toString(): String
```

Function: Outputs the type of public key.

Return value:

- String - Description of the key type.

### func verify(Array\<Byte>, Array\<Byte>)

```cangjie
public func verify(data: Array<Byte>, sig: Array<Byte>): Bool
```

Function: Verifies the signature result.

Parameters:

- data: Array\<Byte> - The data.
- sig: Array\<Byte> - The signature result of the data.

Return value:

- Bool - Returns true if verification succeeds, false otherwise.

Exceptions:

- [CryptoException](../../digest/digest_package_api/digest_package_exceptions.md#class-cryptoexception) - Throws an exception when setting the padding mode fails or verification fails.