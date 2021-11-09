FROM gitpod/workspace-full

# Ported from Makefile.  Eventually might just force the use of a docker container for prereq...

# Install Arcade
RUN curl -sLS https://get.arkade.dev | sh && \
    sudo mv arkade /usr/local/bin/

# INstall basic k8s utilities and civo
RUN for util in civo kubectl helm kustomize; do \
  arkade get ${util}; \
  sudo mv .arkade/bin/${util} /usr/local/bin/; \
  done

