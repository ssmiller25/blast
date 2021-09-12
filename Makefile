currentepoch := $(shell date +%s)
BIN=scripts/bin
BINREQ=${BIN}/k3d $(BIN)/kubectl $(BIN)/helm $(BIN)/kustomize


DOCKER_REPO="quay.io/ssmiller25"
.PHONY: blast-otr
blast-otr: scripts/bin/arkade $(BINREQ)
	scripts/bin/k3d cluster create blast-otr --wait -c clusters/blast-otr/k3d.yaml

scripts/bin:
	@mkdir scripts/bin

scripts/bin/arkade: | scripts/bin
	@curl -sLS https://get.arkade.dev | sh
	@mv arkade scripts/bin/

$(BINREQ): scripts/bin/arkade
	echo $(notdir $@)
	@scripts/bin/arkade get $(notdir $@)
	@mv $$HOME/.arkade/bin/$(notdir $@) $@

.PHONY: clean
clean:
	scripts/bin/k3d cluster delete blast-otr
	rm -rf scripts/bin