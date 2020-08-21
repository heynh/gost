#!/usr/bin/env bash

tor
/usr/local/bin/gost -L socks5+ws://:80 -F=socks5://127.0.0.1:9050?bypass=~*.onion
