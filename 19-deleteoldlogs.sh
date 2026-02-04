#/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


LOGS_DIRECTORY="/home/ec2-user/app_logs"
LOGS_FILE="$LOGS_DIRECTORY/$0.log"

if [ ! -d $LOGS_DIRECTORY ]; then 
    echo "$LOGS_DIRECTORY does not exists"
    exit 1
fi

    FILES_TO_DELETE=$(find $LOGS_DIRECTORY -name "*.log" -mtime +14 )
   # echo "$FILES_TO_DELETE" 
      
while IFS= read -r filepath; 
    do
        # Process each line here
        echo "Deleting file: $filepath"
        rm -f $filepath &>>$LOGS_FILE
        echo "Deleted file: $filepath"
    done <<< $FILES_TO_DELETE