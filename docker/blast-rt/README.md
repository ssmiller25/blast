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
# Latest Dasel
curl -s https://api.github.com/repos/tomwright/dasel/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4 | wget -qi - && mv dasel_linux_amd64 dasel && chmod +x dasel
mv ./dasel /usr/local/bin/dasel

```
