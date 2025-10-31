#!/bin/bash

echo "start to build CHIR lib ..."
cjc ../src/stdx/CHIR/lib/*.cj --output-type=dylib -g -Woff all -o libCHIRlib.so

echo "start to build CHIR entry ..."
cjc ../src/stdx/CHIR/pluginEntry/*.cj --output-type=dylib -g -o libCHIRentry.so

echo "start to build CHIR macro ..."
cjc ../src/stdx/CHIR/pluginMacro/*.cj --compile-macro -g

echo "start to build plugin1 ..."
cjc plugin1.cj -L . -lCHIRlib -lCHIRentry -l-macro_stdx.CHIR.pluginMacro --output-type=dylib -o libplugin1.so

echo "start to build plugin2 ..."
cjc plugin2.cj -L . -lCHIRlib -lCHIRentry -l-macro_stdx.CHIR.pluginMacro --output-type=dylib -o libplugin2.so

echo "start to build test case..."
cjc test.cj --plugin=libplugin1.so --plugin=libplugin2.so