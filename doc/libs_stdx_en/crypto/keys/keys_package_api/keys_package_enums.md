# Enumerations

## enum Curve

```cangjie
public enum Curve {
    | P224 | P256 | P384 | P521 | BP256 | BP320 | BP384 | BP512
}
```

Function: The enumeration type [Curve](keys_package_enums.md#enum-curve) is used to select the elliptic curve type for ECDSA key generation.

An elliptic curve is a mathematical curve commonly used in cryptographic algorithms for key generation. In cryptography, elliptic curve cryptography (ECC) is a public-key cryptosystem based on the algebraic structure of elliptic curves over finite fields. Its fundamental principle relies on the computational hardness of the elliptic curve discrete logarithm problem to ensure public-key security.

The [Curve](keys_package_enums.md#enum-curve) enumeration supports eight elliptic curves: NIST P-224, NIST P-256, NIST P-384, NIST P-521, Brainpool P-256, Brainpool P-320, Brainpool P-384, and Brainpool P-512.

- NIST P-224: An elliptic curve-based encryption algorithm using a 224-bit prime modulus, offering high security suitable for lightweight applications.

- NIST P-256: An elliptic curve-based encryption algorithm using a 256-bit prime modulus, providing high security for medium-level applications.

- NIST P-384: An elliptic curve-based encryption algorithm using a 384-bit prime modulus, delivering very high security for advanced applications.

- NIST P-521: An elliptic curve-based encryption algorithm using a 521-bit prime modulus, ensuring extremely high security for top-tier applications.

- Brainpool P-256: An elliptic curve-based encryption algorithm using a 256-bit prime modulus, offering high security with faster performance than NIST P-256.

- Brainpool P-320: An elliptic curve-based encryption algorithm using a 320-bit prime modulus, providing very high security with faster performance than NIST P-384.

- Brainpool P-384: An elliptic curve-based encryption algorithm using a 384-bit prime modulus, delivering very high security with faster performance than NIST P-384.

- Brainpool P-512: An elliptic curve-based encryption algorithm using a 512-bit prime modulus, ensuring very high security with faster performance than NIST P-521.

### BP256

```cangjie
BP256
```

Function: Initializes a [Curve](keys_package_enums.md#enum-curve) instance using the Brainpool P-256 elliptic curve.

### BP320

```cangjie
BP320
```

Function: Initializes a [Curve](keys_package_enums.md#enum-curve) instance using the Brainpool P-320 elliptic curve.

### BP384

```cangjie
BP384
```

Function: Initializes a [Curve](keys_package_enums.md#enum-curve) instance using the Brainpool P-384 elliptic curve.

### BP512

```cangjie
BP512
```

Function: Initializes a [Curve](keys_package_enums.md#enum-curve) instance using the Brainpool P-512 elliptic curve.

### P224

```cangjie
P224
```

Function: Initializes a [Curve](keys_package_enums.md#enum-curve) instance using the NIST P-224 elliptic curve.

### P256

```cangjie
P256
```

Function: Initializes a [Curve](keys_package_enums.md#enum-curve) instance using the NIST P-256 elliptic curve.

### P384

```cangjie
P384
```

Function: Initializes a [Curve](keys_package_enums.md#enum-curve) instance using the NIST P-384 elliptic curve.

### P521

```cangjie
P521
```

Function: Initializes a [Curve](keys_package_enums.md#enum-curve) instance using the NIST P-521 elliptic curve.

## enum PadOption

```cangjie
public enum PadOption {
    | OAEP(OAEPOption) | PSS(PSSOption) | PKCS1
}
```

Function: Used to configure RSA padding modes.

RSA has three commonly used padding modes:

- OAEP (Optimal Asymmetric Encryption Padding) can only be used for encryption/decryption;
- PSS (Probabilistic Signature Scheme) is exclusively for signing and verification;
- PKCS1 is a conventional padding mode for data length padding, applicable to encryption, decryption, signing, and verification.

The PKCS1 padding mode for RSA was defined in the early PKCS #1 v1.5 specification. Current attacks against PKCS1 padding are well-developed, making it vulnerable to decryption or signature forgery. It is recommended to use the more secure PSS or OAEP padding modes from PKCS #1 v2.

### OAEP(OAEPOption)

```cangjie
OAEP(OAEPOption)
```

Function: Initializes a [PadOption](keys_package_enums.md#enum-padoption) instance using Optimal Asymmetric Encryption Padding.

### PKCS1

```cangjie
PKCS1
```

Function: Initializes a [PadOption](keys_package_enums.md#enum-padoption) instance using the PKCS #1 Public-Key Cryptography Standard.

### PSS(PSSOption)

```cangjie
PSS(PSSOption)
```

Function: Initializes a [PadOption](keys_package_enums.md#enum-padoption) instance using the Probabilistic Signature Scheme.