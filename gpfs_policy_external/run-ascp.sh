#!/usr/bin/bash
# Environment specific settings
source transfer.rc

# ----------------------
COMMAND=$1
LISTFILE=$2
case $COMMAND in
  TEST )
	# Nothing to do
	;;

  LIST )
	awk -F '[ ]' '{ for(i=7; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) }' > $LISTFILE.aspera
	ascp -l $TRANSFER_RATE --file-list=$LISTFILE.aspera -d --overwrite=diff -k 2 --mode=send --user=$SSH_USER --host=$SSH_HOST -i $SSH_KEY_PATH -p --preserve-xattrs=native --preserve-file-owner-gid --preserve-file-owner-gid --src-base=$SOURCE_DIR $REMOTE_DIR
	rm $LISTFILE.aspera
	;;
  * )
        # Nothing to do
        ;;
esac
exit 0
