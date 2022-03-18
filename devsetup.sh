#! /bin/bash

set -euo pipefail

LANG=$(basename $PWD | cut -d- -f3)

if [ "$LANG" = "js" ]; then
    npm install
    npm test -- --grep 'DevSetup'
elif [ "$LANG" = "go" ]; then
    go test -run MemoryCache_Basic
elif [ "$LANG" = "python" ]; then
    pip3 install -r requirements.txt
    python3 -m unittest memoryCache_test.TestMemoryCache.test_basic
elif [ "$LANG" = "java" ]; then
    ./gradlew test --info --tests MemoryCacheTests.basic
else
    echo "Sorry, I don't know how to test the $LANG exercise."
    exit 1
fi
