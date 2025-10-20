#include <openssl/core.h>
#include <openssl/core_dispatch.h>
#include <openssl/core_names.h>
#include <openssl/params.h>
#include <openssl/evp.h>
#include <string.h>
#include <stdlib.h>
#include <openssl/bn.h>
#include "api.h"
#include "provider.h"
#include "opensslSymbols.h"
#include "securec.h"

static void KeylessKeyFree(KeylessKey* k)
{
    if (!k) {
        return;
    }
    if (__atomic_sub_fetch(&k->refCnt, 1, __ATOMIC_RELAXED) > 0) {
        return;
    }
    free(k->keyId);
    free(k->n);
    free(k->e);
    free(k->ecPoint);
    free(k->groupName);
    free(k);
}

static KeylessKey* KeylessKeyNew(void)
{
    KeylessKey* k = calloc(1, sizeof(*k));
    if (k) {
        k->refCnt = 1;
        KeylessCopyDynMsg(&k->dynMsg, KeylessProviderGetThreadDynMsg());
    }
    return k;
}

/* Duplicate increment */
static KeylessKey* KeylessKeyDup(KeylessKey* k)
{
    if (k) {
        __atomic_add_fetch(&k->refCnt, 1, __ATOMIC_RELAXED);
    }
    return k;
}

/* External accessor implementations */
__attribute__((visibility("hidden"))) int KeylessKeyGetType(const void* keyData)
{
    const KeylessKey* k = keyData;
    return k ? k->type : 0;
}
__attribute__((visibility("hidden"))) const char* KeylessKeyGetGroup(const void* keyData)
{
    const KeylessKey* k = keyData;
    return (k && k->type == 2) ? k->groupName : NULL;
}
__attribute__((visibility("hidden"))) const char* KeylessKeyGetId(const void* keyData)
{
    const KeylessKey* k = keyData;
    return k ? k->keyId : NULL;
}
__attribute__((visibility("hidden"))) int KeylessKeyUpRef(void* keyData)
{
    KeylessKey* k = keyData;
    if (!k) {
        return 0;
    }
    __atomic_add_fetch(&k->refCnt, 1, __ATOMIC_RELAXED);
    return 1;
}
__attribute__((visibility("hidden"))) void KeylessKeyFreeExtern(void* keyData)
{
    KeylessKeyFree(keyData);
}
__attribute__((visibility("hidden"))) size_t KeylessKeyGetRsaNLen(const void* keyData)
{
    const KeylessKey* k = keyData;
    return (k && k->type == 1) ? k->nLen : 0;
}

/* KEYMGMT context (unused for now) */
struct keyless_keymgmt_ctx
{
    int dummy;
};

/* Utility: parse params to fill key */
static int KeylessImportRsa(KeylessKey* k, const OSSL_PARAM params[])
{
    /**
     * pN: OSSL_PKEY_PARAM_RSA_N (BIGNUM or octet string)
     * pE: OSSL_PKEY_PARAM_RSA_E (BIGNUM or octet string)
     */
    const OSSL_PARAM* pN = DYN_OSSL_PARAM_locate_const(params, OSSL_PKEY_PARAM_RSA_N, NULL);
    const OSSL_PARAM* pE = DYN_OSSL_PARAM_locate_const(params, OSSL_PKEY_PARAM_RSA_E, NULL);
    if (!pN || !pE) {
        return 0;
    }

    BIGNUM *bnN = NULL, *bnE = NULL; // bnN: modulus, bnE: public exponent
    if (DYN_OSSL_PARAM_get_BN(pN, &bnN, NULL) && DYN_OSSL_PARAM_get_BN(pE, &bnE, NULL)) {
        k->type = KEYLESS_KEY_TYPE_RSA;
        k->nLen = DYN_BN_num_bytes(bnN, NULL);
        k->eLen = DYN_BN_num_bytes(bnE, NULL);
        k->n = malloc(k->nLen);
        k->e = malloc(k->eLen);
        if (!k->n || !k->e) {
            DYN_BN_free(bnN, NULL);
            DYN_BN_free(bnE, NULL);
            free(k->n);
            k->n = NULL;
            free(k->e);
            k->e = NULL;
            return 0;
        }
        DYN_BN_bn2bin(bnN, k->n, NULL);
        DYN_BN_bn2bin(bnE, k->e, NULL);
        DYN_BN_free(bnN, NULL);
        DYN_BN_free(bnE, NULL);
        return 1;
    }

    const void* nPtr = NULL;
    const void* ePtr = NULL;
    size_t nSize = 0, eSize = 0;
    if (!DYN_OSSL_PARAM_get_octet_string_ptr(pN, &nPtr, &nSize, NULL) || !DYN_OSSL_PARAM_get_octet_string_ptr(pE, &ePtr, &eSize, NULL)) {
        return 0;
    }

    k->type = KEYLESS_KEY_TYPE_RSA;
    k->n = malloc(nSize);
    k->e = malloc(eSize);
    if (!k->n || !k->e) {
        free(k->n);
        k->n = NULL;
        free(k->e);
        k->e = NULL;
        return 0;
    }

    memcpy_s(k->n, nSize, nPtr, nSize);
    k->nLen = nSize;
    memcpy_s(k->e, eSize, ePtr, eSize);
    k->eLen = eSize;
    return 1;
}

