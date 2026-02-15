# CCaddy (Cron-Caddy)

[steffenbusch/caddy-cron-matcher](https://github.com/steffenbusch/caddy-cron-matcher)を組み込んだDocker版Caddy(Webサーバー)です。

## Build

```sh
docker build ./ -t ccaddy
docker run --rm -it -p 80:80 -p 443:443 ccaddy
```

## Example config

```
example.com {
    root * /usr/share/caddy
    encode gzip
    header /assets Cache-Control "public, max-age=31536000, immutable"

    @proxy_paths {
        path_regexp (/inbox$|/api/|/users/|/proxy$|/.well-known/|/nodeinfo/)
    }
    handle @proxy_paths {
        reverse_proxy mi:3000 {
            header_up X-Real-IP {header.CF-Connecting-IP}
            header_up X-Forwarded-For {header.CF-Connecting-IP}
            header_up X-Forwarded-Proto {scheme}
            header_up X-Forwarded-Host {host}
        }
    }

    @telehoTime cron "0 8 * * *" "0 23 * * *"
    handle @telehoTime {
        error "Teleho Time Pending" 200
    }

    handle {
        reverse_proxy mi:3000 {
            header_up X-Real-IP {header.CF-Connecting-IP}
            header_up X-Forwarded-For {header.CF-Connecting-IP}
            header_up X-Forwarded-Proto {scheme}
            header_up X-Forwarded-Host {host}
        }
    }

    handle_errors {
        @503 expression {err.status_code} == 200
        handle @503 {
            rewrite * /503.html
            header Cache-Control "no-store, no-cache, must-revalidate"
            header Service-Worker-Allowed "none"
            file_server
        }
    }
}
```
