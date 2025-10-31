/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.pluginEntry

import stdx.CHIR.lib.*

internal func deserialize(root: CPointer<UInt8>, length: Int64): Package {
    if (root.isNull()) {
        throw Exception("root is null in deserialize")
    }
    let pkgBuf = Array<UInt8>(length, {x: Int64 => unsafe { root.read(x) }})
    let pkgFormat = PackageFormat_CHIRPackage(pkgBuf, 0)
    return deserializePackage(pkgFormat)
}

private func deserializePackage(pkgFormat: PackageFormat_CHIRPackage): Package {
    let accessLevel = deserializePackageAccessLevel(pkgFormat.GetPkgAccessLevel())
    let pkg = Package(pkgFormat.GetName(), accessLevel)
    return pkg
}

private func deserializePackageAccessLevel(accessLevel: PackageFormat_PackageAccessLevel): AccessLevel {
    return match (accessLevel) {
        case PackageFormat_PackageAccessLevel.PackageAccessLevel_INTERNAL => AccessLevel.INTERNAL
        case PackageFormat_PackageAccessLevel.PackageAccessLevel_PROTECTED => AccessLevel.PROTECTED
        case PackageFormat_PackageAccessLevel.PackageAccessLevel_PUBLIC => AccessLevel.PUBLIC
        case _ => throw Exception("invalid package access level")
    }
}

