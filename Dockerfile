FROM golang:alpine AS builder

RUN apk update && \
    apk add --no-cache git && \
    git clone https://github.com/ginuerzh/gost && \
    cd /gost/cmd/gost && \
    go build

FROM alpine

COPY --from=builder /tmp/gost/src/github.com/ginuerzh/gost/cmd/gost/gost /gost
RUN apk update && apk add --no-cache tor ca-certificates && \
    
CMD nohup tor & \
    /gost -L socks5+ws://:$PORT $METHOD
