/* Keyless ASYM_CIPHER (RSA decrypt) skeleton */
#include <openssl/core.h>
#include <openssl/core_dispatch.h>
#include <openssl/core_names.h>
#include <openssl/evp.h>
#include <openssl/params.h>
#include <openssl/crypto.h>
#include <openssl/rand.h>
#include <stdlib.h>
#include "provider.h"
#include "opensslSymbols.h"
#include "api.h"
#include "securec.h"

/**
 * @brief Constant-time 8-bit zero check.
 *
 * @details Checks whether the least-significant 8 bits of the input are zero in a
 * branchless, constant-time manner and returns a full-width mask.
 *
 * @param x Input value; only the lowest 8 bits are considered.
 *
 * @return:
 *   0xFFFFFFFFu if (x & 0xFFu) == 0, otherwise 0u.
 */
static inline unsigned int CtIsZero8(unsigned int x)
{
    unsigned int v = x & 0xFFu;
    unsigned int orv = v | (0u - v);
    unsigned int msb = (orv >> 31) ^ 1u;
    return 0u - (msb & 1u);
}

/**
 * @brief Constant-time equality check for 8-bit values.
 *
 * @details Compares the least-significant 8 bits of the inputs without introducing
 * data-dependent branches or timing variability, making it suitable for
 * cryptographic use.
 *
 * @param a First value; only the low 8 bits are considered.
 * @param b Second value; only the low 8 bits are considered.
 *
 * @return:
 *  - An 8-bit mask as an unsigned int: 0xFFu if the low bytes are equal,
 *    0x00u otherwise.
 */
static inline unsigned int CtEq8(unsigned int a, unsigned int b)
{
    return CtIsZero8((a ^ b) & 0xFFu);
}

/**
 * @brief Constant-time zero test for size_t values.
 *
 * @details Produces a branch-free mask indicating whether the input is zero,
 * suitable for use in constant-time code paths to avoid timing side channels.
 *
 * @param x The value to test.
 *
 * @return:
 *   An unsigned int mask:
 *     - ~0u (all bits set) if x == 0
 *     - 0u otherwise
 */
static inline unsigned int CtIsZeroSizeT(size_t x)
{
    size_t orv = x | ((size_t)0 - x);
    size_t msb = (orv >> (sizeof(size_t) * 8 - 1)) ^ 1u;
    return 0u - (unsigned int)(msb & 1u);
}

/**
 * @brief Constant‑time equality check for size_t values.
 *
 * @details Compares two size_t values in constant time (no data‑dependent branches) by
 * XORing the inputs and testing the result for zero using a constant‑time
 * zero check. Suitable for cryptographic or side‑channel sensitive code.
 *
 * @param a First value to compare.
 * @param b Second value to compare.
 * @return unsigned int 1 if a equals b; 0 otherwise.
 *
 * @note The constant‑time guarantee relies on CtIsZeroSizeT executing in
 *       constant time for all inputs on the target platform.
 */
static inline unsigned int CtEqSizeT(size_t a, size_t b)
{
    return CtIsZeroSizeT(a ^ b);
}

/**
 * @brief Constant-time less-than comparison for size_t values.
 *
 * @details Compares two size_t operands without data-dependent branches or memory
 * accesses, suitable for cryptographic paths to mitigate timing side channels.
 *
 * @param a The left operand.
 * @param b The right operand.
 * @return 1 if a < b; otherwise 0.
 *
 * Notes:
 * - Treats size_t as an unsigned integer type.
 * - Intended for comparisons involving potentially secret data.
 * - Attempts to keep execution time independent of input values.
 */
static inline unsigned int CtLtSizeT(size_t a, size_t b)
{
    size_t diff = a - b;
    size_t msb = diff >> (sizeof(size_t) * 8 - 1);
    return 0u - (unsigned int)(msb & 1u);
}

/**
 * @brief Constant-time selection between two size_t values without data-dependent branches.
 *
 * @details This helper chooses between two candidates in a way that aims to avoid timing
 * side channels commonly introduced by conditional branches. It is intended for
 * use in cryptographic or other sensitive code paths.
 *
 * @param mask Selection mask. 
 * @param a Value returned when mask is non-zero (true).
 * @param b Value returned when mask is zero (false).
 *
 * @return The selected value (a if mask != 0, otherwise b), computed using only bitwise
 *         operations to avoid data-dependent branching.
 *
 * @note
 * - Designed to execute in time independent of the values of a, b, and mask.
 * - Callers should pass a mask that is either 0 or non-zero; non-zero is treated
 *   as "true" and is internally expanded to a full-width mask.
 */
