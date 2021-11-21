ARG GIT_HASH
ARG VERSION
ARG RELEASE_DATE
ARG UPSTREAM_IMAGE

FROM ${UPSTREAM_IMAGE}

# Ported from Makefile.  Eventually might just force the use of a docker container for prereq...

# Utilities to Add
RUN sudo apt-get update && sudo apt-get install -y \
  shellcheck \
  && sudo rm -rf /var/lib/apt/lists/*

# Install Arcade
RUN curl -sLS https://get.arkade.dev | sh && \
    sudo mv arkade /usr/local/bin/

# Install basic k8s utilities and civo
#  TODO: Add kustomize back in once it's fixed
RUN for util in civo kubectl helm; do \
  arkade get ${util}; \
  sudo mv .arkade/bin/${util} /usr/local/bin/; \
  done

# Work-around until they kustomize fixed in arkade
USER root

RUN curl -LO https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv4.4.1/kustomize_v4.4.1_linux_amd64.tar.gz && \
  tar -xf kustomize*.tar.gz && \
  mv kustomize /usr/local/bin && \
  rm kustomize*.tar.gz

USER gitpod

# Install starship
RUN brew install starship

# starship configuration
RUN mkdir $HOME/.config
COPY scripts/starship.toml $HOME/.config/starship.toml

# bashrc inclusion for custom startup commands - from https://community.gitpod.io/t/how-to-config-bashrc/957/13
COPY scripts/gitpod-bashrc/90-kubectl.sh $HOME/.bashrc.d/
COPY scripts/gitpod-bashrc/95-gitpod-civo-env.sh $HOME/.bashrc.d/
COPY scripts/gitpod-bashrc/99-starship.sh $HOME/.bashrc.d/