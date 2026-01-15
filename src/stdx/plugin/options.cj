/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package stdx.plugin

import std.collection.{ArrayList, HashMap}

public enum ArchType {
    | X86_64 | AARCH64 | ARM64 | ARM32 | Unknown
}

public enum OSType {
    | Windows | Linux | Darwin | IOS | Unknown
}

public enum Vendor {
    | PC | Apple | Unknown
}

public enum Environment {
    | OHOS | GNU | Android | Simulator | NotAvailable
}

public enum OptimizationLevel {
    | O0 | O1 | O2 | O3 | Os | Oz
}

public enum OutputMode {
    | Executable | StaticLib | SharedLib | CHIR
}

public enum MockMode {
    | On | Off | RuntimeError | Default
}

public enum SanitizerType {
    | None | Address | Thread | HwAddress
}

public class CompilerOptions {
    // Target triple
    public var arch: ArchType = ArchType.Unknown
    public var vendor: Vendor = Vendor.Unknown
    public var os: OSType = OSType.Unknown
    public var env: Environment = Environment.NotAvailable

    // Flags
    public var enableCompileTest: Bool = false
    public var enableCompileDebug: Bool = false
    public var strictNumberMode: Bool = false
    public var disableReflection: Bool = false
    public var enableCoverage: Bool = false
    public var experimentalMode: Bool = false

    // Enums
    public var optimizationLevel: OptimizationLevel = OptimizationLevel.O0
    public var outputMode: OutputMode = OutputMode.Executable
    public var mock: MockMode = MockMode.Default
    public var sanitizerType: SanitizerType = SanitizerType.None

    // Strings
    public var moduleName: String = ""
    public var moduleSrcPath: String = ""
    public var cangjieHome: String = ""
    public var output: String = ""

    // String arrays
    public var importPaths: Array<String> = []
    public var librarySearchPaths: Array<String> = []
    public var srcFiles: Array<String> = []

    // Conditional compilation map
    public var passedWhenKeyValue: HashMap<String, String> = HashMap<String, String>()
}

func readInt32(ptr: CPointer<UInt8>): (Int32, CPointer<UInt8>) {
    unsafe {
        let b0 = Int32(ptr.read())
        let b1 = Int32((ptr + 1).read())
        let b2 = Int32((ptr + 2).read())
        let b3 = Int32((ptr + 3).read())
        (b0 | (b1 << 8) | (b2 << 16) | (b3 << 24), ptr + 4)
    }
}

func readString(ptr: CPointer<UInt8>): (String, CPointer<UInt8>) {
    let (len, p) = readInt32(ptr)
    var result = ""
    var cur = p
    unsafe {
        for (_ in 0..len) {
            result += String(Rune(cur.read()))
            cur += 1
        }
    }
    (result, cur)
}

func readStringArray(ptr: CPointer<UInt8>): (Array<String>, CPointer<UInt8>) {
    let (count, p) = readInt32(ptr)
    var result = ArrayList<String>()
    var cur = p
    for (_ in 0..count) {
        let (s, next) = readString(cur)
        result.add(s)
        cur = next
    }
    (result.toArray(), cur)
}

func readStringMap(ptr: CPointer<UInt8>): (HashMap<String, String>, CPointer<UInt8>) {
    let (count, p) = readInt32(ptr)
    var result = HashMap<String, String>()
    var cur = p
    for (_ in 0..count) {
        let (k, p1) = readString(cur)
        let (v, p2) = readString(p1)
        result.add(k, v)
        cur = p2
    }
    (result, cur)
}

func deserialiseOptions(buffer: CPointer<UInt8>): CompilerOptions {
    let opts = CompilerOptions()
    unsafe {
        // Skip size prefix (4 bytes)
        var ptr = buffer + 4

        // Triple::Info target (4 bytes)
        opts.arch = match (ptr.read()) {
            case 0 => ArchType.X86_64
            case 1 => ArchType.AARCH64
            case 2 => ArchType.ARM64
            case 3 => ArchType.ARM32
            case _ => ArchType.Unknown
        }
        ptr += 1
        opts.vendor = match (ptr.read()) {
            case 0 => Vendor.PC
            case 1 => Vendor.Apple
            case _ => Vendor.Unknown
        }
        ptr += 1
        opts.os = match (ptr.read()) {
            case 0 => OSType.Windows
            case 1 => OSType.Linux
            case 2 => OSType.Darwin
            case 3 => OSType.IOS
            case _ => OSType.Unknown
        }
        ptr += 1
        opts.env = match (ptr.read()) {
            case 0 => Environment.OHOS
            case 1 => Environment.GNU
            case 2 => Environment.Android
            case 3 => Environment.Simulator
            case _ => Environment.NotAvailable
        }
        ptr += 1

        // Flags (1 byte bitfield)
        let flags = ptr.read()
        opts.enableCompileTest = (flags & 0x01) != 0
        opts.enableCompileDebug = (flags & 0x02) != 0
        opts.strictNumberMode = (flags & 0x04) != 0
        opts.disableReflection = (flags & 0x08) != 0
        opts.enableCoverage = (flags & 0x10) != 0
        opts.experimentalMode = (flags & 0x20) != 0
        ptr += 1

        // Enums (1 byte each)
        opts.optimizationLevel = match (ptr.read()) {
            case 0 => OptimizationLevel.O0
            case 1 => OptimizationLevel.O1
            case 2 => OptimizationLevel.O2
            case 3 => OptimizationLevel.O3
            case 4 => OptimizationLevel.Os
            case _ => OptimizationLevel.Oz
        }
        ptr += 1
        opts.outputMode = match (ptr.read()) {
            case 0 => OutputMode.Executable
            case 1 => OutputMode.StaticLib
            case 2 => OutputMode.SharedLib
            case _ => OutputMode.CHIR
        }
        ptr += 1
        opts.mock = match (ptr.read()) {
            case 0 => MockMode.On
            case 1 => MockMode.Off
            case 2 => MockMode.RuntimeError
            case _ => MockMode.Default
        }
        ptr += 1
        opts.sanitizerType = match (ptr.read()) {
            case 0 => SanitizerType.None
            case 1 => SanitizerType.Address
            case 2 => SanitizerType.Thread
            case _ => SanitizerType.HwAddress
        }
        ptr += 1

        // Strings
        let (moduleName, p1) = readString(ptr)
        opts.moduleName = moduleName
        let (moduleSrcPath, p2) = readString(p1)
        opts.moduleSrcPath = moduleSrcPath
        let (cangjieHome, p3) = readString(p2)
        opts.cangjieHome = cangjieHome
        let (output, p4) = readString(p3)
        opts.output = output

        // String vectors
        let (importPaths, p5) = readStringArray(p4)
        opts.importPaths = importPaths
        let (librarySearchPaths, p6) = readStringArray(p5)
        opts.librarySearchPaths = librarySearchPaths
        let (srcFiles, p7) = readStringArray(p6)
        opts.srcFiles = srcFiles

        // Conditional compilation map
        let (passedWhenKeyValue, _) = readStringMap(p7)
        opts.passedWhenKeyValue = passedWhenKeyValue
    }
    opts
}

var options: CompilerOptions = CompilerOptions()
public func getCompilerOptions(): CompilerOptions {
    options
}
