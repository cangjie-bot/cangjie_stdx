# Structures

## struct HttpStatusCode

```cangjie
public struct HttpStatusCode {
    public static const STATUS_CONTINUE: UInt16 =                        100
    public static const STATUS_SWITCHING_PROTOCOLS: UInt16 =             101
    public static const STATUS_PROCESSING: UInt16 =                      102
    public static const STATUS_EARLY_HINTS: UInt16 =                     103
 
    public static const STATUS_OK: UInt16 =                              200
    public static const STATUS_CREATED: UInt16 =                         201
    public static const STATUS_ACCEPTED: UInt16 =                        202
    public static const STATUS_NON_AUTHORITATIVE_INFO: UInt16 =          203
    public static const STATUS_NO_CONTENT: UInt16 =                      204
    public static const STATUS_RESET_CONTENT: UInt16 =                   205
    public static const STATUS_PARTIAL_CONTENT: UInt16 =                 206
    public static const STATUS_MULTI_STATUS: UInt16 =                    207
    public static const STATUS_ALREADY_REPORTED: UInt16 =                208
    public static const STATUS_IM_USED: UInt16 =                         226
 
    public static const STATUS_MULTIPLE_CHOICES: UInt16 =                300
    public static const STATUS_MOVED_PERMANENTLY: UInt16 =               301
    public static const STATUS_FOUND: UInt16 =                           302
    public static const STATUS_SEE_OTHER: UInt16 =                       303
    public static const STATUS_NOT_MODIFIED: UInt16 =                    304
    public static const STATUS_USE_PROXY: UInt16 =                       305
    public static const STATUS_TEMPORARY_REDIRECT: UInt16 =              307
    public static const STATUS_PERMANENT_REDIRECT: UInt16 =              308
 
    public static const STATUS_BAD_REQUEST: UInt16 =                     400
    public static const STATUS_UNAUTHORIZED: UInt16 =                    401
    public static const STATUS_PAYMENT_REQUIRED: UInt16 =                402
    public static const STATUS_FORBIDDEN: UInt16 =                       403
    public static const STATUS_NOT_FOUND: UInt16 =                       404
    public static const STATUS_METHOD_NOT_ALLOWED: UInt16 =              405
    public static const STATUS_NOT_ACCEPTABLE: UInt16 =                  406
    public static const STATUS_PROXY_AUTH_REQUIRED: UInt16 =             407
    public static const STATUS_REQUEST_TIMEOUT: UInt16 =                 408
    public static const STATUS_CONFLICT: UInt16 =                        409
    public static const STATUS_GONE: UInt16 =                            410
    public static const STATUS_LENGTH_REQUIRED: UInt16 =                 411
    public static const STATUS_PRECONDITION_FAILED: UInt16 =             412
    public static const STATUS_REQUEST_CONTENT_TOO_LARGE: UInt16 =       413
    public static const STATUS_REQUEST_URI_TOO_LONG: UInt16 =            414
    public static const STATUS_UNSUPPORTED_MEDIA_TYPE: UInt16 =          415
    public static const STATUS_REQUESTED_RANGE_NOT_SATISFIABLE: UInt16 = 416
    public static const STATUS_EXPECTATION_FAILED: UInt16 =              417
    public static const STATUS_TEAPOT: UInt16 =                          418
    public static const STATUS_MISDIRECTED_REQUEST: UInt16 =             421
    public static const STATUS_UNPROCESSABLE_ENTITY: UInt16 =            422
    public static const STATUS_LOCKED: UInt16 =                          423
    public static const STATUS_FAILED_DEPENDENCY: UInt16 =               424
    public static const STATUS_TOO_EARLY: UInt16 =                       425
    public static const STATUSUPGRADE_REQUIRED: UInt16 =                426
    public static const STATUS_PRECONDITION_REQUIRED: UInt16 =           428
    public static const STATUS_TOO_MANY_REQUESTS: UInt16 =               429
    public static const STATUS_REQUEST_HEADER_FIELDS_TOO_LARGE: UInt16 = 431
    public static const STATUS_UNAVAILABLE_FOR_LEGAL_REASONS: UInt16 =   451
 
    public static const STATUS_INTERNAL_SERVER_ERROR: UInt16 =           500
    public static const STATUS_NOT_IMPLEMENTED: UInt16 =                 501
    public static const STATUS_BAD_GATEWAY: UInt16 =                     502
    public static const STATUS_SERVICE_UNAVAILABLE: UInt16 =             503
    public static const STATUS_GATEWAY_TIMEOUT: UInt16 =                 504
    public static const STATUS_HTTP_VERSION_NOT_SUPPORTED: UInt16 =      505
    public static const STATUS_VARIANT_ALSO_NEGOTIATES: UInt16 =         506
    public static const STATUS_INSUFFICIENT_STORAGE: UInt16 =            507
    public static const STATUS_LOOP_DETECTED: UInt16 =                   508
    public static const STATUS_NOT_EXTENDED: UInt16 =                    510
    public static const STATUS_NETWORK_AUTHENTICATION_REQUIRED: UInt16 = 511
}
```

