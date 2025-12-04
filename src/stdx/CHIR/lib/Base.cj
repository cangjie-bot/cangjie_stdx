/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package stdx.CHIR.lib

internal abstract class Base {
    private var attributes: AttributeInfo = AttributeInfo()
    private var annotations: Annotation = Annotation()
    private var chirAnno = ArrayList<CHIRAnno>()

    public func getAnno<T>(): Any where T <: CHIRAnno {
        for (anno in chirAnno) {
            if (anno is T) {
                return anno.get()
            }
        }
        return T.defaultValue()
    }
    public func setAnno<T>(value: Any): Unit where T <: CHIRAnno {
        for (anno in chirAnno) {
            if (anno is T) {
                anno.set(value)
                return
            }
        }
        chirAnno.add(T.create(value))
    }
    public func enableOpen(): Unit {
        attributes.setAttr(Attribute.VIRTUAL, true)
    }

    public func disableOpen(): Unit {
        attributes.setAttr(Attribute.VIRTUAL, false)
        attributes.setAttr(Attribute.ABSTRACT, false)
    }

    public func isOpen(): Bool {
        return attributes.testAttr(Attribute.VIRTUAL)
    }

    public func enableAbstract(): Unit {
        attributes.setAttr(Attribute.ABSTRACT, true)
    }

    public func disableAbstract(): Unit {
        attributes.setAttr(Attribute.ABSTRACT, false)
    }

    public func isAbstract(): Bool {
        return attributes.testAttr(Attribute.ABSTRACT)
    }

    public func enableImported(): Unit {
        attributes.setAttr(Attribute.IMPORTED, true)
    }

    public func disableImported(): Unit {
        attributes.setAttr(Attribute.IMPORTED, false)
    }

    public func isImported(): Bool {
        return attributes.testAttr(Attribute.IMPORTED)
    }
}