static inline size_t CtSelectSizeT(unsigned int mask, size_t a, size_t b)
{
    /* Expand to a full-width mask: 0 -> 0x00..00, nonzero -> 0xFF..FF */
    size_t m = (size_t)0 - (size_t)(mask & 1u);
    return (m & a) | (~m & b);
}

/**
 * @brief Remove PKCS#1 v1.5 padding from an encoded message (EM).
 *
 * @details Validates the PKCS#1 v1.5 structure
 *   0x00 || 0x02 || PS || 0x00 || M
 * without data-dependent branches and, on success, copies the last 'outLen'
 * bytes of M into 'out'. The padding string PS must be at least 8 bytes and
 * contain only non-zero bytes.
 *
 * @param out      Destination buffer for the recovered message bytes.
 * @param outLen  Number of bytes to recover into 'out'.
 * @param em       Source buffer containing the encoded message (EM).
 * @param emLen   Length of 'em' in bytes (typically the RSA modulus size).
 *
 * @return:
 *   1 on success; 0 on failure (invalid format or insufficient padding).
 *
 * @note:
 *   - Buffers 'out' and 'em' must not overlap.
 *   - This routine does not perform RSA; it only removes PKCS#1 v1.5 padding.
 *
 * @see RFC 8017 (PKCS #1 v2.2), §7.2 RSAES-PKCS1-v1_5.
 */
static int Pkcs1V15Unpad(unsigned char* out, size_t outLen, const unsigned char* em, size_t emLen)
{
    /* PKCS#1 v1.5 minimal overhead = 11 bytes:
       0x00 || 0x02 || PS(>=8 non-zero) || 0x00 */
    const size_t pkcs1V15MinOverhead = 11u;

    if (!out || !em || emLen < outLen + pkcs1V15MinOverhead) {
        return 0;
    }

    unsigned int validMask = CtIsZero8(em[0]);
    /*
    * PKCS#1 v1.5: EM = 0x00 || 0x02 || PS || 0x00 || M
    * 0x02 denotes "block type 2" 
    * (RSAES-PKCS1-v1_5; PS is at least 8 non-zero random bytes; signatures use 0x01) 
    */
    validMask &= CtEq8(em[1], 0x02);

    // Find the index of the first 0x00 separator after the PS.
    // Start at index 2 because [0]=0x00, [1]=0x02 by definition.
    unsigned int zeroFound = 0;         // Will be 0xFFFFFFFF if a zero was found
    unsigned int looking = 0xFFFFFFFFu; // While still looking for the first zero
    size_t sepIndex = 0;                // Will hold the index of the first 0x00

    for (size_t i = 2; i < emLen; ++i) {
        unsigned int isZero = CtIsZero8(em[i]);
        size_t chosen = CtSelectSizeT(looking & isZero, i, sepIndex);
        sepIndex = chosen;
        zeroFound |= looking & isZero;
        looking &= ~isZero;
    }

    size_t msgIndex = sepIndex + 1;
    size_t msgLen = emLen - msgIndex;

    unsigned int psTooShort = CtLtSizeT(sepIndex, 10); // 2 (0x00,0x02) + 8 (min PS)
    unsigned int msgLenBad = ~CtEqSizeT(msgLen, outLen);

    validMask &= zeroFound;
    validMask &= ~psTooShort;
    validMask &= ~msgLenBad;

    size_t fallbackIndex = emLen >= outLen ? emLen - outLen : 0;
    size_t readIndex = CtSelectSizeT(validMask, msgIndex, fallbackIndex);
    unsigned char validMaskByte = (unsigned char)(validMask & 0xFFu);
    unsigned char invalidMaskByte = (unsigned char)(~validMaskByte);

    for (size_t i = 0; i < outLen; ++i) {
        unsigned char fallbackByte = out[i];
        unsigned char selected = em[readIndex + i];
        out[i] = (unsigned char)((validMaskByte & selected) | (invalidMaskByte & fallbackByte));
    }

    return (int)(validMask & 1u);
}

/**
 * @brief Creates a new Keyless asymmetric-cipher context.
 * @param provctx Opaque provider context (unused).
 * @return Pointer to the newly allocated KeylessAsymcipherCtx, or NULL on failure.
 */
static void* KeylessAcNewctx(void* provctx)
{
    (void)provctx;
    KEYLESS_PROVIDER_LOG("[keyless] asym newctx\n");
    return DYN_OPENSSL_zalloc(sizeof(KeylessAsymcipherCtx), NULL);
}

/**
 * @brief Frees a Keyless asymmetric-cipher context.
 * @param v Pointer to the KeylessAsymcipherCtx to free.
 * @note Also releases any associated key data.
 */
static void KeylessAcFreectx(void* v)
{
    KeylessAsymcipherCtx* c = v;
    if (!c) {
        return;
    }
    if (c->keyData) {
        KeylessKeyFreeExtern(c->keyData);
    }
    DYN_OPENSSL_secure_free(c, NULL);
}

