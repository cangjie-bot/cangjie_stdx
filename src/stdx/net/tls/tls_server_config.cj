/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import std.collection.{Map, HashMap}
import stdx.net.tls.common.*
import stdx.crypto.x509.*
import stdx.crypto.common.*

public struct TlsServerConfig <: TlsConfig {
    private var _supportedAlpnProtocols: Array<String> = Array<String>()
    private var _certificate: (Array<X509Certificate>, PrivateKey)
    private var _dhParameters: ?DHParameters = None
    /* level 2 means DH key lengh 2048, ECDH key length 224 */
    private var _securityLevel: Int32 = 2

    /* Client certificate verify mode */
    private var _verifyMode: CertificateVerifyMode = CertificateVerifyMode.Default
    /* Supported TLS versions */
    private var _supportedVersions: Array<TlsVersion> = []
    private var _supportedCipherSuites: Map<TlsVersion, Array<String>> = HashMap<TlsVersion, Array<String>>()
    /* Whether we require client to send certificate */
    private var _clientIdentityRequired: TlsClientIdentificationMode = Disabled

    /*
     * Callback that is invoked for every handshake providing TLS initial
     * key data that is useful for debugging and decrypting a recorded
     * network dump.
     */
    public var keylogCallback: ?(TlsSocket, String) -> Unit = None

    public init(
        certChain: Array<X509Certificate>,
        certKey: PrivateKey
    ) {
        this._certificate = (certChain, certKey)
    }

    /**
     * Server certificate and the corresponding private key
     */
    mut prop serverCertificate: (Array<X509Certificate>, PrivateKey) {
        get() {
            _certificate
        }
        set(value) {
            _certificate = value
        }
    }

    public mut prop verifyMode: CertificateVerifyMode {
        get() {
            _verifyMode
        }
        set(v) {
            _verifyMode = v
        }
    }

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
            _supportedAlpnProtocols
        }
        set(v) {
            for (s in v) {
                checkString(s, "supportedAlpnProtocols")
            }
            _supportedAlpnProtocols = v
        }
    }

    public mut prop supportedVersions: Array<TlsVersion> {
        get() {
            _supportedVersions
        }
        set(v) {
            _supportedVersions = v
        }
    }

    public mut prop supportedCipherSuites: Map<TlsVersion, Array<String>> {
        get() {
            _supportedCipherSuites
        }
        set(v) {
            for ((_, cipherSuites) in v) {
                for (cipherSuite in cipherSuites) {
                    checkString(cipherSuite, "supportedCipherSuites")
                }
            }
            _supportedCipherSuites = v
        }
    }

    /**
     * Server certificate and the corresponding private key
     */
    public mut prop certificate: ?(Array<Certificate>, PrivateKey) {
        get() {
            (_certificate[0].map({c => c}), _certificate[1])
        }
        set(v) {
            let cert = v ?? throw TlsException("The server certificate cannot be null.")
            _certificate = (cert[0].map({c => c as X509Certificate ??
                throw TlsException("Only certificates of type `X509Certificate` are allowed.")}), cert[1])
        }
    }

    public mut prop clientIdentityRequired: TlsClientIdentificationMode {
        get() {
            _clientIdentityRequired
        }
        set(v) {
            _clientIdentityRequired = v
        }
    }

    /**
     * self-generated DH parameters for DH/DHE/ECDH/ECDHE ciphers.
     * When it's None, use openssl auto generated DH parameters
     */
    public mut prop dhParameters: ?DHParameters {
        get() {
            _dhParameters
        }
        set(value) {
            _dhParameters = value
        }
    }

    /**
     * securityLevel 0-5， refer to openssl SSL_CTX_set_security_level
     */
    public mut prop securityLevel: Int32 {
        get() {
            _securityLevel
        }
        set(value) {
            if (value < 0 || value > 5) {
                throw IllegalArgumentException("SecurityLevel should be from 0 to 5.")
            }
            _securityLevel = value
        }
    }
}

extend TlsContext {
    func configureServer(cfg: TlsServerConfig, session: ?TlsServerSession): Unit {
        withContext<Unit> {
            nativeContext, _ => configureServerContext(nativeContext, cfg, session)
        }
    }

    private func configureServerContext(
        context: CPointer<Ctx>,
        cfg: TlsServerConfig,
        session: ?TlsServerSession
    ): Unit {
        configureVerifyMode(cfg.verifyMode)
        configureSecurityLevel(cfg.securityLevel)
        configureClientIdentification(cfg.clientIdentityRequired)

        let (cert, key) = cfg.serverCertificate // The server certificate is not supposed to be null
        setCertificateChainAndPrivateKey(cert, key)

        setDHParam(cfg.dhParameters)

        enableSNI(context)

        setProtoVersions(context, cfg.supportedVersions)

        if (cfg.supportedVersions.contains(V1_2) &&
            let Some(cipherSuite) <- cfg.supportedCipherSuites.entryView(V1_2).value) {
            setCipherSuitesV1_2(context, cipherSuite)
        }

        if (cfg.supportedVersions.contains(V1_3) &&
            let Some(cipherSuite) <- cfg.supportedCipherSuites.entryView(V1_3).value) {
            setCipherSuitesV1_3(context, cipherSuite)
        }

        let alpnList = cfg.supportedAlpnProtocols
        if (!alpnList.isEmpty()) {
            setServerAlpnProtos(context, alpnList)
        }

        let sessionId = session?.name ?? ""
        setServerSessionId(context, sessionId)
    }
}
