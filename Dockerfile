FROM alpine/git:latest

RUN apk --no-cache add bash

LABEL "com.github.actions.name"="Mirror Repository"
LABEL "com.github.actions.description"="Automate mirroring of git commits to another remote repository, like GitLab or Bitbucket"
LABEL "com.github.actions.icon"="git-commit"
LABEL "com.github.actions.color"="green"

LABEL "repository"="https://github.com/yesolutions/mirror-action"
LABEL "homepage"="https://github.com/yesolutions/mirror-action"
LABEL "maintainer"="Spencer Phillip Young <spencer.young@spyoung.com>"


COPY entrypoint.sh /entrypoint.sh
COPY cred-helper.sh /cred-helper.sh
ENTRYPOINT ["/entrypoint.sh"]
