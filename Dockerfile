FROM alpine

ENV METHOD='-L socks5+ws://:$PORT'

RUN apk add --no-cache --virtual=.build-dependencies go gcc git libc-dev ca-certificates \
    && apk add --no-cache tor \
    && export GOPATH=/tmp/go \
    && git clone https://github.com/ginuerzh/gost $GOPATH/src/github.com/ginuerzh/gost \
    && cd $GOPATH/src/github.com/ginuerzh/gost/cmd/gost \
    && go build \
    && mv $GOPATH/src/github.com/ginuerzh/gost/cmd/gost/gost /usr/local/bin/ \
    && apk del .build-dependencies \
    && rm -rf /tmp
    
CMD nohup tor & \
    eval /usr/local/bin/gost -L $METHOD
