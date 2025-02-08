#!/bin/bash
best_ip=$(cat $1)

# Replace old IPv4 in Hiddify-next config
sed -i "s/old_ipv4/$best_ip/g" sing-box-hiddify.json

# Replace old IPv4 in mahsaNg config
sed -i "s/old_ipv4/$best_ip/g" Xray-WoW.json