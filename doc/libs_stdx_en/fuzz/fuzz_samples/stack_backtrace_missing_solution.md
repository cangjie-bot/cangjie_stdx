# Solutions for Missing Stack Traces

Currently, these three WARNING messages appear by default when starting fuzz, as they are not implemented in the current cj-fuzz:

```text
WARNING: Failed to find function "__sanitizer_acquire_crash_state".
WARNING: Failed to find function "__sanitizer_print_stack_trace".
WARNING: Failed to find function "__sanitizer_set_death_callback".
```

During fuzzing, the process may terminate due to the following three scenarios:

1. Exception thrown
2. Timeout
3. Crash in C code

For the "exception thrown" case, the fuzz framework captures the exception and prints the stack trace, so no stack trace is missing.

Both "timeout" and "crash in C code" scenarios actually trigger SIGNALs in native code, which are not Cangjie exceptions, thus resulting in missing stack traces.

libfuzzer attempts to handle exceptional cases using functions like `__sanitizer_acquire_crash_state`, `__sanitizer_print_stack_trace`, and `__sanitizer_set_death_callback`. Among these, `__sanitizer_print_stack_trace` is responsible for printing stack traces. Mature implementations currently exist in modules like `asan` within `llvm`'s `compiler-rt`.

Therefore, the recommended solution is to include the following static library files and linking options during compilation, with explanations below:

```/usr/lib/llvm-14/lib/clang/14.0.0/lib/linux/libclang_rt.asan-x86_64.a -lgcc_s --eh-frame-hdr```

- `/usr/lib/llvm-14/lib/clang/14.0.0/lib/linux/libclang_rt.asan-x86_64.a` is included because this .a file implements `__sanitizer_print_stack_trace`, and we use it for convenience;
- `-lgcc_s` is required as stack traces depend on gcc_s;
- `--eh-frame-hdr` instructs the ld linker to generate the eh_frame_hdr section to assist with stack unwinding.

Optional environment variable: `ASAN_SYMBOLIZER_PATH=$CANGJIE_HOME/third_party/llvm/bin/llvm-symbolizer`, which may be useful in certain scenarios.

This will ultimately produce two sets of stack traces: one from Exception.printStackTrace and another from `__sanitizer_print_stack_trace`, as shown below:

```text
[WARNING]: Detect uncatched exception, maybe caused by bugs, exit now
An exception has occurred:
Exception: TRAP!
         at default.ttt(std/core::Array<...>)(/data/cangjie/libs/fuzz/ci_fuzzer0.cj:11)
         at _ZN7default3tttER_ZN8std$core5ArrayIhE_cc_wrapper(/data/cangjie/libs/fuzz/ci_fuzzer0.cj:0)
         at libfuzzerCallback(/data/cangjie/libs/fuzz/fuzz/callback.cj:34)
[INFO]: data is: [0, 202, 0, 0, 0, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255]
[INFO]: crash file will stored with libfuzzer
==425243== ERROR: libFuzzer: fuzz target exited
    #0 0x563a233fadf1 in __sanitizer_print_stack_trace (/data/cangjie/libs/fuzz/main+0x280df1)
    #1 0x563a2337c0b8 in fuzzer::PrintStackTrace() (/data/cangjie/libs/fuzz/main+0x2020b8)
    #2 0x563a2338726c in fuzzer::Fuzzer::ExitCallback() (/data/cangjie/libs/fuzz/main+0x20d26c)
    #3 0x7f485cf36494 in __run_exit_handlers stdlib/exit.c:113:8
    #4 0x7f485cf3660f in exit stdlib/exit.c:143:3
    #5 0x563a23224e68 in libfuzzerCallback$real /data/cangjie/libs/fuzz/fuzz/callback.cj:62:18
    #6 0x7f485d22718b in CJ_MCC_N2CStub (/data/cangjie/output/runtime/lib/linux_x86_64_cjnative/libcangjie-runtime.so+0x2718b)
    #7 0x563a2322fc26 in libfuzzerCallback /data/cangjie/libs/fuzz/fuzz/callback.cj:20
    #8 0x563a23387883 in fuzzer::Fuzzer::ExecuteCallback(unsigned char const*, unsigned long) (/data/cangjie/libs/fuzz/main+0x20d883)
    #9 0x563a2338a3f9 in fuzzer::Fuzzer::RunOne(unsigned char const*, unsigned long, bool, fuzzer::InputInfo*, bool, bool*) (/data/cangjie/libs/fuzz/main+0x2103f9)
    #10 0x563a23387e49 in fuzzer::Fuzzer::MutateAndTestOne() (/data/cangjie/libs/fuzz/main+0x20de49)
    #11 0x563a2338a2b5 in fuzzer::Fuzzer::Loop(std::vector<fuzzer::SizedFile, std::allocator<fuzzer::SizedFile>>&) (/data/cangjie/libs/fuzz/main+0x2102b5)
    #12 0x563a23377a12 in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long)) (/data/cangjie/libs/fuzz/main+0x1fda12)
    #13 0x563a231ad2b6 in fuzz_fake$fuzz::Fuzzer::startFuzz() /data/cangjie/libs/fuzz/fuzz/fuzzer.cj:200:13
    #14 0x563a23405fad in default::main() /data/cangjie/libs/fuzz/ci_fuzzer0.cj:5:5
    #15 0x563a23405fe7 in user.main /data/cangjie/libs/fuzz/<stdin>
    #16 0x563a234060e1 in cj_entry$ (/data/cangjie/libs/fuzz/main+0x28c0e1)
    #17 0x7f485d227220  (/data/cangjie/output/runtime/lib/linux_x86_64_cjnative/libcangjie-runtime.so+0x27220)
    #18 0x7f485d223898  (/data/cangjie/output/runtime/lib/linux_x86_64_cjnative/libcangjie-runtime.so+0x23898)
    #19 0x7f485d2607b9 in CJ_CJThreadEntry (/data/cangjie/output/runtime/lib/linux_x86_64_cjnative/libcangjie-runtime.so+0x607b9)
```