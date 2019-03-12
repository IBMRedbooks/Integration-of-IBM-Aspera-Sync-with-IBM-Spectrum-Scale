#!/usr/bin/bash
# Environment specific settings
source transfer.rc

# ----------------------
LISTFILE=$1
ascp -l $TRANSFER_RATE --file-list=$LISTFILE -d --overwrite=diff -k 2 --mode=send --user=$SSH_USER --host=$SSH_HOST -i $SSH_KEY_PATH -p --preserve-xattrs=native --preserve-file-owner-gid --preserve-file-owner-gid --src-base=$SOURCE_DIR $REMOTE_DIR
rm $LISTFILE
exit 0
