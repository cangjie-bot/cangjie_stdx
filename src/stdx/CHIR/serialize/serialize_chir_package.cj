/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.serialize

import stdx.CHIR.lib.*

let builder = Builder(0)

public func serialize(pkg: Package): (CPointer<UInt8>, Int64) {
    builder.reset()
    return serializePackage(builder, pkg)
}

@C
public func freeSerializedMemory(): Unit {
    builder.reset()
}

private func serializePackage(builder: Builder, pkg: Package): (CPointer<UInt8>, Int64) {
    let name = builder.createString(pkg.name)
    PackageFormat_CHIRPackage.startCHIRPackage(builder)
    let pkgAccessLevel = serializePackageAccessLevel(pkg.accessLevel)
    PackageFormat_CHIRPackage.addName(name, builder)
    PackageFormat_CHIRPackage.addPkgAccessLevel(pkgAccessLevel, builder)
    let rootTable = PackageFormat_CHIRPackage.endCHIRPackage(builder)
    builder.finish(rootTable)
    let data = unsafe { acquireArrayRawData<UInt8>(builder.finishedBytes()) }
    return (data.pointer, data.array.size)
}

private func serializePackageAccessLevel(accessLevel: AccessLevel): PackageFormat_PackageAccessLevel {
    return match (accessLevel) {
        case AccessLevel.INTERNAL => PackageFormat_PackageAccessLevel.PackageAccessLevel_INTERNAL
        case AccessLevel.PROTECTED => PackageFormat_PackageAccessLevel.PackageAccessLevel_PROTECTED
        case AccessLevel.PUBLIC => PackageFormat_PackageAccessLevel.PackageAccessLevel_PUBLIC
    }
}