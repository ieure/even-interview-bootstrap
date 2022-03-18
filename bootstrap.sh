#! /bin/bash

ZIPF=https://github.com/ieure/even-interview-bootstrap/archive/refs/heads/main.zip

if [ -x wget ]; then
    wget $ZIPF;
elif [ -x curl ]; then
    curl -O $ZIPF
else
    echo "You need to install wget or curl."
    exit 1
fi

unzip main.zip
rm main.zip
cd even-interview-bootstrap-main
git init .
git remote add origin git@github.com:$REPO

./ssh-key.sh

git add .
git commit -am "Added bootstrap repo"
git push -u origin main
