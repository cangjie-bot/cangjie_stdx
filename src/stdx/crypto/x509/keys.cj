/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

import stdx.encoding.hex.fromHexString

/**
 * Represents either a public or private key
 */
public interface Key <: ToString {
    /**
     * Encode key to a DerBlob (DER/ASN1 binary format) without encryption.
     * @throws X509Exception if failed to encode
     */
    func encodeToDer(): DerBlob

    /**
     * Encode to PemEntry without encryption
     * @throws X509Exception if failed to encode
     */
    func encodeToPem(): PemEntry

    /**
     * Decode a key from a DerBlob (DER/ASN1 binary format). The key shouldn't be encrypted.
     * @throws X509Exception if failed to decode
     */
    static func decodeDer(encoded: DerBlob): Key

    /**
     * Load the first key from PEM text. The key shouldn't be encrypted.
     * @throws X509Exception if failed to parse PEM or decode the key's content
     */
    static func decodeFromPem(text: String): Key
}

/**
 * Represents a public key
 */
public interface PublicKey <: Key {
/**
     * Encode to PemEntry
     * @throws X509Exception if failed to encode
     */
    override func encodeToPem(): PemEntry {
        PemEntry(PemEntry.LABEL_PUBLIC_KEY, encodeToDer())
    }

    /**
     * Decode a key from a DerBlob (DER/ASN1 binary format).
     * @throws X509Exception if failed to decode
     */
    static func decodeDer(blob: DerBlob): PublicKey {
        DerPublicKeyImpl(blob)
    }

    /**
     * Load the first key from PEM text.
     * @throws X509Exception if failed to parse or decode key or there are no public keys in the PEM
     */
    static func decodeFromPem(text: String): PublicKey {
        for (entry in Pem.decode(text)) {
            if (isPublicKey(entry)) {
                if (let Some(v) <- entry.body) {
                    return decodeDer(v)
                }
            }
        }

        throw X509Exception("No ${PemEntry.LABEL_PUBLIC_KEY} entry found in PEM file.")
    }
}

/**
 * Represents DH parameters
*/
public interface DHParameters <: Key {
    /**
     * Encode to PemEntry
     * @throws X509Exception if failed to encode
    */
    override func encodeToPem(): PemEntry {
        PemEntry(PemEntry.LABEL_DH_PARAMETERS, encodeToDer())
    }

    /**
     * Decode a key from a DerBlob (DER/ASN1 binary format).
     * @throws X509Exception if failed to decode
     */
    static func decodeDer(blob: DerBlob): DHParameters {
        DerDHParametersImpl(blob)
    }

    /**
     * Load the first key from PEM text.
     * @throws X509Exception if failed to parse or decode key or there are no dh parameters in the PEM
     */
    static func decodeFromPem(text: String): DHParameters {
        for (entry in Pem.decode(text)) {
            if (isDHParameters(entry)) {
                if (let Some(v) <- entry.body) {
                    return decodeDer(v)
                }
            }
        }

        throw X509Exception("No ${PemEntry.LABEL_DH_PARAMETERS} entry found in PEM file.")
    }
}

/**
 * Represents a private key
*/
public interface PrivateKey <: Key {
    /**
     * Encode key to a DerBlob (DER/ASN1 binary format) optionally doing encryption
     * using the specified password if any
     * If the passord is None, then the key will be encoded unencrypted.
     * An encrypted key produced by this function is always in PKCS8 format.
     * @throws X509Exception if failed to encode/encrypt or the provided password is empty
     */
    func encodeToDer(password!: ?String): DerBlob

    /**
     * Encode to PemEntry without encryption
     * @throws X509Exception if failed to encode
     */
    override func encodeToPem(): PemEntry {
        PemEntry(PemEntry.LABEL_PRIVATE_KEY, encodeToDer())
    }

    /**
     * Encode the key to PemEntry optionally doing encryption using the specified password if any
     * If the passord is None, then the key will be encoded unencrypted.
     * An encrypted key produced by this function is always in PKCS8 format.
     * @throws X509Exception if failed to encode/encrypt or the provided password is empty
     */
    func encodeToPem(password!: ?String): PemEntry {
        match (password) {
            case Some(password) => PemEntry(PemEntry.LABEL_ENCRYPTED_PRIVATE_KEY, encodeToDer(password: password))
            case None => encodeToPem()
        }
    }

