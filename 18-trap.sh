#!/bin/bash
set -e
trap 'echo "Error at $LINENO for command: $BASH_COMMAND"' ERR

USERID=$(id -u)
LOGS_DIRECTORY="/var/log/shell-script"
LOGS_FILE="$LOGS_DIRECTORY/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#--ROOT User Check--
if [ "$USERID" -ne 0 ]; then 
    echo -e "$R You must run this script with root access $N" 
    exit 1
fi

#--Log Setup---
mkdir -p $LOGS_DIRECTORY


install_if_missing()
{
  if dnf list installed $1 &>/dev/null; then
    return 2
else
    echo  -e "${G} Installing $1 ${N}" | tee -a $LOGS_FILE
    dnf install $1 -y &>> $LOGS_FILE
    return $?
fi
}

for pkg in $@ 
do
    install_if_missing $pkg
done
