#!/bin/bash

read -p "Enter first number:" num1
read -p "Enter second number:" num2

if ! [[ "$num1" =~ ^-?[0-9]+$ &&  "$num2" =~ ^-?[0-9]+$ ]];then
    echo " please enter a valid number"
    exit 1;
fi

if [ "$num1" -gt "$num2" ]; then 
    echo " $num1 is gretaer than $num2"
elif [ "$num1" -lt "$num2" ];then 
    echo " $num2 is gretaer than $num1"
else
    echo "Both numbers are equal"
fi