static char* KeylessStrndup(const char* s, size_t n)
{
    size_t len = 0;
    while (len < n && s[len] != '\0') {
        len++;
    }
    char* out = calloc(len + 1, sizeof(char));
    if (!out) {
        return NULL;
    }
    if (memcpy_s(out, len, s, len) != EOK) {
        free(out);
        return NULL;
    }

    out[len] = '\0';
    return out;
}

static int KeylessImportEc(KeylessKey* k, const OSSL_PARAM params[])
{
    const OSSL_PARAM* p_point = DYN_OSSL_PARAM_locate_const(params, OSSL_PKEY_PARAM_PUB_KEY, NULL);
    const OSSL_PARAM* p_group = OSSL_PKEY_PARAM_GROUP_NAME ? DYN_OSSL_PARAM_locate_const(params, OSSL_PKEY_PARAM_GROUP_NAME, NULL) : NULL;
    if (!p_point) {
        return 0;
    }
    k->type = KEYLESS_KEY_TYPE_EC;
    k->ecPoint = calloc(p_point->data_size, sizeof(unsigned char));
    k->ecPointLen = p_point->data_size;
    if (!k->ecPoint) {
        return 0;
    }
    memcpy_s(k->ecPoint, p_point->data_size, p_point->data, k->ecPointLen);
    if (p_group) {
        k->groupName = KeylessStrndup(p_group->data, p_group->data_size);
    }
    return 1;
}

static int KeylessImportKeyId(KeylessKey* k, const OSSL_PARAM params[])
{
    const OSSL_PARAM* p_id = DYN_OSSL_PARAM_locate_const(params, "KEYLESS_ID", NULL);
    if (!p_id) {
        return 1; /* optional for comparison */
    }
    k->keyId = KeylessStrndup(p_id->data, p_id->data_size);
    return k->keyId != NULL;
}

/* Common import function entry */
static int KeylessImport(void* keyData, int selection, const OSSL_PARAM params[])
{
    KeylessKey* k = keyData;
    if (!k) {
        return 0;
    }
    if (selection & OSSL_KEYMGMT_SELECT_PUBLIC_KEY) {
        /* Determine if RSA or EC by presence */
        if (DYN_OSSL_PARAM_locate_const(params, OSSL_PKEY_PARAM_RSA_N, NULL)) {
            if (!KeylessImportRsa(k, params)) {
                return 0;
            }
        } else if (DYN_OSSL_PARAM_locate_const(params, OSSL_PKEY_PARAM_PUB_KEY, NULL)) {
            if (!KeylessImportEc(k, params)) {
                return 0;
            }
        } else {
            return 0;
        }
        if (!KeylessImportKeyId(k, params)) {
            return 0;
        }
    }
    return 1;
}

static void* KeylessNew(void* provctx)
{
    (void)provctx;
    return KeylessKeyNew();
}

static void KeylessFree(void* keyData)
{
    KeylessKeyFree(keyData);
}

/**
 * @param provctx Opaque provider context (unused).
 * @param reference Pointer to a reference to the KeylessKey to duplicate.
 * @param referenceSize Size of the reference data; must be sizeof(KeylessKey*).
 * @return Pointer to the newly allocated duplicate KeylessKey, or NULL on failure.
 * @note used by OpenSSL when loading keys by reference.
 */
static void* KeylessLoad(void* provctx, const void* reference, size_t referenceSize)
{
    (void)provctx;
    if (referenceSize != sizeof(KeylessKey*)) {
        return NULL;
    }

    KeylessKey* const* ref = reference;
    return KeylessKeyDup(*ref);
}

