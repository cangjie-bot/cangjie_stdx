/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib

internal import std.collection.*

const GLOBAL_VAL_PREFIX = "@"
let g_invalidType = InvalidType()

public enum AccessLevel {
    INTERNAL | PROTECTED | PUBLIC
}

public class Package <: ToString {
    private let _name: String
    private let _accessLevel: AccessLevel
    private var _packageInitFunc: ?Function = None
    private var _packageLiteralInitFunc: ?Function = None

    private var _importedVars = ArrayList<GlobalVar>()
    private var _importedFuncs = ArrayList<Function>()
    private var _importedClasses = ArrayList<ClassDef>()
    private var _importedEnums = ArrayList<EnumDef>()
    private var _importedStructs = ArrayList<StructDef>()
    private var _importedExtends = ArrayList<ExtendDef>()

    private var _globalVars = ArrayList<GlobalVar>()
    private var _globalFuncs = ArrayList<Function>()
    private var _classes = ArrayList<ClassDef>()
    private var _enums = ArrayList<EnumDef>()
    private var _structs = ArrayList<StructDef>()
    private var _extends = ArrayList<ExtendDef>()

    // ----------------------- Public API -----------------------
    protected mut prop packageInitFunc: ?Function {
        get() {
            return _packageInitFunc
        }
        set(value) {
            _packageInitFunc = value
        }
    }
    protected mut prop packageLiteralInitFunc: ?Function {
        get() {
            return _packageLiteralInitFunc
        }
        set(value) {
            _packageLiteralInitFunc = value
        }
    }
    
    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public prop name: String {
        get() {
            return _name
        }
    }

    public prop accessLevel: AccessLevel {
        get() {
            return _accessLevel
        }
    }

    public prop importedVars: ArrayList<GlobalVar> {
        get() {
            return _importedVars
        }
    }

    public prop importedFuncs: ArrayList<Function> {
        get() {
            return _importedFuncs
        }
    }

    public prop importedClasses: ArrayList<ClassDef> {
        get() {
            return _importedClasses
        }
    }

    public prop importedEnums: ArrayList<EnumDef> {
        get() {
            return _importedEnums
        }
    }

    public prop importedStructs: ArrayList<StructDef> {
        get() {
            return _importedStructs
        }
    }

    public prop importedExtends: ArrayList<ExtendDef> {
        get() {
            return _importedExtends
        }
    }

    public prop globalVars: ArrayList<GlobalVar> {
        get() {
            return _globalVars
        }
    }

    public prop globalFuncs: ArrayList<Function> {
        get() {
            return _globalFuncs
        }
    }

    public prop classes: ArrayList<ClassDef> {
        get() {
            return _classes
        }
    }

    public prop enums: ArrayList<EnumDef> {
        get() {
            return _enums
        }
    }

    public prop structs: ArrayList<StructDef> {
        get() {
            return _structs
        }
    }

    public prop extends: ArrayList<ExtendDef> {
        get() {
            return _extends
        }
    }

    // ----------------------- Internal API -----------------------
    public init(name: String, accessLevel: AccessLevel) {
        this._name = name
        this._accessLevel = accessLevel
    }

    internal func addImportedVar(v: GlobalVar) {
        _importedVars.add(v)
    }

    internal func addImportedFunc(f: Function) {
        _importedFuncs.add(f)
    }

    internal func addImportedClass(def: ClassDef) {
        _importedClasses.add(def)
    }

    internal func addImportedEnum(def: EnumDef) {
        _importedEnums.add(def)
    }

    internal func addImportedStruct(def: StructDef) {
        _importedStructs.add(def)
    }

    internal func addImportedExtend(def: ExtendDef) {
        _importedExtends.add(def)
    }

    internal func addGlobalVar(v: GlobalVar) {
        _globalVars.add(v)
    }

    internal func addGlobalFunc(f: Function) {
        _globalFuncs.add(f)
    }

    internal func addClass(def: ClassDef) {
        _classes.add(def)
    }

    internal func addEnum(def: EnumDef) {
        _enums.add(def)
    }

    internal func addStruct(def: StructDef) {
        _structs.add(def)
    }

    internal func addExtend(def: ExtendDef) {
        _extends.add(def)
    }
}
