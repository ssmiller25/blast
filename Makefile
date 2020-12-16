currentepoch := $(shell date +%s)
latestepoch := $(shell docker image ls | grep r15cookieblog | grep -v latest | awk ' { print $$2; } ' | sort -n | tail -n 1)

DOCKER_REPO="quay.io/ssmiller25"
DOCKER_BUILD=docker-ansible-alpine blast-rt


.PHONY: build
build: build-blast-rt build-ansible-rt

.PHONY: build-ansible-rt
build-ansible-rt:
	docker build docker-ansible-alpine/ \
	--build-arg ANSIBLE_LINT_VERSION=4.3.7 \
	--build-arg ANSIBLE_VERSION=2.10.3 \
	--build-arg MITOGEN_VERSION=0.2.9 \
	-t $(DOCKER_REPO)/docker-ansible-alpine:${currentepoch}; \
	docker tag $(DOCKER_REPO)/docker-ansible-alpine:${currentepoch} $(DOCKER_REPO)/docker-ansible-alpine:latest; \



.PHONY: build-blast-rt
build-blast-rt:
	docker build blast-rt/ -t $(DOCKER_REPO)/blast-rt:${currentepoch}; \
	docker tag $(DOCKER_REPO)/blast-rt:${currentepoch} $(DOCKER_REPO)/blast-rt:latest; \
	

.PHONY: run
run:
	@docker run -d --rm -p 8080:80 --name r15cookieblog ssmiller25/r15cookieblog:latest 
	@echo "Local running.  Go to http://localhost:8080/ to view"

.PHONY: stop
stop:
	@echo "Stopping r15cookieblog - should shelf-cleanup"
	@docker stop r15cookieblog

.PHONY: push
push:
	@docker push ssmiller25/r15cookieblog:$(latestepoch)
	@docker push ssmiller25/r15cookieblog:latest


.PHONY: civo-up
civo-up: $(KUBECONFIG)

$(KUBECONFIG):
	@echo "Creating $(CLUSTER_NAME)"
	@$(CIVO_CMD) k3s list | grep -q $(CLUSTER_NAME) || $(CIVO_CMD) k3s create $(CLUSTER_NAME) -n 1 --size $(CIVO_SIZE) --wait
	@$(CIVO_CMD) k3s config $(CLUSTER_NAME) > $(KUBECONFIG)

.PHONY: civo-down
civo-down:
	@echo "Removing $(CLUSTER_NAME)"
	@$(CIVO_CMD) k3s remove $(CLUSTER_NAME) || true
	@rm $(KUBECONFIG)

.PHONY: civo-deploy
civo-deploy: $(KUBECONFIG)
	@$(KUBECTL) apply -k ./

civo-env: $(KUBECONFIG)
	export KUBECONFIG=$(KUBECONFIG)
