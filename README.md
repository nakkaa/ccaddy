# CCaddy (Cron-Caddy)

A Caddy Docker image with built-in cron support.

## Build

```sh
docker build ./ -t ccaddy
docker run --rm -it -p 80:80 -p 443:443 ccaddy
```