/**
 * Determines whether the specified key data contains the properties indicated by the selection bitmask.
 * @param keyData Pointer to the provider-specific key data instance.
 * @param selection Bitmask indicating which properties to check (e.g., public key, private key).
 * @return 1 if the key data contains all requested properties; 0 otherwise.
 * @note used by OpenSSL to verify key capabilities before performing operations.
 */
static int KeylessHas(const void* keyData, int selection)
{
    const KeylessKey* k = keyData;
    if (!k) {
        return 0;
    }

    int ok = 1;
    if (selection & OSSL_KEYMGMT_SELECT_PUBLIC_KEY) {
        ok &= ((k->type == KEYLESS_KEY_TYPE_RSA && k->n && k->e) || (k->type == KEYLESS_KEY_TYPE_EC && k->ecPoint));
    }

    if (selection & OSSL_KEYMGMT_SELECT_PRIVATE_KEY) {
        /* We claim private key capability so signature/decryption operations proceed */
        ok &= 1;
    }
    return ok;
}

/**
 * Determines whether two provider-specific key representations are equivalent
 * for the specified property selection without accessing or requiring private
 * key material.
 *
 * @param keyData1: Pointer to the first provider-specific key data instance.
 * @param keyData2: Pointer to the second provider-specific key data instance to compare against.
 * @param selection: Bitmask indicating which properties must match (e.g., algorithm, parameters, key size, public key).
 *      When used with OpenSSL-style providers, this typically corresponds to OSSL_KEYMGMT_SELECT_* flags.
 *
 * @returns:
 *  - 1 if all properties indicated by 'selection' match between the two keys.
 *  - 0 if any of the selected properties do not match.
 *  - A negative value on error (e.g., invalid arguments or unsupported selection).
 *
 * @note Intended to operate without private key material; only public attributes and metadata relevant to 'selection' are considered.
 */
static int KeylessMatch(const void* keyData1, const void* keyData2, int selection)
{
    const KeylessKey* a = keyData1;
    const KeylessKey* b = keyData2;
    if (!a || !b) {
        return 0;
    }
    if (selection & OSSL_KEYMGMT_SELECT_PUBLIC_KEY) {
        if (a->type != b->type) {
            return 0;
        }
        if (a->type == KEYLESS_KEY_TYPE_RSA) {
            BIGNUM* an = DYN_BN_bin2bn(a->n, (int)a->nLen, NULL, NULL);
            BIGNUM* bn = DYN_BN_bin2bn(b->n, (int)b->nLen, NULL, NULL);
            BIGNUM* ae = DYN_BN_bin2bn(a->e, (int)a->eLen, NULL, NULL);
            BIGNUM* be = DYN_BN_bin2bn(b->e, (int)b->eLen, NULL, NULL);
            int ok = an && bn && ae && be && DYN_BN_cmp(an, bn, NULL) == 0 && DYN_BN_cmp(ae, be, NULL) == 0;
            DYN_BN_free(an, NULL);
            DYN_BN_free(bn, NULL);
            DYN_BN_free(ae, NULL);
            DYN_BN_free(be, NULL);
            if (!ok) {
                return 0;
            }
        } else if (a->type == KEYLESS_KEY_TYPE_EC) {
            if (a->ecPointLen != b->ecPointLen) {
                return 0;
            }
            if (memcmp(a->ecPoint, b->ecPoint, a->ecPointLen) != 0) {
                return 0;
            }
            if ((a->groupName == NULL) != (b->groupName == NULL)) {
                return 0;
            }
            if (a->groupName && strcmp(a->groupName, b->groupName) != 0) {
                return 0;
            }
        }
    }

    /* We do not hold private material locally, but selections may include it.
     * Returning success signals that remote storage would satisfy the match. */
    return 1;
}

static const char* DefaultDigestForKey(const KeylessKey* k) {
    if (k->type == KEYLESS_KEY_TYPE_EC && k->groupName) {
        unsigned ob = GetEcOrderBitsFromGroup(k->groupName);
        if (ob >= 512) return "SHA512";
        if (ob >= 384) return "SHA384";
        return "SHA256";  /* P-256 and similar */
    }
    if (k->type == KEYLESS_KEY_TYPE_RSA) {
        unsigned rsaBits = (unsigned)(k->nLen * 8);
        /* @refer NIST SP 800-57 Part 1 Rev. 5 Table 2 */
        if (rsaBits >= 7680) return "SHA512";
        if (rsaBits >= 3072) return "SHA384";
        return "SHA256";
    }
    return "SHA256";
}