    /**
     * Decode a private key from a DerBlob (DER/ASN1 binary format). The private key shouldn't be encrypted.
     * @throws X509Exception if failed to decode key
     */
    static func decodeDer(blob: DerBlob): PrivateKey {
        decodeDer(blob, password: None)
    }

    /**
     * Decode private key from DER/ASN1 format applying decyption if
     * password provided. Please note that the returned key will be decrypted
     * therefore encodeToPem/Der without password will serialize unecrypted key.
     * This only works for PKCS8 encrypted keys.
     *
     * @throws X509Exception if failed to decode or decrypt or the provided password is empty
     */
    static func decodeDer(blob: DerBlob, password!: ?String): PrivateKey {
        DerPrivateKeyImpl.decodeFromDer(blob, password)
    }

    /**
     * Load the first private key from PEM text. The private key shouldn't be encrypted.
     * @throws X509Exception if failed to decode key or the PEM doesn't contain a key
     */
    static func decodeFromPem(text: String): PrivateKey {
        decodeFromPem(text, password: None)
    }

    /**
     * Load the first private key from the PEM text applying decryption if
     * password provided.
     * Please note that the returned key will be already decrypted therefore the subsequent encodeToPem/Der
     * without password will serialize unecrypted key as well
     *
     * @throws X509Exception if failed to parse, decode, decrypt or the provided password is empty
     */
    static func decodeFromPem(
        text: String,
        password!: ?String
    ): PrivateKey {
        for (entry in Pem.decode(text)) {
            if (isPrivateKey(entry) && entry.body.exists()) {
                return DerPrivateKeyImpl.decodeFromPem(entry, password)
            }
        }

        throw X509Exception("No supported private key entry found in PEM.")
    }
}

func isPrivateKey(it: PemEntry): Bool {
    it.label == PemEntry.LABEL_PRIVATE_KEY || it.label == PemEntry.LABEL_EC_PRIVATE_KEY || it.label == PemEntry
        .LABEL_ENCRYPTED_PRIVATE_KEY || it.label == PemEntry.LABEL_RSA_PRIVATE_KEY || it.label == PemEntry
        .LABEL_DSA_PRIVATE_KEY || it.label == PemEntry.LABEL_SM2_PRIVATE_KEY
}

func isEncrypted(entry: PemEntry): Bool {
    entry.label == PemEntry.LABEL_ENCRYPTED_PRIVATE_KEY
}

func isPublicKey(entry: PemEntry): Bool {
    entry.label == PemEntry.LABEL_PUBLIC_KEY
}

func isDHParameters(entry: PemEntry): Bool {
    entry.label == PemEntry.LABEL_DH_PARAMETERS
}

unsafe func describeImpl(
    body: Array<Byte>,
    exception: CPointer<ExceptionData>,
    f: CFunc<(key: CPointer<Byte>, length: UIntNative, exception: CPointer<ExceptionData>, msg: CPointer<DynMsg>) -> Int32>,
    message: String
): Unit {
    let keySize = UIntNative(body.size) // we do it outside of acq-release
    let dynMsgPtr = MallocDynMsg()
    if (dynMsgPtr.isNull()) {
        throw X509Exception("malloc failed")
    }

    let keyBytes = acquireArrayRawData(body)
    let result = try {
        f(
            keyBytes.pointer,
            keySize,
            exception,
            dynMsgPtr
        )
    } finally {
        releaseArrayRawData(keyBytes)
    }
    try {
        if (!dynMsgPtr.read().found) {
            let funcName = CString(dynMsgPtr.read().funcName).toString()
            throw X509Exception("Can not load openssl library or function ${funcName}.")
        }
    } finally {
        FreeDynMsg(dynMsgPtr)
    }

    if (exception.read().hasException) {
        exception.read().throwException(fallback: message)
    }

    if (result <= 0) {
        throw X509Exception(message)
    }
}

class DerPublicKeyImpl <: PublicKey {
    DerPublicKeyImpl(private let blob: DerBlob) {
        describe()
    }

    public override func encodeToDer(): DerBlob {
        blob
    }

    public override func toString(): String {
        "PublicKey(${blob.size} bytes)"
    }

    // Check if the publicKey is valid
    // should only be used to check the not-garanteed inputted data.
    // No need to be called while the inputted data is get from a cert, which is already checked.
    private func describe(): Unit {
        unsafe {
            ExceptionData.withException<Unit> {
                exception => describeImpl(blob.body, exception)
            }
        }
    }

