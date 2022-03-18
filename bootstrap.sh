#! /bin/bash
#
# This script bootstraps the Even interview repository.
#
# If you're reading this instead of running it blindly, great!  You
# just demonstrated one of our company values, curiosity.

set -euo pipefail

UPSTREAM=https://github.com/ieure/even-interview-bootstrap.git

if [ -e "$REPO" ]; then
    echo "Sorry, the repo name wasn't specified, so I can't do anything."
    exit 1
fi

NAME=$(echo $REPO | cut -d/ -f2)

if [ -x "$(which git)" ]; then
    echo "Pleast install git, then try again."
    exit 1
fi

git clone $UPSTREAM $NAME
cd $NAME

git remote rename origin upstream
git remote add origin git@github.com:$REPO

./ssh-key.sh
./devsetup.sh

git push -u origin main

echo "========================================"
echo "You're good to go!"
echo "========================================"
ecno
echo "Great, everything should be working!  Please take a few minutes to read:\n"
echo "    http://github.com/$REPO/README.md\n"
echo "It has important information about the interview."

