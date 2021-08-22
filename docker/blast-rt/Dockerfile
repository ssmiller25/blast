FROM alpine:3.12.1

RUN apk --update add --no-cache make && \
  apk --update add --no-cache curl && \
  apk --update add --no-cache jq && \
  curl -sLS https://dl.get-arkade.dev | sh && \
  arkade get kubectl && \
  mv /root/.arkade/bin/kubectl /usr/local/bin/ && \
  arkade get civo && \
  mv /root/.arkade/bin/civo /usr/local/bin/

# Dasel
RUN curl -s https://api.github.com/repos/tomwright/dasel/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4 | xargs curl -LO && mv dasel_linux_amd64 dasel && \
chmod +x dasel && \
mv ./dasel /usr/local/bin/dasel
