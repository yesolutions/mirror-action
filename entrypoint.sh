#!/usr/bin/env bash
set -e


GIT_USERNAME=${INPUT_GIT_USERNAME:-${GIT_USERNAME:-"git"}}
REMOTE=${INPUT_REMOTE:-"$*"}
GIT_SSH_PRIVATE_KEY=${INPUT_GIT_SSH_PRIVATE_KEY}
GIT_PUSH_ARGS=${INPUT_ADDITIONAL_PUSH_ARGS:-"--tags --force --prune"}

HAS_CHECKED_OUT="$(git rev-parse --is-inside-work-tree 2>/dev/null || echo false)"


if [[ "${HAS_CHECKED_OUT}" -eq "false" ]]; then
    echo "WARNING: repo not checked out; attempting checkout" > /dev/stderr
    echo "WARNING: this behavior is deprecated and will be removed in a future release" > /dev/stderr
    echo "WARNING: to remove this warning add the following to your yml job steps:" > /dev/stderr
    echo " - uses: actions/checkout@v2" > /dev/stderr
    if [[ "${SRC_REPO}" -eq "" ]]; then
        echo "FATAL: SRC_REPO env variable not defined"
        exit 1
    fi
    git init
    git add origin "${SRC_REPO}"
fi

git config --global credential.username "${GIT_USERNAME}"


if [[ "${GIT_SSH_PRIVATE_KEY}" -ne "" ]]; then
    mkdir ~/.ssh
    echo "${INPUT_SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa
    chmod 600 ~/.ssh/id_rsa
else
    git config --global credential.helper cache
fi

git fetch origin

git remote add mirror "${REMOTE}"
git push "${GIT_PUSH_ARGS}" mirror "refs/remotes/origin/*:refs/heads/*"
