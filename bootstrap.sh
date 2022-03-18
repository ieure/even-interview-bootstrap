#! /bin/bash
#
# This script bootstraps the Even interview repository.
#
# If you're reading this instead of running it blindly, great!  You
# just demonstrated one of our company values, curiosity.

set -euo pipefail

ZIPF=https://github.com/ieure/even-interview-bootstrap/archive/refs/heads/main.zip

if [ -e "$REPO" ]; then
    echo "Sorry, the repo name wasn't specified, so I can't do anything."
    exit 1
fi

NAME=$(echo $REPO | cut -d/ -f2)

mkdir -p $NAME
cd $NAME

if [ -x "$(which curl)" ]; then
    curl -sL -O $ZIPF
else
    echo "You need to install wget or curl."
    exit 1
fi

unzip -d . main.zip
rm main.zip

git init -b main .
git remote add origin git@github.com:$REPO

./ssh-key.sh
./devsetup.sh

git add .
git commit --no-gpg-sign -am "Added bootstrap repo"
git push -u origin main

echo "========================================"
echo "You're good to go!"
echo "========================================"
ecno
echo "Great, everything should be working!  Please take a few minutes to read:\n"
echo "    http://github.com/$REPO/README.md\n"
echo "It has important information about the interview."

