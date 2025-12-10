/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib

public class CHIRBuilder {
    private let curPkg: Package
    private let boolTy = BoolType()
    private let int8Ty = IntType(TypeKind.INT8)
    private let int16Ty = IntType(TypeKind.INT16)
    private let int32Ty = IntType(TypeKind.INT32)
    private let int64Ty = IntType(TypeKind.INT64)
    private let intNativeTy = IntType(TypeKind.INT_NATIVE)
    private let uint8Ty = IntType(TypeKind.UINT8)
    private let uint16Ty = IntType(TypeKind.UINT16)
    private let uint32Ty = IntType(TypeKind.UINT32)
    private let uint64Ty = IntType(TypeKind.UINT64)
    private let uintNativeTy = IntType(TypeKind.UINT_NATIVE)
    private let float16Ty = FloatType(TypeKind.FLOAT16)
    private let float32Ty = FloatType(TypeKind.FLOAT32)
    private let float64Ty = FloatType(TypeKind.FLOAT64)
    private let cstringTy = CStringType()
    private let unitTy = UnitType()
    private let nothingTy = NothingType()
    private let runeTy = RuneType()
    private let thisTy = ThisType()
    private let voidTy = VoidType()

    private var classTypes = HashMap<ClassType, ClassType>()
    private var structTypes = HashMap<StructType, StructType>()
    private var enumTypes = HashMap<EnumType, EnumType>()
    private var funcTypes = HashMap<FuncType, FuncType>()
    private var genericTypes = HashMap<GenericType, GenericType>()
    private var refTypes = HashMap<RefType, RefType>()
    private var boxTypes = HashMap<BoxType, BoxType>()

    public init(p: Package) {
        this.curPkg = p
    }
    public prop curPackage: Package {
        get() {
            return curPkg
        }
    }

    // ----------------------- built-in type -----------------------
    public prop boolType: BoolType {
        get() {
            return boolTy
        }
    }
    public prop int8Type: IntType {
        get() {
            return int8Ty
        }
    }
    public prop int16Type: IntType {
        get() {
            return int16Ty
        }
    }
    public prop int32Type: IntType {
        get() {
            return int32Ty
        }
    }
    public prop int64Type: IntType {
        get() {
            return int64Ty
        }
    }
    public prop intNativeType: IntType {
        get() {
            return intNativeTy
        }
    }
    public prop uint8Type: IntType {
        get() {
            return uint8Ty
        }
    }
    public prop uint16Type: IntType {
        get() {
            return uint16Ty
        }
    }
    public prop uint32Type: IntType {
        get() {
            return uint32Ty
        }
    }
    public prop uint64Type: IntType {
        get() {
            return uint64Ty
        }
    }
    public prop uintNativeType: IntType {
        get() {
            return uintNativeTy
        }
    }
    public prop float16Type: FloatType {
        get() {
            return float16Ty
        }
    }
    public prop float32Type: FloatType {
        get() {
            return float32Ty
        }
    }
    public prop float64Type: FloatType {
        get() {
            return float64Ty
        }
    }
    public prop cstringType: CStringType {
        get() {
            return cstringTy
        }
    }
    public prop unitType: UnitType {
        get() {
            return unitTy
        }
    }
    public prop nothingType: NothingType {
        get() {
            return nothingTy
        }
    }
    public prop runeType: RuneType {
        get() {
            return runeTy
        }
    }
    public prop thisType: ThisType {
        get() {
            return thisTy
        }
    }
    public prop voidType: VoidType {
        get() {
            return voidTy
        }
    }

    // ----------------------- custom type -----------------------
    public func GetClassType(def: ClassDef, args: ArrayList<Type>): ClassType {
        let temp = ClassType(def, args)
        let res = classTypes.get(temp)
        if (res.isSome()) {
            return res.getOrThrow()
        }
        classTypes.add(temp, temp)
        return temp
    }
    public func GetStructType(def: StructDef, args: ArrayList<Type>): StructType {
        let temp = StructType(def, args)
        let res = structTypes.get(temp)
        if (res.isSome()) {
            return res.getOrThrow()
        }
        structTypes.add(temp, temp)
        return temp
    }
    public func GetEnumType(def: EnumDef, args: ArrayList<Type>): EnumType {
        let temp = EnumType(def, args)
        let res = enumTypes.get(temp)
        if (res.isSome()) {
            return res.getOrThrow()
        }
        enumTypes.add(temp, temp)
        return temp
    }
    public func GetFuncType(paramTypes: ArrayList<Type>, retType: Type, varArg !: Bool = false, cFunc !: Bool = false): FuncType {
        let temp = FuncType(paramTypes, retType, varArg, cFunc)
        let res = funcTypes.get(temp)
        if (res.isSome()) {
            return res.getOrThrow()
        }
        funcTypes.add(temp, temp)
        return temp
    }
    public func GetGenericType(identifier: String, srcCodeIdentifier: String): GenericType {
        let temp = GenericType(identifier, srcCodeIdentifier)
        let res = genericTypes.get(temp)
        if (res.isSome()) {
            return res.getOrThrow()
        }
        genericTypes.add(temp, temp)
        return temp
    }
    public func GetRefType(baseType: Type): RefType {
        let temp = RefType(baseType)
        let res = refTypes.get(temp)
        if (res.isSome()) {
            return res.getOrThrow()
        }
        refTypes.add(temp, temp)
        return temp
    }
    public func GetBoxType(baseType: Type): BoxType {
        let temp = BoxType(baseType)
        let res = boxTypes.get(temp)
        if (res.isSome()) {
            return res.getOrThrow()
        }
        boxTypes.add(temp, temp)
        return temp
    }

