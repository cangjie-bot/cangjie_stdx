/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.net.tls

import stdx.crypto.x509.*

enum HandshakeConfig {
    | Client(TlsClientConfig, ?TlsSession)
    | Server(TlsServerConfig, ?TlsSessionContext)
}

extend TlsContext {
    func setCertificateChainAndPrivateKey(chain: Array<X509Certificate>, key: PrivateKey): Unit {
        withContext<Unit> {
            nativeContext, exception => setCertificateChainAndPrivateKey(nativeContext, chain, key, exception)
        }
    }

    func setDHParam(key: ?DHParameters): Unit {
        withContext<Unit> {
            nativeContext, exception => setDHParam(nativeContext, key, exception)
        }
    }

    func configureVerifyMode(verifyMode: CertificateVerifyMode): Unit {
        withContext<Unit> {
            nativeContext, exception => configureVerifyMode(nativeContext, verifyMode, exception)
        }
    }

    func configureClientIdentification(verifyMode: TlsClientIdentificationMode) {
        withContext<Unit> {
            nativeContext, _ => configureClientVerifyMode(nativeContext, verifyMode)
        }
    }

    func configureSecurityLevel(level: Int32): Unit {
        withContext<Unit> {
            nativeContext, _ =>
            let ret = unsafe { CJ_TLS_SetSecurityLevel(nativeContext, level) }
            if (ret == 0) {
                throw TlsException("Failed to set tls socket security level.")
            }
        }
    }

    private func setCertificateChainAndPrivateKey(
        context: CPointer<Ctx>,
        chain: Array<X509Certificate>,
        key: PrivateKey,
        exception: CPointer<ExceptionData>
    ): Unit {
        if (chain.isEmpty()) {
            throw IllegalArgumentException("Certificate chain is empty: at least one certificate required.")
        }

        setPrivateKeyImpl(context, key.encodeToDer(), exception)

        var ifNotFirst = false
        for (cert in chain) {
            let entry = PemEntry(PemEntry.LABEL_CERTIFICATE, cert.encodeToDer())
            useAddCertImpl(context, entry, add: ifNotFirst, exception: exception)
            ifNotFirst = true
        }

        unsafe {
            let ret = CJ_TLS_CheckPrivateKey(context)
            if (ret <= 0) {
                throw TlsException("The Certificate chain doesn't match the private key.")
            }
        }
    }

    private func setPrivateKeyImpl(
        context: CPointer<Ctx>,
        key: DerBlob,
        exception: CPointer<ExceptionData>
    ) {
        let rawContent = key.body
        let rawContentSize = UIntNative(rawContent.size)
        let setKeyResult = unsafe {
            let pinned = acquireArrayRawData(rawContent)
            try {
                CJ_TLS_SetPrivateKey(
                    context,
                    pinned.pointer,
                    rawContentSize,
                    exception
                )
            } finally {
                releaseArrayRawData(pinned)
            }
        }
        if (setKeyResult == 0) {
            unsafe { exception.read().throwException(fallback: "Failed to set private key.") }
        }
    }

    private func useAddCertImpl(
        context: CPointer<Ctx>,
        entry: PemEntry,
        add!: Bool,
        exception!: CPointer<ExceptionData>
    ) {
        let useCertResult = unsafe {
            withPemImpl<Int32>(entry) {
                pointer, size => match (add) {
                    case true => CJ_TLS_Add_Cert(context, pointer, size, exception)
                    case false => CJ_TLS_Use_Cert(context, pointer, size, exception)
                }
            }
        }

        if (useCertResult == 0) {
            unsafe { exception.read().throwException(fallback: "Failed to add certificate.") }
        }
    }

    private func setDHParam(
        context: CPointer<Ctx>,
        key: ?DHParameters,
        exception: CPointer<ExceptionData>
    ): Unit {
        let result = if (let Some(v) <- key) {
            let entry = PemEntry(PemEntry.LABEL_DH_PARAMETERS, v.encodeToDer())
            unsafe {
                withPemImpl<Int32>(entry) {
                    pointer, size => CJ_TLS_SetDHParam(context, pointer, size, exception)
                }
            }
        } else {
            unsafe { CJ_TLS_SetDHParam(context, CPointer<Unit>(), 0, exception) }
        }
        if (result == 0) {
            unsafe { exception.read().throwException(fallback: "Failed to set DH Parameters.") }
        }
    }

    private func withPemImpl<R>(entry: PemEntry, block: (CPointer<Unit>, UIntNative) -> R): R {
        let pemText = Pem([entry]).encode().toArray()
        let pemSize = UIntNative(pemText.size)

        unsafe {
            let pinned = acquireArrayRawData(pemText)
            try {
                block(CPointer(pinned.pointer), pemSize)
            } finally {
                releaseArrayRawData(pinned)
            }
        }
    }

    private func configureVerifyMode(
        context: CPointer<Ctx>,
        verifyMode: CertificateVerifyMode,
        exception: CPointer<ExceptionData>
    ): Unit {
        match (verifyMode) {
            case Default => ()
            case TrustAll => setContextTrustAll(context)
            case CustomCA(items) => configureCustomCA(context, items, exception)
        }
    }

    private func configureCustomCA(
        context: CPointer<Ctx>,
        items: Array<X509Certificate>,
        exception: CPointer<ExceptionData>
    ) {
        for (ca in items) {
            let pem = ca.encodeToPem().encode().toArray()
            let bytes = unsafe { acquireArrayRawData(pem) }
            try {
                let addResult = unsafe { CJ_TLS_Add_CA(context, CPointer(bytes.pointer), UIntNative(pem.size), exception
                ) }
                if (addResult == 0) {
                    throw TlsException("Failed to assign CA certificate.")
                }
            } finally {
                unsafe { releaseArrayRawData(bytes) }
            }
        }
    }

    private func setContextTrustAll(context: CPointer<Ctx>) {
        let ret = unsafe { CJ_TLS_SetTrustAll(context) }
        if (ret == 0) {
            throw TlsException("Failed to set tls socket verify mode to trust all.")
        }
    }

    private func configureClientVerifyMode(context: CPointer<Ctx>, verifyMode: TlsClientIdentificationMode) {
        let result = unsafe {
            match (verifyMode) {
                case Disabled => CJ_TLS_SetClientVerifyMode(context, 0, 0) // not required, not verify
                case Optional => CJ_TLS_SetClientVerifyMode(context, 0, 1) // not required, do verify
                case Required => CJ_TLS_SetClientVerifyMode(context, 1, 1) // required, do verify
            }
        }

        if (result == 0) {
            throw TlsException("Failed to configure TlsClientIdentificationMode.")
        }
    }
}

