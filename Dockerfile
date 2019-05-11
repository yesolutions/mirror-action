FROM alpine/git:latest

LABEL "com.github.actions.name"="Mirror Action"
LABEL "com.github.actions.description"="Mirror git repositories"
LABEL "com.github.actions.icon"="code"
LABEL "com.github.actions.color"="white"

LABEL "repository"="https://github.com/spyoungtech/mirror-action"
LABEL "homepage"="https://github.com/spyoungtech/mirror-action"
LABEL "maintainer"="Spencer Phillip Young <spencer.young@spyoung.com>"


COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
