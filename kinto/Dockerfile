FROM golang:1-alpine as builder

RUN apk update && \
    apk add --no-cache musl-dev git gcc && \
    git clone https://github.com/ginuerzh/gost.git && \
    cd /go/gost/cmd/gost && \
    go build

FROM alpine
ENV METHOD="socks5+ws://:3000 -F=socks5://127.0.0.1:9050?bypass=~*.onion"

COPY --from=builder /go/gost/cmd/gost/gost /bin/gost
RUN apk update && apk add --no-cache tor ca-certificates

CMD nohup tor & \
    /bin/gost -L $METHOD
