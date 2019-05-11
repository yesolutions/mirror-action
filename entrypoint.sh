#!/bin/sh

branch=$(git symbolic-ref --short HEAD)
sh -c "git config --global user.name $GIT_USERNAME"
sh -c "git config --global core.askPass /cred-helper.sh"
sh -c "git config --global credential.helper cache"
sh -c "git config credential"
sh -c "git remote add mirror $*"
sh -c "git remote set-url $*"
sh -c "echo pushing to $(git remote get-url --push mirror)"
sh -c "git push mirror $branch"