Function: Represents the 3-digit status codes of HTTP responses from web servers.

Status codes are defined by RFC 9110 specification and extended by RFC2518, RFC 3229, RFC 4918, RFC 5842, RFC 7168, and RFC 8297 specifications.

The first digit of all status codes represents one of five response states:

- 1xx (Informational) status codes indicate a provisional response communicating connection status or request progress before the final response is sent.
- 2xx (Successful) status codes indicate that the client's request was successfully received, understood, and accepted.
- 3xx (Redirection) status codes indicate that the user agent needs to take further action to complete the request.
- 4xx (Client Error) status codes indicate that the client appears to have erred.
- 5xx (Server Error) status codes indicate that the server is aware it has erred or is incapable of performing the requested method.

### static const STATUS_ACCEPTED

```cangjie
public static const STATUS_ACCEPTED: UInt16 = 202
```

Function: The request has been accepted for processing, but the processing has not been completed.

Type: UInt16

### static const STATUS_ALREADY_REPORTED

```cangjie
public static const STATUS_ALREADY_REPORTED: UInt16 = 208
```

Function: The message body will be an XML message.

Type: UInt16

### static const STATUS_BAD_GATEWAY

```cangjie
public static const STATUS_BAD_GATEWAY: UInt16 = 502
```

Function: The server, while acting as a gateway or proxy, received an invalid response from the upstream server.

Type: UInt16

### static const STATUS_BAD_REQUEST

```cangjie
public static const STATUS_BAD_REQUEST: UInt16 = 400
```

Function: The request could not be understood by the server due to malformed syntax, or the request parameters are incorrect.

Type: UInt16

### static const STATUS_CONFLICT

```cangjie
public static const STATUS_CONFLICT: UInt16 = 409
```

Function: The request could not be completed due to a conflict with the current state of the target resource.

Type: UInt16

### static const STATUS_CONTINUE

```cangjie
public static const STATUS_CONTINUE: UInt16 = 100
```

Function: This interim response indicates that the initial part of the request has been received and has not yet been rejected by the server.

Type: UInt16

> **Note:**
>
> The client should continue sending the remainder of the request or ignore this response if the request is already complete.
> The server must send a final response after the request is completed.

### static const STATUS_CREATED

```cangjie
public static const STATUS_CREATED: UInt16 = 201
```

Function: The request has been fulfilled and resulted in a new resource being created, with its URI returned in the Location header.

Type: UInt16

### static const STATUS_EARLY_HINTS

```cangjie
public static const STATUS_EARLY_HINTS: UInt16 = 103
```

Function: Used for early hints (preloading CSS, JS) documents.

Type: UInt16

### static const STATUS_EXPECTATION_FAILED

```cangjie
public static const STATUS_EXPECTATION_FAILED: UInt16 = 417
```

Function: The server cannot meet the requirements of the Expect request-header field.

Type: UInt16

### static const STATUS_FAILED_DEPENDENCY

```cangjie
public static const STATUS_FAILED_DEPENDENCY: UInt16 = 424
```

Function: The current request failed due to an error in a previous request.

Type: UInt16

### static const STATUS_FORBIDDEN

```cangjie
public static const STATUS_FORBIDDEN: UInt16 = 403
```

Function: The server understood the request but refuses to authorize it.

