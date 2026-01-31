#/bin/bash

USERID=$(id -u)
LOGS_DIRECTORY="/var/log/shell-script"
LOGS_FILE="$LOGS_DIRECTORY/$0.log"

if [ $USERID -ne 0 ]; then 
    echo "You must run this script with root access" | tee -a $LOGS_FILE
fi

mkdir -p $LOGS_DIRECTORY

validation()
{
  if [ $1 -ne 0 ]; then 
    echo "$2 installation failed | tee -a $LOGS_FILE
    exit 1
else
    echo "$2 installation completed" | tee -a $LOGS_FILE
    
}

install_if_missing()
{
  if dnf list installed $1 &>/dev/null; then
    echo "$1 already installed" | tee -a $LOGS_FILE
    return 0
else
    echo "Installing $1"
    dnf install $1 -y | tee -a $LOGS_FILE
    return $?
fi
}

install_if_missing nginx
validation $? nginx
