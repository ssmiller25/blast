#!/bin/sh
#
# Setup initial civo kubectl with ALL cluster imported

if [ -n ${CIVO_API_KEY} ]; then
    if civo apikey add default $CIVO_API_KEY > /dev/null 2>&1; then
        echo "CIVO API failed"
        exit 1
    fi
    mkdir ${HOME}/.kube
    kubectl config view --raw > ${HOME}/.kube/config
    for cluster in $(civo k3s list -o custom -f "name"); do
        civo k3s config ${cluster} --save --merge
    done
fi