Type: UInt16

### static const STATUS_FOUND

```cangjie
public static const STATUS_FOUND: UInt16 = 302
```

Function: Temporary redirection.

Type: UInt16

> **Note:**
>
> The requested resource has been temporarily moved to a new URI, and the client should continue to use the original address for subsequent requests.

### static const STATUS_GATEWAY_TIMEOUT

```cangjie
public static const STATUS_GATEWAY_TIMEOUT: UInt16 = 504
```

Function: The server, while acting as a gateway or proxy, did not receive a timely response from the upstream server (identified by the URI, e.g., HTTP, FTP, LDAP) or auxiliary server (e.g., DNS).

Type: UInt16

### static const STATUS_GONE

```cangjie
public static const STATUS_GONE: UInt16 = 410
```

Function: The requested resource is no longer available on the server, and no forwarding address is known.

Type: UInt16

### static const STATUS_HTTP_VERSION_NOT_SUPPORTED

```cangjie
public static const STATUS_HTTP_VERSION_NOT_SUPPORTED: UInt16 = 505
```

Function: The server does not support or refuses to support the HTTP version used in the request.

Type: UInt16

### static const STATUS_IM_USED

```cangjie
public static const STATUS_IM_USED: UInt16 = 226
```

Function: The server has fulfilled the request for the resource, and the response represents the result of one or more instance operations applied to the current instance.

Type: UInt16

### static const STATUS_INSUFFICIENT_STORAGE

```cangjie
public static const STATUS_INSUFFICIENT_STORAGE: UInt16 = 507
```

Function: The server is unable to store the representation needed to complete the request.

Type: UInt16

### static const STATUS_INTERNAL_SERVER_ERROR

```cangjie
public static const STATUS_INTERNAL_SERVER_ERROR: UInt16 = 500
```

Function: The server encountered an unexpected condition that prevented it from fulfilling the request.

Type: UInt16

### static const STATUS_LENGTH_REQUIRED

```cangjie
public static const STATUS_LENGTH_REQUIRED: UInt16 = 411
```

Function: The server refuses to accept the request without a defined Content-Length header.

Type: UInt16

### static const STATUS_LOCKED

```cangjie
public static const STATUS_LOCKED: UInt16 = 423
```

Function: The current resource is locked.

Type: UInt16

### static const STATUS_LOOP_DETECTED

```cangjie
public static const STATUS_LOOP_DETECTED: UInt16 = 508
```

Function: The server detected infinite recursion while processing the request.

Type: UInt16

### static const STATUS_METHOD_NOT_ALLOWED

```cangjie
public static const STATUS_METHOD_NOT_ALLOWED: UInt16 = 405
```

Function: The request method specified in the request line cannot be used for the requested resource.

Type: UInt16

### static const STATUS_MISDIRECTED_REQUEST

```cangjie
public static const STATUS_MISDIRECTED_REQUEST: UInt16 = 421
```

Function: The request was directed to a server that is unable to produce a response.

Type: UInt16

### static const STATUS_MOVED_PERMANENTLY

```cangjie
public static const STATUS_MOVED_PERMANENTLY: UInt16 = 301
```

Function: Moved Permanently.

Type: UInt16

> **Note:**
>
> The requested resource has been permanently moved to a new URI. The response includes the new URI, and the browser will automatically redirect to it.

### static const STATUS_MULTIPLE_CHOICES

```cangjie
public static const STATUS_MULTIPLE_CHOICES: UInt16 = 300
```

Function: The requested resource has a list of alternative representations, each with its own specific address and browser-driven negotiation information.

Type: UInt16

> **Note:**
>
> The user or browser can select a preferred address for redirection.

### static const STATUS_MULTI_STATUS

```cangjie
public static const STATUS_MULTI_STATUS: UInt16 = 207
```

Function: DAV-bound members have already been enumerated in a (Multi-Status) response and are not included again.

Type: UInt16

### static const STATUS_NETWORK_AUTHENTICATION_REQUIRED

```cangjie
public static const STATUS_NETWORK_AUTHENTICATION_REQUIRED: UInt16 = 511
```

Function: Network Authentication Required.

Type: UInt16

