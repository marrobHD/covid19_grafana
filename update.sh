#!/usr/bin/env bash

git init

git remote add origin https://github.com/marrobHD/covid19_grafana.git

git fetch origin master

# git checkout -b master --track origin/master # origin/master is clone's default branch

git reset --hard origin/master # or to whatever commit you want to go reset to

# git clean -f -d

rm -rf .git





