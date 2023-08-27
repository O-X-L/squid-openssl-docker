# Squid OpenSSL - Docker

Build image
```bash
bash scripts/build.sh
```

Run container
```bash
# interactively
docker run -p 3128:3128 --name squid local/squid
# daemon
docker run -d -p 3128:3128 --restart unless-stopped --name squid local/squid
```

You can map your custom config: `-v /path/to/main/config:/etc/squid/squid.conf`

You can also map cache data: ` -v /path/to/data:/var/spool/squid`

## Default config

* SSL-Bump peaking (*no interception - just read target hostnames for filtering*)
* Allow connections only from private IPv4 ranges and localhost
* Allow connections to 80/443
* Deny weak inbound and outbound ciphers
* Deny connections to servers with bad certificates
* Deny HTTP-Connect tunnels through proxy

## Testing

```bash
http_proxy=http://127.0.0.1:3128 curl -v http://superstes.eu
> TCP_MISS/301 478 GET http://superstes.eu/ - HIER_DIRECT/135.181.170.219 text/html

https_proxy=http://127.0.0.1:3128 curl -v https://superstes.eu
> NONE_NONE/200 0 CONNECT superstes.eu:443 - HIER_NONE/- -
> TCP_TUNNEL/200 6178 CONNECT superstes.eu:443 - HIER_DIRECT/135.181.170.219 -
```

## Custom paths

If you change paths at build-time you will at least also need to change them in the squid.conf file.

## Logs
The log-files are redirected to `docker logs` as done in the [ubuntu/squid](https://hub.docker.com/r/ubuntu/squid) image.

So configure these log-file locations:

```
SQUID_DIR_LOG=/var/log/squid  # can be configured at build-time
access_log /var/log/squid/access.log
cache_log /var/log/squid/cache.log
cache_store_log /var/log/squid/store.log
```