/**
 * @brief Duplicates a Keyless asymmetric-cipher context.
 * @param v Pointer to the KeylessAsymcipherCtx to duplicate.
 * @return Pointer to the newly allocated duplicate context, or NULL on failure.
 * @note Increments the reference count of any associated key data.
 * @note used by OpenSSL when duplicating operation contexts.
 */
static void* KeylessAcDupctx(void* v)
{
    KeylessAsymcipherCtx* c = v;
    if (!c) {
        return NULL;
    }

    KeylessAsymcipherCtx* n = DYN_OPENSSL_memdup(c, sizeof(*c), NULL);
    if (!n) {
        return NULL;
    }

    if (n->keyData) {
        KeylessKeyUpRef(n->keyData);
    }
    return n;
}

/**
 * @brief Initializes the Keyless asymmetric-cipher context for decryption.
 * @param vctx    Opaque operation context to initialize.
 * @param keydata Pointer to the key data to use for decryption.
 * @param params  Array of OSSL_PARAM parameters (unused).
 * @return 1 on success; 0 on failure (e.g., invalid parameters or unsupported key type).
 */
static int KeylessAcDecryptInit(void* vctx, void* keydata, const OSSL_PARAM params[])
{
    (void)params;
    KeylessAsymcipherCtx* c = vctx;
    if (!c || !keydata) {
        return 0;
    }

    KeylessKeyUpRef(keydata);
    c->keyData = keydata;
    c->type = KeylessKeyGetType(keydata);
    if (c->type != 1) {
        return 0;
    }
    return 1;
}

/**
 * @brief Decrypts a ciphertext buffer using the keyless asymmetric-cipher provider context.
 *
 * @details This function follows the provider asym-cipher decrypt contract:
 * - If out is NULL, the function sets *outlen to the required plaintext size and returns success.
 * - If out is not NULL, outsize must be large enough; the function writes the plaintext to out
 *   and sets *outlen to the number of bytes written.
 *
 * Parameters:
 * @param vctx    Opaque operation context initialized for the intended key/algorithm and mode.
 * @param out     Destination buffer for the plaintext, or NULL to query the required size.
 * @param outlen  Output: receives the required or actual plaintext length in bytes.
 * @param outsize Size of the out buffer in bytes (ignored when out is NULL).
 * @param in      Source buffer containing the ciphertext to decrypt.
 * @param inlen   Length of the ciphertext in bytes.
 *
 * @returns
 * - 1 on success (whether sizing query or actual decryption),
 * - 0 on failure (e.g., invalid parameters, buffer too small, unsupported operation, or backend error).
 *
 * @note
 * - The vctx is not thread-safe for concurrent use across threads.
 * - On error, no plaintext is written and *outlen is left unmodified unless performing a size query.
 */
