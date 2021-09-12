currentepoch := $(shell date +%s)
BIN=scripts/bin
BINREQ=${BIN}/k3d $(BIN)/kubectl $(BIN)/helm $(BIN)/kustomize

DOCKER_REPO="quay.io/ssmiller25"
.PHONY: blast-otr
blast-otr: scripts/bin/arkade scripts/bin/k3d scripts/bin/kubectl scripts/bin/helm
	scripts/bin/k3d cluster create blast-otr --wait -c clusters/blast-otr/k3d.yaml

scripts/bin:
	@mkdir scripts/bin

scripts/bin/arkade: | scripts/bin
	@curl -sLS https://get.arkade.dev | sh
	@mv arkade scripts/bin/

scripts/bin/k3d: scripts/bin/arkade
	@scripts/bin/arkade get k3d
	@mv $$HOME/.arkade/bin/k3d scripts/bin/k3d

scripts/bin/kubectl: scripts/bin/arkade
	@scripts/bin/arkade get kubectl
	@mv $$HOME/.arkade/bin/kubectl scripts/bin/kubectl


scripts/bin/helm: scripts/bin/arkade
	@scripts/bin/arkade get helm
	@mv $$HOME/.arkade/bin/helm scripts/bin/helm


.PHONY: clean
clean:
	scripts/bin/k3d cluster delete blast-otr
	rm -rf scripts/bin