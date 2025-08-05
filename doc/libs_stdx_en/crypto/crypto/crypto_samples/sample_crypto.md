# SM4 Usage

SM4 encrypts and decrypts data.

Example:

<!-- verify -->
```cangjie
import stdx.crypto.crypto.*
import stdx.encoding.hex.fromHexString

main() {
    var plains = "hello cangjie!"
    var key = "1234567890123456"
    var iv = "1234567890123456"
    var sm4 = SM4(OperationMode.CBC, key.toArray(), iv: iv.toArray())
    var enRe = sm4.encrypt(plains.toArray())
    var dd = sm4.decrypt(enRe)
    println(String.fromUtf8(dd))
}
```

Execution Result:

```text
hello cangjie!
```