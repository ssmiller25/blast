ARG GIT_HASH
ARG VERSION
ARG RELEASE_DATE
ARG UPSTREAM_IMAGE


# Main Image
FROM $UPSTREAM_IMAGE

RUN apk add --no-cache git
# From Edge Testing
RUN apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing git-secret

RUN npm install -g @bitwarden/cli


COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

LABEL maintainer="Steve Miller <me@r15cookie.com>"
LABEL version="${VERSION}"
LABEL git_hash="${GIT_HASH}"
LABEL release-date="${RELEASE_DATE}"

