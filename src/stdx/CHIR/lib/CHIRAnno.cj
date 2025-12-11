/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib
import std.deriving.*

@Derive[Equatable]
protected enum LinkType <: ToString {
    EXTERNAL | INTERNAL | WEAK_ODR | LINKONCE_ODR | EXTERNAL_WEAK

    public func toString(): String {
        match (this) {
            case EXTERNAL => "external"
            case INTERNAL => "internal"
            case WEAK_ODR => "weak_odr"
            case LINKONCE_ODR => "linkonce_odr"
            case EXTERNAL_WEAK => "external_weak"
        }
    }
}

protected interface CHIRAnno {
    func get(): Any
    func set(value: Any): Unit
    func toString(): String
    static func defaultValue(): Any
    static func create(value: Any): CHIRAnno
}

protected class GenerateFromForIn <: CHIRAnno {
    private var v: Bool
    protected init(value: Bool) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = (value as Bool).getOrThrow()
    }
    public func toString(): String {
        return "generated-from-forin"
    }
    static public func defaultValue(): Any {
        return false
    }
    static public func create(value: Any): CHIRAnno {
        return GenerateFromForIn((value as Bool).getOrThrow())
    }
}

protected class AnnoFactoryInfo <: CHIRAnno {
    private var v: ArrayList<GlobalVar>
    protected init(value: ArrayList<GlobalVar>) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = (value as ArrayList<GlobalVar>).getOrThrow()
    }
    public func toString(): String {
        if (v.isEmpty()) {
            return ""
        }
        var str = "annoGVs: "
        for (gv in v) {
            str += gv.toString() + ", "
        }
        str = str.removeSuffix(", ")
        return str
    }
    static public func defaultValue(): Any {
        return ArrayList<GlobalVar>()
    }
    static public func create(value: Any): CHIRAnno {
        return AnnoFactoryInfo((value as ArrayList<GlobalVar>).getOrThrow())
    }
}

protected class NeedCheckArrayBound <: CHIRAnno {
    private var v: Bool
    protected init(value: Bool) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = (value as Bool).getOrThrow()
    }
    public func toString(): String {
        return "checkArrayBound: " + v.toString()
    }
    static public func defaultValue(): Any {
        return false
    }
    static public func create(value: Any): CHIRAnno {
        return NeedCheckArrayBound((value as Bool).getOrThrow())
    }
}

protected class NeedCheckCast <: CHIRAnno {
    private var v: Bool
    protected init(value: Bool) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = (value as Bool).getOrThrow()
    }
    public func toString(): String {
        return "checkTypeCast: " + v.toString()
    }
    static public func defaultValue(): Any {
        return false
    }
    static public func create(value: Any): CHIRAnno {
        return NeedCheckCast((value as Bool).getOrThrow())
    }
}

protected class DebugLocationInfoForWarning <: CHIRAnno {
    private var v: DebugLocation
    protected init(value: DebugLocation) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = (value as DebugLocation).getOrThrow()
    }
    public func toString(): String {
        return "warning loc: " + v.toString()
    }
    static public func defaultValue(): Any {
        return DebugLocation()
    }
    static public func create(value: Any): CHIRAnno {
        return DebugLocationInfoForWarning((value as DebugLocation).getOrThrow())
    }
}

protected class LinkTypeInfo <: CHIRAnno {
    private var v: LinkType
    protected init(value: LinkType) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = (value as LinkType).getOrThrow()
    }
    public func toString(): String {
        return "linkType: " + v.toString()
    }
    static public func defaultValue(): Any {
        return LinkType.EXTERNAL
    }
    static public func create(value: Any): CHIRAnno {
        return LinkTypeInfo((value as LinkType).getOrThrow())
    }
}

protected class WrappedRawMethod <: CHIRAnno {
    private var v: ?Function
    protected init(value: Function) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = value as Function
    }
    public func toString(): String {
        return "WrappedRawMethod: " + v.getOrThrow().toString()
    }
    static public func defaultValue(): Any {
        return Option<Function>.None
    }
    static public func create(value: Any): CHIRAnno {
        return WrappedRawMethod((value as Function).getOrThrow())
    }
}

