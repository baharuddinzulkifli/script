#!/bin/bash
#utk cek root
check-root() {
        if [[ $EUID -ne 0 ]]; then
           echo "This script must be run as root" 
           exit 1
        fi
}

main() {
	#view file list_ip.txt and loop utk read by line
	cat list_ip.txt | while read line; do
        echo "Host: $line"
        #buat directory utk output. identify by host
	mkdir -p nmap/$line
	#nmap script
        nmap -Pn -sC -sV -T4 --min-rate 1000 -sS -oN nmap/$line/nmap.txt $line
done
echo "Done"
}
check-root
main

