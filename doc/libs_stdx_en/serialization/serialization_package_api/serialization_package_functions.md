# Function

## func field\<T>(String, T) where T <: Serializable\<T>

```cangjie
public func field<T>(name: String, data: T) : Field where T <: Serializable<T>
```

Functionality: This function is used to encapsulate a set of data `name` and `data` into a [Field](serialization_package_classes.md#class-field) object. It processes the data pair `name` and `data`, serializes `data` into [DataModel](serialization_package_classes.md#class-datamodel) type, and encapsulates both into a [Field](serialization_package_classes.md#class-field) object.

Parameters:

- name: String - String type. When the `name` field is `""`, its behavior is consistent with other string values.
- data: T - Type `T`, where `T` must implement the [Serializable](serialization_package_interfaces.md#interface-serializable)\<T> interface.

Return Value:

- [Field](serialization_package_classes.md#class-field) - A [Field](serialization_package_classes.md#class-field) object encapsulating both `name` and `data`.