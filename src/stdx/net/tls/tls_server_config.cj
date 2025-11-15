/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import stdx.crypto.x509.*

public struct TlsServerConfig {
    private var minVersion_: TlsVersion = Unknown
    private var maxVersion_: TlsVersion = Unknown
    private var cipherSuitesV1_2_: Array<String> = Array<String>()
    private var cipherSuitesV1_3_: Array<String> = Array<String>()
    private var alpnList_: Array<String> = Array<String>()
    private var serverCertificate_: ?(Array<X509Certificate>, PrivateKey) = None
    private var dhParameters_: ?DHParameters = None
    /* level 2 means DH key length 2048, ECDH key length 224 */
    private var securityLevel_: Int32 = 2

    public init(
        certChain: Array<X509Certificate>,
        certKey: PrivateKey
    ) {
        this.serverCertificate_ = (certChain, certKey)
    }

    /**
     * Server certificate and the corresponding private key
     */
    public mut prop serverCertificate: (Array<X509Certificate>, PrivateKey) {
        get() {
            this.serverCertificate_.getOrThrow()
        }
        set(value) {
            this.serverCertificate_ = value
        }
    }

    /**
     * self-generated DH parameters for DH/DHE/ECDH/ECDHE ciphers.
     * When it's None, use openssl auto generated DH parameters
     */
    public mut prop dhParameters: ?DHParameters {
        get() {
            this.dhParameters_
        }
        set(value) {
            this.dhParameters_ = value
        }
    }

    /**
     * securityLevel 0-5， refer to openssl SSL_CTX_set_security_level
     */
    public mut prop securityLevel: Int32 {
        get() {
            this.securityLevel_
        }
        set(value) {
            if (value < 0 || value > 5) {
                throw IllegalArgumentException("SecurityLevel should be from 0 to 5.")
            }
            this.securityLevel_ = value
        }
    }

    /**
     * Client certificate verify mode
    */
    public var verifyMode: CertificateVerifyMode = CertificateVerifyMode.Default

    /*
     * Whether we require client to send certificate
    */
    public var clientIdentityRequired: TlsClientIdentificationMode = Disabled

    /**
     * A list of supported ALPN protocol names. If a client is trying to negotiate ALPN
     * providing it's list of protocol, the server TLS socket will intersect these lists and
     * negotiate a matching protocol (a protocol is matching if it exists in both server supported list and
     * client requested protocols list). Once negotiated, the resulting protocol name will be available
     * in TlsSocket instance.
     *
     * Clients that don't negotiate ALPN will connect as usual and this list will be ignored.
     *
     * @throws IllegalArgumentException while alpnList contains null character.
     */
    public mut prop supportedAlpnProtocols: Array<String> {
        get() {
            return this.alpnList_
        }
        set(v) {
            for (s in v) {
                checkString(s, "supportedAlpnProtocols")
            }
            this.alpnList_ = v
        }
    }

    /**
     * A list of cipher suites as per TLS 1.2.
     *
     * Accepts cipher strings as specified by
     * <a href="https://www.openssl.org/docs/man1.1.1/man1/openssl-ciphers.html">openssl documentation </a>.
     * or standard cipher names from IANA TLS Cipher Suites Registry that are supported by openssl.
     *
     * throws IllegalArgumentException when illegal characters used in the list
     */
    public mut prop cipherSuitesV1_2: Array<String> {
        get() {
            return this.cipherSuitesV1_2_
        }
        set(v) {
            for (s in v) {
                checkString(s, "cipherSuitesV1_2")
            }
            this.cipherSuitesV1_2_ = v
        }
    }

    /*
     * A list of cipher suites as per TLS 1.3.
     *
     * throws IllegalArgumentException while cipherSuitesV1_3 contains null character.
    */
    public mut prop cipherSuitesV1_3: Array<String> {
        get() {
            return this.cipherSuitesV1_3_
        }
        set(v) {
            for (s in v) {
                checkString(s, "cipherSuitesV1_3")
            }
            this.cipherSuitesV1_3_ = v
        }
    }

    public mut prop minVersion: TlsVersion {
        get() {
            return this.minVersion_
        }
        set(v) {
            this.minVersion_ = v
        }
    }

    public mut prop maxVersion: TlsVersion {
        get() {
            return this.maxVersion_
        }
        set(v) {
            this.maxVersion_ = v
        }
    }

    /*
     * Callback that is invoked for every handshake providing TLS initial
     * key data that is useful for debugging and decrypting a recorded
     * network dump.
     */
    public var keylogCallback: ?(TlsSocket, String) -> Unit = None
}

extend TlsContext {
    func configureServer(cfg: TlsServerConfig, session: ?TlsSessionContext): Unit {
        withContext<Unit> {
            nativeContext, _ => configureServerContext(nativeContext, cfg, session)
        }
    }

    private func configureServerContext(
        context: CPointer<Ctx>,
        cfg: TlsServerConfig,
        session: ?TlsSessionContext
    ): Unit {
        configureVerifyMode(cfg.verifyMode)
        configureSecurityLevel(cfg.securityLevel)
        configureClientIdentification(cfg.clientIdentityRequired)

        let (cert, key) = cfg.serverCertificate // The server certificate is not supposed to be null
        setCertificateChainAndPrivateKey(cert, key)

        setDHParam(cfg.dhParameters)

        enableSNI(context)

        let minVersion = cfg.minVersion
        let maxVersion = cfg.maxVersion
        setProtoVersions(context, minVersion, maxVersion)

        let cipherSuitesV1_2 = cfg.cipherSuitesV1_2
        if (cipherSuitesV1_2.isEmpty()) {
            setCipherSuitesV1_2(context, minVersion, maxVersion, cipherSuitesV1_2)
        }

        let cipherSuitesV1_3 = cfg.cipherSuitesV1_3
        if (cipherSuitesV1_3.isEmpty()) {
            setCipherSuitesV1_3(context, minVersion, maxVersion, cipherSuitesV1_3)
        }

        let alpnList = cfg.supportedAlpnProtocols
        if (!alpnList.isEmpty()) {
            setServerAlpnProtos(context, alpnList)
        }

        let sessionId = session?.name ?? ""
        setServerSessionId(context, sessionId)
    }
}
