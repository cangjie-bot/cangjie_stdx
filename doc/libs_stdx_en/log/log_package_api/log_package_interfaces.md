# Interface

## interface LogValue

```cangjie
public interface LogValue {
    func writeTo(w: LogWriter): Unit
}
```

Function: Provides an interface for types to serialize to log output targets.

Used in conjunction with [LogWriter](log_package_classes.md#class-logwriter), [LogWriter](log_package_classes.md#class-logwriter) can write types implementing the [LogValue](log_package_interfaces.md#interface-logvalue) interface to log output targets via writeValue.

### func writeTo(LogWriter)

```cangjie
func writeTo(w: LogWriter): Unit
```

Function: Writes types implementing the [LogValue](log_package_interfaces.md#interface-logvalue) interface to the [LogWriter](log_package_classes.md#class-logwriter) instance specified by parameter `w`.

Parameters:

- w: [LogWriter](log_package_classes.md#class-logwriter) - The [LogWriter](log_package_classes.md#class-logwriter) instance for writing serialized results.

### extend Bool <: LogValue

```cangjie
extend Bool <: LogValue
```

Function: Implements the LogValue interface for Bool type.

Parent types:

- [LogValue](#interface-logvalue)

#### func writeTo(LogWriter)

```cangjie
public func writeTo(w: LogWriter): Unit
```

Function: Provides serialization capability for Bool type to streams.

Parameters:

- w: [LogWriter](log_package_classes.md#class-logwriter) - The [LogWriter](log_package_classes.md#class-logwriter) instance for writing serialized results.

### extend Exception <: LogValue

```cangjie
extend Exception <: LogValue
```

Function: Implements the [LogValue](./log_package_interfaces.md#interface-logvalue) interface for Exception type.

Parent types:

- [LogValue](#interface-logvalue)

#### func writeTo(LogWriter)

```cangjie
public func writeTo(w: LogWriter): Unit
```

Function: Provides serialization capability for Exception type to streams.

Parameters:

- w: [LogWriter](log_package_classes.md#class-logwriter) - The [LogWriter](log_package_classes.md#class-logwriter) instance for writing serialized results.

### extend Int64 <: LogValue

```cangjie
extend Int64 <: LogValue
```

Function: Implements the LogValue interface for Int64 type.

Parent types:

- [LogValue](#interface-logvalue)

#### func writeTo(LogWriter)

```cangjie
public func writeTo(w: LogWriter): Unit
```

Function: Provides serialization capability for Int64 type to streams.

Parameters:

- w: [LogWriter](log_package_classes.md#class-logwriter) - The [LogWriter](log_package_classes.md#class-logwriter) instance for writing serialized results.

### extend Float64 <: LogValue

```cangjie
extend Float64 <: LogValue
```

Function: Implements the LogValue interface for Float64 type.

Parent types:

- [LogValue](#interface-logvalue)

#### func writeTo(LogWriter)

```cangjie
public func writeTo(w: LogWriter): Unit
```

Function: Provides serialization capability for Float64 type to streams.

Parameters:

- w: [LogWriter](log_package_classes.md#class-logwriter) - The [LogWriter](log_package_classes.md#class-logwriter) instance for writing serialized results.

### extend String <: LogValue

```cangjie
extend String <: LogValue
```

Function: Implements the LogValue interface for String type.

Parent types:

- [LogValue](#interface-logvalue)

#### func writeTo(LogWriter)

```cangjie
public func writeTo(w: LogWriter): Unit
```

Function: Provides serialization capability for String type to streams.

Parameters:

- w: [LogWriter](log_package_classes.md#class-logwriter) - The [LogWriter](log_package_classes.md#class-logwriter) instance for writing serialized results.

### extend DateTime <: LogValue

```cangjie
extend DateTime <: LogValue
```

Function: Implements the LogValue interface for DateTime type.

Parent types:

- [LogValue](#interface-logvalue)

#### func writeTo(LogWriter)

```cangjie
public func writeTo(w: LogWriter): Unit
```

Function: Provides serialization capability for DateTime type to streams.

Parameters:

- w: [LogWriter](log_package_classes.md#class-logwriter) - The [LogWriter](log_package_classes.md#class-logwriter) instance for writing serialized results.

### extend Duration <: LogValue

```cangjie
extend Duration <: LogValue
```

Function: Implements the LogValue interface for Duration type.

Parent types:

- [LogValue](#interface-logvalue)

#### func writeTo(LogWriter)

```cangjie
public func writeTo(w: LogWriter): Unit
```

Function: Provides serialization capability for Duration type to streams.

Parameters:

- w: [LogWriter](log_package_classes.md#class-logwriter) - The [LogWriter](log_package_classes.md#class-logwriter) instance for writing serialized results.

### extend\<T> Array\<T> <: LogValue where T <: LogValue

```cangjie
extend<T> Array<T> <: LogValue where T <: LogValue
```

Function: Implements the LogValue interface for Array\<T> type.

Parent types:

- [LogValue](#interface-logvalue)

#### func writeTo(LogWriter)

```cangjie
public func writeTo(w: LogWriter): Unit
```

Function: Provides serialization capability for Array\<T> type to streams.

Parameters:

- w: [LogWriter](log_package_classes.md#class-logwriter) - The [LogWriter](log_package_classes.md#class-logwriter) instance for writing serialized results.

### extend\<V> HashMap\<String, V> <: LogValue where V <: LogValue

```cangjie
extend<V> HashMap<String, V> <: LogValue where V <: LogValue
```

Function: Implements the LogValue interface for HashMap\<K, V> type.

Parent types:

- [LogValue](#interface-logvalue)

#### func writeTo(LogWriter)

```cangjie
public func writeTo(w: LogWriter): Unit
```

Function: Provides serialization capability for HashMap\<K, V> type to streams.

Parameters:

- w: [LogWriter](log_package_classes.md#class-logwriter) - The [LogWriter](log_package_classes.md#class-logwriter) instance for writing serialized results.

### extend\<V> TreeMap\<String, V> <: LogValue where V <: LogValue

```cangjie
extend<V> TreeMap<String, V> <: LogValue where V <: LogValue
```

Function: Implements the LogValue interface for TreeMap\<K, V> type.

Parent types:

- [LogValue](#interface-logvalue)

#### func writeTo(LogWriter)

```cangjie
public func writeTo(w: LogWriter): Unit
```

Function: Provides serialization capability for TreeMap\<K, V> type to streams.

Parameters:

- w: [LogWriter](log_package_classes.md#class-logwriter) - The [LogWriter](log_package_classes.md#class-logwriter) instance for writing serialized results.

### extend\<T> Option\<T> <: LogValue where T <: LogValue

```cangjie
extend<T> Option<T> <: LogValue where T <: LogValue
```

Function: Implements the LogValue interface for Option\<T> type.

Parent types:

- [LogValue](#interface-logvalue)

#### func writeTo(LogWriter)

```cangjie
public func writeTo(w: LogWriter): Unit
```

Function: Provides serialization capability for Option\<T> type to streams.

Parameters:

- w: [LogWriter](log_package_classes.md#class-logwriter) - The [LogWriter](log_package_classes.md#class-logwriter) instance for writing serialized results.