#! /bin/bash

ZIPF=https://github.com/ieure/even-interview-bootstrap/archive/refs/heads/main.zip

if [ -e "$REPO" ]; then
    echo "Sorry, the repo name wasn't specified, so I can't do anything."
    exit 1
fi

NAME=$(echo $REPO | cut -d/ -f2)

mkdir $NAME
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
git init .
git remote add origin git@github.com:$REPO

./ssh-key.sh
./devsetup.sh

git add .
git commit -am "Added bootstrap repo"
git push -u origin main
