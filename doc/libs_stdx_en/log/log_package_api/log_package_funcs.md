# Functions

## func getGlobalLogger(Array\<Attr>)

```cangjie
public func getGlobalLogger(attrs: Array<Attr>): Logger
```

Function: Retrieves a [Logger](log_package_classes.md#class-logger) object.

> **Note:**
>
> If no `attrs` parameter is passed, the same [Logger](log_package_classes.md#class-logger) object will be retrieved. When `attrs` parameter is provided, a copy of the [Logger](log_package_classes.md#class-logger) object containing the specified attributes will be created.

Parameters:

- attrs: Array\<[Attr](log_package_types.md#type-attr)> - Key-value pair attributes for log data. The retrieved [Logger](log_package_classes.md#class-logger) object will contain these attributes.

Return Value:

- [Logger](log_package_classes.md#class-logger) - An instance of the [Logger](log_package_classes.md#class-logger) class.

## func setGlobalLogger(Logger)

```cangjie
public func setGlobalLogger(logger: Logger): Unit
```

Function: Sets the global [Logger](log_package_classes.md#class-logger) object.

> **Important:**
>
> - This function should only be called once during the program's lifecycle. Any log events occurring before the completion of `setGlobalLogger` call will be ignored.
> - This function typically doesn't need to be called manually. Log implementation providers should offer initialization methods that include calling this function.

Parameters:

- logger: [Logger](log_package_classes.md#class-logger) - An instance of a class implementing the [Logger](log_package_classes.md#class-logger) interface.