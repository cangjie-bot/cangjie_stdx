# Printing Fuzz Usage Instructions

You can use `-help=1` to print the help message and `-seed=246468919` to specify the random number seed.

The execution result is as follows:

```text
$ ./main -help=1

Usage:
To run fuzzing pass 0 or more directories.
program_name [-flag1=val1 [-flag2=val2 ...] ] [dir1 [dir2 ...] ]
To run individual tests without fuzzing pass 1 or more files:
program_name [-flag1=val1 [-flag2=val2 ...] ] file1 [file2 ...]
```