protected enum SkipKind <: ToString {
    NO_SKIP | SKIP_DCE_WARNING | SKIP_FORIN_EXIT | SKIP_VIC
    public func toString(): String {
        match (this) {
            case NO_SKIP => ""
            case SKIP_DCE_WARNING => "skip: dce warning"
            case SKIP_FORIN_EXIT => "skip: for-in exit"
            case SKIP_VIC => "skip: vic"
        }
    }
}

protected class SkipCheck <: CHIRAnno {
    private var v: SkipKind
    protected init(value: SkipKind) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = (value as SkipKind).getOrThrow()
    }
    public func toString(): String {
        return v.toString()
    }
    static public func defaultValue(): Any {
        return SkipKind.NO_SKIP
    }
    static public func create(value: Any): CHIRAnno {
        return SkipCheck((value as SkipKind).getOrThrow())
    }
}

protected class NeverOverflowInfo <: CHIRAnno {
    private var v: Bool
    protected init(value: Bool) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = (value as Bool).getOrThrow()
    }
    public func toString(): String {
        return "NeverOverflowInfo: " + v.toString()
    }
    static public func defaultValue(): Any {
        return false
    }
    static public func create(value: Any): CHIRAnno {
        return NeverOverflowInfo((value as Bool).getOrThrow())
    }
}

protected class GeneratedFromForIn <: CHIRAnno {
    private var v: Bool
    protected init(value: Bool) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = (value as Bool).getOrThrow()
    }
    public func toString(): String {
        return "GeneratedFromForIn: " + v.toString()
    }
    static public func defaultValue(): Any {
        return false
    }
    static public func create(value: Any): CHIRAnno {
        return GeneratedFromForIn((value as Bool).getOrThrow())
    }
}

protected class IsAutoEnvClass <: CHIRAnno {
    private var v: Bool
    protected init(value: Bool) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = (value as Bool).getOrThrow()
    }
    public func toString(): String {
        return "IsAutoEnvClass: " + v.toString()
    }
    static public func defaultValue(): Any {
        return false
    }
    static public func create(value: Any): CHIRAnno {
        return IsAutoEnvClass((value as Bool).getOrThrow())
    }
}

protected class IsCapturedClassInCC <: CHIRAnno {
    private var v: Bool
    protected init(value: Bool) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = (value as Bool).getOrThrow()
    }
    public func toString(): String {
        return "IsCapturedClassInCC: " + v.toString()
    }
    static public func defaultValue(): Any {
        return false
    }
    static public func create(value: Any): CHIRAnno {
        return IsCapturedClassInCC((value as Bool).getOrThrow())
    }
}

protected class EnumCaseIndex <: CHIRAnno {
    private var v: ?UInt64
    protected init(value: UInt64) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = value as UInt64
    }
    public func toString(): String {
        return "EnumCaseIndex: " + v.toString()
    }
    static public func defaultValue(): Any {
        return Option<UInt64>.None
    }
    static public func create(value: Any): CHIRAnno {
        return EnumCaseIndex((value as UInt64).getOrThrow())
    }
}

protected class VirMethodOffset <: CHIRAnno {
    private var v: ?UInt64
    protected init(value: UInt64) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = value as UInt64
    }
    public func toString(): String {
        return "VirMethodOffset: " + v.toString()
    }
    static public func defaultValue(): Any {
        return Option<UInt64>.None
    }
    static public func create(value: Any): CHIRAnno {
        return VirMethodOffset((value as UInt64).getOrThrow())
    }
}

protected class OverrideSrcFuncType <: CHIRAnno {
    private var v: ?FuncType
    protected init(value: FuncType) {
        this.v = value
    }
    public func get(): Any {
        return v
    }
    public func set(value: Any): Unit {
        this.v = value as FuncType
    }
    public func toString(): String {
        return "OverrideSrcFuncType: " + v.getOrThrow().toString()
    }
    static public func defaultValue(): Any {
        return Option<FuncType>.None
    }
    static public func create(value: Any): CHIRAnno {
        return OverrideSrcFuncType((value as FuncType).getOrThrow())
    }
}