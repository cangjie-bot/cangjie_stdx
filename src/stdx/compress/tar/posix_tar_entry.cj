/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.compress.tar

import std.io.{InputStream, OutputStream}
import std.fs.Path

public abstract class PosixTarEntry <: TarEntry {
    public prop userName: String {
        get() { _header.uName }
    }

    public prop groupName: String {
        get() { _header.gName }
    }

    public prop deviceMajor: Int32 {
        get() { _header.devMajor }
    }

    public prop deviceMinor: Int32 {
        get() { _header.devMinor }
    }

    init(header: TarHeader) {
        super(header)
    }

    init(header: TarHeader, stream: ?InputStream) {
        super(header, stream)
    }

    protected init(filePath: String) {
        this(Path(filePath))
    }

    protected init(filePath: Path) {
        super(filePath)

        _header.uName = Native.getUserName(filePath)
        _header.gName = Native.getGroupName(filePath)
        _header.devMajor = Native.getDeviceMajor(filePath)
        _header.devMinor = Native.getDeviceMinor(filePath)
    }

    func writePosixFields(buffer: TarHeaderBuffer, magic: String, version: String) {
        magic.encodeTo(buffer[FieldLocation.MAGIC])
        version.encodeTo(buffer[FieldLocation.VERSION])

        _header.uName.encodeTo(buffer[FieldLocation.U_NAME])
        _header.gName.encodeTo(buffer[FieldLocation.G_NAME])

        const DEV_MAJOR_MINOR_MAX: Int32 = 0o77777777
        if (_header.devMajor > DEV_MAJOR_MINOR_MAX) {
            throw TarException("DeviceMajor ${_header.devMajor} is too large.")
        }
        if (_header.devMajor < 0) {
            throw TarException("DeviceMajor ${_header.devMajor} is negative.")
        }
        _header.devMajor.encodeOcatalTo(buffer[FieldLocation.DEV_MAJOR])
        if (_header.devMinor > DEV_MAJOR_MINOR_MAX) {
            throw TarException("DeviceMinor ${_header.devMinor} is too large.")
        }
        if (_header.devMinor < 0) {
            throw TarException("DeviceMinor ${_header.devMinor} is negative.")
        }
        _header.devMinor.encodeOcatalTo(buffer[FieldLocation.DEV_MINOR])
    }
}
