#!/bin/bash

USERID=$(id -u)

if [ "$USERID" -ne 0 ]; then 
    echo "Only root users can execute this script"
    exit 1
fi

VALIDATION(){
    if [ $1 -ne 0 ]; then 
        echo "$2 is failed"
    else 
        echo "$2 is completed"
    fi
}

if dnf list installed nginx &> /dev/null; then 
        echo "Nginx already installed"
    else
        echo "Installing nginx"
        dnf install nginx -y

VALIDATION $? "nginx installation"

fi

if dnf list installed mysql &> /dev/null; then 
        echo "mysql already installed"
    else
        echo "Installing mysql"
        dnf install mysql -y

VALIDATION $? "mysql installation"

fi

if dnf list installed nodejs &> /dev/null; then 
        echo "nodejs already installed"
    else
        echo "Installing nodejs"
        dnf install nodejs -y

VALIDATION $? "nodejs installation"

fi