# Functions

## func fromHexString(String)

```cangjie
public func fromHexString(data: String): Option<Array<Byte>>
```

Function: This function is used for decoding hex-encoded strings.

Parameters:

- data: String - The hex-encoded string to be decoded.

Return Value:

- Option\<Array\<Byte>> - Returns Option\<Array\<Byte>>.Some(Array\<Byte>()) for empty input strings, and Option\<Array\<Byte>>.None if decoding fails.

## func toHexString(Array\<Byte>)

```cangjie
public func toHexString(data: Array<Byte>): String
```

Function: This function is used to convert a Byte array into a hex-encoded string.

Parameters:

- data: Array\<Byte> - The Byte array to be encoded.

Return Value:

- String - Returns the encoded string.