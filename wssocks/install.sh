#!/bin/sh

curl -o /usr/local/bin/wssocks -L https://github.com/ixiumu/box/releases/download/v1.0/wssocks
chmod +x /usr/local/bin/wssocks

cat <<EOFSERVER > /etc/systemd/system/wssocks.service
[Unit]
Description=WSSOCKS
After=network.target 

[Service]
User=nobody
Type=simple
Restart=on-failure
ExecStart=/usr/local/bin/wssocks server --addr 127.0.0.1:7688
KillMode=process

[Install]
WantedBy=multi-user.target
EOFSERVER

systemctl daemon-reload
systemctl enable wssocks.service
systemctl start wssocks.service
