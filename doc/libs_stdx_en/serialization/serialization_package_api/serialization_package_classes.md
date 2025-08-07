# Classes

## class DataModel

```cangjie
public abstract class DataModel
```

Function: This class serves as the intermediate data layer.

## class DataModelBool

```cangjie
public class DataModelBool <: DataModel {
    public init(bv: Bool)
}
```

Function: This class is a subclass of [DataModel](serialization_package_classes.md#class-datamodel), implementing encapsulation for Bool type data.

Parent Types:

- [DataModel](#class-datamodel)

### init(Bool)

```cangjie
public init(bv: Bool)
```

Function: Constructs a [DataModelBool](serialization_package_classes.md#class-datamodelbool) instance with initial data.

Parameters:

- bv: Bool - The input Bool type data.

### func getValue()

```cangjie
public func getValue(): Bool
```

Function: Retrieves the data from [DataModelBool](serialization_package_classes.md#class-datamodelbool).

Return Value:

- Bool - The `value` of Bool type stored in [DataModelBool](serialization_package_classes.md#class-datamodelbool).

## class DataModelFloat

```cangjie
public class DataModelFloat <: DataModel {
    public init(fv: Float64)
    public init(v: Int64)
}
```

Function: This class is a subclass of [DataModel](serialization_package_classes.md#class-datamodel), implementing encapsulation for Float64 type data.

Parent Types:

- [DataModel](#class-datamodel)

### init(Float64)

```cangjie
public init(fv: Float64)
```

Function: Constructs a [DataModelFloat](serialization_package_classes.md#class-datamodelfloat) instance with initial data.

Parameters:

- fv: Float64 - The input Float64 type data.

### init(Int64)

```cangjie
public init(v: Int64)
```

Function: Constructs a [DataModelFloat](serialization_package_classes.md#class-datamodelfloat) instance with initial data.

Parameters:

- v: Int64 - The input Int64 type data.

### func getValue()

```cangjie
public func getValue(): Float64
```

Function: Retrieves the data from [DataModelFloat](serialization_package_classes.md#class-datamodelfloat).

Return Value:

- Float64 - The `value` of Float64 type stored in [DataModelFloat](serialization_package_classes.md#class-datamodelfloat).

## class DataModelInt

```cangjie
public class DataModelInt <: DataModel {
    public init(iv: Int64)
}
```

Function: This class is a subclass of [DataModel](serialization_package_classes.md#class-datamodel), implementing encapsulation for Int64 type data.

Parent Types:

- [DataModel](#class-datamodel)

### init(Int64)

```cangjie
public init(iv: Int64)
```

Function: Constructs a [DataModelInt](serialization_package_classes.md#class-datamodelint) instance with initial data.

Parameters:

- iv: Int64 - The input Int64 type data.

### func getValue()

```cangjie
public func getValue(): Int64
```

Function: Retrieves the data from [DataModelInt](serialization_package_classes.md#class-datamodelint).

Return Value:

- Int64 - The `value` of Int64 type stored in [DataModelInt](serialization_package_classes.md#class-datamodelint).

## class DataModelNull

```cangjie
public class DataModelNull <: DataModel
```

Function: This class is a subclass of [DataModel](serialization_package_classes.md#class-datamodel), implementing encapsulation for `Null` type data.

Parent Types:

- [DataModel](#class-datamodel)

## class DataModelSeq

```cangjie
public class DataModelSeq <: DataModel {
    public init()
    public init(list: ArrayList<DataModel>)
}
```

Function: This class is a subclass of [DataModel](serialization_package_classes.md#class-datamodel), implementing encapsulation for ArrayList\<[DataModel](serialization_package_classes.md#class-datamodel)> type data.

Parent Types:

- [DataModel](#class-datamodel)

### init()

```cangjie
public init()
```

Function: Constructs an empty-parameter [DataModelSeq](serialization_package_classes.md#class-datamodelseq) instance. The data defaults to an empty ArrayList\<[DataModel](serialization_package_classes.md#class-datamodel)>.

### init(ArrayList\<DataModel>)

```cangjie
public init(list: ArrayList<DataModel>)
```

Function: Constructs a [DataModelSeq](serialization_package_classes.md#class-datamodelseq) instance with initial data.

Parameters:

- list: ArrayList\<[DataModel](serialization_package_classes.md#class-datamodel)> - The input ArrayList\<[DataModel](serialization_package_classes.md#class-datamodel)> type data.

### func add(DataModel)

```cangjie
public func add(dm: DataModel): Unit 
```

Function: Appends a [DataModel](serialization_package_classes.md#class-datamodel) data item to the end of [DataModelSeq](serialization_package_classes.md#class-datamodelseq).

Parameters:

- dm: [DataModel](serialization_package_classes.md#class-datamodel) - The input [DataModel](serialization_package_classes.md#class-datamodel) type data.

### func getItems()

```cangjie
public func getItems(): ArrayList<DataModel>
```

Function: Retrieves the data from [DataModelSeq](serialization_package_classes.md#class-datamodelseq).

Return Value:

- ArrayList\<[DataModel](serialization_package_classes.md#class-datamodel)> - The data stored in [DataModelSeq](serialization_package_classes.md#class-datamodelseq), of type ArrayList\<[DataModel](serialization_package_classes.md#class-datamodel)>.

## class DataModelString

```cangjie
public class DataModelString <: DataModel {
    public init(sv: String)
}
```

Function: This class is a subclass of [DataModel](serialization_package_classes.md#class-datamodel), implementing encapsulation for String type data.

Parent Types:

- [DataModel](#class-datamodel)

### init(String)

```cangjie
public init(sv: String)
```

Function: Constructs a [DataModelString](serialization_package_classes.md#class-datamodelstring) with initial data.

Parameters:

- sv: String - The input String type data.

### func getValue()

```cangjie
public func getValue(): String
```

Function: Retrieves the data from [DataModelString](serialization_package_classes.md#class-datamodelstring).

Return Value:

- String - The `value` of String type stored in [DataModelString](serialization_package_classes.md#class-datamodelstring).

## class DataModelStruct

```cangjie
public class DataModelStruct <: DataModel {
    public init()
    public init(list: ArrayList<Field>)
}
```

Function: This class is a subclass of [DataModel](serialization_package_classes.md#class-datamodel), used to convert `class` objects to [DataModel](serialization_package_classes.md#class-datamodel).

Parent Types:

- [DataModel](#class-datamodel)

### init()

```cangjie
public init()
```

Function: Constructs a parameterless `DataModelStruct` with `fields` defaulting to an empty ArrayList\<[Field](serialization_package_classes.md#class-field)>.

### init(ArrayList\<Field>)

```cangjie
public init(list: ArrayList<Field>)
```

Function: Constructs a [DataModelStruct](serialization_package_classes.md#class-datamodelstruct) with initial data.

Parameters:

- list: ArrayList\<[Field](serialization_package_classes.md#class-field)> - The input ArrayList\<[Field](serialization_package_classes.md#class-field)> type data.

### func add(Field)

```cangjie
public func add(fie: Field): DataModelStruct
```

Function: Adds data `fie` to [DataModelStruct](serialization_package_classes.md#class-datamodelstruct).

Parameters:

- fie: [Field](serialization_package_classes.md#class-field) - The input [Field](serialization_package_classes.md#class-field) type data.

Return Value:

- [DataModelStruct](serialization_package_classes.md#class-datamodelstruct) - The new [DataModelStruct](serialization_package_classes.md#class-datamodelstruct).

### func get(String)

```cangjie
public func get(key: String): DataModel
```

Function: Retrieves the data corresponding to the `key`.

Parameters:

- key: String - The input parameter of String type.

Return Value:

- [DataModel](serialization_package_classes.md#class-datamodel) - Returns a [DataModel](serialization_package_classes.md#class-datamodel) type. If no corresponding value is found, returns [DataModelNull](serialization_package_classes.md#class-datamodelnull).

### func getFields()

```cangjie
public func getFields(): ArrayList<Field>
```

Function: Retrieves the data collection of [DataModelStruct](serialization_package_classes.md#class-datamodelstruct).

Return Value:

- ArrayList\<[Field](serialization_package_classes.md#class-field)> - Returns a data collection of type ArrayList\<[Field](serialization_package_classes.md#class-field)>.

## class Field

```cangjie
public class Field {
    public init(name: String, data: DataModel)
}
```

Function: Used to store elements of [DataModelStruct](serialization_package_classes.md#class-datamodelstruct).

### init(String, DataModel)

```cangjie
public init(name: String, data: DataModel)
```

Function: Constructor for [Field](serialization_package_classes.md#class-field).

Parameters:

- name: String - The value for the `name` field. Behavior is consistent whether `name` is an empty string `""` or any other string.
- data: [DataModel](serialization_package_classes.md#class-datamodel) - The value for the `data` field.

### func getData()

```cangjie
public func getData(): DataModel
```

Function: Retrieves the `data` field.

Return Value:

- [DataModel](serialization_package_classes.md#class-datamodel) - The retrieved `data` field, of type [DataModel](serialization_package_classes.md#class-datamodel).

### func getName()

```cangjie
public func getName(): String
```

Function: Retrieves the `name` field.

Return Value:

- String - The retrieved `name` field, of type String.
```