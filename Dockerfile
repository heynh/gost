FROM golang:alpine AS builder

RUN apk update && \
    apk add --no-cache git libc-dev && \
    git clone https://github.com/ginuerzh/gost.git && \
    cd /go/gost/cmd/gost && \
    go build

FROM alpine

COPY --from=builder /go/gost/cmd/gost/gost /gost
RUN apk update && apk add --no-cache tor ca-certificates

CMD nohup tor & \
    /gost -L socks5+ws://:$PORT $METHOD
