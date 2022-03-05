#!/bin/bash
#$2 is the time, and $1 is the first 4 digits of the for the file to search (date)

sed s/:00:00" "/""/ $1* | grep -i $2 | awk '{print $4, $5}'
