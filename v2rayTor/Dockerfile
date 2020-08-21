FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git bash wget curl
WORKDIR /go/src/v2ray.com/core
RUN git clone --progress https://github.com/v2fly/v2ray-core.git . && \
    bash ./release/user-package.sh nosource noconf codename=$(git describe --tags) buildname=docker-fly abpathtgz=/tmp/v2ray.tgz

FROM alpine

ENV CONFIG=https://gist.githubusercontent.com/mixool/ad940b202e25ce51d52b20f535eeebde/raw/edecd8717833b1b20c19f9e65446bf7186c1c630/v2rayTor.json

COPY --from=builder /tmp/v2ray.tgz /tmp
COPY start.sh /start.sh
RUN apk update && apk add --no-cache bash tor ca-certificates && \
    mkdir -p /usr/bin/v2ray && \
    tar xvfz /tmp/v2ray.tgz -C /usr/bin/v2ray && \
    chmod +x /start.sh && \
    rm -rf /tmp/v2ray.tgz

CMD ["/start.sh"]
