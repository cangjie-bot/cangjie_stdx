/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib

import std.fs.*

public class Position <: ToString {
    private let _line: Int64
    private let _column: Int64
    public init() {
        this._line = 0
        this._column = 0
    }
    public init(line: Int64, column: Int64) {
        this._line = line
        this._column = column
    }
    public prop line: Int64 {
        get() {
            return _line
        }
    }
    public prop column: Int64 {
        get() {
            return _column
        }
    }
    public func isValid(): Bool {
        return line > 0 && column > 0
    }
    public func toString(): String {
        return "-" + line.toString() + "-" + column.toString()
    }
}

public class DebugLocation <: ToString {
    private let _start: Position
    private let _end: Position
    private let _fileId: UInt64
    private let _filePath: Path
    private let _scopeInfo: ArrayList<Int64>
    public init() {
        this._start = Position()
        this._end = Position()
        this._fileId = 0
        this._filePath = Path("")
        this._scopeInfo = ArrayList<Int64>()
    }
    public init(start: Position, end: Position, fileId: UInt64, filePath: Path, scopeInfo: ArrayList<Int64>) {
        this._start = start
        this._end = end
        this._fileId = fileId;
        this._filePath = filePath;
        this._scopeInfo = scopeInfo;
    }
    public prop start: Position {
        get() {
            return _start
        }
    }
    public prop end: Position {
        get() {
            return _end
        }
    }
    public prop fileId: UInt64 {
        get() {
            return _fileId
        }
    }
    public prop filePath: Path {
        get() {
            return _filePath
        }
    }
    public prop scopeInfo: ArrayList<Int64> {
        get() {
            return _scopeInfo
        }
    }
    public func isValid(): Bool {
        return start.isValid() && end.isValid()
    }
    public func toString(): String {
        if (!isValid()) {
            return ""
        }
        var str = "loc: " + filePath.fileName + start.toString()
        if (scopeInfo.isEmpty()) {
            return str
        }
        str += ", scope: "
        for (info in scopeInfo) {
            str += info.toString() + "-"
        }
        str = str.removeSuffix("-")
        return str
    }
}