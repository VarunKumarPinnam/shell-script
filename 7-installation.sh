#!/bin/bash

USERID=$(id -u)

if [ "$USERID" -ne 0 ]; then 
    echo "Only root users can execute this script"
    exit 1
fi

echo "Installing ngnix"
dnf install ngnix -y

if [ $? -ne 0 ]; then 
    echo "Nginx installaion..failed"
else
    echo "Ngnix installation..completed"
fi
