/*
 * Minimal provider skeleton for keyless TLS. Will be expanded with real
 * KEYMGMT / SIGNATURE / ASYM_CIPHER implementations.
 */
#include <openssl/core.h>
#include <openssl/core_names.h>
#include <openssl/crypto.h>
#include <openssl/evp.h>
#include <openssl/params.h>
#include <openssl/provider.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <stdatomic.h>
#include "api.h"
#include "opensslSymbols.h"
#include "provider.h"

static KeylessProviderCtx* g_provider_ctx = NULL;

static __thread DynMsg g_thread_dyn_msg;
static __thread int g_thread_dyn_msg_set = 0;

__attribute__((visibility("hidden"))) void KeylessCopyDynMsg(DynMsg* dst, const DynMsg* src)
{
    if (!dst) {
        return;
    }
    if (src) {
        *dst = *src;
    } else {
        dst->found = true;
        dst->funcName = NULL;
    }
}

__attribute__((visibility("hidden"))) void KeylessProviderSetThreadDynMsg(const DynMsg* dynMsg)
{
    if (dynMsg) {
        g_thread_dyn_msg = *dynMsg;
        g_thread_dyn_msg_set = 1;
    } else {
        g_thread_dyn_msg.found = true;
        g_thread_dyn_msg.funcName = NULL;
        g_thread_dyn_msg_set = 0;
    }
}

__attribute__((visibility("hidden"))) DynMsg* KeylessProviderGetThreadDynMsg(void)
{
    return g_thread_dyn_msg_set ? &g_thread_dyn_msg : NULL;
}

__attribute__((visibility("hidden"))) bool KeylessCheckDynMsg(const DynMsg* dynMsg, const char* context)
{
    if (!dynMsg || dynMsg->found) {
        return true;
    }
    const char* funcName = dynMsg->funcName ? dynMsg->funcName : "(unknown)";
    const char* phase = context ? context : "operation";
    KEYLESS_PROVIDER_LOG("[keyless] missing OpenSSL symbol %s during %s\n.", funcName, phase);
    return false;
}

static KeylessCallbackEntry* KeylessFindEntryLocked(KeylessProviderCtx* ctx, const char* keyId)
{
    if (!ctx || !keyId) {
        return NULL;
    }
    for (KeylessCallbackEntry* it = ctx->callbacks; it != NULL; it = it->next) {
        if (it->keyId && strcmp(it->keyId, keyId) == 0) {
            return it;
        }
    }
    return NULL;
}

static KeylessCallbackEntry* KeylessEnsureEntryLocked(KeylessProviderCtx* ctx, const char* keyId, DynMsg* dynMsg)
{
    KeylessCallbackEntry* entry = KeylessFindEntryLocked(ctx, keyId);
    if (entry) {
        return entry;
    }

    KeylessCallbackEntry* created = DYN_OPENSSL_zalloc(sizeof(*created), dynMsg);
    if (!created) {
        return NULL;
    }

    created->keyId = strdup(keyId);
    if (!created->keyId) {
        DYN_OPENSSL_secure_free(created, dynMsg);
        return NULL;
    }
    created->next = ctx->callbacks;
    ctx->callbacks = created;
    return created;
}

static void KeylessClearCallbacks(KeylessProviderCtx* ctx)
{
    if (!ctx) {
        return;
    }
    pthread_rwlock_wrlock(&ctx->callbackLock);
    KeylessCallbackEntry* it = ctx->callbacks;
    ctx->callbacks = NULL;
    pthread_rwlock_unlock(&ctx->callbackLock);

    while (it) {
        KeylessCallbackEntry* next = it->next;
        free(it->keyId);
        DYN_OPENSSL_secure_free(it, NULL);
        it = next;
    }
}

__attribute__((visibility("hidden"))) KeylessRemoteSignCb KeylessLookupSignCb(const char* keyId)
{
    if (!keyId) {
        return NULL;
    }

    KeylessProviderCtx* ctx = g_provider_ctx;
    if (!ctx) {
        return NULL;
    }

    pthread_rwlock_rdlock(&ctx->callbackLock);
    KeylessCallbackEntry* entry = KeylessFindEntryLocked(ctx, keyId);
    KeylessRemoteSignCb cb = entry ? entry->signCb : NULL;
    pthread_rwlock_unlock(&ctx->callbackLock);

    if (cb) {
        return cb;
    }
    return NULL;
}

__attribute__((visibility("hidden"))) KeylessRemoteDecryptCb KeylessLookupDecryptCb(const char* keyId)
{
    if (!keyId) {
        return NULL;
    }

    KeylessProviderCtx* ctx = g_provider_ctx;
    if (!ctx) {
        return NULL;
    }

    pthread_rwlock_rdlock(&ctx->callbackLock);
    KeylessCallbackEntry* entry = KeylessFindEntryLocked(ctx, keyId);
    KeylessRemoteDecryptCb cb = entry ? entry->decryptCb : NULL;
    pthread_rwlock_unlock(&ctx->callbackLock);
    if (cb) {
        return cb;
    }
    return NULL;
}

