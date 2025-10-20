/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.chir

@C
public struct Memory {
    private let _mem: CPointer<UInt8>
    private let _size: UInt64
    
    public prop mem: CPointer<UInt8> {
        get() { _mem }
    }
    
    public prop size: UInt64 {
        get() { _size }
    }
    
    public Memory(mem: CPointer<UInt8>, size: UInt64) {
        this._mem = mem
        this._size = size
    }
}