### static const STATUS_NON_AUTHORITATIVE_INFO

```cangjie
public static const STATUS_NON_AUTHORITATIVE_INFO: UInt16 = 203
```

Function: The server has successfully processed the request.

Type: UInt16

> **Note:**
>
> The returned entity-header metadata is not the definitive set from the original server but a local or third-party copy.

### static const STATUS_NOT_ACCEPTABLE

```cangjie
public static const STATUS_NOT_ACCEPTABLE: UInt16 = 406
```

Function: The requested resource's content characteristics cannot satisfy the conditions in the request headers, thus unable to generate a response entity.

Type: UInt16

### static const STATUS_NOT_EXTENDED

```cangjie
public static const STATUS_NOT_EXTENDED: UInt16 = 510
```

Function: The policy for accessing the resource has not been met.

Type: UInt16

### static const STATUS_NOT_FOUND

```cangjie
public static const STATUS_NOT_FOUND: UInt16 = 404
```

Function: The request failed because the requested resource was not found on the server.

Type: UInt16

### static const STATUS_NOT_IMPLEMENTED

```cangjie
public static const STATUS_NOT_IMPLEMENTED: UInt16 = 501
```

Function: The server does not support a required feature for the current request.

Type: UInt16

### static const STATUS_NOT_MODIFIED

```cangjie
public static const STATUS_NOT_MODIFIED: UInt16 = 304
```

Function: The requested resource has not been modified. The server returns this status code without any resource.

Type: UInt16

> **Note:**
>
> Clients typically cache accessed resources. By providing a header indicating the client wishes to receive only resources modified after a specified date.

### static const STATUS_NO_CONTENT

```cangjie
public static const STATUS_NO_CONTENT: UInt16 = 204
```

Function: The server successfully processed the request but returned no content.

Type: UInt16

### static const STATUS_OK

```cangjie
public static const STATUS_OK: UInt16 = 200
```

Function: The request has succeeded. The desired response headers or data body will be returned with this response.

Type: UInt16

### static const STATUS_PARTIAL_CONTENT

```cangjie
public static const STATUS_PARTIAL_CONTENT: UInt16 = 206
```

Function: The server has successfully processed a partial GET request.

Type: UInt16

### static const STATUS_PAYMENT_REQUIRED

```cangjie
public static const STATUS_PAYMENT_REQUIRED: UInt16 = 402
```

Function: Reserved for future use.

Type: UInt16

### static const STATUS_PERMANENT_REDIRECT

```cangjie
public static const STATUS_PERMANENT_REDIRECT: UInt16 = 308
```

Function: The request and all future requests should use another URI.

Type: UInt16

### static const STATUS_PRECONDITION_FAILED

```cangjie
public static const STATUS_PRECONDITION_FAILED: UInt16 = 412
```

Function: The server failed to meet one or more preconditions specified in the request headers.

Type: UInt16

### static const STATUS_PRECONDITION_REQUIRED

```cangjie
public static const STATUS_PRECONDITION_REQUIRED: UInt16 = 428
```

Function: The client must meet certain preconditions when sending an HTTP request.

Type: UInt16

### static const STATUS_PROCESSING

```cangjie
public static const STATUS_PROCESSING: UInt16 = 102
```

Function: Processing will continue.

Type: UInt16

### static const STATUS_PROXY_AUTH_REQUIRED

```cangjie
public static const STATUS_PROXY_AUTH_REQUIRED: UInt16 = 407
```

Function: Authentication is required on the proxy server.

Type: UInt16

### static const STATUS_REQUESTED_RANGE_NOT_SATISFIABLE

```cangjie
public static const STATUS_REQUESTED_RANGE_NOT_SATISFIABLE: UInt16 = 416
```

Function: The client's requested range is invalid.

Type: UInt16

> **Note:**
>
> The request includes a `Range` header, and none of the specified ranges overlap with the available range of the current resource. Additionally, the request does not include an `If-Range` header.

### static const STATUS_REQUEST_CONTENT_TOO_LARGE

```cangjie
public static const STATUS_REQUEST_CONTENT_TOO_LARGE: UInt16 = 413
```

Function: The size of the submitted entity data exceeds the server's willingness or ability to process.