__attribute__((visibility("hidden"))) static void KeylessRegisterSignCallback(const char* keyId, KeylessRemoteSignCb cb, ExceptionData* exception, DynMsg* dynMsg)
{
    if (!keyId || !cb) {
        HandleError(exception, "Invalid parameters for sign callback registration", dynMsg);
        return;
    }

    KeylessProviderCtx* ctx = g_provider_ctx;
    if (!ctx) {
        HandleError(exception, "Provider context not ready for sign callback registration", dynMsg);
        return;
    }
    pthread_rwlock_wrlock(&ctx->callbackLock);
    KeylessCallbackEntry* entry = KeylessEnsureEntryLocked(ctx, keyId, dynMsg);
    if (entry) {
        entry->signCb = cb;
    }
    pthread_rwlock_unlock(&ctx->callbackLock);
}

__attribute__((visibility("hidden"))) static void KeylessRegisterDecryptCallback(const char* keyId, KeylessRemoteDecryptCb cb, ExceptionData* exception, DynMsg* dynMsg)
{
    if (!keyId || !cb) {
        HandleError(exception, "Invalid parameters for decrypt callback registration", dynMsg);
        return;
    }

    KeylessProviderCtx* ctx = g_provider_ctx;
    if (!ctx) {
        HandleError(exception, "Provider context not ready for decrypt callback registration", dynMsg);
        return;
    }

    pthread_rwlock_wrlock(&ctx->callbackLock);
    KeylessCallbackEntry* entry = KeylessEnsureEntryLocked(ctx, keyId, dynMsg);
    if (entry) {
        entry->decryptCb = cb;
    }
    pthread_rwlock_unlock(&ctx->callbackLock);

}

static void* KeylessProviderNewctx(OSSL_LIB_CTX* libctx, const OSSL_DISPATCH* in, const OSSL_CORE_HANDLE* handle)
{
    (void)libctx;
    (void)in;
    (void)handle;
    KeylessProviderCtx* ctx = DYN_OPENSSL_zalloc(sizeof(*ctx), NULL);
    if (!ctx) {
        return NULL;
    }
    if (pthread_rwlock_init(&ctx->callbackLock, NULL) != 0) {
        DYN_OPENSSL_secure_free(ctx, NULL);
        return NULL;
    }
    ctx->callbacks = NULL;
    g_provider_ctx = ctx;
    return ctx;
}

static void KeylessProviderFreectx(void* vctx)
{
    KeylessProviderCtx* ctx = vctx;
    if (!ctx) {
        return;
    }
    KeylessClearCallbacks(ctx);
    pthread_rwlock_destroy(&ctx->callbackLock);
    if (g_provider_ctx == ctx) {
        g_provider_ctx = NULL;
    }
    DYN_OPENSSL_secure_free(ctx, NULL);
}

/* keymgmt algorithms now defined in keymgmt.c */
extern const OSSL_ALGORITHM keylessKeymgmtAlgorithms[];
extern const OSSL_ALGORITHM keylessSignatureAlgorithms[];
extern const OSSL_ALGORITHM keylessAsymcipherAlgorithms[];

static const OSSL_ALGORITHM* KeylessQuery(OSSL_PROVIDER* prov, int operationId, int* noCache)
{
    (void)prov;
    (void)noCache;
    switch (operationId) {
        case OSSL_OP_KEYMGMT:
            return keylessKeymgmtAlgorithms;
        case OSSL_OP_SIGNATURE:
            return keylessSignatureAlgorithms;
        case OSSL_OP_ASYM_CIPHER:
            return keylessAsymcipherAlgorithms;
        default:
            return NULL;
    }
}

static void KeylessProviderTeardown(void* provctx)
{
    KeylessProviderFreectx(provctx);
}

static const OSSL_DISPATCH keyless_dispatch_table[] = {
        {OSSL_FUNC_PROVIDER_QUERY_OPERATION, (void (*)(void))KeylessQuery}, {OSSL_FUNC_PROVIDER_TEARDOWN, (void (*)(void))KeylessProviderTeardown}, {0, NULL}};

__attribute__((visibility("hidden"))) static int KeylessProviderInit(const OSSL_CORE_HANDLE* handle, const OSSL_DISPATCH* in, const OSSL_DISPATCH** out, void** provctx)
{
    *out = keyless_dispatch_table;
    *provctx = KeylessProviderNewctx(NULL, in, handle);
    if (*provctx == NULL) {
        return 0;
    }
    return 1;
}

extern bool DYN_CJ_TLS_InitEmbeddedKeylessProvider(DynMsg* dynMsg)
{
    if (DYN_OSSL_PROVIDER_add_builtin(NULL, "keyless", KeylessProviderInit, dynMsg) != 1) {
        KEYLESS_PROVIDER_LOG("[keyless] Failed to add builtin keyless provider\n");
        return 0;
    }

    OSSL_PROVIDER* p = DYN_OSSL_PROVIDER_load(NULL, "keyless", dynMsg);
    if (!p) {
        KEYLESS_PROVIDER_LOG("[keyless] Failed to load keyless provider\n");
        return 0;
    }
    (void)DYN_OSSL_PROVIDER_load(NULL, "default", dynMsg);
    return 1;
}

extern void DYN_CJ_TLS_RegisterKeylessSignCallback(const char* keyId, KeylessRemoteSignCb cb, ExceptionData* exception, DynMsg* dynMsg)
{
    KeylessRegisterSignCallback(keyId, cb, exception, dynMsg);
}

extern void DYN_CJ_TLS_RegisterKeylessDecryptCallback(const char* keyId, KeylessRemoteDecryptCb cb, ExceptionData* exception, DynMsg* dynMsg)
{
    KeylessRegisterDecryptCallback(keyId, cb, exception, dynMsg);
}
