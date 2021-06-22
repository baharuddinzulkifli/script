#!/bin/bash
#utk cek root
check-root() {
        if [[ $EUID -ne 0 ]]; then
           echo "This script must be run as root"
           exit 1
        fi
}

main() {
        #view file list ip and loop utk read by line
        #cat list_ip.txt | sed 's~http[s]*://~~g' | while read line; do
        cat /mnt/c/Users/demo/Desktop/projek2/iponly.txt | while read line; do
        echo "Host: $line"
        #buat directory utk output. identify by host
        mkdir -p nmap/$line
        #nmap script, buleh tukar ikut nk paka command ape

        #nmap -sC -sV -T4 -p- --min-rate 1000 -sS -oN nmap/$line/nmap.txt $line -oG - | egrep -v "^#|Status: Up" | cut -d' ' -f4- | sed -n -e 's/Ignored.*//p' | tr ',' '\n' | sed -e 's/^[ \t]*//' | sort -n >> nmap/$line/nmap.txt
        nmap -sC -sV -oX nmap/$line/nmap.xml $line
done
echo "Done"
}
check-root
main
