#!/bin/bash

#Get the file from $url and tansfer it to colossus. 
url=xx
finalloc=yy
while  [ -s files.list ]; 
do
        for file in $(cat files.list);
        do 
                rm ok  > /dev/null 2>&1 ;
                wget $url/ok 2 > /dev/null 2>&1 ;
                ls ok  > /dev/null 2>&1 
                while  [ $? -ne "0" ]; 
                do 
                        rm ok  > /dev/null 2>&1 ;
                        wget $url/ok  > /dev/null 2>&1 ; 
                        printf "¤"
                        sleep 60
                        ls ok  > /dev/null 2>&1 ; 
                done;
                ls $file  > /dev/null 2>&1
                if [ $? -ne "0" ]
                then            
                        wget $url/$file 2 > /dev/null 2>&1 ;
                fi
                ls $file  > /dev/null 2>&1 
                if [ $? -eq "0" ] 
                then
                        scp $file $finalloc; 
                        sha1sum $file > sha1_$file;
                        rm $file;
                        sed -i -- '/'$file'/d' files.list
                        echo found $file
                fi
                #printf "."
        done
        sleep 10
        printf "."
done
