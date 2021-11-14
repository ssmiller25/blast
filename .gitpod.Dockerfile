FROM gitpod/workspace-full

# Ported from Makefile.  Eventually might just force the use of a docker container for prereq...

# Utilities to Add
RUN sudo apt-get update && sudo apt-get install -y \
  shellcheck \
  && sudo rm -rf /var/lib/apt/lists/*

# Install Arcade
RUN curl -sLS https://get.arkade.dev | sh && \
    sudo mv arkade /usr/local/bin/

# Install basic k8s utilities and civo
RUN for util in civo kubectl helm kustomize; do \
  arkade get ${util}; \
  sudo mv .arkade/bin/${util} /usr/local/bin/; \
  done

# Install starship
RUN brew install starship

# starship configuration
RUN mkdir $HOME/.config
COPY scripts/gitpod/starship.toml $HOME/.config/starship.toml

# bashrc inclusion for custom startup commands - from https://community.gitpod.io/t/how-to-config-bashrc/957/13
COPY scripts/gitpod/gitpod-bashrc/90-kubectl.sh $HOME/.bashrc.d/
COPY scripts/gitpod/gitpod-bashrc/99-starship.sh $HOME/.bashrc.d/