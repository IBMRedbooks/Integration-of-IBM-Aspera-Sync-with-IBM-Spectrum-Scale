#!/bin/bash
# Environment specific settings
source transfer.rc

run_async()
{
	async -N xfer -d $SOURCE_DIR -r $SSH_USER@$SSH_HOST:$REMOTE_DIR -l $TRANSFER_RATE -K push -i $SSH_KEY_PATH --preserve-xattrs=native -u -j -t --preserve-access-time "${FLAGS[@]}"
}

# ----------------------
LISTFILE=$1
if [[ -z $LISTFILE ]]; then
	FLAGS=
	run_async
else
	FLAGS=(--include-from=$LISTFILE --exclude "*" --create-dir)
	run_async 
fi

exit 0
