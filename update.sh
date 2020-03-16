#!/usr/bin/env bash

git init

git remote add origin https://github.com/marrobHD/covid19_grafana.git

git fetch origin master

# git checkout -b master --track origin/master # origin/master is clone's default branch

git reset --hard origin/master # or to whatever commit you want to go reset to

# git clean -f -d

rm -rf .git
echo "
# /etc/systemd/system/covid19-app.service

[Unit]
Description=COVID19 Grafana tracker
Requires=docker.service
After=docker.service

[Service]
Type=oneshot
RemainAfterExit=yes
WorkingDirectory=/home/covid19_grafana/
ExecStart=/usr/local/bin/docker-compose up -d
ExecStop=/usr/local/bin/docker-compose down
TimeoutStartSec=0

[Install]
WantedBy=multi-user.target
" >> /etc/systemd/system/covid19-app.service


while true; do
    read -p "Do you wish to run COVID19-Grafana now and add autostart?" yn
    case $yn in
        [Yy]* ) systemctl restart covid19-app.service && sleep 5 && systemctl status covid19-app.service && sudo systemctl enable covid19-app.service && echo to remove autostart you have to run: systemctl disable covid19-app.service; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done 







