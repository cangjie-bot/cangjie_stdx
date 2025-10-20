/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.chir
import std.collection.*

foreign func memcpy_s(dest: CPointer<UInt8>, destSize: UInt64, src: CPointer<UInt8>, count: UInt64): Int32

public class Package <: ToString {
    private var _types = ArrayList<Type>()
    private var _gvs = ArrayList<GlobalVar>()
    private var _exprs = ArrayList<Expression>()
    
    public prop types: ArrayList<Type> {
        get() { _types }
    }
    public prop gvs: ArrayList<GlobalVar> {
        get() { _gvs }
    }
    public prop exprs: ArrayList<Expression> {
        get() { _exprs }
    }

    private var _name: String
    public prop name: String {
        get() { _name }
        set(value) { _name = value }
    }

    public Package(name: String) {
        _name = name
    }

    public func serialize(): Memory {
        let p = PackageSerializer(this).build()
        p
    }

    public static func deserialize(mem: Memory): Package {
        let arr = Array<UInt8>(Int64(mem.size)) { _ => 0 }
        unsafe {
            memcpy_s(acquireArrayRawData(arr).pointer, UInt64(arr.size), mem.mem, UInt64(mem.size))
        }
        let pkg = PackageBuilder(PackageFormat_CHIRPackage(arr, 0)).build()
        pkg
    }

    public func processGlobalVar(fun: (GlobalVar) -> Unit) {
        for (v in gvs) {
            fun(v)
        }
    }

    public func toString(): String {
        let s = StringBuilder()
        s.append("package: ${name}\n")
        s.append("global vars:\n")
        for (v in gvs) {
            s.append("  ${v}\n")
        }
        s.toString()
    }
}

type FbId = UInt32
func unreachable(): Nothing {
    throw Exception("unreachable")
}

class PackageBuilder {
    PackageBuilder(let p: PackageFormat_CHIRPackage) {
        pkg = Package(p.GetName())
        primitiveTypes[4] = PrimitiveType(TypeKind.`Int64`)
        primitiveTypes[6] = PrimitiveType(TypeKind.`UInt8`)
        primitiveTypes[15] = PrimitiveType(TypeKind.`Bool`)
        unimplementedValue = IntLiteral("", primitiveTypes[6].getOrThrow(), 7)
    }

    let pkg: Package
    let types = HashMap<FbId, Type>()
    let values = HashMap<FbId, Value>()

    let primitiveTypes = Array<?PrimitiveType>(32) { _ => None }
    let unimplementedValue: IntLiteral

    func build(): Package {
        for (i in 0..p.GetTypesSize()) {
            deserializeType(UInt32(i))
        }
        for (i in 0..p.GetValuesSize()) {
            deserializeValue(UInt32(i))
        }
        pkg
    }

    func deserializeValue(i: FbId): Value {
        if (let Some(v) <- values.get(i)) {
            v
        } else {
            let v = toValue(i)
            values[i] = v
            if (let gv: GlobalVar <- v && let Some(`init`) <- gv.initializer && let ref: RefType <- gv.`type` &&
                let pm: PrimitiveType <- ref.base && pm.kind == TypeKind.`Int64`) {
                pkg.gvs.add(gv)
            }
            v
        }
    }

    func toValue(i: FbId): Value {
        if (let Some(v) <- p.GetValuesAsGlobalVar(i)) {
            toValue(v)
        } else if (let Some(v) <- p.GetValuesAsIntLiteral(i)) {
            toValue(v)
        } else {
            unimplementedValue
        }
    }

    func toValue(v: PackageFormat_GlobalVar): Value {
        let baseInfo = v.GetBase().getOrThrow()
        let name = baseInfo.GetIdentifier()
        let `type` = deserializeType(baseInfo.GetType() - 1)
        let gv = GlobalVar(name, `type`)
        gv.initializer = if (v.GetDefaultInitVal() != 0) {
            let intVal = deserializeValue(v.GetDefaultInitVal() - 1)
            let ce = ConstantExpr()
            ce.value = intVal
            ce.`type` = intVal.`type`
            Some(ce)
        } else { None }
        gv
    }

    func toValue(v: PackageFormat_IntLiteral): Value {
        let valueInfo = v.GetBase().getOrThrow().GetBase().getOrThrow()
        let r = IntLiteral(valueInfo.GetIdentifier(), deserializeType(valueInfo.GetType() - 1), v.GetVal())
        r
    }

    func deserializeType(i: FbId): Type {
        if (let Some(t) <- types.get(i)) {
            t
        } else {
            let t = toType(i)
            types[i] = t
            if (!refEq(t, InvalidType.instance)) {
                pkg.types.add(t)
            }
            t
        }
    }

    func toType(i: FbId): Type {
        if (let Some(v) <- p.GetTypesAsIntType(i)) {
            toType(v)
        } else if (let Some(v) <- p.GetTypesAsRefType(i)) {
            toType(v)
        } else {
            InvalidType.instance
        }
    }

    func toType(t: PackageFormat_IntType): Type {
        if (let Some(pt) <- t.GetBase()) {
            toType(pt)
        } else {
            unreachable()
        }
    }

    func toType(ty: PackageFormat_NumericType): Type {
        if (let Some(pt) <- ty.GetBase()) {
            match (pt.GetKind()) {
                case CHIRTypeKind_INT64 |
                    CHIRTypeKind_UINT8 |
                    CHIRTypeKind_BOOLEAN => getPrimitiveType(pt.GetKind())
                case _ => InvalidType.instance
            }
        } else {
            unreachable()
        }
    }

    func toType(ty: PackageFormat_RefType): Type {
        let baseTy = deserializeType(ty.GetBase().getOrThrow().GetArgTys()[0] - 1)
        let dims = ty.GetBase().getOrThrow().GetRefDims()
        return RefType(baseTy, dims)
    }

    func getPrimitiveType(t: PackageFormat_CHIRTypeKind): Type {
        if (let Some(ty) <- primitiveTypes[Int64(toInt(t))]) {
            ty
        } else {
            throw Exception("primitive kind ${toInt(t)} not implemented")
        }
    }
}

func toInt(ty: PackageFormat_CHIRTypeKind): UInt8 {
    match (ty) {
        case CHIRTypeKind_INVALID => 0
        case CHIRTypeKind_INT64 => 4
        case CHIRTypeKind_UINT8 => 6
        case CHIRTypeKind_BOOLEAN => 15
        case CHIRTypeKind_REFTYPE => 29
        case _ => 0
    }
}

class PackageSerializer {
    PackageSerializer(private let pkg: Package) {
    }

    func build(): Memory {
        let s = pkg.toString()
        unsafe {
            let mem = LibC.mallocCString(s)
            Memory(mem.getChars(), UInt64(s.size) + 1)
        }
    }
}