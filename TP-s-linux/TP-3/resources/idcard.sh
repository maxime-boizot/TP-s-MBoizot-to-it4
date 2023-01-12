#!/bin/bash
echo " "
echo "Machine name : $(hostnamectl --static)."
echo " "
echo "OS $(cat /etc/redhat-release) and kernel version is $(uname -r)"
echo " "
echo "IP :$(hostname -I | awk '{print $1}')"
echo " "
ramfree=$(free -th | grep Total | tr -s ' ' | cut -d' ' -f4)
ramtot=$(free -th | grep Total | tr -s ' ' | cut -d' ' -f2)
echo "RAM : $ramfree memory available on $ramtot total memory"
echo " "
echo "Disk : $(df -h | grep vda2 | tr -s ' ' | cut -d' ' -f4) space left"
echo " "
echo "Top 5 processes by RAM usage :"
while read process ; do 
	echo "  - $process"
done <<< "$(ps -eo cmd= --sort=-%mem | head -n5)"
echo " "
echo "Listening ports :"
while read p; do
        proto=$(echo $p | tr -s ' ' | cut -d' ' -f1)
        port=$(echo $p | tr -s ':' | cut -d':' -f2 | cut -d' ' -f1 | sed 's/ //g')
        psn=$(echo $p | cut -d'"' -f2 | cut -d' ' -f1)
        echo "     - $proto $port : $psn"
done <<< $(ss -lnput4 | tail -n +2)
echo " "
echo "Here is your random cat : ./srv/idcard/cat.jpg"
echo " "