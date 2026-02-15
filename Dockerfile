FROM caddy:builder AS builder

RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
    xcaddy build \
    --with github.com/steffenbusch/caddy-cron-matcher

FROM caddy:latest

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
