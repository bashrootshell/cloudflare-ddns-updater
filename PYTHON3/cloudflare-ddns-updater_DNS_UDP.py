#!/usr/bin/env python3

from requests import get, put
from nslookup import Nslookup

"""
    Cloudflare DDNS Updater
    Using a UDP query just like a dig command

    PEP8 compliant
    "Simple is better than complex."
"""

#  a litte bit faster than HTTP request
[current_ip := _ for _ in Nslookup(dns_servers=["208.67.222.222"])
    .dns_lookup("myip.opendns.com").answer]

api_url = ('https://api.cloudflare.com/client/v4/zones/'
           '__REPLACE__/dns_records/'
           '__REPLACE__/')
token = 'Bearer __PUT YOUR TOKE HERE__'
auth_header = {'Authorization': token, 'Content-Type': 'application/json'}
data = {'type': 'A',
        'name': '__REPLACE__',
        'content': current_ip,
        'ttl': 1,
        'proxied': True}

#  there's no need to import json module
get_ip_cloudflare = get(api_url, headers=auth_header).json()
ip_on_cloudflare = get_ip_cloudflare['result']['content']
date_last_modification = get_ip_cloudflare['result']['modified_on']

if current_ip == ip_on_cloudflare:
    print(f'No change >> IP {ip_on_cloudflare} last modified'
          f' on {date_last_modification}')
else:
    update_ip = put(api_url, headers=auth_header, json=data)
    print(update_ip.text)
