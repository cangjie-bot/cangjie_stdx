# Functions

## func fromBase64String(String)

```cangjie
public func fromBase64String(data: String): Option<Array<Byte>>
```

Function: This function is used to decode a Base64 encoded string.

Parameters:

- data: String - The Base64 encoded string to be decoded.

Return Value:

- Option\<Array\<Byte>> - Returns Option\<Array\<Byte>>.Some(Array\<Byte>()) for an empty input string, and Option\<Array\<Byte>>.None if decoding fails.

## func toBase64String(Array\<Byte>)

```cangjie
public func toBase64String(data: Array<Byte>): String
```

Function: This function is used to convert a Byte array into a Base64 encoded string.

Parameters:

- data: Array\<Byte> - The Byte array to be encoded.

Return Value:

- String - Returns the encoded string.