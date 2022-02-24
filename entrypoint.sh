#!/usr/bin/env bash
set -e

if [[ "${DEBUG}" -eq "true" ]]; then
    set -x
fi

GIT_USERNAME=${INPUT_GIT_USERNAME:-${GIT_USERNAME:-"git"}}
REMOTE=${INPUT_REMOTE:-"$*"}
REMOTE_NAME=${INPUT_REMOTE_NAME}
GIT_SSH_PRIVATE_KEY=${INPUT_GIT_SSH_PRIVATE_KEY}
GIT_SSH_PUBLIC_KEY=${INPUT_GIT_SSH_PUBLIC_KEY}
GIT_PUSH_ARGS=${INPUT_GIT_PUSH_ARGS:-"--tags --force --prune"}
GIT_SSH_NO_VERIFY_HOST=${INPUT_GIT_SSH_NO_VERIFY_HOST}
GIT_SSH_KNOWN_HOSTS=${INPUT_GIT_SSH_KNOWN_HOSTS}
HAS_CHECKED_OUT="$(git rev-parse --is-inside-work-tree 2>/dev/null || /bin/true)"

git config --global credential.username "${GIT_USERNAME}"

if [[ "${GIT_SSH_PRIVATE_KEY}" != "" ]]; then
    mkdir -p ~/.ssh
    chmod 700 ~/.ssh
    echo "${GIT_SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa
    if [[ "${GIT_SSH_PUBLIC_KEY}" != "" ]]; then
        echo "${GIT_SSH_PUBLIC_KEY}" > ~/.ssh/id_rsa.pub
        chmod 600 ~/.ssh/id_rsa.pub
    fi
    chmod 600 ~/.ssh/id_rsa
    if [[ "${GIT_SSH_KNOWN_HOSTS}" != "" ]]; then
      echo "${GIT_SSH_KNOWN_HOSTS}" > ~/.ssh/known_hosts
      git config --global core.sshCommand "ssh -i ~/.ssh/id_rsa -o IdentitiesOnly=yes -o UserKnownHostsFile=~/.ssh/known_hosts"
    else
      if [[ "${GIT_SSH_NO_VERIFY_HOST}" != "true" ]]; then
        echo "WARNING: no known_hosts set and host verification is enabled (the default)"
        echo "WARNING: this job will fail due to host verification issues"
        echo "Please either provide the GIT_SSH_KNOWN_HOSTS or GIT_SSH_NO_VERIFY_HOST inputs"
        exit 1
      else
        git config --global core.sshCommand "ssh -i ~/.ssh/id_rsa -o IdentitiesOnly=yes -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"
      fi
    fi
else
    git config --global core.askPass /cred-helper.sh
    git config --global credential.helper cache
fi

bash /mirror.sh
