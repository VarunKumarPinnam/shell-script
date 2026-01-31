#/bin/bash

USERID=$(id -u)
LOGS_DIRECTORY="/var/log/shell-script"
LOGS_FILE="$LOGS_DIRECTORY/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


if [ $USERID -ne 0 ]; then 
    echo -e "$R You must run this script with root access $N" 
fi

mkdir -p $LOGS_DIRECTORY

validation()
{
  if [ $1 -eq 0 ]; then 
    echo -e "$G $2 installation completed $N" | tee -a $LOGS_FILE
  elif [ $1 -eq 2 ];then
    echo -e "$Y $2 already installed..skipping the installation $N" | tee -a $LOGS_FILE
  else
    echo -e "$R $2 installation is failed $N" | tee -a $LOGS_FILE
 fi
}

install_if_missing()
{
  if dnf list installed $1 &>/dev/null; then
    return 2
else
    echo  -e "$G Installing $1 $N" | tee -a $LOGS_FILE
    dnf install $1 -y &>> $LOGS_FILE
    return $?
fi
}

for pkg in $@ 
do
    install_if_missing $pkg
    validation $? "$pkg"
done