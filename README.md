[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)  
  
> 提醒： 滥用可能导致账户就被BAN！！！  
  
#### 一. 点击图标部署项目：  
  
1. 变量 METHOD 如不需要，保持默认留空即可
  
2. 完成部署后，打开app ，显示404 page not found，表示部署成功  
  
#### 二. 客户端使用，这里介绍如下二种方式
* v2ray socks ws tls: 
```bash
{
            "protocol": "socks",
            "tag": "herokuapp",
            "settings": {"servers": [{"address": "xxxxxxxxx.herokuapp.com","port": 443}]},
            "streamSettings": {"network": "ws","security": "tls","tlsSettings": {"allowInsecure": false,"serverName": "xxxxxxxxx.herokuapp.com"},"wsSettings": {"path": "/ws","headers": {"Host": "xxxxxxxxx.herokuapp.com"}}}
}
```
  
* gost -L=:1080 -F=socks5+wss://xxxxxxxxx.herokuapp.com:443
  
#### 三. 搭配clouflare cdn（可选）
* [参考IBMYes项目的这里](https://github.com/CCChieh/IBMYes#cloudflare-%E9%AB%98%E9%80%9F%E8%8A%82%E7%82%B9%E4%B8%AD%E8%BD%AC)，修改`url.hostname`为**app**分配到的`xxxxxxxxx.herokuapp.com`
  
#### 四. 关于变量 METHOD 使用范例
  默认是空值，运行方式即为：`/usr/local/bin/gost -L socks5+ws://:$PORT` 已可以满足大部分需求

  * 设置METHOD值为`-F=socks5://127.0.0.1:9050?bypass=~*.onion`，即可访问tor网络
  * 如有一个能解锁流媒体的VPS运行着SS服务，只需要修改变量METHOD下面的值，即可分流Netflix流量到VPS的SS服务器：
  > `-F=ss://AEAD_CHACHA20_POLY1305:password@server_ip:833?bypass=~*.btstatic.com,*.netflix.com,*.netflix.net,*.nflxext.com,*.nflximg.com,*.nflximg.net,*.nflxsearch.net,*.nflxso.net,*.nflxvideo.net`
  
  更多自定义使用方式参考 https://github.com/ginuerzh/gost/ https://docs.ginuerzh.xyz/gost/  
   
##### END? 谁告诉我怎么全自定义参数啊??? 
  尝试把`-L socks5+ws://:$PORT`包括到METHOD内，就会导致部署失败  
  目前这部分只有fork项目按需修改...
