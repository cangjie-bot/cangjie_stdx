# Classes

## class TlsSessionContext

```cangjie
public class TlsSessionContext <: Equatable<TlsSessionContext> & ToString
```

Function: Creates a client TLS connection based on the provided StreamingSocket instance, which can be used for TLS handshake.

Parameters:

- socket: StreamingSocket - The socket obtained after TCP connection establishment.
- config: [TlsConfig](../common/tls_common_package_api/tls_common_package_interfaces.md#interface-tlsconfig) - Client TLS configuration.
- session!: ?[TlsSession](../common/tls_common_package_api/tls_common_package_interfaces.md#interface-tlssession) - TLS session. If an available TLS session exists, it can be used for session resumption to save TLS connection establishment time.

Return Value:

- [TlsConnection](../common/tls_common_package_api/tls_common_package_interfaces.md#interface-tlsconnection) - The constructed client TLS connection.

### func getTlsServer(StreamingSocket, TlsConfig, ?TlsSession)

```cangjie
public func getTlsServer(socket: StreamingSocket, config: TlsConfig, session!: ?TlsSession): TlsConnection
```

Function: Creates a server TLS connection based on the provided StreamingSocket instance, which can be used for TLS handshake.

Parameters:

- socket: StreamingSocket - The socket obtained after TCP connection establishment.
- config: [TlsConfig](../common/tls_common_package_api/tls_common_package_interfaces.md#interface-tlsconfig) - Server TLS configuration.
- session!: ?[TlsSession](../common/tls_common_package_api/tls_common_package_interfaces.md#interface-tlssession) - TLS session. If an available TLS session exists, it can be used for session resumption to save TLS connection establishment time.

Return Value:

- [TlsConnection](../common/tls_common_package_api/tls_common_package_interfaces.md#interface-tlsconnection) - The constructed server TLS connection.

### func getTlsServerSession(String)

```cangjie
public func getTlsServerSession(name: String): TlsSession
```

Function: Creates a [TlsSession](../common/tls_common_package_api/tls_common_package_interfaces.md#interface-tlssession) instance by name, which is used to distinguish TLS servers.

Parameters:

- name: String - Session name.

Return Value:

- [TlsSession](../common/tls_common_package_api/tls_common_package_interfaces.md#interface-tlssession) - The created [TlsSession](../common/tls_common_package_api/tls_common_package_interfaces.md#interface-tlssession) instance.

## class KeylessTlsServerConfig

```cangjie
public class KeylessTlsServerConfig <: TlsConfig {
    public mut prop clientIdentityRequired: TlsClientIdentificationMode
    public mut prop keylogCallback: ?(TlsSocket, String) -> Unit
    public mut prop verifyMode: CertificateVerifyMode
    public init(certChain: Array<X509Certificate>, signCallback: KeylessSignFunc, decryptCallback!: ?KeylessDecryptFunc = None<KeylessDecryptFunc>)
}
```

Function: Provides server configuration for keyless handshake.

> **Note:**
>
> When a client attempts to resume a session, both parties must ensure they are resuming the session with a legitimate counterpart.

Parent Types:

- [TlsConfig](../common/tls_common_package_api/tls_common_package_interfaces.md#interface-tlsconfig)

### var keylogCallback

```cangjie
public var keylogCallback: ?(TlsSocket, String) -> Unit = None
```

Function: Callback function during handshake process, provides TLS initial key data for debugging and decryption purposes.

Type: ?([TlsSocket](tls_package_classes.md#class-tlssocket), String) -> Unit

### prop certificate

```cangjie
public mut prop certificate: ?(Array<Certificate>, PrivateKey)
```

Function: Sets or gets the server certificate and corresponding private key file. The certificate must be of [X509Certificate](../../../crypto/x509/x509_package_api/x509_package_classes.md#class-x509certificate) type. Cannot be set to None.

> **Note:**
>
> The `PrivateKey` returned by this property is a meaningless dummy key, unrelated to `Array<Certificate>`.

Type: ?(Array\<[Certificate](../../../crypto/common/crypto_common_package_api/crypto_common_package_interfaces.md#interface-certificate)>, [PrivateKey](../../../crypto/common/crypto_common_package_api/crypto_common_package_interfaces.md#interface-privatekey))

Exceptions:

- [TlsException](../common/tls_common_package_api/tls_common_package_exceptions.md#class-tlsexception) - Thrown when the server certificate is not of [X509Certificate](../../../crypto/x509/x509_package_api/x509_package_classes.md#class-x509certificate) type, or when the server certificate and corresponding private key file are set to None.

### prop clientIdentityRequired

```cangjie
public mut prop clientIdentityRequired: TlsClientIdentificationMode
```

Function: Sets or gets the client authentication mode required by the server. Default value is [TlsClientIdentificationMode](tls_package_enums.md#enum-tlsclientidentificationmode).Disable, which means no client authentication of server certificate is required, and no client certificate is required.

Type: [TlsClientIdentificationMode](tls_package_enums.md#enum-tlsclientidentificationmode)

### prop dhParameters

```cangjie
public mut prop dhParameters: ?DHParameters
```

Function: Specifies the server's DH key parameters. Default is `None`, where OpenSSL automatically generated parameter values are used by default.

Type: ?[DHParameters](../../../crypto/common/crypto_common_package_api/crypto_common_package_interfaces.md#interface-dhparameters)

### prop securityLevel

```cangjie
public mut prop securityLevel: Int32
```

Function: Specifies the server's security level. Default value is 2, with optional parameter values in the range [0,5]. For parameter value meanings, refer to [openssl-SSL_CTX_set_security_level](https://www.openssl.org/docs/man1.1.1/man3/SSL_CTX_set_security_level.html) documentation.

Type: Int32

Exceptions:

- IllegalArgumentException - Thrown when the configuration value is not in the 0-5 range.

### prop supportedAlpnProtocols

```cangjie
public mut prop supportedAlpnProtocols: Array<String>
```

Function: Application Layer Protocol Negotiation protocols. If the client attempts to negotiate these protocols, the server will select intersecting protocol names. If the client does not attempt to negotiate protocols, this configuration will be ignored.

Type: Array\<String>

Exceptions:

- IllegalArgumentException - Thrown when list elements contain '\0' character.

### prop supportedCipherSuites

```cangjie
public mut prop supportedCipherSuites: Map<TlsVersion, Array<String>>
```

Function: Sets or gets the cipher suites corresponding to each TLS version.

Type: Map\<[TlsVersion](../common/tls_common_package_api/tls_common_package_enums.md#enum-tlsversion), Array\<String>>

Exceptions:

- IllegalArgumentException - Thrown when setting cipher suites through the `Map` parameter, if any TLS version's corresponding cipher suite string contains null character `\0`.

### prop supportedVersions

```cangjie
public mut prop supportedVersions: Array<TlsVersion>
```

Function: Sets or gets the supported TLS versions.

Type: Array\<[TlsVersion](../common/tls_common_package_api/tls_common_package_enums.md#enum-tlsversion)>

### prop verifyMode

```cangjie
public mut prop verifyMode: CertificateVerifyMode
```

Function: Sets or gets the verification mode. Default value is [CertificateVerifyMode](../common/tls_common_package_api/tls_common_package_enums.md#enum-certificateverifymode).Default, which verifies system certificates.

Type: [CertificateVerifyMode](../common/tls_common_package_api/tls_common_package_enums.md#enum-certificateverifymode)

### init(Array\<X509Certificate>, KeylessSignFunc, ?KeylessDecryptFunc)

```cangjie
public init(certChain: Array<X509Certificate>, signCallback: KeylessSignFunc, decryptCallback!: ?KeylessDecryptFunc = None<KeylessDecryptFunc>)
```

Function: Constructs a [KeylessTlsServerConfig](./tls_package_classes.md#class-keylesstlsserverconfig) object.

Parameters:

- certChain: Array\<[X509Certificate](../../../crypto/x509/x509_package_api/x509_package_classes.md#class-x509certificate)> - Certificate object.
- signCallback: [KeylessSignFunc](./tls_package_type.md#type-keylesssignfunc) - Signing callback function.
- decryptCallback!: ?[KeylessDecryptFunc](./tls_package_type.md#type-keylessdecryptfunc) - Decryption callback function. Defaults to None\<[KeylessDecryptFunc](./tls_package_type.md#type-keylessdecryptfunc)>.

Exceptions:

- IllegalArgumentException - Thrown when `certChain` is empty.


## class TlsClientSession

```cangjie
public class TlsClientSession <: TlsSession & Equatable<TlsClientSession> & ToString & Hashable
```

Function: This struct represents an established client session. Users cannot create instances of this struct, and its internal structure is not visible to users.

When a client TLS handshake succeeds, a session is generated. If the connection is lost for some reason, the client can reuse this session through the session ID, omitting the handshake process.

Parent Types:

- [TlsSession](../common/tls_common_package_api/tls_common_package_interfaces.md#interface-tlssession)
- Equatable\<[TlsClientSession](#class-tlsclientsession)>
- ToString
- Hashable

### func hashCode()

```cangjie
public override func hashCode(): Int64
```

Function: Generates a hash value for the session ID.

Return Value:

- Int64 - The hash value of the session ID.

### func toString()

```cangjie
public override func toString(): String
```

Function: Generates a string representation of the session ID.

Return Value:

- String - [TlsClientSession](tls_package_classes.md#class-tlsclientsession)(session ID string).

### operator func !=(TlsClientSession)

```cangjie
public override operator func !=(other: TlsClientSession): Bool
```

Function: Determines whether the session IDs are different.

Parameters:

- other: [TlsClientSession](tls_package_classes.md#class-tlsclientsession) - The session object to compare.

Return Value:

- Bool - Returns `true` if the session objects are different; otherwise, returns `false`.

### operator func ==(TlsClientSession)

```cangjie
public override operator func ==(other: TlsClientSession): Bool
```

Function: Determines whether the session IDs are the same.

Parameters:

- other: [TlsClientSession](tls_package_classes.md#class-tlsclientsession) - The session object to compare.

Return Value:

- Bool - Returns `true` if the session objects are the same; otherwise, returns `false`.

## class TlsServerSession

```cangjie
public class TlsServerSession <: TlsSession & Equatable<TlsServerSession> & ToString
```

Function: This class represents the TLS session context, providing information to clients to ensure they are connecting to the same server instance. It is used to validate client legitimacy during connection resumption.

> **Note:**
>
> When a client attempts to resume a session, both parties must ensure they are resuming the session with a legitimate peer.

Parent Types:

- [TlsSession](./../common/tls_common_package_api/tls_common_package_interfaces.md#interface-tlssession)
- Equatable\<[TlsServerSession](#class-tlsserversession)>
- ToString

### static func fromName(String)

```cangjie
public static func fromName(name: String): TlsSessionContext
```

Function: Creates a [TlsSessionContext](tls_package_classes.md#class-tlssessioncontext) instance by name.

Retrieves a [TlsSessionContext](tls_package_classes.md#class-tlssessioncontext) object based on the name stored in [TlsSessionContext](tls_package_classes.md#class-tlssessioncontext). This name is used to distinguish TLS servers, so clients rely on it to avoid accidentally attempting to resume connections with the wrong server. The name does not necessarily need to be cryptographically secure, as the underlying implementation handles this. Two TlsSessionContext instances returned from this function with the same name may not be equal and are not guaranteed to be interchangeable. Although they are created from the same name, the server instance should create a single TlsSessionContext throughout its lifecycle and use it in every [TlsSocket](tls_package_classes.md#class-tlssocket).server() call.

Parameters:

- name: String - The session context name.

Return Value:

- [TlsSessionContext](tls_package_classes.md#class-tlssessioncontext) - The session context.

### func toString()

```cangjie
public override func toString(): String
```

Function: Generates a session context name string.

Return Value:

- String - [TlsSessionContext](tls_package_classes.md#class-tlssessioncontext) (the session context name string).

### operator func !=(TlsSessionContext)

```cangjie
public override operator func !=(other: TlsSessionContext): Bool
```

Function: Determines whether two [TlsSessionContext](tls_package_classes.md#class-tlssessioncontext) instance names are different.

Parameters:

- other: [TlsSessionContext](tls_package_classes.md#class-tlssessioncontext) - The session context object to compare.

Return Value:

- Bool - Returns `true` if the [TlsSessionContext](tls_package_classes.md#class-tlssessioncontext) objects are different; otherwise, returns `false`.

### operator func ==(TlsSessionContext)

```cangjie
public override operator func ==(other: TlsSessionContext): Bool
```

Function: Determines whether two [TlsSessionContext](tls_package_classes.md#class-tlssessioncontext) instance names are the same.

Parameters:

- other: [TlsSessionContext](tls_package_classes.md#class-tlssessioncontext) - The session context object to compare.

Return Value:

- Bool - Returns `true` if the [TlsSessionContext](tls_package_classes.md#class-tlssessioncontext) objects are the same; otherwise, returns `false`.

## class TlsSocket

```cangjie
public class TlsSocket <: StreamingSocket & Equatable<TlsSocket> & Hashable
```

Function: [TlsSocket](tls_package_classes.md#class-tlssocket) is used to create an encrypted transmission channel between client and server.

Parent Types:

- StreamingSocket
- Equatable\<[TlsSocket](#class-tlssocket)>
- Hashable

### prop alpnProtocolName

```cangjie
public prop alpnProtocolName: ?String
```

Function: Reads the negotiated application-layer protocol name.

Type: ?String

Exceptions:

- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the socket has not completed TLS handshake or the local TLS socket is closed.
- IllegalMemoryException - Thrown when memory allocation fails.

### prop cipherSuite

```cangjie
public prop cipherSuite: CipherSuite
```

Function: The negotiated cipher suite after handshake.

> **Note:**
>
> The cipher suite includes encryption algorithms, hash functions for message authentication, and key exchange algorithms.

Type: [CipherSuite](tls_package_structs.md#struct-ciphersuite)

Exceptions:

- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the socket has not completed TLS handshake or the local TLS socket is closed.

### prop clientCertificate

```cangjie
public prop clientCertificate: ?Array<X509Certificate>
```

Function: The client certificate provided by the client. On the client side, this refers to the local certificate; on the server side, it refers to the peer certificate.

> **Note:**
>
> When retrieving the peer certificate, if the peer did not send a certificate, this interface may fail and return None. See [peerCertificate](./tls_package_classes.md#prop-peercertificate).

Type: ?Array\<[X509Certificate](../../../crypto/x509/x509_package_api/x509_package_classes.md#class-x509certificate)>

Exceptions:

- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the socket has not completed TLS handshake or the local TLS socket is closed.

### prop domain

```cangjie
public prop domain: ?String
```

Function: Reads the negotiated server hostname.

- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the socket has not completed TLS handshake or the local TLS socket is closed.

Type: ?String

### prop localAddress

```cangjie
public override prop localAddress: SocketAddress
```

Function: Reads the local address of the [TlsSocket](tls_package_classes.md#class-tlssocket).

Type: SocketAddress

Exceptions:

- SocketException - Thrown when the underlying TCP socket for local connection is closed.
- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the local TLS-configured socket is closed.

### prop peerCertificate

```cangjie
public prop peerCertificate: ?Array<X509Certificate>
```

Function: Retrieves the peer certificate. On the client side, this is the same as [serverCertificate](./tls_package_classes.md#prop-servercertificate); on the server side, it is the same as [clientCertificate](./tls_package_classes.md#prop-clientcertificate).

> **Note:**
>
> - If the peer did not send a certificate during handshake, this interface will fail to retrieve the peer certificate and return None.
>
> - When resuming a connection via session mechanism, neither party sends certificates. The interface behaves as follows:
>
>     - On the server side, if the peer certificate was obtained during the original connection establishment, the server caches the peer certificate and retrieves it here;
>     - On the client side, the original connection's peer certificate is not cached, and this interface will fail to retrieve the peer certificate, returning None.

Type: ?Array\<[X509Certificate](../../../crypto/x509/x509_package_api/x509_package_classes.md#class-x509certificate)>

Exceptions:

- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the socket has not completed TLS handshake or the local TLS socket is closed.

### prop readTimeout

```cangjie
public override mut prop readTimeout: ?Duration
```

Function: Reads/writes the read timeout of the [TlsSocket](tls_package_classes.md#class-tlssocket).

Type: ?Duration

Exceptions:

- SocketException - Thrown when the underlying TCP socket for local connection is closed.
- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the local TLS-configured socket is closed.
- IllegalArgumentException - Thrown when the set read timeout is negative.

### prop remoteAddress

```cangjie
public override prop remoteAddress: SocketAddress
```

Function: Reads the remote address of the [TlsSocket](tls_package_classes.md#class-tlssocket).

Type: SocketAddress

Exceptions:

- SocketException - Thrown when the underlying TCP socket for local connection is closed.
- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the local TLS-configured socket is closed.

### prop serverCertificate

```cangjie
public prop serverCertificate: Array<X509Certificate>
```

Function: The server certificate chain is provided by the server or pre-configured in the server configuration. On the server side, this refers to the local certificate; on the client side, it refers to the peer certificate.

> **Note:**
>
> When retrieving the peer certificate, if the peer did not send a certificate, this interface may fail and return None. See [peerCertificate](./tls_package_classes.md#prop-peercertificate).

Type: Array\<[X509Certificate](../../../crypto/x509/x509_package_api/x509_package_classes.md#class-x509certificate)>

Exceptions:

- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the socket has not completed TLS handshake or the local TLS socket is closed.

### prop session

```cangjie
public prop session: ?TlsSession
```

Function: Reads the TLS session ID. The client captures the current session ID after successful handshake, which can be used to reuse the session and save TLS connection establishment time. Returns `None` if the connection establishment fails.

> **Note:**
>
> The server does not capture this and thus always returns None.

Type: ?[TlsSession](tls_package_structs.md#struct-tlssession)

Exceptions:

- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the socket has not completed TLS handshake.

### prop socket

```cangjie
public prop socket: StreamingSocket
```

Function: The StreamingSocket used to create the [TlsSocket](tls_package_classes.md#class-tlssocket).

Type: StreamingSocket

Exceptions:

- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the local TLS-configured socket is closed.

### prop tlsVersion

```cangjie
public prop tlsVersion: TlsVersion
```

Function: Reads the negotiated TLS version.

Type: [TlsVersion](tls_package_enums.md#enum-tlsversion)

Exceptions:

- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the socket has not completed TLS handshake or the local TLS socket is closed.

### prop writeTimeout

```cangjie
public override mut prop writeTimeout: ?Duration
```

Function: Reads/writes the write timeout of the [TlsSocket](tls_package_classes.md#class-tlssocket).

Type: ?DurationExceptions:

- SocketException - Thrown when the underlying TCP socket of the local connection is closed.
- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when a socket configured for TLS on the local end is closed.
- IllegalArgumentException - Thrown when the specified write timeout value is negative.

### static func client(StreamingSocket, ?TlsSession, TlsClientConfig)

```cangjie
public static func client(
    socket: StreamingSocket,
    session!: ?TlsSession = None,
    clientConfig!: TlsClientConfig = TlsClientConfig()
): TlsSocket
```

Function: Creates a client TLS socket for the specified address using the provided StreamingSocket instance. This socket can be used for client TLS handshake and session.

Parameters:

- socket: StreamingSocket - A client TCP socket already connected to the server.
- session!: ?[TlsSession](tls_package_structs.md#struct-tlssession) - TLS session ID. If an available TLS session exists, this ID can be used to resume a historical TLS session, saving TLS connection establishment time. However, session negotiation may still fail. Defaults to `None`.
- clientConfig!: [TlsClientConfig](tls_package_structs.md#struct-tlsclientconfig) - Client configuration. Defaults to [TlsClientConfig](tls_package_structs.md#struct-tlsclientconfig)().

Return Value:

- [TlsSocket](tls_package_classes.md#class-tlssocket) - The constructed [TlsSocket](tls_package_classes.md#class-tlssocket) instance.

### static func server(StreamingSocket, ?TlsSessionContext, TlsServerConfig)

```cangjie
public static func server(
    socket: StreamingSocket,
    sessionContext!: ?TlsSessionContext = None,
    serverConfig!: TlsServerConfig
): TlsSocket
```

Function: Creates a server TLS socket for the specified address using the provided StreamingSocket instance. This socket can be used for server TLS handshake and session.

Parameters:

- socket: StreamingSocket - The accepted socket after TCP connection establishment.
- sessionContext!: ?[TlsSessionContext](tls_package_classes.md#class-tlssessioncontext) - TLS session ID. If an available TLS session exists, this ID can be used to resume a historical TLS session, saving TLS connection establishment time. However, session negotiation may still fail. Defaults to None.
- serverConfig!: [TlsServerConfig](tls_package_structs.md#struct-tlsserverconfig) - Server configuration. Defaults to [TlsServerConfig](tls_package_structs.md#struct-tlsserverconfig)().

Return Value:

- [TlsSocket](tls_package_classes.md#class-tlssocket) - The constructed [TlsSocket](tls_package_classes.md#class-tlssocket) instance.

### func close()

```cangjie
public func close(): Unit
```

Function: Closes the socket.

Exceptions:

- SocketException - Thrown when the underlying connection cannot be closed.

### func handshake(?Duration)

```cangjie
public func handshake(timeout!: ?Duration = None): Unit
```

Function: Performs TLS handshake. Does not support renegotiation and can only be called once. Can be called on either client or server [TlsSocket](tls_package_classes.md#class-tlssocket).

Parameters:

- timeout!: ?Duration - Handshake timeout duration. Defaults to None, which uses the default 30-second timeout.

Exceptions:

- SocketException - Thrown when the underlying TCP socket of the local connection is closed.
- SocketTimeoutException - Thrown when the underlying TCP socket connection times out.
- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the handshake has already started or completed, or when a system error occurs during the handshake phase.
- IllegalArgumentException - Thrown when the specified handshake timeout value is negative.

### func hashCode()

```cangjie
public override func hashCode(): Int64
```

Function: Returns the hash value of the TLS socket object.

Return Value:

- Int64 - The result of the hash computation on the TLS socket object.

### func isClosed()

```cangjie
public func isClosed(): Bool
```

Function: Returns the closed state of the socket.

Return Value:

- Bool - Returns true if the connection is closed; otherwise, returns false.

### func read(Array\<Byte>)

```cangjie
public override func read(buffer: Array<Byte>): Int64
```

Function: Reads data from [TlsSocket](tls_package_classes.md#class-tlssocket).

Parameters:

- buffer: Array\<Byte> - Array to store the read data.

Return Value:

- Int64 - The number of bytes read.

Exceptions:

- SocketException - Thrown when the underlying TCP socket of the local connection is closed.
- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when `buffer` is empty, [TlsSocket](tls_package_classes.md#class-tlssocket) is not connected, or a system error occurs during data reading.

### func toString()

```cangjie
public func toString(): String
```

Function: String representation of the socket, indicating its current state.

> **Note:**
>
> For example: When the socket is ready to start a handshake, this method returns the string "[TlsSocket](tls_package_classes.md#class-tlssocket)(TcpSocket(\${local address} -> \${remote address}), ready for handshake)"

Return Value:

- String - The TLS connection string.

### func write(Array\<Byte>)

```cangjie
public func write(buffer: Array<Byte>): Unit
```

Function: Writes data to [TlsSocket](tls_package_classes.md#class-tlssocket).

Parameters:

- buffer: Array\<Byte> - Array containing the data to be sent.

Exceptions:

- SocketException - Thrown when the underlying TCP socket of the local connection is closed.
- [TlsException](tls_package_exceptions.md#class-tlsexception) - Thrown when the socket is closed, [TlsSocket](tls_package_classes.md#class-tlssocket) is not connected, or a system error occurs during data writing.

### operator func !=(TlsSocket)

```cangjie
public override operator func !=(other: TlsSocket): Bool
```

Function: Determines whether two [TlsSocket](tls_package_classes.md#class-tlssocket) instances reference different objects.

Parameters:

- other: [TlsSocket](tls_package_classes.md#class-tlssocket) - The TLS socket to compare.

Return Value:

- Bool - Returns `true` if the compared sockets are different; otherwise, returns `false`.

### operator func ==(TlsSocket)

```cangjie
public override operator func ==(other: TlsSocket): Bool
```

Function: Determines whether two [TlsSocket](tls_package_classes.md#class-tlssocket) instances reference the same object.

Parameters:

- other: [TlsSocket](tls_package_classes.md#class-tlssocket) - The TLS socket to compare.

Return Value:

- Bool - Returns `true` if the compared sockets are the same; otherwise, returns `false`.