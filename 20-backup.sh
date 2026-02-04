#!/bin/bash

USERID=$(id -u)
LOGS_DIRECTORY="/var/log/shell-script"
SCRIPT_NAME=$(basename "$0" .sh)
LOGS_FILE="$LOGS_DIRECTORY/${SCRIPT_NAME}_$(date '+%Y-%m-%d_%H-%M-%S').log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # default 14 days if not provided

#--ROOT User Check--
if [ "$USERID" -ne 0 ]; then 
    echo -e "$R You must run this script with root access $N" 
    exit 1
fi

mkdir -p $LOGS_DIRECTORY

usage(){
    echo -e "$R USAGE :: sudo backup <source_dir> <dest_dir> <days>[default 14 days] $N"
    exit 1 
}

if [ $# -lt 2 ]; then
    usage
fi

if [ ! -d $SOURCE_DIR ]; then
    echo -e "$R source dir $SOURCE_DIR does not exists"
    exit 1
fi


if [ ! -d $DEST_DIR ]; then
    echo -e "$R dest dir $DEST_DIR does not exists"
    exit 1
fi