#!/bin/bash
LOGS_DIRECTORY="/var/log/diskusage"
SCRIPT_NAME=$(basename "$0" .sh)
LOGS_FILE="$LOGS_DIRECTORY/${SCRIPT_NAME}_$(date '+%Y-%m-%d_%H-%M-%S').log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
MESSAGE=""

mkdir -p $LOGS_DIRECTORY

log (){
    echo -e "$(date '+%Y-%m-%d_%H-%M-%S') | $1" | tee -a $LOGS_FILE
}

DISK_USAGE=$(df -hT | grep -v Filesystem)
USAGE_THRESHOLD=3

while IFS= read -r line
do 
    USAGE=$(echo $line | awk '{print $6}' | cut -d '%' -f1)
    PARTITION=$(echo $line | awk '{print $7}')
    if [ $USAGE -gt $USAGE_THRESHOLD ]; then
        MESSAGE+="High disk usage on $PARTITION: $USAGE% \n"
    fi        
done <<< $DISK_USAGE

#echo -e $MESSAGE
log  "$MESSAGE"