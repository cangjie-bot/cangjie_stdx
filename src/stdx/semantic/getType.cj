package stdx.semantic

import std.collection.HashMap
import std.collection.ArrayList

func getDeclTypeMap(maps: SemanticType_NodeTypeMap) {
    let declMap = HashMap<UInt64, SemanticType>()
    // 不重复创建类型节点
    let tyPtrToSemanticType = HashMap<UInt64, SemanticType>()
    for (semanticTypeMapOption in maps.GetDeclMapList()) {
        if (let Some(semanticTypeMap) <- semanticTypeMapOption){
            let id = semanticTypeMap.GetId()
            let ty = generateSemanticType(semanticTypeMap.GetType())
            if (tyPtrToSemanticType.contains(ty.rawPointer)) {
                declMap.add(id, tyPtrToSemanticType[ty.rawPointer])
            } else {
                declMap.add(id, ty)
                tyPtrToSemanticType.add(ty.rawPointer, ty)
            }
        }
    }
    return declMap
}

func generateSemanticType(t: Option<SemanticType_ASTType>): SemanticType {
    let semanticType = match (t) {
        case Some(v) => v
        case None => throw Exception("no semanticType")
    }
    let kindValue = semanticType.GetKind()
    let kind = convertInt2TypeKind(kindValue)

    let name = semanticType.GetName()
    let rawPointer = semanticType.GetRawPointer()

    let typeArgsNode = semanticType.GetTypeArgs()
    let typeArgs = ArrayList<SemanticType>()

    for (arg in typeArgsNode) {
        typeArgs.add(generateSemanticType(arg))
    }
    return match(kind) {
        case TYPE_UNIT => UnitSType()
        case TYPE_INT8 => Int8SType(rawPointer)
        case TYPE_INT16 => Int16SType(rawPointer)
        case TYPE_INT32 => Int32SType(rawPointer)
        case TYPE_INT64 => Int64SType(rawPointer)
        case TYPE_UINT8 =>  UInt8SType(rawPointer)
        case TYPE_UINT16 => UInt16SType(rawPointer)
        case TYPE_UINT32 => UInt32SType(rawPointer)
        case TYPE_UINT64 => UInt64SType(rawPointer)
        case TYPE_FLOAT16 => Float16SType(rawPointer)
        case TYPE_FLOAT32 => Float32SType(rawPointer)
        case TYPE_FLOAT64 => Float64SType(rawPointer)
        case TYPE_RUNE => RuneSType(rawPointer)


        case TYPE_CLASS => ClassSType(name, typeArgs.toArray(), rawPointer)
        case TYPE_STRUCT => match(name) {
            case "String" => StringSType(rawPointer)
            case _ => StructSType(name, typeArgs.toArray(), rawPointer)
        }
        case TYPE_ENUM => EnumSType(name, typeArgs.toArray(), rawPointer)
        case TYPE_INTERFACE => InterfaceSType(name, typeArgs.toArray(), rawPointer)
        case TYPE_FUNC => FuncSType(typeArgs.toArray(), rawPointer)
        case _ => AnySType()
    }

}