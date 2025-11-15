/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import stdx.crypto.x509.*

public struct TlsClientConfig {
    private var domain_: ?String = None

    private var minVersion_: TlsVersion = Unknown
    private var maxVersion_: TlsVersion = Unknown
    private var cipherSuitesV1_2_: ?Array<String> = None
    private var cipherSuitesV1_3_: ?Array<String> = None
    private var alpnList_: Array<String> = Array<String>()
    private var clientCertificate_: ?(Array<X509Certificate>, PrivateKey) = None
    private var signatureAlgorithms_: ?Array<SignatureAlgorithm> = None
    /* level 2 means DH key length 2048, ECDH key length 224 */
    private var securityLevel_: Int32 = 2

    public init() {
    }

    /**
     * Configures server certificate verification
    */
    public var verifyMode: CertificateVerifyMode = CertificateVerifyMode.Default

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
     * a pair of client certificate to send and the corresponding private key (not sent)
     */
    public mut prop clientCertificate: ?(Array<X509Certificate>, PrivateKey) {
        get() {
            this.clientCertificate_
        }
        set(v) {
            this.clientCertificate_ = v
        }
    }

    /**
     * specific domain name to request (SNI) or None to not request
     */
    public mut prop domain: ?String {
        get() {
            return this.domain_
        }
        set(v) {
            if (let Some(v) <- v) {
                checkString(v, "domain")
            }
            this.domain_ = v
        }
    }

    /**
     * A list of requested ALPN protocol names
     * client will not negotiate ALPN if the list of empty
     *
     * @throws IllegalArgumentException while alpnList contains null character.
     */
    public mut prop alpnProtocolsList: Array<String> {
        get() {
            return this.alpnList_
        }
        set(v) {
            for (s in v) {
                checkString(s, "alpnProtocolsList")
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
    public mut prop cipherSuitesV1_2: ?Array<String> {
        get() {
            return this.cipherSuitesV1_2_
        }
        set(v) {
            if (let Some(v) <- v) {
                for (s in v) {
                    checkString(s, "cipherSuitesV1_2")
                }
            }
            this.cipherSuitesV1_2_ = v
        }
    }

    /**
     * A list of cipher suites as per TLS 1.3.
     *
     * throws IllegalArgumentException when illegal characters used in the list
    */
    public mut prop cipherSuitesV1_3: ?Array<String> {
        get() {
            return this.cipherSuitesV1_3_
        }
        set(v) {
            if (let Some(v) <- v) {
                for (s in v) {
                    checkString(s, "cipherSuitesV1_3")
                }
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

    public mut prop signatureAlgorithms: ?Array<SignatureAlgorithm> {
        get() {
            return this.signatureAlgorithms_
        }
        set(v) {
            this.signatureAlgorithms_ = v
        }
    }

    /*
     * Callback that is invoked for every handshake providing TLS initial
     * key data that is useful for debugging and decrypting a recorded
     * network dump. Should be NEVER used in production because the
     * provided string parameter is a sensitive data and
     * exposing it's content may seriously harm connection security.
     */
    public var keylogCallback: ?(TlsSocket, String) -> Unit = None
}

extend TlsContext {
    func configureClient(cfg: TlsClientConfig, session: ?TlsSession): Unit {
        withContext<Unit> {
            nativeContext, _ => configureClientContext(nativeContext, cfg, session)
        }
    }

    private func configureClientContext(
        context: CPointer<Ctx>,
        cfg: TlsClientConfig,
        session: ?TlsSession
    ): Unit {
        configureVerifyMode(cfg.verifyMode)
        configureSecurityLevel(cfg.securityLevel)

        if (let Some((chain, key)) <- cfg.clientCertificate) {
            setCertificateChainAndPrivateKey(chain, key)
        }

        let minVersion = cfg.minVersion
        let maxVersion = cfg.maxVersion
        setProtoVersions(context, minVersion, maxVersion)

        if (let Some(cipherSuitesV1_2) <- cfg.cipherSuitesV1_2) {
            setCipherSuitesV1_2(context, minVersion, maxVersion, cipherSuitesV1_2)
        }

        if (let Some(cipherSuitesV1_3) <- cfg.cipherSuitesV1_3) {
            setCipherSuitesV1_3(context, minVersion, maxVersion, cipherSuitesV1_3)
        }

        let alpnList = cfg.alpnProtocolsList
        if (!alpnList.isEmpty()) {
            setClientAlpnProtos(context, alpnList)
        }

        if (let Some(signatureAlgorithms) <- cfg.signatureAlgorithms) {
            setClientSignatureAlgorithms(context, signatureAlgorithms)
        }

        if (let Some(session) <- session) {
            session
                .holder
                .withNativeSession<Unit> {
                    nativeSession => unsafe { CJ_TLS_AddSession(context, nativeSession) }
                }
        }
    }
}
