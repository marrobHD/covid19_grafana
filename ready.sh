#!/bin/bash
source .env

echo Set url to $END_IP_DOMAIN

cd grafana_provisioning/dashboards
cp COVID19.json COVID19.json.bak
cp COVID19_CONFIRMED.json COVID19_CONFIRMED.json.bak
cp COVID19_DEATHS.json COVID19_DEATHS.json.bak
sed "s#http://localhost:5000#$END_IP_DOMAIN#g" COVID19.json
sed "s#http://localhost:5000#$END_IP_DOMAIN#g" COVID19_CONFIRMED.json
sed "s#http://localhost:5000#$END_IP_DOMAIN#g" COVID19_DEATHS.json

