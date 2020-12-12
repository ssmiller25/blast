currentepoch := $(shell date +%s)
latestepoch := $(shell docker image ls | grep r15cookieblog | grep -v latest | awk ' { print $$2; } ' | sort -n | tail -n 1)

DOCKER_REPO="quay.io/ssmiller25"
DOCKER_BUILD=docker-ansible-alpine blast-rt


.PHONY: build
build: 
	@for docker_build in $(DOCKER_BUILD); do \
		docker build $${docker_build}/ -t $(DOCKER_REPO)/$${docker_build}:${currentepoch}; \
		docker tag $(DOCKER_REPO)/$${docker_build}:${currentepoch} $(DOCKER_REPO)/$${docker_build}:latest; \
	done
	

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
