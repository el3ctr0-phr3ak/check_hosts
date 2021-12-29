#!/bin/bash

echo ""
echo "Usage: check_live_hosts.sh <IP / IP Range>"
echo ""

ips=$1
output=$(echo -n "$1_live_hosts.txt" | sed 's/\//_/g')

if [[ $# -eq 0 ]] ; then
    echo "Please enter IP or IP Range"
    exit 0
fi

nmap -n -sn $ips -oG - | awk '/Up$/{print $2}' > $output

if [[ -f $output ]] && [[ ! -s $output ]];
then
    echo "No Live hosts found"
    rm $output
    exit
elif cat $output
then
echo ""
echo "Finished! Results saved in ${output}"
fi
