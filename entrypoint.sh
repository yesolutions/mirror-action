#!/bin/sh -x
set -eu
sh -c "git config --global credential.username $GIT_USERNAME"
sh -c "git config --global core.askPass /cred-helper.sh"
sh -c "git config --global credential.helper cache"
sh -c "git remote add mirror $*"
sh -c "git push  mirror HEAD:master"
