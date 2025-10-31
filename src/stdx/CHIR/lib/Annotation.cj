/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib

public class AnnoClassInfo <: ToString {
    private let _classSrcCodeName: String = ""
    private var _fields = ArrayList<String>()

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public prop classSrcCodeName: String {
        get() {
            return _classSrcCodeName
        }
    }

    public prop fields: ArrayList<String> {
        get() {
            return _fields
        }
    }
}

public class Annotation <: ToString {
    private let _identifier: String = "none"
    private var _annoClasses = ArrayList<AnnoClassInfo>()

    // TODO: 后面实现
    public func toString(): String {
        String()
    }

    public prop identifier: String {
        get() {
            return _identifier
        }
    }

    public prop annoClasses: ArrayList<AnnoClassInfo> {
        get() {
            return _annoClasses
        }
    }
}