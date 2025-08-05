# Client Example

Example:

<!-- compile -->
```cangjie
import std.net.TcpSocket
import stdx.crypto.x509.{X509Certificate, PrivateKey}
import stdx.net.tls.*

main() {
    var config = TlsClientConfig()
    config.verifyMode = TrustAll
    config.alpnProtocolsList = ["h2"]

    // For session resumption
    var lastSession: ?TlsSession = None
    // Reconnection loop
    while (true) {
        try (socket = TcpSocket("127.0.0.1", 8443)) {
            // First establish TCP connection
            socket.connect()
            try (tls = TlsSocket.client(socket, clientConfig: config, session: lastSession)) {
                try {
                    tls.handshake()
                    // If successful, remember session for next reconnection
                    lastSession = tls.session
                } catch (e: Exception) {
                    // If negotiation fails, clear the session
                    lastSession = None
                    throw e
                }
                // TLS instance is ready
                tls.write("Hello, peer! Let's discuss our personal secrets.\n".toArray())
            }
        } catch (e: Exception) {
            println("client connection failed ${e}, retrying...")
        }
    }
}
```