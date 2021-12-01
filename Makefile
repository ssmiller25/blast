currentepoch := $(shell date +%s)
k8s-code-server-version ?= 3.11.1-1
BIN=scripts/bin
BINREQ=${BIN}/k3d $(BIN)/kubectl $(BIN)/helm $(BIN)/kustomize $(BIN)/kubeseal $(BIN)/argocd


DOCKER_REPO="quay.io/ssmiller25"
.PHONY: blast-otr
blast-otr: $(BINREQ) scripts/bin/clusterctl
	docker pull quay.io/ssmiller25/k8s-code-server:$(k8s-code-server-version)
	scripts/bin/k3d cluster create blast-otr --wait -c clusters/blast-otr/k3d.yaml
	scripts/bin/k3d image import quay.io/ssmiller25/k8s-code-server:$(k8s-code-server-version) -c blast-otr

scripts/bin:
	@mkdir scripts/bin

scripts/bin/arkade: | scripts/bin
	@curl -sLS https://get.arkade.dev | sh
	@mv arkade scripts/bin/

scripts/bin/clusterctl:
	@curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/v0.4.3/clusterctl-linux-amd64 -o $@
	@chmod +x $@

$(BINREQ): scripts/bin/arkade
	echo $(notdir $@)
	@scripts/bin/arkade get $(notdir $@)
	@mv $$HOME/.arkade/bin/$(notdir $@) $@

.PHONY: clean
clean:
	scripts/bin/k3d cluster delete blast-otr

.PHONY: clean-all
clean-all: clean
	rm -rf scripts/bin
