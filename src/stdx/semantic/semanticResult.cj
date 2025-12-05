package stdx.semantic
import stdx.syntax.*
import std.collection.HashMap

public class SemanticResult {
    public let diags: Array<Diagnostic> = []
    // public static func analyze(pkgAST: Package, importedPkgContexts!: Array<SemanticContext> = []): SemanticResult {
    //     let maps = unsafe {analyzeImpl("")}

    // }

    private let declTypeInfoMap: HashMap<UInt64, SemanticType>
    init(declTypeInfoMap: HashMap<UInt64, SemanticType>){
        this.declTypeInfoMap = declTypeInfoMap
    }

    public func getTypeByName(name: String): Option<SemanticType> {
        for ((_, semanticType) in declTypeInfoMap) {
            if (semanticType.toString() == name) {
                return semanticType
            }
        }
        return Option<SemanticType>.None
    }

    public func getTypeInfo(decl: Decl): Option<SemanticType> {
        declTypeInfoMap.get(decl.getId())
    }
}

public class SemanticContext {

}

public func getSemanticResult(input: Decl): SemanticResult {
    let maps = unsafe { getSemanticResultImpl(input.getId()) }

    let declMap = getDeclTypeMap(maps)
    SemanticResult(declMap)
}
