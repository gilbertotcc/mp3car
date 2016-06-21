#!/bin/bash

# mp3car - A simple script to reduce size of mp3 files (suitable for low memory audio players and storages).

LAME=$(which lame)
LAME_OPT="--mp3input --abr "

BITRATE=$1	# ABR Bitrate parameter
SRC_DIR=$2	# Source directory, it contains mp3 files
DST_DIR=$3	# Destination directory, output goes here

# Check lame available
if [ $LAME == "" ]
then
	echo "lame mp3 encoder not found"
	exit 1
fi

LAME_CMD="$LAME $LAME_OPT $BITRATE "

DIR_NAME=$(basename "$SRC_DIR")
mkdir "$DST_DIR/$DIR_NAME"	# Create the destination directory

find "$SRC_DIR" -iname "*.mp3" | \
	while read file
	do
		FILENAME=$(basename "$file")
		$LAME_CMD "$file" "$DST_DIR/$DIR_NAME/$FILENAME"
	done

