FROM gitpod/workspace-full

# Ported from Makefile.  Eventually might just force the use of a docker container for prereq...

# Install Arcade
RUN curl -sLS https://get.arkade.dev | sh && \
    mv arkade scripts/bin/