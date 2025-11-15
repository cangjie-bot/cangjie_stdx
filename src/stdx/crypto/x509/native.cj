/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

const CJ_FAIL: Int32 = -1
const CJ_NEED_READ: Int32 = -2
const CJ_NEED_WRITE: Int32 = -3
const CJ_OK: Int32 = 1

@C
struct Ssl {}

@C
struct Ctx {}

@C
struct ExceptionData {
    var message: CPointer<Byte> = CPointer() // this is always allocated using malloc
    var constMessage: CPointer<Byte> = CPointer() // this is never allocated

    prop hasException: Bool {
        get() {
            !message.isNull() || !constMessage.isNull()
        }
    }

    func throwException(fallback!: String): Nothing {
        if (!message.isNull()) {
            throw X509Exception(CString(message).toString())
        }
        if (!constMessage.isNull()) {
            throw X509Exception(CString(constMessage).toString())
        }

        throw X509Exception(fallback)
    }

    mut func clear(): Unit {
        if (!message.isNull()) {
            unsafe { CRYPTO_free(message) }
            message = CPointer()
        }
    }

    static func create(): CPointer<ExceptionData> {
        unsafe {
            let ptr = LibC.malloc<ExceptionData>(count: 1)
            if (ptr.isNull()) {
                throw X509Exception("malloc failed")
            }
            ptr.write(ExceptionData())
            return ptr
        }
    }

    static func free(exception: CPointer<ExceptionData>): Unit {
        unsafe {
            if (exception.isNull()) {
                return
            }

            var data = exception.read()
            data.clear()
            LibC.free(exception)
        }
    }

    static func withException<R>(block: (CPointer<ExceptionData>) -> R): R {
        let exception = ExceptionData.create()
        try {
            block(exception)
        } finally {
            ExceptionData.free(exception)
        }
    }
}

foreign func memcpy_s(dest: CPointer<UInt8>, destMax: UIntNative, src: CPointer<UInt8>, count: UIntNative): Int32