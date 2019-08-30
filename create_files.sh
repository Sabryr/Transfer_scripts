#!/bin/bash

FILELIST=$1
OUT_LOC=$2

for c_file in {1..10}
do
  	filenm="$OUT_LOC/$c_file"
        echo "$c_file" > $filenm
        echo "$filenm" >> $FILELIST
        sleep 10
done

