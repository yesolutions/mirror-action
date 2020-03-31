#!/bin/sh -x
set -eu
sh -c "git config --global credential.username $GIT_USERNAME"
sh -c "git config --global core.askPass /cred-helper.sh"
sh -c "git config --global credential.helper cache"
sh -c "git init"
sh -c "git remote add mirror $*"
sh -c "git remote add origin https://github.com/perkoren/infinity-api-server"
sh -c "git fetch origin"
sh -c "git checkout -b master origin/master"
sh -c "git push --mirror mirror"