    // ----------------------- create value -----------------------
    public func CreateGlobalFunc(ty: FuncType, mangledName: String, srcName: String, pkgName: String): Function {
        let temp = Function(ty, GLOBAL_VAL_PREFIX + mangledName, srcName, pkgName)
        curPkg.addGlobalFunc(temp)
        return temp
    }
    public func CreateImportedFunc(ty: FuncType, mangledName: String, srcName: String, pkgName: String): Function {
        let temp = Function(ty, GLOBAL_VAL_PREFIX + mangledName, srcName, pkgName)
        curPkg.addImportedFunc(temp)
        temp.enableImported()
        return temp
    }
    public func CreateGlobalVar(ty: Type, mangledName: String, srcName: String, pkgName: String): GlobalVar {
        let temp = GlobalVar(ty, GLOBAL_VAL_PREFIX + mangledName, srcName, pkgName)
        curPkg.addGlobalVar(temp)
        return temp
    }
    public func CreateImportedVar(ty: Type, mangledName: String, srcName: String, pkgName: String): GlobalVar {
        let temp = GlobalVar(ty, GLOBAL_VAL_PREFIX + mangledName, srcName, pkgName)
        curPkg.addImportedVar(temp)
        temp.enableImported()
        return temp
    }

    // ----------------------- LiteralValue API -----------------------
    public func CreateBoolLiteral(value: Bool): BoolLiteral {
        return BoolLiteral(this.boolType, value)
    }

    public func CreateRuneLiteral(value: Rune): RuneLiteral {
        return RuneLiteral(this.runeType, value)
    }

    public func CreateIntLiteral(ty: IntType, value: UInt64): IntLiteral {
        return IntLiteral(ty, value)
    }

    public func CreateFloatLiteral(ty: FloatType, value: Float64): FloatLiteral {
        return FloatLiteral(ty, value)
    }

    public func CreateStringLiteral(value: String): StringLiteral {
        return StringLiteral(this.cstringType, value)
    }

    public func CreateUnitLiteral(): UnitLiteral {
        return UnitLiteral(this.unitType)
    }

    public func CreateNullLiteral(): NullLiteral {
        return NullLiteral(this.nothingType)
    }

    // ----------------------- create expression -----------------------
    public func CreateConstant(val: LiteralValue, owner: Block): Constant {
        let expr = Constant(val, owner)
        let id = expr.topLevelFunc.GenerateLocalId().toString()
        let res = LocalVar(val.ty, id, expr)
        return expr
    }
    public func CreateTypeCast(srcVal: Value, dstTy: Type, owner: Block): TypeCast {
        let expr = TypeCast(srcVal, dstTy, owner)
        let id = expr.topLevelFunc.GenerateLocalId().toString()
        let res = LocalVar(dstTy, id, expr)
        return expr
    }
    public func CreateTypeCast(srcVal: Value, dstTy: Type, owner: Block, normal: Block, err: Block): TypeCast {
        let expr = TypeCast(srcVal, dstTy, owner, normal, err)
        let id = expr.topLevelFunc.GenerateLocalId().toString()
        let res = LocalVar(dstTy, id, expr)
        return expr
    }
    public func CreateApply(retTy: Type, callee: Value, funcCallCtx: FuncCallContext, owner: Block): Apply {
        let expr = Apply(callee, funcCallCtx, owner)
        let id = expr.topLevelFunc.GenerateLocalId().toString()
        let res = LocalVar(retTy, id, expr)
        return expr
    }
    public func CreateApply(retTy: Type, callee: Value, funcCallCtx: FuncCallContext, owner: Block, normal: Block, err: Block): Apply {
        let expr = Apply(callee, funcCallCtx, owner, normal, err)
        let id = expr.topLevelFunc.GenerateLocalId().toString()
        let res = LocalVar(retTy, id, expr)
        return expr
    }
    public func CreateInOut(retTy: Type, funcCallCtx: FuncCallContext, owner: Block): Intrinsic {
        let expr = Intrinsic(IntrinsicKind.INOUT, funcCallCtx, owner)
        let id = expr.topLevelFunc.GenerateLocalId().toString()
        let res = LocalVar(retTy, id, expr)
        return expr
    }
    public func CreateInvoke(retTy: Type, callContext: InvokeCallContext, owner: Block): Invoke {
        let expr = Invoke(callContext, owner)
        let id = expr.topLevelFunc.GenerateLocalId().toString()
        let res = LocalVar(retTy, id, expr)
        return expr
    }
    public func CreateInvoke(retTy: Type, callContext: InvokeCallContext, owner: Block, normal: Block, err: Block): Invoke {
        let expr = Invoke(callContext, owner, normal, err)
        let id = expr.topLevelFunc.GenerateLocalId().toString()
        let res = LocalVar(retTy, id, expr)
        return expr
    }
}