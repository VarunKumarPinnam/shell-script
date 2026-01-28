#!/bin/bash

START_TIME=$(Date +s%)

echo " start time is : $START_TIME"

sleep 10

END_TIME=$(Date +s%)

TOTAL_TIME=$($START_TIME-$END_TIME);

echo "Total execution time is: $TOTAL_TIME";
