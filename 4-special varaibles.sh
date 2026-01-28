#!/bin/bash

echo " all args passed to script  : $@"
echo " no of var passed to script : $#"
echo "script name:                : $0"
echo " present directory          : $PWD"
echo "who is running the script   : $USER"
echo "home directory of the user  : $HOME"
echo " PID of recently BG process : $!"
echo " Exit status of last command: $?"

