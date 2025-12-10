#!/bin/bash

echo "start to build CHIR lib ..."
cjc ../src/stdx/CHIR/lib/*.cj --output-type=dylib -g -Woff all --no-sub-pkg -o libCHIR.lib.so

echo "start to build CHIR serialize ..."
cjc ../src/stdx/CHIR/serialize/*.cj --output-type=dylib -g -Woff all --no-sub-pkg -L . -lCHIR.lib -o libCHIR.serialize.so

echo "start to build plugin ..."
cjc ../src/stdx/plugin/*.cj --output-type=dylib -g -Woff all -L . -lCHIR.lib -o libplugin.so

echo "start to build plugin register ..."
cjc ../src/stdx/plugin/register/*.cj --compile-macro -g --no-sub-pkg -L . -lplugin -Woff all

echo "start to build plugin execute ..."
cjc ../src/stdx/plugin/execute/*.cj --output-type=dylib -g -Woff all --no-sub-pkg -L . -lCHIR.serialize -lplugin -o libplugin.execute.so

echo "start to build plugin1 ..."
cjc plugin1.cj -Woff all -L . -lplugin.execute -l-macro_stdx.plugin.register --output-type=dylib -o libplugin1.so

echo "start to build plugin2 ..."
cjc plugin2.cj -Woff all -L . -lplugin.execute -l-macro_stdx.plugin.register --output-type=dylib -o libplugin2.so

echo "start to build test case..."
cjc test.cj --plugin=libplugin1.so --plugin=libplugin2.so