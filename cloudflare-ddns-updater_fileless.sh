#!/usr/bin/env bash

## Bash DDNS Updater for Cloudflare DNS API
## Change values according to your needs (proxied, TTL, DOMAIN_NAME)
## Create a crontab entry for this file so it can run from time to time.
## Ex: * */6 * * * /home/user/cloudflare-ddns-updater.sh > /home/user/ddns.log

current_ip_address=$(curl -s https://api.ipify.org)
unixtime=$(date +%s)
api_url='https://api.cloudflare.com/client/v4/zones'
domain_zone='REPLACE'
dns_record='REPLACE'
# use API Tokens (https://developers.cloudflare.com/api/keys)
# "API Keys are the legacy authorization scheme for talking to Cloudflare's APIs."
token='Bearer REPLACE VALUE'

cld_ip=$(curl -s -X GET "$api_url/$domain_zone/dns_records/$dns_record" \
-H "Authorization: $token" \
-H "Content-Type: application/json" \
| json_pp | grep content | egrep -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}")

if [ $current_ip_address == $cld_ip ]; then
    echo "$unixtime|Same IP address: $ipaddr"
    exit 1
else
      curl -X PUT "$api_url/$domain_zone/dns_records/$dns_record" \
      -H "Authorization: $token" \
      -H "Content-Type: application/json" \
      --data '{"type":"A","name":"DOMAIN_NAME","content":"'$current_ip_address'","ttl":1,"proxied":true}'
      echo "timestamp: $unixtime  |  New IP Address: $current_ip_address"
      exit 0
fi
