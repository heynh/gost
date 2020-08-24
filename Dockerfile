FROM golang:alpine AS builder

RUN apk update && \
    apk add --no-cache git gcc libc-dev && \
    export GOPATH=/tmp/go && \
    git clone https://github.com/ginuerzh/gost $GOPATH/src/github.com/ginuerzh/gost && \
    cd $GOPATH/src/github.com/ginuerzh/gost/cmd/gost && \
    go build

FROM alpine

COPY --from=builder /tmp/go/src/github.com/ginuerzh/gost/cmd/gost/gost /gost
RUN apk update && apk add --no-cache tor ca-certificates

CMD nohup tor & \
    /gost -L socks5+ws://:$PORT $METHOD
