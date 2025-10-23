/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * Runtime for manipulating Cangjie AST in libast.
 */

#include "AstApi.h"
#include "NodeWriter.h"
#include "TokenWriter.h" 
#include "ParserSyntax.h"
#include "cangjie/Basic/DiagnosticEmitter.h"
#include "cangjie/Basic/SourceManager.h"
#include "cangjie/Frontend/CompilerInstance.h"
#include "cangjie/Parse/Parser.h"

using namespace Cangjie;
namespace {
uint8_t* getDiagInfos(DiagnosticEngine& diag) {
    std::vector<DiagnosticInfo> diagInfosParse, diagInfosLex, diagInfos;
    diag.GetCategoryDiagnosticInfos(DiagCategory::PARSE, diagInfosParse);
    diag.GetCategoryDiagnosticInfos(DiagCategory::LEX, diagInfosLex);
    diagInfos = diagInfosParse;
    diagInfos.insert(diagInfos.end(), diagInfosLex.begin(), diagInfosLex.end());
    flatbuffers::FlatBufferBuilder builder(AstWriter::INITIAL_FILE_SIZE);
    return ExportDiags(SerializeDiags(diagInfos, builder), builder);
}

void SetDiagEngine(DiagnosticEngine& diag, SourceManager& sm) {
    diag.SetSourceManager(&sm);
    diag.SetDiagnoseStatus(true);
    diag.DisableScopeCheck();
    diag.SetErrorCountLimit(std::nullopt);
    diag.EnableCheckRangeErrorCodeRatherICE();
}

ParseRes* createParseResult() {
    ParseRes* result = (ParseRes*)malloc(sizeof(ParseRes));
    if (result == nullptr) {
        return nullptr;
    }
    result->eMsg = nullptr;
    result->node = nullptr;
    return result;
}

ParseRes* getParseResult(ParseRes* result, DiagnosticEngine& diag, SourceManager& sm, Ptr<AST::Node> nodePtr) {
    // Analyzing Errors and Warnings
    if (diag.GetErrorCount() || diag.GetWarningCount()) {
        result->eMsg = getDiagInfos(diag);
    }

    AstWriter::NodeWriter nodeWriter(nodePtr);
    auto astNode = nodeWriter.ExportNode(&sm);
    if (diag.GetErrorCount() == 0 || nodeWriter.isUnsupported) {
        // Serialize ast node
        result->node = astNode;
    }
    return result;
}
} // namespace

extern "C" {
ParseRes* CJ_ParseFile(const char* path)
{
    Cangjie::ICE::TriggerPointSetter iceSetter(CompileStage::PARSE);
    DiagnosticEngine diag;
    SourceManager sm;

    SetDiagEngine(diag, sm);
    std::string filePath(path, path + strlen(path));
    std::string failedReason;
    auto content = FileUtil::ReadFileContent(path, failedReason);
    auto fileID = sm.AddSource(filePath, content.value());
    Parser parser(fileID, content.value(), diag, sm, true);
    auto file = parser.ParseTopLevel();
    ParseRes* res = createParseResult();
    return getParseResult(res, diag, sm, file.get());
}

ParseRes* CJ_ParseText(const char* text)
{
    Cangjie::ICE::TriggerPointSetter iceSetter(CompileStage::PARSE);
    DiagnosticEngine diag;
    SourceManager sm;

    SetDiagEngine(diag, sm);
    std::string rawString(text, text + strlen(text));
    ParserSyntax parser(rawString, diag, sm, {0, 1, 1}, true);

    auto textParsed = parser.ParseExprOrDecl(ScopeKind::UNKNOWN_SCOPE);
    
    ParseRes* res = createParseResult();
    if (textParsed == nullptr) {
        return res;
    }
    return getParseResult(res, diag, sm, textParsed.get());
}

ParseRes* CJ_ParseAnnotationArguments(const uint8_t* tokensBytes)
{
    Cangjie::ICE::TriggerPointSetter iceSetter(CompileStage::PARSE);
    std::vector<Token> tokens = TokenWriter::GetTokensFromBytes(tokensBytes);
    DiagnosticEngine diag;
    SourceManager sm;
    diag.SetSourceManager(&sm);
    diag.SetDiagnoseStatus(true);
    diag.DisableScopeCheck();
    diag.SetDisableWarning(true);
    diag.EnableCheckRangeErrorCodeRatherICE();
    Parser parser(tokens, diag, sm, false, false);
    auto node = parser.ParseCustomAnnotation();

    ParseRes* result = (ParseRes*)malloc(sizeof(ParseRes));
    // result free on cangjie side
    if (result == nullptr) {
        return nullptr;
    }
    AstWriter::NodeWriter nodeWriter(node.get());
    result->node = nodeWriter.ExportNode(&sm);
    result->eMsg = nullptr;
    return result;
}
}