static int KeylessGetParams(void* keyData, OSSL_PARAM params[])
{
    KeylessKey* k = keyData;
    if (!k) {
        return 0;
    }
    OSSL_PARAM* p = NULL;

    if (k->type == KEYLESS_KEY_TYPE_RSA) {
        if ((p = DYN_OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_RSA_N, NULL))) {
            BIGNUM* bn = DYN_BN_bin2bn(k->n, (int)k->nLen, NULL, NULL);
            if (!bn || !DYN_OSSL_PARAM_set_BN(p, bn, NULL)) {
                DYN_BN_free(bn, NULL);
                return 0;
            }
            DYN_BN_free(bn, NULL);
        }
        if ((p = DYN_OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_RSA_E, NULL))) {
            BIGNUM* be = DYN_BN_bin2bn(k->e, (int)k->eLen, NULL, NULL);
            if (!be || !DYN_OSSL_PARAM_set_BN(p, be, NULL)) {
                DYN_BN_free(be, NULL);
                return 0;
            }
            DYN_BN_free(be, NULL);
        }

        if ((p = DYN_OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_MAX_SIZE, NULL))) {
            DYN_OSSL_PARAM_set_size_t(p, k->nLen, NULL);
        }

        unsigned int rsaBits = (unsigned int)(k->nLen * 8);
        if ((p = DYN_OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_BITS, NULL))) {
            DYN_OSSL_PARAM_set_uint(p, rsaBits, NULL);
        }
        if ((p = DYN_OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_SECURITY_BITS, NULL))) {
            /* @refer NIST SP 800-57 Part 1 Rev. 5 Table 2 */
            unsigned secureBits = (rsaBits >= 15360) ? 256u : (rsaBits >= 7680) ? 192u : (rsaBits >= 3072) ? 128u : (rsaBits >= 2048) ? 112u : 0u;
            if (secureBits) {
                DYN_OSSL_PARAM_set_uint(p, secureBits, NULL);
            }
        }
    } else if (k->type == KEYLESS_KEY_TYPE_EC) {
        if ((p = DYN_OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_PUB_KEY, NULL))) {
            DYN_OSSL_PARAM_set_octet_string(p, k->ecPoint, k->ecPointLen, NULL);
        }
        if (k->groupName && (p = DYN_OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_GROUP_NAME, NULL))) {
            DYN_OSSL_PARAM_set_utf8_string(p, k->groupName, NULL);
        }

        unsigned orderBits = GetEcOrderBitsFromGroup(k->groupName);
        if (orderBits) {
            if ((p = DYN_OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_MAX_SIZE, NULL))) {
                size_t nbytes = orderBits / 8 + ((orderBits % 8) ? 1 : 0);
                /* Upper bound for ECDSA DER signature length. Two INTEGERs plus overhead; safe simple bound: 2*nbytes + 10. */
                size_t derSigMax = 2 * nbytes + 10;
                DYN_OSSL_PARAM_set_size_t(p, derSigMax, NULL);
            }
        } else {
            if ((p = DYN_OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_MAX_SIZE, NULL))) {
                DYN_OSSL_PARAM_set_size_t(p, 160, NULL); /* > P-521 ECDSA DER max (~158B), 160B will be enough. */
            }
        }
    }

    if ((p = DYN_OSSL_PARAM_locate(params, "KEYLESS_ID", NULL))) {
        DYN_OSSL_PARAM_set_utf8_string(p, k->keyId, NULL);
    }

    if ((p = DYN_OSSL_PARAM_locate(params, OSSL_PKEY_PARAM_DEFAULT_DIGEST, NULL))) {
        const char* md = DefaultDigestForKey(k);
        DYN_OSSL_PARAM_set_utf8_string(p, md, NULL);
    }

    return 1;
}

static const OSSL_PARAM* KeylessGettableParams(void* provctx)
{
    static const OSSL_PARAM gettable[] = {OSSL_PARAM_utf8_string("KEYLESS_ID", NULL, 0),
                                          OSSL_PARAM_uint(OSSL_PKEY_PARAM_BITS, NULL),
                                          OSSL_PARAM_uint(OSSL_PKEY_PARAM_SECURITY_BITS, NULL),
                                          OSSL_PARAM_size_t(OSSL_PKEY_PARAM_MAX_SIZE, NULL),
                                          OSSL_PARAM_utf8_string(OSSL_PKEY_PARAM_DEFAULT_DIGEST, NULL, 0),
                                          OSSL_PARAM_END};
    return gettable;
}

