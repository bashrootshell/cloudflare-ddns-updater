# cloudflare-ddns-updater
 

## Bash DDNS Updater for Cloudflare DNS API
## Change values according to your needs (proxied, TTL, DOMAIN_NAME)


Simple bash script to update a DNS record at Cloudflare's DNS Zone, acting
as a DDNS provider.


PS: 

- It assumes a proxied record (all HTTP/HTTPS traffic goes through Cloudflare's CDN).

- If the actual DNS record is proxied, the dig command (as many scripts out there are doing) does not return the real IP address, but the Cloudflare's Reverse Proxy IP addresses instead.