/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

#include "opensslSymbols.h"
#include <openssl/provider.h>
#include <openssl/rand.h>
#include <openssl/x509v3.h>

/* 仅用于 libcangjie-dynamicLoader-opensslFFI.a，确保在静态链接场景下
 * OpenSSL 符号不会被 dead strip / OPT:REF 裁掉。其他静态产物不会引用此文件。 */
#if defined(__clang__) || defined(__GNUC__)
__attribute__((used))
#endif
static void* g_cj_openssl_keep[] = {
#if defined(__clang__)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#elif defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif
#ifdef DECLAREFUNCTION
#undef DECLAREFUNCTION
#endif
#ifdef DECLAREFUNCTION0
#undef DECLAREFUNCTION0
#endif
#ifdef DECLAREFUNCTION1
#undef DECLAREFUNCTION1
#endif
#ifdef DECLAREFUNCTION2
#undef DECLAREFUNCTION2
#endif
#ifdef DECLAREFUNCTION3
#undef DECLAREFUNCTION3
#endif
#ifdef DECLAREFUNCTION4
#undef DECLAREFUNCTION4
#endif
#ifdef DECLAREFUNCTION5
#undef DECLAREFUNCTION5
#endif
#ifdef DECLAREFUNCTION6
#undef DECLAREFUNCTION6
#endif
#ifdef DECLAREFUNCTION7
#undef DECLAREFUNCTION7
#endif
#ifdef DECLAREFUNCTION8
#undef DECLAREFUNCTION8
#endif
#ifdef DECLAREFUNCTIONCB2
#undef DECLAREFUNCTIONCB2
#endif
#ifdef DECLAREFUNCTIONCB3
#undef DECLAREFUNCTIONCB3
#endif
#define DECLAREFUNCTION0(name, ...) (void*)&name,
#define DECLAREFUNCTION1(name, ...) (void*)&name,
#define DECLAREFUNCTION2(name, ...) (void*)&name,
#define DECLAREFUNCTION3(name, ...) (void*)&name,
#define DECLAREFUNCTION4(name, ...) (void*)&name,
#define DECLAREFUNCTION5(name, ...) (void*)&name,
#define DECLAREFUNCTION6(name, ...) (void*)&name,
#define DECLAREFUNCTION7(name, ...) (void*)&name,
#define DECLAREFUNCTION8(name, ...) (void*)&name,
#define DECLAREFUNCTIONCB2(name, ...) (void*)&name,
#define DECLAREFUNCTIONCB3(name, ...) (void*)&name,
#include "declareFunction.inc"
#undef DECLAREFUNCTION0
#undef DECLAREFUNCTION1
#undef DECLAREFUNCTION2
#undef DECLAREFUNCTION3
#undef DECLAREFUNCTION4
#undef DECLAREFUNCTION5
#undef DECLAREFUNCTION6
#undef DECLAREFUNCTION7
#undef DECLAREFUNCTION8
#undef DECLAREFUNCTIONCB2
#undef DECLAREFUNCTIONCB3
    /* 手工补充 declareFunction.inc 之外的入口。 */
    (void*)&CRYPTO_strdup,
    (void*)&CRYPTO_strndup,
    (void*)&CRYPTO_memdup,
    (void*)&CRYPTO_free,
    (void*)&CRYPTO_secure_malloc,
    (void*)&CRYPTO_secure_zalloc,
    (void*)&CRYPTO_secure_free,
    (void*)&SSL_CTX_ctrl,
    (void*)&BN_num_bits
};