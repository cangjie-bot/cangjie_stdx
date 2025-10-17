# Classes

## class Command\<Res>

```cangjie
public abstract class Command<Res> {
    public open func defaultImpl(): Res
}
```

**Description:** This abstract class represents an **effect** that can be performed and handled.

**Type Parameters:**

- **Res**: The expected result type returned when the effect is performed.

### func defaultImpl()

```cangjie
public open func defaultImpl(): Res
```

**Description:** This is the default handler for the effect. If an effect is not explicitly handled by any handler, this method will throw an [UnhandledCommandException](./effect_package_exceptions.md#class-unhandledcommandexception). You can override this method in a concrete `Command` subclass to provide a default implementation for the effect.

**Returns:**

- **Res**: The result of performing the effect (if you provide a default implementation).

**Throws:**

- [UnhandledCommandException](./effect_package_exceptions.md#class-unhandledcommandexception) — Thrown when this function is not overridden.
