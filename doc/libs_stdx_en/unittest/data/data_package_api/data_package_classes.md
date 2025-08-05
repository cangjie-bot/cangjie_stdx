# Classes

## class CsvStrategy

```cangjie
public class CsvStrategy<T> <: DataStrategy<T> where T <: Serializable<T> {}
```

Function: Implementation of DataStrategy for CSV data format serialization.

Parent Types:

- DataStrategy\<T>

### func provider(Configuration)

```cangjie
public override func provider(configuration: Configuration): SerializableProvider<T>
```

Function: Generates a serialized data iterator.

Parameters:

- configuration: Configuration - Data configuration information.

Return Value:

- [SerializableProvider](#class-serializableprovider)\<T> - Serialized iterator object.

## class JsonStrategy

```cangjie
public class JsonStrategy<T> <: DataStrategy<T> where T <: Serializable<T> {}
```

Function: Implementation of DataStrategy for JSON data format serialization.

Parent Types:

- DataStrategy\<T>

### func provider(Configuration)

```cangjie
public override func provider(configuration: Configuration): SerializableProvider<T>
```

Function: Generates a serialized data iterator.

Parameters:

- configuration: Configuration - Data configuration information.

Return Value:

- SerializableProvider\<T> - Serialized iterator object.

## class SerializableProvider

```cangjie
public class SerializableProvider<T> <: DataProvider<T> where T <: Serializable<T> {}
```

Function: Implementation of the DataProvider interface for obtaining serialized data.

Parent Types:

- DataProvider\<T>

### prop isInfinite

```cangjie
public prop isInfinite: Bool
```

Function: Whether to generate infinite data.

Bool.

### func provide()

```cangjie
public override func provide(): Iterable<T> 
```

Function: Retrieves a data iterator.

Return Value:

- Iterable\<T> - Data iterator.