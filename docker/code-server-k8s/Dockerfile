ARG GIT_HASH
ARG VERSION
ARG RELEASE_DATE
ARG UPSTREAM_IMAGE

FROM ${UPSTREAM_IMAGE}

# VSCode extensions
RUN code-server --install-extension redhat.vscode-yaml \
  code-server --install-extension ms-kubernetes-tools.vscode-kubernetes-tools

# Adding our utiltiies
RUN sudo apt-get update \
 && sudo apt-get install -y \
    make \
    jq \
  && sudo rm -rf /var/lib/apt/lists/*

# Arkade and other utils
RUN curl -sLS https://get.arkade.dev | sudo sh
#RUN for util in kubectl kustomize civo helm kim kubeseal tkn yq; do \
RUN for util in kubectl kustomize civo; do \
    arkade get ${util}; \
    sudo mv ${HOME}/.arkade/bin/${util} /usr/local/bin/; \
done


LABEL maintainer="Steve Miller <me@r15cookie.com>"
LABEL version="${VERSION}"
LABEL git_hash="${GIT_HASH}"
LABEL release-date="${RELEASE_DATE}"

