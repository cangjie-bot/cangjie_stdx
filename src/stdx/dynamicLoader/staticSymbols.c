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
#include <string.h>

/*
 * Only to keep OpenSSL symbols from being dead stripped / OPT:REFed away
 * in static linking scenarios for libcangjie-dynamicLoader-opensslFFI.a.
 * Other static artifacts will not reference this file.
 */

/*
 * Build-time switch:
 * - CJ_OPENSSL_STATIC=1 (static artifacts): treat symbols as strong refs so linker
 *   must pull them from libcrypto.a; if missing, build should fail.
 * - default (shared/dlopen mode): use weak refs so the binary can still link and
 *   resolve at runtime via dlsym/dlopen.
 */
#if defined(__clang__)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#elif defined(__GNUC__)
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#endif
#if defined(CJ_OPENSSL_STATIC)
#define DECLARE_WEAK(name) extern __typeof__(name) name;
#else
#define DECLARE_WEAK(name) __attribute__((weak)) __typeof__(name) name;
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
#define DECLAREFUNCTION0(name, ...) DECLARE_WEAK(name)
#define DECLAREFUNCTION1(name, ...) DECLARE_WEAK(name)
#define DECLAREFUNCTION2(name, ...) DECLARE_WEAK(name)
#define DECLAREFUNCTION3(name, ...) DECLARE_WEAK(name)
#define DECLAREFUNCTION4(name, ...) DECLARE_WEAK(name)
#define DECLAREFUNCTION5(name, ...) DECLARE_WEAK(name)
#define DECLAREFUNCTION6(name, ...) DECLARE_WEAK(name)
#define DECLAREFUNCTION7(name, ...) DECLARE_WEAK(name)
#define DECLAREFUNCTION8(name, ...) DECLARE_WEAK(name)
#define DECLAREFUNCTIONCB2(name, ...) DECLARE_WEAK(name)
#define DECLAREFUNCTIONCB3(name, ...) DECLARE_WEAK(name)
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

DECLARE_WEAK(CRYPTO_strdup)
DECLARE_WEAK(CRYPTO_strndup)
DECLARE_WEAK(CRYPTO_memdup)
DECLARE_WEAK(CRYPTO_free)
DECLARE_WEAK(CRYPTO_secure_malloc)
DECLARE_WEAK(CRYPTO_secure_zalloc)
DECLARE_WEAK(CRYPTO_secure_free)
DECLARE_WEAK(SSL_CTX_ctrl)
DECLARE_WEAK(BN_num_bits)

typedef struct {
    const char* name;
    void* ptr;
} NamePtr;

static const NamePtr g_cj_openssl_map[] = {
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
#define DECLAREFUNCTION0(name, ...) { #name, (void*)&name },
#define DECLAREFUNCTION1(name, ...) { #name, (void*)&name },
#define DECLAREFUNCTION2(name, ...) { #name, (void*)&name },
#define DECLAREFUNCTION3(name, ...) { #name, (void*)&name },
#define DECLAREFUNCTION4(name, ...) { #name, (void*)&name },
#define DECLAREFUNCTION5(name, ...) { #name, (void*)&name },
#define DECLAREFUNCTION6(name, ...) { #name, (void*)&name },
#define DECLAREFUNCTION7(name, ...) { #name, (void*)&name },
#define DECLAREFUNCTION8(name, ...) { #name, (void*)&name },
#define DECLAREFUNCTIONCB2(name, ...) { #name, (void*)&name },
#define DECLAREFUNCTIONCB3(name, ...) { #name, (void*)&name },
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
    { "CRYPTO_strdup", (void*)&CRYPTO_strdup },
    { "CRYPTO_strndup", (void*)&CRYPTO_strndup },
    { "CRYPTO_memdup", (void*)&CRYPTO_memdup },
    { "CRYPTO_free", (void*)&CRYPTO_free },
    { "CRYPTO_secure_malloc", (void*)&CRYPTO_secure_malloc },
    { "CRYPTO_secure_zalloc", (void*)&CRYPTO_secure_zalloc },
    { "CRYPTO_secure_free", (void*)&CRYPTO_secure_free },
    { "SSL_CTX_ctrl", (void*)&SSL_CTX_ctrl },
    { "BN_num_bits", (void*)&BN_num_bits },
};

#if defined(__clang__)
#pragma clang diagnostic pop
#elif defined(__GNUC__)
#pragma GCC diagnostic pop
#endif

__attribute__((visibility("default"))) void* CJLookupOpenSSL(const char* name)
{
    if (name == NULL) {
        return NULL;
    }
    for (size_t i = 0; i < sizeof(g_cj_openssl_map) / sizeof(g_cj_openssl_map[0]); ++i) {
        if (g_cj_openssl_map[i].ptr != NULL && strcmp(name, g_cj_openssl_map[i].name) == 0) {
            return g_cj_openssl_map[i].ptr;
        }
    }
    return NULL;
}

#if defined(__clang__) || defined(__GNUC__)
__attribute__((used, visibility("default")))
#endif
void* g_cj_openssl_keep[] = {
// for compiler warning suppression
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
    /* Manually supplement entries beyond declareFunction.inc. */
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

#if defined(__clang__)
#pragma clang diagnostic pop
#elif defined(__GNUC__)
#pragma GCC diagnostic pop
#endif
