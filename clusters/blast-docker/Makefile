capi-blast-docker.yaml:
	@../../scripts/bin/clusterctl generate cluster capi-quickstart --flavor development \
  --kubernetes-version v1.21.3 \
  --control-plane-machine-count=1 \
  --worker-machine-count=1 \
  > capi-blast-docker.yaml

calico.yaml:
	@curl -LO https://docs.projectcalico.org/v3.20/manifests/calico.yaml