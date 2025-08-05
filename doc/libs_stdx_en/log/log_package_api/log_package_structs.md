# Struct

## struct LogLevel

```cangjie
public struct LogLevel <: ToString & Comparable<LogLevel> {
    public static const OFF: LogLevel = LogLevel("OFF", 0x7FFF_FFFF)
    public static const FATAL: LogLevel = LogLevel("FATAL", 6000)
    public static const ERROR: LogLevel = LogLevel("ERROR", 5000)
    public static const WARN: LogLevel = LogLevel("WARN", 4000)
    public static const INFO: LogLevel = LogLevel("INFO", 3000)
    public static const DEBUG: LogLevel = LogLevel("DEBUG", 2000)
    public static const TRACE: LogLevel = LogLevel("TRACE", 1000)
    public static const ALL: LogLevel = LogLevel("ALL", -0x8000_0000)
    public let name: String
    public let value: Int32
    public const init(name: String, value: Int32)
}
```

Function: [LogLevel](log_package_structs.md#struct-loglevel) is a log level structure.

Defines seven log levels in descending order: `OFF`, `FATAL`, `ERROR`, `WARN`, `INFO`, `DEBUG`, `TRACE`, `ALL`.

We expect only log entries with levels greater than or equal to the specified print level to be output.

Parent types:

- ToString
- Comparable\<[LogLevel](#struct-loglevel)>

### static const ALL

```cangjie
public static const ALL: LogLevel = LogLevel("ALL", -0x8000_0000)
```

Function: Gets a static constant instance of log level with ALL level.

### static const DEBUG

```cangjie
public static const DEBUG: LogLevel = LogLevel("DEBUG", 2000)
```

Function: Gets a static constant instance of log level with DEBUG level.

### static const ERROR

```cangjie
public static const ERROR: LogLevel = LogLevel("ERROR", 5000)
```

Function: Gets a static constant instance of log level with ERROR level.

### static const FATAL

```cangjie
public static const FATAL: LogLevel = LogLevel("FATAL", 6000)
```

Function: Gets a static constant instance of log level with FATAL level.

### static const INFO

```cangjie
public static const INFO: LogLevel = LogLevel("INFO", 3000)
```

Function: Gets a static constant instance of log level with INFO level.

### static const OFF

```cangjie
public static const OFF: LogLevel = LogLevel("OFF", 0x7FFF_FFFF)
```

Function: Gets a static constant instance of log level with OFF level.

### static const TRACE

```cangjie
public static const TRACE: LogLevel = LogLevel("TRACE", 1000)
```

Function: Gets a static constant instance of log level with TRACE level.

### static const WARN

```cangjie
public static const WARN: LogLevel = LogLevel("WARN", 4000)
```

Function: Gets a static constant instance of log level with WARN level.

### let name

```cangjie
public let name: String
```

Function: The name of the log level.

### let value

```cangjie
public let value: Int32
```

Function: The value of the log level.

### const init(String, Int32)

```cangjie
public const init(name: String, value: Int32)
```

Function: Constant constructor that creates a LogLevel object.

Parameters:

- name: String - The name of the log level.
- value: Int32 - The value of the log level.

### func compare(LogLevel)

```cangjie
public func compare(rhs: LogLevel): Ordering
```

Function: Compares the current [LogLevel](log_package_structs.md#struct-loglevel) instance with another [LogLevel](log_package_structs.md#struct-loglevel) instance.

Parameters:

- rhs: [LogLevel](log_package_structs.md#struct-loglevel) - Another instance to compare with the current one.

Return value:

- Ordering - Returns Ordering.GT if greater, Ordering.EQ if equal, and Ordering.LT if less.

### func toString()

```cangjie
public func toString(): String
```

Function: Gets the name corresponding to the log level.

Return value:

- String - The name of the current log level.

### operator func ==(LogLevel)

```cangjie
public operator func ==(rhs: LogLevel): Bool
```

Function: Compares log levels.

Parameters:

- rhs: [LogLevel](log_package_structs.md#struct-loglevel) - Compares the current log level with `target`.

Return value:

- Bool - Returns `true` if the current log level equals `target`, otherwise returns `false`.

### operator func !=(LogLevel)

```cangjie
public operator func !=(rhs: LogLevel): Bool
```

Function: Compares log levels.

Parameters:

- rhs: [LogLevel](log_package_structs.md#struct-loglevel) - Compares the current log level with `target`.

Return value:

- Bool - Returns `true` if the current log level does not equal `target`, otherwise returns `false`.

### operator func >=(LogLevel)

```cangjie
public operator func >=(rhs: LogLevel): Bool
```

Function: Compares log levels.

Parameters:

- rhs: [LogLevel](log_package_structs.md#struct-loglevel) - Compares the current log level with `target`.

Return value:

- Bool - Returns `true` if the current log level is greater than or equal to `target`, otherwise returns `false`.

### operator func <=(LogLevel)

```cangjie
public operator func <=(rhs: LogLevel): Bool
```

Function: Compares log levels.

Parameters:

- rhs: [LogLevel](log_package_structs.md#struct-loglevel) - Compares the current log level with `target`.

Return value:

- Bool - Returns `true` if the current log level is less than or equal to `target`, otherwise returns `false`.

### operator func >(LogLevel)

```cangjie
public operator func >(rhs: LogLevel): Bool
```

Function: Compares log levels.

Parameters:

- rhs: [LogLevel](log_package_structs.md#struct-loglevel) - Compares the current log level with `target`.

Return value:

- Bool - Returns `true` if the current log level is greater than `target`, otherwise returns `false`.

### operator func <(LogLevel)

```cangjie
public operator func <(rhs: LogLevel): Bool
```

Function: Compares log levels.

Parameters:

- rhs: [LogLevel](log_package_structs.md#struct-loglevel) - Compares the current log level with `target`.

Return value:

- Bool - Returns `true` if the current log level is less than `target`, otherwise returns `false`.