/**
 * OSSL_PKEY_PARAM_RSA_N: BIGNUM for RSA modulus
 * OSSL_PKEY_PARAM_RSA_E: BIGNUM for RSA public exponent
 * OSSL_PKEY_PARAM_PUB_KEY: octet string for EC public point
 * OSSL_PKEY_PARAM_GROUP_NAME: UTF8 string for EC group name, like "prime256v1"
 * KEYLESS_ID: UTF8 string for key identifier
 */
static const OSSL_PARAM* KeylessImportTypes(int selection)
{
    static const OSSL_PARAM import_public_union[] = {OSSL_PARAM_BN(OSSL_PKEY_PARAM_RSA_N, NULL, 0),
                                                     OSSL_PARAM_BN(OSSL_PKEY_PARAM_RSA_E, NULL, 0),
                                                     OSSL_PARAM_octet_string(OSSL_PKEY_PARAM_PUB_KEY, NULL, 0),
                                                     OSSL_PARAM_utf8_string(OSSL_PKEY_PARAM_GROUP_NAME, NULL, 0),
                                                     OSSL_PARAM_utf8_string("KEYLESS_ID", NULL, 0),
                                                     OSSL_PARAM_END};
    if (selection & OSSL_KEYMGMT_SELECT_PUBLIC_KEY) {
        return import_public_union;
    }
    return NULL;
}

/**
 * @brief Maps operation IDs to algorithm names for RSA keys.
 * @param operation_id The operation ID to query.
 * @return The corresponding algorithm name if supported; NULL otherwise.
 */
static const char* KeylessRsaQueryOpName(int operation_id)
{
    if (operation_id == OSSL_OP_SIGNATURE || operation_id == OSSL_OP_ASYM_CIPHER) {
        return "RSA";
    }
    return NULL;
}

/**
 * @brief Maps operation IDs to algorithm names for EC keys.
 * @param operation_id The operation ID to query.
 * @return The corresponding algorithm name if supported; NULL otherwise.
 */
static const char* KeylessEcQueryOpName(int operation_id)
{
    if (operation_id == OSSL_OP_SIGNATURE) {
        return "ECDSA";
    }
    return NULL;
}

static const OSSL_DISPATCH keylessRsaKeymgmtFunctions[] = {{OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))KeylessNew},
                                                           {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))KeylessFree},
                                                           {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void))KeylessLoad},
                                                           {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void))KeylessHas},
                                                           {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void))KeylessMatch},
                                                           {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void))KeylessImport},
                                                           {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*)(void))KeylessGetParams},
                                                           {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void (*)(void))KeylessGettableParams},
                                                           {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void (*)(void))KeylessImportTypes},
                                                           {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void (*)(void))KeylessRsaQueryOpName},
                                                           {0, NULL}};

static const OSSL_DISPATCH keylessEcKeymgmtFunctions[] = {{OSSL_FUNC_KEYMGMT_NEW, (void (*)(void))KeylessNew},
                                                          {OSSL_FUNC_KEYMGMT_FREE, (void (*)(void))KeylessFree},
                                                          {OSSL_FUNC_KEYMGMT_LOAD, (void (*)(void))KeylessLoad},
                                                          {OSSL_FUNC_KEYMGMT_HAS, (void (*)(void))KeylessHas},
                                                          {OSSL_FUNC_KEYMGMT_MATCH, (void (*)(void))KeylessMatch},
                                                          {OSSL_FUNC_KEYMGMT_IMPORT, (void (*)(void))KeylessImport},
                                                          {OSSL_FUNC_KEYMGMT_GET_PARAMS, (void (*)(void))KeylessGetParams},
                                                          {OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS, (void (*)(void))KeylessGettableParams},
                                                          {OSSL_FUNC_KEYMGMT_IMPORT_TYPES, (void (*)(void))KeylessImportTypes},
                                                          {OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME, (void (*)(void))KeylessEcQueryOpName},
                                                          {0, NULL}};

/* Expose KEYMGMT algorithms */
const OSSL_ALGORITHM keylessKeymgmtAlgorithms[] = {{"RSA", "provider=keyless", keylessRsaKeymgmtFunctions, "Keyless RSA public key"},
                                                   {"EC", "provider=keyless", keylessEcKeymgmtFunctions, "Keyless EC public key"},
                                                   {NULL, NULL, NULL, NULL}};
