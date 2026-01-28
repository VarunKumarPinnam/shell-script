#!/bin/bash

USERID=$(id -u)

if [ $USERID ne 0 ];then
    echo "You should have root access to execute this script"
    exit 1
else
    dnf install -y
fi