    private static unsafe func describeImpl(
        body: Array<Byte>,
        exception: CPointer<ExceptionData>
    ): Unit {
        describeImpl(body, exception, CJX509DescribePublicKey, "Failed to load PublicKey")
    }
}

class DerDHParametersImpl <: DHParameters {
    DerDHParametersImpl(private let blob: DerBlob) {
        describe()
    }

    public override func toString(): String {
        "DHParameters(${blob.size} bytes)"
    }

    public override func encodeToDer(): DerBlob {
        blob
    }

    // Check if the DH parameters is valid
    // should only be used to check the not-garanteed inputted data.
    // No need to be called while the inputted data is get from a cert, which is already checked.
    private func describe(): Unit {
        unsafe {
            ExceptionData.withException<Unit> {
                exception => describeImpl(blob.body, exception)
            }
        }
    }

    private static unsafe func describeImpl(
        body: Array<Byte>,
        exception: CPointer<ExceptionData>
    ): Unit {
        describeImpl(body, exception, CJX509DescribeDHParameters, "Failed to load DH Parameters")
    }
}

const PROC_TYPE_HEADER = "Proc-Type"
const DEK_INFO_HEADER = "DEK-Info"

class DerPrivateKeyImpl <: PrivateKey {
    private DerPrivateKeyImpl(
        let blob: DerBlob,
        private let description: String
    ) {}

    init(blob: DerBlob) {
        this(blob, describe(blob))
    }

    public func encodeToDer(): DerBlob {
        blob
    }

    public func encodeToDer(password!: ?String): DerBlob {
        match (password) {
            case Some(password) => unsafe { encryptImpl(blob, password) }
            case None => encodeToDer()
        }
    }

    public override func toString(): String {
        "PrivateKey(${blob.size} bytes, ${description})"
    }

    private static func describe(blob: DerBlob): String {
        var description = unsafe {
            ExceptionData.withException<?String> {
                exception => describeImpl(blob.body, exception)
            }
        }

        return description ?? throw X509Exception("Failed to load private key")
    }

    static func decodeFromDer(blob: DerBlob, password: ?String) {
        // since we don't have DER parser anymore, we can't check if't it's a PKCS8 or not
        // so an attempt to decode an encrypted key without password may fail somewhere
        // in the libcrypto internals: the error message will be not descriptive enough
        // we are trying to check for PEB2 PKCS8 in the native part of describe() to cover some likely cases
        match (password) {
            case Some(password) => decrypt(blob, password, None, None)
            case None => DerPrivateKeyImpl(blob)
        }
    }

    static func decodeFromPem(
        entry: PemEntry,
        password: ?String
    ): PrivateKey {
        let procType = entry.header(PROC_TYPE_HEADER).next()?.trimAscii()
        let dekInfo = entry.header(DEK_INFO_HEADER).next()
        let body = entry.body.getOrThrow()

        match ((procType, dekInfo)) {
            case (Some("4,ENCRYPTED"), Some(dekInfo)) =>
                let dekInfoComponents = dekInfo.trimAscii().split(",")
                if (dekInfoComponents.size != 2) {
                    throw X509Exception("Wrong DEK-Info header format")
                }
                let cipherName = dekInfoComponents[0]
                let iv = fromHexString(dekInfoComponents[1])
                let password = password ?? throwPasswordIsMissing()
                decrypt(body, password, iv, cipherName)
            case (Some(unsupportedProcType), _) => throw X509Exception("Unsupported Proc-Type = ${unsupportedProcType}")
            case (None, Some(_)) => throw X509Exception("DEK-Info requires Proc-Type header")
            case (None, None) =>
                if (isEncrypted(entry) && password.isNone()) {
                    throwPasswordIsMissing()
                }
                decodeFromDer(body, password)
        }
    }

    private static func throwPasswordIsMissing(): Nothing {
        throw X509Exception("The private key is encrypted but no password provided to decrypt it")
    }

    private static func decrypt(
        body: DerBlob,
        password: String,
        iv: ?Array<Byte>,
        cipherName: ?String
    ): DerPrivateKeyImpl {
        return unsafe {
            decryptImpl(body.body, password, iv, cipherName)
        }
    }

