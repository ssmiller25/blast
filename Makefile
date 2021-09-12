currentepoch := $(shell date +%s)

DOCKER_REPO="quay.io/ssmiller25"
.PHONY: blast-otr
blast-otr: scripts/bin/arkade scripts/bin/k3d scripts/bin/kubectl

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

.PHONY: clean
clean:
	rm -rf scripts/bin