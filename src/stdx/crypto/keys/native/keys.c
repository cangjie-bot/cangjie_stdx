/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

#include <openssl/evp.h>
#include <openssl/ssl.h>
#include <string.h>
#include "opensslSymbols.h"
#define CJKEYS_FAIL (-1)
#define CJKEYS_OK 1

extern int32_t DYN_CJ_KEYS_OAEPSetting(
    EVP_PKEY_CTX* ctx, const char* label, const EVP_MD* md, const EVP_MD* mgf, DynMsg* dynMsg)
{
    if (DYN_EVP_PKEY_CTX_set_rsa_oaep_md(ctx, md, dynMsg) <= 0 ||
        DYN_EVP_PKEY_CTX_set_rsa_mgf1_md(ctx, mgf, dynMsg) <= 0) {
        return CJKEYS_FAIL;
    }

    // if label is NULL, or length is 0, EVP_PKEY_CTX_set0_rsa_oaep_label would clear the original label in ctx
    if (NULL == label || strlen(label) == 0) {
        // a bug in openssl3 (https://github.com/openssl/openssl/issues/21288)
        // EVP_PKEY_CTX_set0_rsa_oaep_label behavior wrong when accept NULL
        // a walkaround fix, pLabel will be freed in EVP_PKEY_CTX_set0_rsa_oaep_label
        char* pLabel = DYN_CRYPTO_malloc(1, "", 0, dynMsg);
        if (!pLabel) {
            return CJKEYS_FAIL;
        }
        pLabel[0] = '\0';
        int ret = DYN_EVP_PKEY_CTX_set0_rsa_oaep_label(ctx, pLabel, 0, dynMsg);
        if (ret <= 0) {
            DYN_CRYPTO_free(pLabel, dynMsg);
            return CJKEYS_FAIL;
        }
        return CJKEYS_OK;
    }

    size_t labelLen = strlen(label);
    if (labelLen > INT32_MAX) {
        return CJKEYS_FAIL;
    }

    char* labelSsl = DYN_CRYPTO_malloc(labelLen + 1, "", 0, dynMsg);
    if (!labelSsl) {
        return CJKEYS_FAIL;
    }

    if (DYN_OPENSSL_strlcpy(labelSsl, label, labelLen + 1, dynMsg) != labelLen) {
        DYN_CRYPTO_free(labelSsl, dynMsg);
        return CJKEYS_FAIL;
    }

    if (DYN_EVP_PKEY_CTX_set0_rsa_oaep_label(ctx, labelSsl, (int)(labelLen), dynMsg) <= 0) {
        DYN_CRYPTO_free(labelSsl, dynMsg);
        return CJKEYS_FAIL;
    }

    // labelSsl has been freed in func EVP_PKEY_CTX_set0_rsa_oaep_label if return 1
    return CJKEYS_OK;
}