Type: UInt16

### static const STATUS_REQUEST_HEADER_FIELDS_TOO_LARGE

```cangjie
public static const STATUS_REQUEST_HEADER_FIELDS_TOO_LARGE: UInt16 = 431
```

Function: The request header fields are too large.

Type: UInt16

### static const STATUS_REQUEST_TIMEOUT

```cangjie
public static const STATUS_REQUEST_TIMEOUT: UInt16 = 408
```

Function: The request timed out. The client did not complete the request within the server's prepared waiting time.

Type: UInt16

### static const STATUS_REQUEST_URI_TOO_LONG

```cangjie
public static const STATUS_REQUEST_URI_TOO_LONG: UInt16 = 414
```

Function: The length of the requested URI exceeds the server's ability to interpret.

Type: UInt16

### static const STATUS_RESET_CONTENT

```cangjie
public static const STATUS_RESET_CONTENT: UInt16 = 205
```

Function: The server successfully processed the request but returned no content, expecting the requester to reset the document view.

Type: UInt16

### static const STATUS_SEE_OTHER

```cangjie
public static const STATUS_SEE_OTHER: UInt16 = 303
```

Function: Indicates that the response to the current request can be found at a different [URL](../../../encoding/url/url_package_api/url_package_classes.md#class-url), and the client should use the GET method to access that resource.

Type: UInt16

### static const STATUS_SERVICE_UNAVAILABLE

```cangjie
public static const STATUS_SERVICE_UNAVAILABLE: UInt16 = 503
```

Function: Temporary server maintenance or overload.

Type: UInt16

### static const STATUS_SWITCHING_PROTOCOLS

```cangjie
public static const STATUS_SWITCHING_PROTOCOLS: UInt16 = 101
```

Function: The server has understood the client's request and will notify the client via the Upgrade header to use a different protocol to complete this request.

Type: UInt16

> **Note:**
>
> After sending the final empty line of this response, the server will switch to the protocols defined in the Upgrade header.

### static const STATUS_TEAPOT

```cangjie
public static const STATUS_TEAPOT: UInt16 = 418
```

Function: The server cannot process the request, a whimsical status code known as the "I'm a teapot" error, which should not be taken seriously.

Type: UInt16

### static const STATUS_TEMPORARY_REDIRECT

```cangjie
public static const STATUS_TEMPORARY_REDIRECT: UInt16 = 307
```

Function: Temporary redirect.

Type: UInt16

### static const STATUS_TOO_EARLY

```cangjie
public static const STATUS_TOO_EARLY: UInt16 = 425
```

Function: The server is unwilling to risk processing this request.

Type: UInt16

### static const STATUS_TOO_MANY_REQUESTS

```cangjie
public static const STATUS_TOO_MANY_REQUESTS: UInt16 = 429
```

Function: Too many requests.

Type: UInt16

### static const STATUS_UNAUTHORIZED

```cangjie
public static const STATUS_UNAUTHORIZED: UInt16 = 401
```

Function: The current request requires user authentication.

Type: UInt16

### static const STATUS_UNAVAILABLE_FOR_LEGAL_REASONS

```cangjie
public static const STATUS_UNAVAILABLE_FOR_LEGAL_REASONS: UInt16 = 451
```

Function: The request is unavailable for legal reasons.

Type: UInt16

### static const STATUS_UNPROCESSABLE_ENTITY

```cangjie
public static const STATUS_UNPROCESSABLE_ENTITY: UInt16 = 422
```

Function: The request is well-formed but cannot be processed due to semantic errors.

Type: UInt16

### static const STATUS_UNSUPPORTED_MEDIA_TYPE

```cangjie
public static const STATUS_UNSUPPORTED_MEDIA_TYPE: UInt16 = 415
```

Function: The server cannot process the media format attached to the request.

Type: UInt16

> **Note:**
>
> For the requested function and resource, the entity submitted in the request is not in a format supported by the server.

### static const STATUS_UPGRADE_REQUIRED

```cangjie
public static const STATUS_UPGRADE_REQUIRED: UInt16 = 426
```

Function: The server refuses to process the request sent by the client using the current protocol but may accept it if sent using an upgraded protocol.

Type: UInt16

### static const STATUS_USE_PROXY

```cangjie
public static const STATUS_USE_PROXY: UInt16 = 305
```

Function: Use a proxy; the requested resource must be accessed through a proxy.

Type: UInt16

### static const STATUS_VARIANT_ALSO_NEGOTIATES

```cangjie
public static const STATUS_VARIANT_ALSO_NEGOTIATES: UInt16 = 506
```

Function: The server has an internal configuration error.

Type: UInt16

## struct ServicePoolConfig

```cangjie
public struct ServicePoolConfig {
    public let capacity: Int64
    public let queueCapacity: Int64
    public let preheat: Int64
    public init(capacity!: Int64 = 10 ** 4, queueCapacity!: Int64 = 10 ** 4, preheat!: Int64 = 0)
}
```

Function: Configuration for the coroutine pool of the Http [Server](http_package_classes.md#class-server).

> **Note:**
>
> For HTTP/1.1 [Server](http_package_classes.md#class-server), each received request will be processed by a coroutine taken from the pool. If the task queue is full, the request will be rejected, and the connection will be terminated.
> For HTTP/2 [Server](http_package_classes.md#class-server), multiple coroutines will be taken from the pool during processing. If the task queue is full, the process will block until a coroutine becomes available.

### let capacity

```cangjie
public let capacity: Int64
```

Function: Gets the capacity of the coroutine pool.

Type: Int64

### let preheat

```cangjie
public let preheat: Int64
```

Function: Gets the number of coroutines to be pre-started when the service launches.

Type: Int64

### let queueCapacity

```cangjie
public let queueCapacity: Int64
```

Function: Gets the maximum number of tasks that can be queued in the buffer.

Type: Int64

### init(Int64, Int64, Int64)

```cangjie
public init(
    capacity!: Int64 = 10 ** 4,
    queueCapacity!: Int64 = 10 ** 4,
    preheat!: Int64 = 0
)
```

Function: Constructs a [ServicePoolConfig](http_package_structs.md#struct-servicepoolconfig) instance.

Parameters:

- capacity!: Int64 - The capacity of the coroutine pool, default value is 10000.
- queueCapacity!: Int64 - The maximum number of tasks that can be queued in the buffer, default value is 10000.
- preheat!: Int64 - The number of coroutines to be pre-started when the service launches, default value is 0.

Exceptions:

- IllegalArgumentException - Thrown when parameters capacity/queueCapacity/preheat are less than 0, or when preheat is greater than capacity.

## struct TransportConfig

```cangjie
public struct TransportConfig
```

Function: Transport layer configuration class, used for server connection establishment.

### prop keepAliveConfig

```cangjie
public mut prop keepAliveConfig: SocketKeepAliveConfig
```

Function: Sets and retrieves the keep-alive configuration for transport layer connections. Default configuration includes an idle time of 45s, probe interval of 5s, and 5 probe attempts before considering the connection invalid. Actual timing granularity may vary by OS.

Type: SocketKeepAliveConfig

### prop readBufferSize

```cangjie
public mut prop readBufferSize: ?Int64
```

Function: Sets and retrieves the read buffer size for transport layer connections. Default is None. If set to a value less than 0, an IllegalArgumentException will be thrown when the server establishes the connection.

> **Note:**
>
> When using the default value, the actual buffer size will be determined by the operating system.

Type: ?Int64

### prop readTimeout

```cangjie
public mut prop readTimeout: Duration
```

Function: Sets and retrieves the read timeout for transport layer connections. If set to less than 0, it will be set to 0. Default value is Duration.Max.

Type: Duration

### prop writeBufferSize

```cangjie
public mut prop writeBufferSize: ?Int64
```

Function: Sets and retrieves the write buffer size for transport layer connections. Default is None. If set to a value less than 0, an IllegalArgumentException will be thrown when the server establishes the connection.

> **Note:**
>
> When using the default value, the actual buffer size will be determined by the operating system.

Type: ?Int64

### prop writeTimeout

```cangjie
public mut prop writeTimeout: Duration
```

Function: Sets and retrieves the write timeout for transport layer connections. If set to less than 0, it will be set to 0. Default value is Duration.Max.

Type: Duration
