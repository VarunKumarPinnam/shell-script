#!/bin/bash

read -p "enter number :" num

if ! [[ "$num"  =~  ^-?[0-9]+$ ]]; then
    echo "please enter a valid number"
    exit 1
fi

if [ "$num" -gt 0 ]; then
    echo "Given number $num is postive number"
elif [ "$num" -lt 0 ]; then 
    echo "Given number $num is negative number"
else
    echo "Given number is $num is zero"
fi