    private static unsafe func decryptImpl(
        body: Array<Byte>,
        password: String,
        iv: ?Array<Byte>,
        cipherName: ?String
    ): DerPrivateKeyImpl {
        if (password.contains(NULL_BYTE)) {
            throw X509Exception("Password shouldn't contain zero byte.")
        }
        if (password.isEmpty()) {
            throw X509Exception("Password shouldn't be empty.")
        }
        var decryptedBody: ?DerBlob = None
        var keyDescription: ?String = None
        try (passwordCStr = mallocCString(password), cipherCStr = mallocCString(cipherName), ivBuffer = mallocCopyOf(iv), resultBody = malloc<CPointer<Byte>>(
            initial: CPointer()), resultSize = malloc<UIntNative>(initial: 0), description = malloc<CPointer<Byte>>(
            initial: CPointer()), exception = malloc<ExceptionData>(initial: ExceptionData())) {
            var params = EncryptedKeyParams()
            params.password = passwordCStr.value
            params.cipherName = cipherCStr.value
            params.iv = ivBuffer.pointer
            params.ivLength = UIntNative(iv?.size ?? 0)
            let keySize = UIntNative(body.size) // we do it outside of acq-release
            let dynMsgPtr = MallocDynMsg()
            if (dynMsgPtr.isNull()) {
                throw X509Exception("malloc failed")
            }
            let keyBytes = acquireArrayRawData(body)
            let result = try {
                CJX509DecryptPrivateKey(
                    keyBytes.pointer,
                    keySize,
                    resultBody.pointer,
                    resultSize.pointer,
                    inout params,
                    description.pointer,
                    exception.pointer,
                    dynMsgPtr
                )
            } finally {
                releaseArrayRawData(keyBytes)
            }
            try {
                if (!dynMsgPtr.read().found) {
                    let funcName = CString(dynMsgPtr.read().funcName).toString()
                    throw X509Exception("Can not load openssl library or function ${funcName}.")
                }
            } finally {
                FreeDynMsg(dynMsgPtr)
            }
            try {
                if (result == CJ_FAIL) {
                    exception.value.throwException(fallback: "Failed to decrypt private key")
                }
                decryptedBody = resultBody.value.ifNotNull {ptr => DerBlob(toArray(ptr, resultSize.value))}
                keyDescription = description.value.ifNotNull {ptr => CString(ptr).toString()}
            } finally {
                CRYPTO_free(description.value)
                CRYPTO_free(resultBody.value)
                var data = exception.value
                data.clear()
                exception.value = data
            }
        }
        return DerPrivateKeyImpl(
            decryptedBody ?? throw X509Exception("Failed to decrypt private key"),
            keyDescription ?? ""
        )
    }

    private static unsafe func encryptImpl(
        input: DerBlob,
        password: String
    ): DerBlob {
        if (password.contains(NULL_BYTE)) {
            throw X509Exception("Password shouldn't contain zero byte.")
        }
        if (password.isEmpty()) {
            throw X509Exception("Password shouldn't be empty.")
        }
        var encryptedBody: ?DerBlob = None
        try (passwordCStr = LibC.mallocCString(password).asResource(), resultBody = malloc<CPointer<Byte>>(
            initial: CPointer()), resultSize = malloc<UIntNative>(initial: 0), exception = malloc<ExceptionData>(
            initial: ExceptionData())) {
            let keySize = UIntNative(input.size) // we do it outside of acq-release
            let keyBytes = acquireArrayRawData(input.body)
            let result = try {
                cjX509EncryptPrivateKey(
                    keyBytes.pointer,
                    keySize,
                    passwordCStr.value,
                    resultBody.pointer,
                    resultSize.pointer,
                    exception.pointer
                )
            } finally {
                releaseArrayRawData(keyBytes)
            }
            try {
                if (result == CJ_FAIL) {
                    exception.value.throwException(fallback: "Failed to encrypt private key")
                }
                encryptedBody = resultBody.value.ifNotNull {ptr => DerBlob(toArray(ptr, resultSize.value))}
            } finally {
                CRYPTO_free(resultBody.value)
                var data = exception.value
                data.clear()
                exception.value = data
            }
        }
        return encryptedBody ?? throw X509Exception("Failed to encrypt private key")
    }

    private static unsafe func describeImpl(
        body: Array<Byte>,
        exception: CPointer<ExceptionData>
    ): String {
        if (exception.isNull()) {
            throw X509Exception("Null pointer check failed.")
        }
        let keySize = UIntNative(body.size) // we do it outside of acq-release
        let keyBytes = acquireArrayRawData(body)
        let message = try {
            cjX509DescribePrivateKey(
                keyBytes.pointer,
                keySize,
                exception
            )
        } finally {
            releaseArrayRawData(keyBytes)
        }

        let messageString: ?String
        if (!message.isNull()) {
            try {
                messageString = CString(message).toString()
            } finally {
                CRYPTO_free(message)
            }
        } else {
            messageString = None
        }

        if (exception.read().hasException) {
            exception.read().throwException(fallback: "Failed to load private key")
        }

        return messageString ?? throw X509Exception("Failed to load private key")
    }
}

