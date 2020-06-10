#!/bin/bash
source .env

echo Set url to $END_IP_DOMAIN

cd grafana_provisioning/dashboards
cp COVID19.json COVID19.json.bak
cp COVID19_CONFIRMED.json COVID19_CONFIRMED.json.bak
cp COVID19_DEATHS.json COVID19_DEATHS.json.bak
sed -i "s#http://localhost:5000#$END_IP_DOMAIN#g" COVID19.json
sed -i "s#http://localhost:5000#$END_IP_DOMAIN#g" COVID19_CONFIRMED.json
sed -i "s#http://localhost:5000#$END_IP_DOMAIN#g" COVID19_DEATHS.json

echo "
# /etc/systemd/system/covid19-app.service

[Unit]
Description=COVID19 Grafana tracker
Requires=docker.service
After=docker.service

[Service]
Type=simple
RemainAfterExit=yes
WorkingDirectory=/home/covid19_grafana/
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
" >> /etc/systemd/system/covid19-app.service
systemctl daemon-reload

while true; do
    read -p "Do you wish to run COVID19-Grafana now and add autostart?" yn
    case $yn in
        [Yy]* ) systemctl restart covid19-app.service && sleep 5 && systemctl status covid19-app.service && sudo systemctl enable covid19-app.service && echo to remove autostart you have to run: systemctl disable covid19-app.service; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
