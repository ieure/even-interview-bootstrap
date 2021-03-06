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

if [ ! -x "$(which git)" ]; then
    echo "Pleast install git, then try again."
    exit 1
fi

echo "========================================"
echo "Cloning repo."
echo "========================================"
echo
echo "If this process fails, please ensure that Git is installed and"
echo "configured for SSH key authentication, then try again."

git clone $UPSTREAM $NAME
cd $NAME

./ssh-key.sh

git remote rename origin upstream
git remote add origin git@github.com:$REPO
git remote update
git push -u origin main

./devsetup.sh

echo "========================================"
echo "You're good to go!"
echo "========================================"
echo
echo "Great, everything should be working!  Please take a few minutes to read:\n"
echo "    http://github.com/$REPO/README.md\n"
echo "It has important information about the interview."

