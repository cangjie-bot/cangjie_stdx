# Experimental Feature - Coverage Information Printing

The Cangjie fuzzer supports running with the `-print_coverage=1` startup parameter to collect testing statistics for each function. This feature is currently under continuous improvement and is solely related to outputting coverage reports, without affecting the fuzzing process.

Since this functionality requires intrusive modifications to libfuzzer, using it necessitates linking with Cangjie's customized libfuzzer located at: $CANGJIE_HOME/lib/{linux_x86_64_cjnative, linux_aarch64_cjnative}/libclang_rt-fuzzer_no_main.a.

During compilation, both `--sanitizer-coverage-inline-8bit-counters` and `--sanitizer-coverage-pc-table` must be enabled.

Example output for C language libfuzzer:

```text
./a.out -print_coverage=1
COVERAGE:
COVERED_FUNC: hits: 5 edges: 6/8 LLVMFuzzerTestOneInput /tmp/test.cpp:5
  UNCOVERED_PC: /tmp/test.cpp:6
  UNCOVERED_PC: /tmp/test.cpp:9
```

Example output for Cangjie language cj-fuzz:

```text
./main -print_coverage=1 -runs=100
Done 100 runs in 0 second(s)
COVERAGE:
COVERED_FUNC: hits: 1 edges: 3/12 ttt <unknown cj filename>:<unknown cj line number>
  UNCOVERED_PC: <unknown cj filename>:<unknown cj line number>
  UNCOVERED_PC: <unknown cj filename>:<unknown cj line number>
  UNCOVERED_PC: <unknown cj filename>:<unknown cj line number>
  UNCOVERED_PC: <unknown cj filename>:<unknown cj line number>
  UNCOVERED_PC: <unknown cj filename>:<unknown cj line number>
  UNCOVERED_PC: <unknown cj filename>:<unknown cj line number>
  UNCOVERED_PC: <unknown cj filename>:<unknown cj line number>
  UNCOVERED_PC: <unknown cj filename>:<unknown cj line number>
  UNCOVERED_PC: <unknown cj filename>:<unknown cj line number>
UNCOVERED_FUNC: hits: 0 edges: 0/2 main <unknown cj filename>:<unknown cj line number>
COVERED_FUNC: hits: 1 edges: 1/1 ttt_cc_wrapper <unknown cj filename>:<unknown cj line number>
```