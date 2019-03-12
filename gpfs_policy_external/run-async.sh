#!/bin/bash
# Environment specific settings
source transfer.rc

run_async()
{
	async -N xfer -d $SOURCE_DIR -r $SSH_USER@$SSH_HOST:$REMOTE_DIR -l $TRANSFER_RATE -K push -i $SSH_KEY_PATH --preserve-xattrs=native -u -j -t --preserve-access-time "${FLAGS[@]}"
}

# ----------------------
COMMAND=$1
LISTFILE=$2
case $COMMAND in
  TEST )
		# Nothing to do
		;;

  LIST )
		awk -v source_dir=$SOURCE_DIR '{ path = "";for(i = 5; i<=NF;i++) { path = path (i>5?" ":"") $i }; sub(source_dir"/", "", path); n=split(path, elems, /\//); for(i = 1; i<=n -1;i++) { partial = elems[1] "/"; for (j=2; j<=i; j++) { partial = partial elems[j] "/"} print partial } print path }' $LISTFILE  | sort | uniq  > $LISTFILE.aspera
		FLAGS=(--include-from=$LISTFILE.aspera --exclude "*" --create-dir)
		run_async
		rm $LISTFILE.aspera
		;;

  STANDALONE )
		FLAGS=
		run_async
		;;
  * )
        # Nothing to do
        ;;
esac
exit 0
