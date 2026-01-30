#!/bin/bash

USERID=$(id -u)

if [ "$USERID" -ne 0 ]; then 
    echo "Only root users can execute this script"
    exit 1
fi

if dnf list installed nginx &> /dev/null; then 
        echo "Nginx already installed"
    else
        echo "Installing nginx"
        dnf install nginx -y

    if [ $? -ne 0 ]; then 
        echo "Nginx installaion..failed"
     else
        echo "Nginx installation..completed"
    fi

fi