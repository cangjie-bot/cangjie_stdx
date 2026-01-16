# stdx.chir（当前处于开发阶段，尚不具备完整功能）

## 功能介绍

chir 包提供类型系统的基础类型定义，包括抽象类型基类、内置类型（整数、浮点数、布尔、字符等）以及引用类型等。该包为 Cangjie 语言的类型系统提供核心支持。

## API 列表

### 类

| 类名                                                                    | 功能                                 |
| ----------------------------------------------------------------------- | ------------------------------------ |
| [Type](./chir_package_api/chir_package_classes.md#class-type)           | 类型系统中所有类型的抽象基类。       |
| [BoolType](./chir_package_api/chir_package_classes.md#class-booltype)   | 表示布尔类型。                       |
| [NothingType](./chir_package_api/chir_package_classes.md#class-nothingtype) | 表示 Nothing 类型（底部类型）。      |
| [FloatType](./chir_package_api/chir_package_classes.md#class-floattype) | 表示浮点类型（Float16、Float32、Float64）。 |
| [IntType](./chir_package_api/chir_package_classes.md#class-inttype)     | 表示整数类型（有符号和无符号）。     |
| [RuneType](./chir_package_api/chir_package_classes.md#class-runetype)   | 表示字符类型。                       |
| [UnitType](./chir_package_api/chir_package_classes.md#class-unittype)   | 表示 Unit 类型（类似 C 语言中的 void）。 |
| [RefType](./chir_package_api/chir_package_classes.md#class-reftype)     | 表示引用类型。                       |
