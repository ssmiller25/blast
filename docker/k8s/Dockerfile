FROM alpine:latest

RUN curl -sLS https://dl.get-arkade.dev | sudo sh
RUN for util in kubectl civo terraform kind k3d kustomize yq; do \
    arkade get ${util}; \
    sudo mv ${HOME}/.arkade/bin/${util} /usr/local/bin/ \
done

