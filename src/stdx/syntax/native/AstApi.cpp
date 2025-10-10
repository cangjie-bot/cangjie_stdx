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
#include "cangjie/Basic/DiagnosticEmitter.h"
#include "cangjie/Basic/SourceManager.h"
#include "cangjie/Frontend/CompilerInstance.h"
#include "cangjie/Parse/Parser.h"

using namespace Cangjie;

namespace {
static char* CloneString(const std::string s, const size_t size)
{
    auto ret = (char*)malloc(size * sizeof(char));
    if (ret == nullptr) {
        return nullptr;
    }
    std::copy(s.begin(), s.end(), ret);
    ret[size - 1] = '\0';
    return ret;
}
} // namespace

extern "C" {
ParseRes* CJ_ParseFile(const char* path)
{
    Cangjie::ICE::TriggerPointSetter iceSetter(CompileStage::PARSE);
    DiagnosticEngine diag;
    SourceManager sm;

    diag.SetSourceManager(&sm);
    diag.SetDiagnoseStatus(true);
    diag.DisableScopeCheck();
    diag.SetErrorCountLimit(std::nullopt);
    diag.EnableCheckRangeErrorCodeRatherICE();
    std::string filePath(path, path + strlen(path));
    std::string failedReason;
    auto content = FileUtil::ReadFileContent(path, failedReason);
    auto fileID = sm.AddSource(filePath, content.value());
    Parser parser(fileID, content.value(), diag, sm, true);

    auto file = parser.ParseTopLevel();

    ParseRes* result = (ParseRes*)malloc(sizeof(ParseRes));
    if (result == nullptr) {
        return nullptr;
    }
    result->eMsg = nullptr;
    result->node = nullptr;

    if (diag.GetErrorCount() > 0) {
        return result;
    }

    if (diag.GetWarningCount()) {
        std::string errMsg;
        diag.GetCategoryDiagnosticsString(DiagCategory::PARSE, errMsg);
        result->eMsg = CloneString(errMsg, errMsg.size() + 1);
    }
    // Serialize ast node
    AstWriter::NodeWriter nodeWriter(file.get());
    result->node = nodeWriter.ExportNode(&sm);
    return result;
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
