#!/bin/bash
HOST=$1
PORT=$2
USER=$3
DIRECTORY=$4
FILE=$5

eval "$(ssh-agent -s)" # Start ssh-agent cache
chmod 600 id_rsa # Allow read access to the private key
ssh-add id_rsa # Add the private key to SSH

sftp -P $PORT $USER@$HOST <<END_SCRIPT
cd $PATH
put $FILE
quit
END_SCRIPT
exit 0

