# Overriding defaultImpl

The following program uses a series of effect handlers to count how many layers of calls to `deeper` a computation is
under.
The default handler, given by `GetDepth.defaultImpl`, says that the depth under no explicit handlers is 0.
Each handler installed by `deeper` reperforms the `GetDepth` effect and resumes the computation with a depth 1 more than
what it was outside this call to `deeper`.

```cangjie
package test_cj

import stdx.effect.*

public class GetDepth <: Command<Int64> {
    public func defaultImpl(): Int64 {
        0
    }
}

func deeper<T>(f: () -> T): Unit {
    try {
        f()
    } handle(e: GetDepth) {
        resume with ((perform e) + 1)
    }
}

main() {
    println("Depth: ${perform GetDepth()}")
    deeper {
        println("Depth: ${perform GetDepth()}")
        deeper {
            println("Depth: ${perform GetDepth()}")
        }
        println("Depth: ${perform GetDepth()}")
    }
    println("Depth: ${perform GetDepth()}")
}
```

This program produces the following output.

```
Depth: 0
Depth: 1
Depth: 2
Depth: 1
Depth: 0
```

Overriding `defaultImpl` to always return a value means that this program will never throw an
`UnhandledCommandException`.
This program behaves the same as if the body of `main` were wrapped in the handler
`try { ... } handle(_: GetDepth) { resume with 0 }`.