static int KeylessAcDecrypt(void* vctx, unsigned char* out, size_t* outlen, size_t outsize, const unsigned char* in, size_t inlen)
{
    KeylessAsymcipherCtx* c = vctx;
    if (!c || !c->keyData) {
        return 0;
    }
    size_t modlen = KeylessKeyGetRsaNLen(c->keyData);
    if (!modlen) {
        modlen = KeylessKeyGetSize(c->keyData);
    }
    if (modlen == 0) {
        return 0;
    }

    const size_t TLS_RSA_PMS_LENGTH = 48; // TLS RSA PMS length fixed 48 bytes
    if (!out) {
        if (outlen) {
            *outlen = TLS_RSA_PMS_LENGTH;
        }
        KEYLESS_PROVIDER_LOG("[keyless] asym size query -> %zu\n", TLS_RSA_PMS_LENGTH);
        return 1;
    }

    if (outsize < TLS_RSA_PMS_LENGTH) {
        return 0;
    }

    DynMsg* dynMsg = KeylessProviderGetThreadDynMsg();
    const char* keyId = ((KeylessKey*)(c->keyData))->keyId;
    KeylessRemoteDecryptCb dcb = KeylessLookupDecryptCb(keyId);
    if (!dcb) {
        int lib = KeylessErrorLibInit();
        KEYLESS_PROVIDER_LOG("[keyless] %d: decrypt callback not set.\n", lib);
        return 0;
    }

    if (DYN_RAND_bytes(out, TLS_RSA_PMS_LENGTH, dynMsg) <= 0) {
        int lib = KeylessErrorLibInit();
        KEYLESS_PROVIDER_LOG("[keyless] %d: RAND_bytes failed.\n", lib);
        return 0;
    }

    unsigned char* cipher = NULL;
    unsigned char* em = NULL;
    int ok = 0;

    cipher = DYN_OPENSSL_secure_malloc(modlen, dynMsg);
    em = DYN_OPENSSL_secure_malloc(modlen, dynMsg);
    if (!cipher || !em) {
        goto cleanup;
    }

    memset_s(cipher, modlen, 0, modlen);
    memset_s(em, modlen, 0, modlen);

    size_t copyLen = inlen;
    const unsigned char* src = in;
    if (copyLen > modlen) {
        src = in + (inlen - modlen);
        copyLen = modlen;
    }
    if (memcpy_s(cipher + (modlen - copyLen), copyLen, src, copyLen) != EOK) {
        goto cleanup;
    }

    KEYLESS_PROVIDER_LOG("[keyless] asym decrypt inlen=%zu paddedLen=%zu\n", inlen, modlen);

    int64_t written = 0;
    unsigned char* remote = (unsigned char*)dcb(keyId, cipher, (int64_t)modlen, &written);
    int success = 0;
    if (remote && written > 0 && (size_t)written <= modlen) {
        size_t produced = (size_t)written;
        if (memcpy_s(em + (modlen - produced), produced, remote, produced) != EOK) {
            goto cleanup;
        }
        success = Pkcs1V15Unpad(out, TLS_RSA_PMS_LENGTH, em, modlen);
        KEYLESS_PROVIDER_LOG("[keyless] asym decrypt remoteLen=%zu success=%d\n", produced, success);
    } else {
        KEYLESS_PROVIDER_LOG("[keyless] asym decrypt remote failure (written=%ld)\n", (long)written);
        (void)Pkcs1V15Unpad(out, TLS_RSA_PMS_LENGTH, em, modlen);
    }

    if (outlen) {
        *outlen = TLS_RSA_PMS_LENGTH;
    }

    ok = 1;

cleanup:
    if (cipher) {
        DYN_OPENSSL_cleanse(cipher, modlen, dynMsg);
        DYN_OPENSSL_secure_free(cipher, dynMsg);
    }
    if (em) {
        DYN_OPENSSL_cleanse(em, modlen, dynMsg);
        DYN_OPENSSL_secure_free(em, dynMsg);
    }
    KeylessCheckDynMsg(dynMsg, "KeylessAcDecrypt");
    return ok;
}

static const OSSL_PARAM* KeylessAcGettableCtxParams(void* provctx)
{
    (void)provctx;
    static const OSSL_PARAM params[] = {OSSL_PARAM_END};
    return params;
}

static const OSSL_PARAM* KeylessAcSettableCtxParams(void* provctx)
{
    (void)provctx;
    static const OSSL_PARAM params[] = {OSSL_PARAM_END};
    return params;
}

static int KeylessAcGetCtxParams(void* vctx, OSSL_PARAM params[])
{
    (void)vctx;
    (void)params;
    return 1;
}

static int KeylessAcSetCtxParams(void* vctx, const OSSL_PARAM params[])
{
    (void)vctx;
    (void)params;
    return 1;
}

const OSSL_DISPATCH keylessAsymcipherFunctions[] = {{OSSL_FUNC_ASYM_CIPHER_NEWCTX, (void (*)(void))KeylessAcNewctx},
                                                    {OSSL_FUNC_ASYM_CIPHER_FREECTX, (void (*)(void))KeylessAcFreectx},
                                                    {OSSL_FUNC_ASYM_CIPHER_DUPCTX, (void (*)(void))KeylessAcDupctx},
                                                    {OSSL_FUNC_ASYM_CIPHER_DECRYPT_INIT, (void (*)(void))KeylessAcDecryptInit},
                                                    {OSSL_FUNC_ASYM_CIPHER_DECRYPT, (void (*)(void))KeylessAcDecrypt},
                                                    {OSSL_FUNC_ASYM_CIPHER_GETTABLE_CTX_PARAMS, (void (*)(void))KeylessAcGettableCtxParams},
                                                    {OSSL_FUNC_ASYM_CIPHER_GET_CTX_PARAMS, (void (*)(void))KeylessAcGetCtxParams},
                                                    {OSSL_FUNC_ASYM_CIPHER_SETTABLE_CTX_PARAMS, (void (*)(void))KeylessAcSettableCtxParams},
                                                    {OSSL_FUNC_ASYM_CIPHER_SET_CTX_PARAMS, (void (*)(void))KeylessAcSetCtxParams},
                                                    {0, NULL}};

/* Algorithm export (referenced in provider) */
const OSSL_ALGORITHM keylessAsymcipherAlgorithms[] = {{"RSA:rsaEncryption:1.2.840.113549.1.1.1", "provider=keyless", keylessAsymcipherFunctions, "Keyless RSA Decrypt (remote)"},
                                                      {NULL, NULL, NULL, NULL}};
