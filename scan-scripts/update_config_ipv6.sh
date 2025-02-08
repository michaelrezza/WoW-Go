#!/bin/bash
best_ip=$(cat $1)

# Replace old IPv6 in Hiddify-next config
sed -i "s/old_ipv6/$best_ip/g" sing-box-hiddify-ipv6.json