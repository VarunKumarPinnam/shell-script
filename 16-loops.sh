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
  if [ $1 -eq 0 ]; then 
    echo "$2 installation completed" | tee -a $LOGS_FILE
  elif [ $1 -eq 2 ];then
    echo "$2 already installed..skipping the installation" | tee -a $LOGS_FILE
  else
    echo "$2 installation is failed" | tee -a $LOGS_FILE
 fi
}

install_if_missing()
{
  if dnf list installed $1 &>/dev/null; then
    return 2
else
    echo "Installing $1"
    dnf install $1 -y &>> $LOGS_FILE
    return $?
fi
}

for pkg in $@ 
do
    install_if_missing $pkg
    validation $? "$pkg"
done