#! /bin/bash

set -euo pipefail

LANG=$(basename $PWD | cut -d- -f3)

cd $LANG

if [ "$LANG" = "js" ]; then
    if [ ! -x "$(which npm)" ]; then
        echo "===================="
        echo "NPM isn't installed"
        echo "===================="
        echo
        echo "Even's JavaScript interview requires Node 12+ and NPM.  Please install them, then run:"
        echo
        echo "    ./devsetup.sh"
        exit 1
    fi

    npm install
    npm test -- --grep 'DevSetup'
elif [ "$LANG" = "go" ]; then
    if [ ! -x "$(which go)" ]; then
        echo "===================="
        echo "Go isn't installed"
        echo "===================="
        echo
        echo "Even's Go interview requires Go 1.13+.  Please install it, then run:"
        echo
        echo "    ./devsetup.sh"
        exit 1
    fi
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
