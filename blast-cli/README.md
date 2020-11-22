# Blast CLI

A CLI that can be used to help bootstrap a blast cluster

## Development

```sh
docker run -it alpine:3.12.1 /bin/sh
apk --update add --no-cache make
apk --update add --no-cache curl
curl -sLS https://dl.get-arkade.dev | sh
arkade get kubectl
mv /root/.arkade/bin/kubectl /usr/local/bin/
arkade get civo
mv /root/.arkade/bin/civo /usr/local/bin/

```