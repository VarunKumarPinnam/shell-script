#/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_DIRECTORY="/home/ec2-user/app_logs"
SCRIPT_NAME=$(basename "$0")
LOGS_FILE="$LOGS_DIRECTORY/${SCRIPT_NAME}_$(date '+%Y-%m-%d_%H-%M-%S').log"

#..check directory
if [ ! -d $LOGS_DIRECTORY ]; then 
    echo "$LOGS_DIRECTORY does not exists"
    exit 1
fi

#..finding tyhe files to delete
FILES_TO_DELETE=$(find $LOGS_DIRECTORY -name "*.log" -mtime +14 )
     # echo "$FILES_TO_DELETE" 
     
if [ -z "$FILES_TO_DELETE" ]; then
    echo "there are no files to delete"
    exit 1
else      
    while IFS= read -r filepath; 
        do
            # Process each line here
            echo "Deleting file: $filepath"
            rm -f $filepath 
            echo "$(date '+%Y-%m-%d_%H-%M-%S') | Deleted file: $filepath" &>>$LOGS_FILE
        done <<< $FILES_TO_DELETE
fi