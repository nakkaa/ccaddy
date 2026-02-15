# CCaddy (Cron-Caddy)

[steffenbusch/caddy-cron-matcher](https://github.com/steffenbusch/caddy-cron-matcher)を組み込んだDocker版Caddy(Webサーバー)です。

## Build

```sh
docker build ./ -t ccaddy
docker run --rm -it -p 80:80 -p 443:443 ccaddy
```
