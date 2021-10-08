#!/bin/sh

# Inspired by https://docs.armory.io/docs/armory-admin/manual-service-account/

SERVICE_ACCOUNT_NAME=code-server
NAMESPACE=code-server
CLUSTERNAME=local-k8s

NEW_CONTEXT=default
KUBECONFIG_FILE="kubeconfig-sa"

SECRET_NAME=$(kubectl get serviceaccount ${SERVICE_ACCOUNT_NAME} \
  --namespace ${NAMESPACE} \
  -o jsonpath='{.secrets[0].name}')

TOKEN_DATA=$(kubectl get secret ${SECRET_NAME} \
  --namespace ${NAMESPACE} \
  -o jsonpath='{.data.token}')


TOKEN=$(echo ${TOKEN_DATA} | base64 -d)

#echo $SECRET_NAME

# Work around incase this init container is ahead of main permission initcontainer
echo "Setting permissions"
sudo chown -R 1000:1000 /home/coder

if [ ! -d "${HOME}/.kube" ]; then
  mkdir ${HOME}/.kube
fi

# Create dedicated kubeconfig
# Create a full copy
kubectl config view --raw > ${KUBECONFIG_FILE}.tmp

# Create token user
kubectl config --kubeconfig ${KUBECONFIG_FILE}.tmp \
  set-credentials ${CLUSTERNAME} \
  --token ${TOKEN}

# Create a Context
kubectl config --kubeconfig ${KUBECONFIG_FILE}.tmp \
  set-context ${CLUSTERNAME} --user ${CLUSTERNAME}
  
# Switch to context
kubectl config --kubeconfig ${KUBECONFIG_FILE}.tmp \
  use-context ${CLUSTERNAME}

# Minify
kubectl --kubeconfig ${KUBECONFIG_FILE}.tmp \
  config view --flatten --minify > ${HOME}/.kube/config

# Cleanup
rm ${KUBECONFIG_FILE}.tmp