# 自定义证书校验

示例：

<!-- compile -->
```cangjie
import std.net.TcpSocket
import stdx.crypto.x509.X509Certificate
import stdx.net.tls.*
import stdx.net.tls.common.*

main() {
    var config = TlsClientConfig()
    config.supportedAlpnProtocols = ["h2"]

    // 自定义校验逻辑
    config.verifyMode = CustomVerify({
        certificates =>
            if (certificates.size == 0) {
                return false
            }
            for (certificate in certificates) {
                match (certificate as X509Certificate) {
                    case Some(c) =>
                        if (c.issuer.organizationName != "example") {
                            return false
                        }
                    case None => return false
                }
            }
            return true
    })

    try (socket = TcpSocket("127.0.0.1", 8443)) {
        socket.connect()
        let client = TlsSocket.client(socket, clientConfig: config, session: None)
        client.handshake()
    }
}
```
