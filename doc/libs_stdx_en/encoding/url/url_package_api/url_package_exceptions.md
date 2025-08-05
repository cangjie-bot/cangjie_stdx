# Exception Classes

## class UrlSyntaxException

```cangjie
public class UrlSyntaxException <: Exception {
    public init(reason: String)
    public init(input: String, reason: String)
    public init(input: String, reason: String, pos: String)
}
```

Function: URL parsing exception class.

Parent Type:

- Exception

### init(String)

```cangjie
public init(reason: String)
```

Function: Constructs a [UrlSyntaxException](url_package_exceptions.md#class-urlsyntaxexception) instance based on the error reason.

Parameters:

- reason: String - The cause of the parsing error.

### init(String, String)

```cangjie
public init(input: String, reason: String)
```

Function: Constructs a [UrlSyntaxException](url_package_exceptions.md#class-urlsyntaxexception) instance based on the URL and error reason.

Parameters:

- input: String - The original URL or its fragment.
- reason: String - The cause of the parsing error.

### init(String, String, String)

```cangjie
public init(input: String, reason: String, pos: String)
```

Function: Constructs a [UrlSyntaxException](url_package_exceptions.md#class-urlsyntaxexception) instance based on the URL string, error reason, and the failed parsing portion.

Parameters:

- input: String - The original URL or its fragment.
- reason: String - The cause of the parsing error.
- pos: String - The portion of the given URL string that failed to parse.