#! /bin/bash
#
# This script bootstraps the Even interview repository.
#
# If you're reading this instead of running it blindly, great!  You
# just demonstrated one of our company values, curiosity.

set -euo pipefail
set -x

ZIPF=https://github.com/ieure/even-interview-bootstrap/archive/refs/heads/main.zip

if [ -e "$REPO" ]; then
    echo "Sorry, the repo name wasn't specified, so I can't do anything."
    exit 1
fi

NAME=$(echo $REPO | cut -d/ -f2)

mkdir -p $NAME
cd $NAME

if [ -x "$(which wget)" ]; then
    wget $ZIPF;
elif [ -x "$(which curl)" ]; then
    curl -O $ZIPF
else
    echo "You need to install wget or curl."
    exit 1
fi

unzip main.zip
rm main.zip
mv even-interview-bootstrap-main/* .
rmdir even-interview-bootstrap-main
git init -b main .
git remote add origin git@github.com:$REPO

./ssh-key.sh
./devsetup.sh

git add .
git commit --no-gpg-sign -am "Added bootstrap repo"
git push -u origin main
