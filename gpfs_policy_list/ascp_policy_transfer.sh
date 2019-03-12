#!/bin/bash

source transfer.rc

TEMP_FILE=$(mktemp /tmp/xfer.XXXXXX)
SUFFIX=.list.transfer-list
OUTPUT_FILE=$TEMP_FILE$SUFFIX

if [[ -z $FSETNAME ]];
then
   FSETNAME="root"
fi

# get LAST_XFER_DATE as argument $1 or set default
# date format is: "2018-06-06 12:37:00" (must be given in quotes
if [[ -z $1 ]];
then
  # if no argument given then set the date to now - 1 h
  LAST_XFER_DATE="$(date +"%Y-%m-%d %H:%M:%S" -d "$DATE - 1 hours")"
else
  LAST_XFER_DATE="$1"
fi

echo "DEBUG: $LAST_XFER_DATE"

mmapplypolicy $SOURCE_DIR -I defer -f $TEMP_FILE -P ascp_policy --single-instance -m 1 -M LAST_XFER=`date -d "$LAST_XFER_DATE" +%s` -M FSETNAME=$FSETNAME
if [ $? == 0 ] && [ -s $OUTPUT_FILE ]
then
	awk -F '[ ]' '{ for(i=7; i<=NF; i++) printf "%s",$i (i==NF?ORS:OFS) }' $OUTPUT_FILE > $TEMP_FILE
	./run-ascp.sh $TEMP_FILE
fi
rm $OUTPUT_FILE

exit 0
