#!/bin/bash

# First argument is logs path 
# Second argument is searched word

help(){
   cat << _EOF_
	log_stats is a script that searches for a key word in log files and
	returns the stats.
	If the script is run without arguments it displays this help message.
	In order to get the log stats two arguments need to be provided.
	The first argument is the path to the log files and the second 
	argument is the word that is to be searched.
	e.g. ./logs_stats.sh /home/ena/Desktop/atlant/logs/tmp/logs Chrome
_EOF_
}

display(){
   for filename in $logs_path/*
   do
     echo Filename: ${filename##*/}, File size: $(stat -c %s $filename) bytes, Total number of lines: $(wc -l < $filename), Number of lines that contain $search_word: $(grep -c $search_word $filename) 
   done | sort -n -r -k5 -t:
   #done;
   exit 
}

if [ ! $# -eq 2 ]; then
     help
     exit
fi

logs_path=$1

search_word=$2


if [ ! -d $logs_path ]; then
     echo "Error: Chosen directory does not exist"
     exit
fi

display

exit
