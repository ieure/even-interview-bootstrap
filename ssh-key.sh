#! /bin/sh
#
# This script configures SSH key-based authentication for GitHub.
#
# If you're reading this instead of running it blindly, great!  You
# just demonstrated one of our company values, curiosity.

set -u

KEYGEN=$(which ssh-keygen)

if [ ! -x "$KEYGEN" ]; then
    echo "It appears that you don't have SSH installed, which is unusual.  Please install it and try again."
    exit 1
fi

DIR=~/.ssh
KEYNAME=github
KEYTYPE=rsa
KEY=$DIR/${KEYNAME}_id_${KEYTYPE}
CFG=$DIR/config
CFG_BAK=$DIR/config.even-interview

if [ -f "$KEY" ]; then
    exit 0
fi

$KEYGEN -q -N "" -t $KEYTYPE -f $KEY

if [ -d "$DIR" -a -r "$CFG" ]; then
    cp $CFG $CFG_BAK
fi
echo -e "Host github.com\n     IdentityFile $KEY\n" >> $CFG
chmod 0600 $CFG

echo "Great!  Now, you need to configure GitHub:\n"
echo "1. Visit https://github.com/settings/keys"
echo "2. Click \"New SSH key\""
echo "3. Paste this text into the Key field, and click \"Add SSH key.\"\n"
cat ${KEY}.pub

echo
read -n1 -p " --- PRESS ENTER AFTER CONFIGURING GITHUB ---"

echo "\nTo completely remove the changes this script made, you can run:\n"
echo "    rm $KEY ${KEY}.pub"
echo "    mv $CFG_BAK $CFG\n"
