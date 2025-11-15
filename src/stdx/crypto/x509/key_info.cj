/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.crypto.x509

class CertPublicKey <: PublicKey {
    CertPublicKey(private let blob: X509Blob) {}

    public override func encodeToDer(): DerBlob {
        blob.publicKey.blob
    }

    public override func toString(): String {
        "PublicKey(for ${blob.subject})"
    }
}

class CertRequestPublicKey <: PublicKey {
    CertRequestPublicKey(private let blob: X509CsrBlob) {}

    public override func encodeToDer(): DerBlob {
        blob.publicKey.blob
    }

    public override func toString(): String {
        "PublicKey(for ${blob.subject})"
    }
}

public enum PublicKeyAlgorithm <: Equatable<PublicKeyAlgorithm> & ToString {
    RSA | DSA | ECDSA | UnknownPublicKeyAlgorithm

    public override operator func ==(other: PublicKeyAlgorithm): Bool {
        this.toString() == other.toString()
    }

    public override operator func !=(other: PublicKeyAlgorithm): Bool {
        !(this == other)
    }

    public override func toString(): String {
        var res: String = "Public Key Algorithm: "
        match (this) {
            case RSA => res = res + "rsaEncryption"
            case DSA => res = res + "dsaEncryption"
            case ECDSA => res = res + "id-ecPublicKey"
            case UnknownPublicKeyAlgorithm => res = res + "unknown public key algorithm"
        }
        res
    }
}
