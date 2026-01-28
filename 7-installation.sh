#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ];then
    echo "You should have root access to execute this script"
    exit 1
fi

echi  "Installing  Nginix"
dnf install nginxx -y

if [ $? -ne 0 ]; then
    echo "Nginix installation failed"
    exit 1
else
    echo "Installation completed successfully"
fi