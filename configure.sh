#!/bin/sh

mkdir /tmp/v
curl -L -H "Cache-Control: no-cache" -o /tmp/v/v2.zip https://raw.githubusercontent.com/luminislight/else-if/master/v2linux.zip
unzip /tmp/v/v2.zip -d /tmp/v
install -m 755 /tmp/v/v2ray /usr/local/bin/v2ray
install -m 755 /tmp/v/v2ctl /usr/local/bin/v2ctl

rm -rf /tmp/v2

install -d /usr/local/etc/v2ray
cat << EOF > /usr/local/etc/v2ray/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "alterId": 64
                    }
                ],
                "disableInsecureEncryption": true
            },
            "streamSettings": {
                "network": "ws"
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

/usr/local/bin/v2ray -config /usr/local/etc/v2ray/config.json
