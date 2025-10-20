#ifndef KEYLESS_H
#define KEYLESS_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>
#include <openssl/x509.h>
#include <pthread.h>
#include "api.h"

#ifdef __cplusplus
extern "C" {
#endif

#define KEYLESS_KEY_TYPE_RSA (1)
#define KEYLESS_KEY_TYPE_EC (2)
#define KEYLESS_KEY_TYPE_ECDSA (2)
typedef struct KeylessKey
{
    int type;    /* 1=rsa 2=ec */
    char* keyId; /* allocated */

    /* For RSA */
    unsigned char* n;
    size_t nLen;
    unsigned char* e;
    size_t eLen;

    /* For EC */
    unsigned char* ecPoint;
    size_t ecPointLen; /* encoded P in uncompressed form */
    char* groupName;   /* e.g., P-256 */

    DynMsg dynMsg; /* snapshot of the dyn loader state captured at creation */
    int refCnt;
} KeylessKey;

typedef struct Pkcs1DigestDescriptor
{
    const char* name;
    const unsigned char* derPrefix;
    size_t derLen;
    size_t hashLen;
} Pkcs1DigestDescriptor;

// Remote signing callback
// Parameters:
//   key_id : remote key identifier
//   alg    : canonical algorithm name (e.g., "rsa-pss-sha256", "ecdsa-secp256r1-sha256")
//   digest : pointer to message digest buffer
//   digestLen : length of digest
//   sig_written : actual written length (output)
// Return pointer to signature buffer (owned by callback) or NULL on failure.
typedef char* (*KeylessRemoteSignCb)(const char* keyId, const char* alg, const unsigned char* digest, const int64_t size, int64_t* written);

// Remote decrypt callback (for future TLS1.2 RSA key exchange)
// ciphertext -> plaintext
// Return 1 on success, 0 on failure.
typedef char* (*KeylessRemoteDecryptCb)(const char* keyId, const unsigned char* digest, const int64_t size, int64_t* written);

__attribute__((visibility("hidden"))) size_t KeylessKeyGetSize(const void* keyData);
__attribute__((visibility("hidden"))) const unsigned char* KeylessKeyGetN(const void* keyData);
__attribute__((visibility("hidden"))) size_t KeylessKeyGetNLen(const void* keyData);
__attribute__((visibility("hidden"))) const unsigned char* KeylessKeyGetE(const void* keyData);
__attribute__((visibility("hidden"))) size_t KeylessKeyGetELen(const void* keyData);

/* Accessors used internally by provider modules */
__attribute__((visibility("hidden"))) KeylessRemoteSignCb KeylessLookupSignCb(const char* keyId);
__attribute__((visibility("hidden"))) KeylessRemoteDecryptCb KeylessLookupDecryptCb(const char* keyId);

/* Opaque keydata accessors (implemented in keymgmt) */
__attribute__((visibility("hidden"))) int KeylessKeyGetType(const void* keyData);          /* 1=rsa 2=ec */
__attribute__((visibility("hidden"))) const char* KeylessKeyGetGroup(const void* keyData); /* NULL if not EC */
__attribute__((visibility("hidden"))) const char* KeylessKeyGetId(const void* keyData);
__attribute__((visibility("hidden"))) int KeylessKeyUpRef(void* keyData);
__attribute__((visibility("hidden"))) void KeylessKeyFreeExtern(void* keyData);
__attribute__((visibility("hidden"))) size_t KeylessKeyGetRsaNLen(const void* keyData);
__attribute__((visibility("hidden"))) int CertIssuerSerialSha256Hex(const X509* crt, char out_hex[65]); /* 64(sha256 length)chars + NULL */
__attribute__((visibility("hidden"))) int8_t GetKeylessLogLevel();
__attribute__((visibility("hidden"))) int keyless_err_lib_init(void);

__attribute__((visibility("hidden"))) unsigned int GetEcOrderBitsFromGroup(const char* groupName);
enum
{
    KEYLESS_LOG_OFF = 0,
    KEYLESS_LOG_ON = 1,
};

enum {
    KEYLESS_LOAD_SUCCESS = 0,
    KEYLESS_PROVIDER_ADD_FAILED = 1,
    KEYLESS_PROVIDER_NOT_FOUND = 2,
};

#define KEYLESS_PROVIDER_LOG(fmt, ...)                                                                                                                                             \
    do {                                                                                                                                                                           \
        int8_t log_level = GetKeylessLogLevel();                                                                                                                                   \
        if (log_level == KEYLESS_LOG_ON) {                                                                                                                                         \
            fprintf(stderr, fmt, ##__VA_ARGS__);                                                                                                                                   \
        }                                                                                                                                                                          \
    } while (0)

typedef struct KeylessAsymcipherCtx
{
    void* keyData;
    int type; // 1=rsa
    DynMsg dynMsg;
} KeylessAsymcipherCtx;

typedef struct KeylessCallbackEntry
{
    char* keyId;
    KeylessRemoteSignCb signCb;
    KeylessRemoteDecryptCb decryptCb;
    ExceptionData* exception; 
    DynMsg* dynMsg;

    struct KeylessCallbackEntry* next;
} KeylessCallbackEntry;

typedef struct KeylessProviderCtx
{
    pthread_rwlock_t callbackLock;
    KeylessCallbackEntry* callbacks;
} KeylessProviderCtx;

__attribute__((visibility("hidden"))) void KeylessProviderSetThreadDynMsg(const DynMsg* dynMsg);
__attribute__((visibility("hidden"))) DynMsg* KeylessProviderGetThreadDynMsg(void);
__attribute__((visibility("hidden"))) void KeylessCopyDynMsg(DynMsg* dst, const DynMsg* src);
__attribute__((visibility("hidden"))) bool KeylessCheckDynMsg(const DynMsg* dynMsg, const char* context);

#ifdef __cplusplus
}
#endif

#endif // KEYLESS_H
