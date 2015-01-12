#!/bin/bash


# If your script don't have any declared 'linuxpath', then it will use the default string 'kernel'
if [ -z $linuxpath ]; then 
    linuxpath="kernel"
fi