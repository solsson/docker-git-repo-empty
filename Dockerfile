FROM alpine:3.9@sha256:769fddc7cc2f0a1c35abb2f91432e8beecf83916c421420e6a6da9f8975464b6 as git

RUN apk add --no-cache git

RUN set -e; \
  git init; \
  rm .git/hooks/*.sample; \
  tar cvfz /empty-git.tgz .git

FROM busybox@sha256:4b6ad3a68d34da29bf7c8ccb5d355ba8b4babcad1f99798204e7abb43e54ee3d

COPY --from=git /empty-git.tgz /empty-git.tgz

ENV GIT_PATH=/git
VOLUME [ "/git" ]

WORKDIR ${GIT_PATH}
ENTRYPOINT [ "tar", "xvzf", "/empty-git.tgz" ]
