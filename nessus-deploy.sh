#!/bin/bash
# nessus-deploy.sh

key=$1
nessuscli='/opt/nessus/sbin/nessuscli'

main(){
if [[ -z $key ]] || ! [[ $key =~ [A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4}-[A-Z0-9]{4} ]]; then
    echo "Usage: nessus-deploy.sh [Nessus License Key]"
    exit 1
else
    systemctl stop nessusd.service
    $nessuscli fix --reset
    $nessuscli fetch --register $key
    $nessuscli update --all
    $nessuscli adduser
    systemctl start nessusd.service
    exit 0
fi
}

main
