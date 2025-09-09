/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.logger

import std.collection.ArrayList
import std.io.OutputStream
import std.sync.AtomicBool
import stdx.log.*
import std.time.DateTime

foreign {
    func OH_LOG_IsLoggable(domain: UInt32, tag: CString, level: Int32): Bool
    func OH_LOG_Print(`type`: Int32, level: Int32, domain: UInt32, tag: CString, fmt: CString, msg: CString): Int32
}

let tag = unsafe { LibC.mallocCString("Cangjie-Log") }
let fmt = unsafe { LibC.mallocCString("%{public}s") }
const DOMAIN = 0xD003901u32
const APP_TYPE = 0i32

func doHilog(level: LogLevel, msg: Array<Byte>): Unit {
    let logLevel = convertLevel(level)
    if (logLevel <= 0) {
        return
    }
    unsafe {
        if (OH_LOG_IsLoggable(APP_TYPE, tag, logLevel)) {
            let handle = unsafe { acquireArrayRawData<Byte>(msg) }
            OH_LOG_Print(APP_TYPE, logLevel, DOMAIN, tag, fmt, CString(handle.pointer))
            releaseArrayRawData<Byte>(handle)
        }
    }
}

// hilog log level:
// LOG_DEBUG = 3
// LOG_INFO = 4
// LOG_WARN = 5
// LOG_ERROR = 6
// LOG_FATAL = 7
func convertLevel(level: LogLevel): Int32 {
    match {
        case level == LogLevel.FaTAL => 7
        case level == LogLevel.ERROR => 6
        case level == LogLevel.WARN => 5
        case level == LogLevel.INFO => 4
        case level == LogLevel.DEBUG => 3
        case level == LogLevel.TRACE => 3
        case level == LogLevel.ALL => 3
        case level == LogLevel.OFF => 0
        case _ => 3
    }
}

enum LogStyle {
    | SIMPLE
    | TEXT
    | JSON
}

class CommonLogger <: Logger {
    let _attrs = ArrayList<Attr>()
    var _level = LogLevel.INFO
    let _mode: LogStyle
    let o: OutputStream

    let _closed = AtomicBool(false)

    init(output: OutputStream, mode: LogStyle) {
        o = output
        _mode = mode
    }

    public mut prop level: LogLevel {
        get() {
            _level
        }
        set(v) {
            _level = v
        }
    }

    public func withAttrs(attrs: Array<Attr>): CommonLogger {
        if (attrs.size > 0) {
            let nl = this.clone()
            nl._attrs.add(all: attrs)
            return nl
        }
        return this
    }

    public func log(record: LogRecord): Unit {
        let _as = this._attrs.clone()
        _as.add(all: record.attrs)
        record.attrs = unsafe { _as.getRawArray() }
        match (_mode) {
            case LogStyle.SIMPLE => logSimple(record, o)
            case LogStyle.TEXT => logText(record, o)
            case LogStyle.JSON => logJson(record, o)
        }

        let sb = StringBuilder(record.message)
        let lw = StringLogWriter(sb)
        // write attrs
        for(i in 0..record.attrs.size) {
            let (key, value) = record.attrs[i]
            lw.writeKey(key)
            lw.writeValue(value)
        }
        doHilog(record.level, unsafe { lw.finish().rawData() })
    }

    public func isClosed(): Bool {
        _closed.load()
    }

    public func close(): Unit {
        if (isClosed()) {
            return
        }
        if (_closed.compareAndSwap(false, true)) {
            o.flush()
        }
    }
    
    func clone(): CommonLogger {
        let cl = CommonLogger(o, _mode)
        cl.level = this.level
        cl._attrs.add(all: this._attrs)
        return cl
    }
}

func writeLogRecordKeyValue(lw: LogWriter, record: LogRecord) {
    // write time
    lw.writeKey("time")
    lw.writeValue(record.time)
    // write level
    lw.writeKey("level")
    lw.writeValue(record.level.toString())
    // write message
    lw.writeKey("msg")
    lw.writeValue(record.message)
    // write source

    // write attrs
    for (i in 0..record.attrs.size) {
        let (key, value) = record.attrs[i]
        lw.writeKey(key)
        lw.writeValue(value)
    }
}

func logSimple(record: LogRecord, output: OutputStream): Unit {
    let tw: TextLogWriter = TextLogWriter(output)
    tw.start()
    // write time
    tw.writeMessage(record.time.toString())
    tw.writeMessage(' ')
    // write level
    tw.writeMessage(record.level.toString())
    tw.writeMessage(' ')
    // write message
    tw.writeMessage(record.message)
    tw.writeMessage(' ')
    // write source

    // write attrs
    for (i in 0..record.attrs.size) {
        let (key, value) = record.attrs[i]
        tw.writeKey(key)
        tw.writeValue(value)
    }
    tw.end()
    tw.flush()
}

func logText(record: LogRecord, output: OutputStream): Unit {
    let tw: TextLogWriter = TextLogWriter(output)
    tw.start()
    writeLogRecordKeyValue(tw, record)
    tw.end()
    tw.flush()
}

func logJson(record: LogRecord, output: OutputStream): Unit {
    let w: JsonLogWriter = JsonLogWriter(output)
    w.startObject()
    writeLogRecordKeyValue(w, record)
    w.endObject()
    w.flush()
}

class StringLogWriter <: LogWriter {
    let out: StringBuilder
    init(out: StringBuilder) {
        this.out = out
    }

    public func writeNone(): Unit {
        out.append("None")
    }

    public func writeInt(v: Int64): Unit {
        out.append(v)
    }

    public func writeBool(v: Bool): Unit {
        out.append(v)
    }

    public func writeFloat(v: Float64): Unit {
        out.append(v)
    }

    public func writeString(v: String): Unit {
        out.append(b'"')
        out.append(v)
        out.append(b'"')
    }

    public func writeDateTime(v: DateTime): Unit {
        out.append(v)
    }

    public func writeDuration(v: Duration): Unit {
        out.append(v)
    }

    public func write(v: Exception): Unit {
        out.append(v)
    }

    public func writeKey(v: String): Unit {
        out.append(b' ')
        out.append(b'[')
        out.append(v)
        out.append(b']')
        out.append(b'=')
    }

    public func writeValue(lv: LogValue): Unit {
        lv.writeTo(this)
    }

    public func startArray(): Unit {}
    public func endArray(): Unit {}
    public func startObject(): Unit {}
    public func endObject(): Unit {}

    func finish(): String {
        out.toString()
    }

}