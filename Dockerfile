FROM golang:alpine AS builder

RUN apk update && \
    apk add --no-cache git gcc libc-dev && \
    git clone https://github.com/ginuerzh/gost.git && \
    cd gost/cmd/gost && \
    pwd && \
    go build

FROM alpine

COPY --from=builder /root/gost/cmd/gost/gost /gost
RUN apk update && apk add --no-cache tor ca-certificates

CMD nohup tor & \
    /gost -L socks5+ws://:$PORT $METHOD
