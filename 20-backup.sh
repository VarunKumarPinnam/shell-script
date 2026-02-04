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

log(){
    echo -e "$Y $(date '+%Y-%m-%d_%H-%M-%S') | $1" | tee -a $LOGS_FILE
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

#Find the files
FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

log "Backup started"
log "Source dir: $SOURCE_DIR"
log "Dest dir  : $DEST_DIR"
log "DAYS     : $DAYS"

if [ -z "$FILES" ]; then
    echo -e "$R No files found to archieve $N"
    exit 1
else   
    #app_logs.timestamp.zip
    log "files to archieve: $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE_NAME="$DEST_DIR/$DEST_DIR-$TIMESTAMP.tar.gz"
    echo "Archieve name: $ZIP_FILE_NAME"
    tar -zvcf $ZIP_FILE_NAME $FILES

    #check archeival is success or not 
    if [ -z $ZIP_FILE_NAME ]; then 
        echo -e "$GArcheival is success$N"
    else  
        echo -e "$GArcheival is failed$N"
    fi
fi