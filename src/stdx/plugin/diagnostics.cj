/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package stdx.plugin

import std.collection.ArrayList
import std.sync.Mutex
import stdx.syntax.DiagnosticInfo

private let diagnostics = ArrayList<Diagnostic>()
private let mtx = Mutex()

private class Diagnostic {
    Diagnostic(let info: DiagnosticInfo, let filePath: String, let beginLine: Int32, let beginColumn: Int32, let endLine: Int32, let endColumn: Int32) {}
}

public func addDiagnostic(info: DiagnosticInfo, filePath: String, beginLine: Int32, beginColumn: Int32, endLine: Int32, endColumn: Int32): Unit {
    let d = Diagnostic(info, filePath, beginLine, beginColumn, endLine, endColumn)
    synchronized(mtx) {
        diagnostics.add(d)
    }
}

unsafe func writeInt(buffer: CPointer<UInt8>, value: Int32): CPointer<UInt8> {
    var ptr = buffer
    // write the four bytes one by one
    ptr.write(UInt8(value & 0xFF))
    ptr += 1
    ptr.write(UInt8((value >> 8) & 0xFF))
    ptr += 1
    ptr.write(UInt8((value >> 16) & 0xFF))
    ptr += 1
    ptr.write(UInt8((value >> 24) & 0xFF))
    ptr + 1
}
unsafe func writeString(buffer: CPointer<UInt8>, s: String): CPointer<UInt8> {
    var ptr = buffer
    let len = Int32(s.size)
    ptr = writeInt(ptr, len)
    for (c in s) {
        ptr.write(UInt8(c))
        ptr += 1
    }
    ptr
}

private func serialiseDiagnostic(buffer: CPointer<UInt8>, d: Diagnostic) {
    var ptr = buffer
    unsafe {
        match (d.info) {
            case Error(kind, msg) =>
                ptr.write(0)
                ptr += 1
                ptr = writeString(ptr, kind)
                ptr = writeString(ptr, msg)
            case Warning(kind, msg) =>
                ptr.write(1)
                ptr += 1
                ptr = writeString(ptr, kind)
                ptr = writeString(ptr, msg)
            case _ => throw Exception("Unknown diagnostic info")
        }
        ptr = writeString(ptr, d.filePath)
        ptr = writeInt(ptr, d.beginLine)
        ptr = writeInt(ptr, d.beginColumn)
        ptr = writeInt(ptr, d.endLine)
        ptr = writeInt(ptr, d.endColumn)
        ptr
    }
}

@C protected func getDiagnostics(): CPointer<UInt8> {
    // compute the size of all diagnostics
    var size: Int32 = 4 + Int32(diagnostics.size * 29) // 29: 1 Bool, 3 Int for String, 4 Int
    for (d in diagnostics) {
        match (d.info) {
            case Error(kind, msg) =>
                size += Int32(kind.size + msg.size)
            case Warning(kind, msg) =>
                size += Int32(kind.size + msg.size)
            case _ => throw Exception("Unknown diagnostic info")
        }
        size += Int32(d.filePath.size)
    }
    if (diagnostics.size == 0) {
        return CPointer<UInt8>()
    }
    unsafe {
        let buffer = LibC.malloc<UInt8>(count: Int64(size)) // to be freed by compiler
        var ptr = buffer
        ptr = writeInt(ptr, Int32(diagnostics.size))
        for (d in diagnostics) {
            ptr = serialiseDiagnostic(ptr, d)
        }
        buffer
    }
}
