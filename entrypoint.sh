#!/usr/bin/env bash
set -e

if [[ "${DEBUG}" -eq "true" ]]; then
    set -x
fi

GIT_USERNAME=${INPUT_GIT_USERNAME:-${GIT_USERNAME:-"git"}}
REMOTE=${INPUT_REMOTE:-"$*"}
GIT_SSH_PRIVATE_KEY=${INPUT_GIT_SSH_PRIVATE_KEY}
GIT_PUSH_ARGS=${INPUT_ADDITIONAL_PUSH_ARGS:-"--tags --force --prune"}

HAS_CHECKED_OUT="$(git rev-parse --is-inside-work-tree 2>/dev/null || /bin/true)"


if [[ "${HAS_CHECKED_OUT}" != "true" ]]; then
    echo "WARNING: repo not checked out; attempting checkout" > /dev/stderr
    echo "WARNING: this may result in missing commits in the remote mirror" > /dev/stderr
    echo "WARNING: this behavior is deprecated and will be removed in a future release" > /dev/stderr
    echo "WARNING: to remove this warning add the following to your yml job steps:" > /dev/stderr
    echo " - uses: actions/checkout@v1" > /dev/stderr
    if [[ "${SRC_REPO}" -eq "" ]]; then
        echo "WARNING: SRC_REPO env variable not defined" > /dev/stderr
        SRC_REPO="https://github.com/${GITHUB_REPOSITORY}.git" > /dev/stderr
        echo "Assuming source repo is ${SRC_REPO}" > /dev/stderr
     fi
    git init > /dev/null
    git remote add origin "${SRC_REPO}"
    git fetch --all > /dev/null 2>&1
fi

git config --global credential.username "${GIT_USERNAME}"


if [[ "${GIT_SSH_PRIVATE_KEY}" -ne "" ]]; then
    mkdir ~/.ssh
    echo "${INPUT_SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa
    chmod 600 ~/.ssh/id_rsa
else
    git config --global core.askPass /cred-helper.sh
    git config --global credential.helper cache
fi


git remote add mirror "${REMOTE}"
if [[ "${INPUT_PUSH_ALL_REFS}" != "false" ]]; then
    eval git push ${GIT_PUSH_ARGS} mirror "\"refs/remotes/origin/*:refs/heads/*\""
else
    if [[ "${HAS_CHECKED_OUT}" != "true" ]]; then
        echo "FATAL: You must upgrade to using actions inputs instead of args: to push a single branch" > /dev/stderr
        exit 1
    else
        eval git push -u ${GIT_PUSH_ARGS} mirror
    fi
fi
