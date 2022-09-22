#!/bin/bash
path=`dirname $0`
kill -9 `cat $path/siteping.pid`
echo $$ > $path/siteping.pid

#notification count
count=5
interval=60
timeout=1

# change hosts or add new hosts
declare -a array=(
"www.google.com" 1
"www.microsoft.com" 1
"www.raspberrypi.org" 1
)

size=${#array[@]}
while true
do
 for (( i=0; i<${size}; i+=2 ));
 do
  x1=$(ping ${array[$i]} -c 1 -W $timeout 2>/dev/null | grep -c "100% packet loss") 
  if [ "${array[$i+1]}" -lt $count -a $x1 -eq 0 ]; then
    $path/tpush.sh "Server '"${array[$i]}"' is Up" 
    array[$i+1]=$count
  else
    if [ "${array[$i+1]}" -gt 0 -a $x1 -eq 1 ]; then 
      $path/tpush.sh "Server '"${array[$i]}"' is Down" 
      array[$i+1]=$((${array[$i+1]} - 1))
    fi
  fi
 done
sleep $interval
done
