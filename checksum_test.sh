#!/bin/bash
#script to untar only if checksum is correct

mkdir bad > /dev/null 2>&1 ;
mkdir good > /dev/null 2>&1 ;
IFS=$'\n' ;
for file in $(cat checksum.txt); 
do 
        #echo $file
        filenm=$(echo  $file | awk '{print $2}')
        ls $filenm > /dev/null 2>&1 ;
        if [ $? -eq "0" ]
        then
                checksum=$(echo  $file | awk '{print $1}')
                new_checksum=$(sha1sum "$filenm" | awk '{print $1}')
                if [ "$checksum" = "$new_checksum" ] 
                then 
                        echo $filenm "  " $checksum -- OK
                        mv $filenm good/

                else
                        echo $filenm "  " $checksum -- BAD
                        mv $filenm bad/
                fi 
        fi
done;