foreign {
    func CJ_TLS_DYN_Add_CA(
        context: CPointer<Ctx>,
        ca: CPointer<Unit>,
        length: UIntNative,
        exception: CPointer<ExceptionData>,
        dynMsg: CPointer<DynMsg>
    ): Int32

    func CJ_TLS_DYN_Add_Cert(
        context: CPointer<Ctx>,
        pem: CPointer<Unit>,
        length: UIntNative,
        exception: CPointer<ExceptionData>,
        dynMsg: CPointer<DynMsg>
    ): Int32

    func CJ_TLS_DYN_Use_Cert(
        context: CPointer<Ctx>,
        pem: CPointer<Unit>,
        length: UIntNative,
        exception: CPointer<ExceptionData>,
        dynMsg: CPointer<DynMsg>
    ): Int32

    func CJ_TLS_DYN_SetPrivateKey(
        context: CPointer<Ctx>,
        key: CPointer<Byte>,
        length: UIntNative,
        exception: CPointer<ExceptionData>,
        dynMsg: CPointer<DynMsg>
    ): Int32

    func CJ_TLS_DYN_SetDHParam(
        context: CPointer<Ctx>,
        key: CPointer<Unit>,
        length: UIntNative,
        exception: CPointer<ExceptionData>,
        dynMsgPtr: CPointer<DynMsg>
    ): Int32

    func CJ_TLS_DYN_SetTrustAll(context: CPointer<Ctx>, dynMsg: CPointer<DynMsg>): Int32

    func CJ_TLS_DYN_SetClientVerifyMode(context: CPointer<Ctx>, required: Int32, verify: Int32, dynMsg: CPointer<DynMsg>): Int32

    func CJ_TLS_DYN_SetSecurityLevel(context: CPointer<Ctx>, level: Int32, dynMsg: CPointer<DynMsg>): Int32
}

func CJ_TLS_Add_CA(
    context: CPointer<Ctx>,
    ca: CPointer<Unit>,
    length: UIntNative,
    exception: CPointer<ExceptionData>
): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_Add_CA(context, ca, length, exception, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_Add_Cert(
    context: CPointer<Ctx>,
    pem: CPointer<Unit>,
    length: UIntNative,
    exception: CPointer<ExceptionData>
): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_Add_Cert(context, pem, length, exception, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_SetPrivateKey(
    context: CPointer<Ctx>,
    key: CPointer<Byte>,
    length: UIntNative,
    exception: CPointer<ExceptionData>
): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_SetPrivateKey(context, key, length, exception, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_SetDHParam(
    context: CPointer<Ctx>,
    key: CPointer<Unit>,
    length: UIntNative,
    exception: CPointer<ExceptionData>
): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_SetDHParam(context, key, length, exception, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_SetTrustAll(context: CPointer<Ctx>): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_SetTrustAll(context, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_SetClientVerifyMode(context: CPointer<Ctx>, required: Int32, verify: Int32): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_SetClientVerifyMode(context, required, verify, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_SetSecurityLevel(context: CPointer<Ctx>, level: Int32): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_SetSecurityLevel(context, level, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}

func CJ_TLS_Use_Cert(
    context: CPointer<Ctx>,
    pem: CPointer<Unit>,
    length: UIntNative,
    exception: CPointer<ExceptionData>
): Int32 {
    unsafe {
        var dynMsg = DynMsg()
        let res = CJ_TLS_DYN_Use_Cert(context, pem, length, exception, inout dynMsg)
        checkDynMsg(dynMsg)
        return res
    }
}