// see api.h for the native declaration
@C
struct EncryptedKeyParams {
    var password: CString = CString(CPointer()) // const char* password
    var iv: CPointer<Byte> = CPointer() // const unsigned char* iv
    var ivLength: UIntNative = 0 // size_t ivLength
    var cipherName: CString = CString(CPointer()) // const char* cipherName
}

foreign {
    func DYN_CJX509DescribePrivateKey(
        key: CPointer<Byte>,
        length: UIntNative,
        exception: CPointer<ExceptionData>,
        msg: CPointer<DynMsg>
    ): CPointer<Byte>

    func CJX509DescribePublicKey(
        key: CPointer<Byte>,
        length: UIntNative,
        exception: CPointer<ExceptionData>,
        msg: CPointer<DynMsg>
    ): Int32

    func CJX509DescribeDHParameters(
        key: CPointer<Byte>,
        length: UIntNative,
        exception: CPointer<ExceptionData>,
        msg: CPointer<DynMsg>
    ): Int32

    func CJX509DecryptPrivateKey(
        keyBody: CPointer<Byte>,
        length: UIntNative,
        resultBody: CPointer<CPointer<Byte>>,
        resultSize: CPointer<UIntNative>,
        password: CPointer<EncryptedKeyParams>,
        description: CPointer<CPointer<Byte>>,
        exception: CPointer<ExceptionData>,
        msg: CPointer<DynMsg>
    ): Int32

    func DYN_CJX509EncryptPrivateKey(
        keyBody: CPointer<Byte>,
        keySize: UIntNative,
        password: CString,
        resultBody: CPointer<CPointer<Byte>>,
        resultSize: CPointer<UIntNative>,
        exception: CPointer<ExceptionData>,
        msg: CPointer<DynMsg>
    ): Int32

    func DYN_CRYPTO_free(ptr: CPointer<Byte>, msg: CPointer<DynMsg>): Unit
}

func CRYPTO_free(ptr: CPointer<Byte>): Unit {
    unsafe {
        let dynMsgPtr = MallocDynMsg()
        if (dynMsgPtr.isNull()) {
            throw X509Exception("malloc failed")
        }
        DYN_CRYPTO_free(ptr, dynMsgPtr)
        try {
            if (!dynMsgPtr.read().found) {
                let funcName = CString(dynMsgPtr.read().funcName).toString()
                throw X509Exception("Can not load openssl library or function ${funcName}.")
            }
        } finally {
            FreeDynMsg(dynMsgPtr)
        }
    }
}

func cjX509EncryptPrivateKey(
    keyBody: CPointer<Byte>,
    keySize: UIntNative,
    password: CString,
    resultBody: CPointer<CPointer<Byte>>,
    resultSize: CPointer<UIntNative>,
    exception: CPointer<ExceptionData>
): Int32 {
    unsafe {
        let dynMsgPtr = MallocDynMsg()
        if (dynMsgPtr.isNull()) {
            throw X509Exception("malloc failed")
        }
        let res = DYN_CJX509EncryptPrivateKey(keyBody, keySize, password, resultBody, resultSize, exception, dynMsgPtr)
        try {
            if (!dynMsgPtr.read().found) {
                let funcName = CString(dynMsgPtr.read().funcName).toString()
                throw X509Exception("Can not load openssl library or function ${funcName}.")
            }
        } finally {
            FreeDynMsg(dynMsgPtr)
        }
        return res
    }
}

func cjX509DescribePrivateKey(
    key: CPointer<Byte>,
    length: UIntNative,
    exception: CPointer<ExceptionData>
): CPointer<Byte> {
    unsafe {
        let dynMsgPtr = MallocDynMsg()
        if (dynMsgPtr.isNull()) {
            throw X509Exception("malloc failed")
        }
        let res = DYN_CJX509DescribePrivateKey(key, length, exception, dynMsgPtr)
        try {
            if (!dynMsgPtr.read().found) {
                let funcName = CString(dynMsgPtr.read().funcName).toString()
                throw X509Exception("Can not load openssl library or function ${funcName}.")
            }
        } finally {
            FreeDynMsg(dynMsgPtr)
        }
        return res
    }
}