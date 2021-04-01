# cloudflare-ddns-updater
 

## Bash and Python3 DDNS Updater for Cloudflare DNS API
## Change values according to your needs (proxied, TTL, DOMAIN_NAME)


Simple bash and python scripts to update a DNS record at Cloudflare's DNS Zone, acting
as a DDNS provider.
Python's implementation is actually way simpler than other python scripts out there.


PS: 

- It assumes a proxied record (all HTTP/HTTPS traffic goes through Cloudflare's CDN).

- If the actual DNS record is proxied, running the dig command (as many scripts out there have been doing) does not return the real IP address, but the Cloudflare's Reverse Proxy IP addresses instead.