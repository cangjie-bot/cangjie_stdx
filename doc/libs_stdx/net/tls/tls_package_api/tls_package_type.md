# 类型别名

## type KeylessDecryptFunc

```cangjie
public type KeylessDecryptFunc = (cipherText: String) -> String
```

功能：供无私钥握手使用的解密回调函数类型。

## type KeylessSignFunc

```cangjie
public type KeylessSignFunc = (hashValue: String) -> String
```

功能：供无私钥握手使用的签名回调函数类型。
