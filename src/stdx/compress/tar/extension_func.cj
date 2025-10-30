/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.io.{InputStream, OutputStream}
import std.fs.{Directory, Path, FileInfo}
import std.deriving.Derive

extend Array<UInt8> {
    func isAllZero() {
        for (i in this) {
            if (i != 0) {
                return false
            }
        }
        return true
    }
}

func readExactly(stream: InputStream, buffer: Array<UInt8>): Unit {
    var start = 0
    var num = 0
    while (num < buffer.size) {
        num = stream.read(buffer.slice(start, buffer.size - start))
        if (num == 0) {
            throw TarException("End of stream reached before tar header was exactly read.")
        }
        start += num
    }
}

func skip(archiveStream: InputStream, skipSize: Int64): Unit {
    readExactly(archiveStream, Array<UInt8>(skipSize, repeat: 0))
}

func writeZeros(stream: OutputStream, size: Int64): Unit {
    if (size <= 0) {
        return
    }
    stream.write(Array<UInt8>(size, repeat: 0))
}

extend String {
    func trimZero(): String { this.trimStart('\0').trimEnd('\0') }

    func normalizePath(): String {
        Path(this).normalize().toString().replace('\\', '/').trimZero()
    }
}

extend Path {
    func normalizePath(): String {
        this.normalize().toString().replace('\\', '/').trimZero()
    }
}

@Derive[Equatable]
enum TargetType {
    File | Directory | Symlink
}

extend Directory {
    static func walkRecursively(path: Path, f: (FileInfo, TargetType) -> Unit): Unit {
        Directory.walk(path) { info =>
            match {
                case info.isDirectory() =>
                    f(info, TargetType.Directory)
                    Directory.walkRecursively(info.path, f)
                case info.isSymbolicLink() =>
                    f(info, TargetType.Symlink)
                case info.isRegular() =>
                    f(info, TargetType.File)
                case _ => ()
            }
            true
        }
    }
}
