# Certificate Hot Reloading

Example:

<!-- run -->
```cangjie
import std.net.StreamingSocket
import stdx.crypto.x509.{X509Certificate, PrivateKey}
import stdx.net.tls.*

class MyServer {
    private var currentConfig: TlsServerConfig

    init(initialConfig: TlsServerConfig) {
        currentConfig = initialConfig
    }

    // Changing certificates with keys only affects new connections
    public mut prop certificate: (Array<X509Certificate>, PrivateKey) {
        get() {
            currentConfig.serverCertificate
        }
        set(newCertificate) {
            currentConfig.serverCertificate = newCertificate
        }
    }

    public func onAcceptedConnection(client: StreamingSocket) {
        try (tls = TlsSocket.server(client, serverConfig: currentConfig)) {
            tls.handshake()
        }
    }
}

main() {}
```