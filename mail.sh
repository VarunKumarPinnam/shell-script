#!/bin/bash

TO_ADDRESS=$1
SUBJECT=$2
MESSAGE_BODY=$3
ALERT_TYPE=$4
SERVER_IP=$5
TO_TEAM=$6


MSG=$(sed -e "s/TO_TEAM/$6/g" -e "s/ALERT_TYPE/$1/g" -e "s/SERVER_IP/$5/g" -e "s/MESSAGE/$3/g" template.html)

{
echo "To: $TO_ADDRESS"
echo "Subject: $SUBJECT"
echo "Content-Type: text/html"
echo ""
echo "$FINAL_MSG
"
} | msmtp "$TO_ADDRESS"