KUBECTL=kubectl --kubeconfig=$(CIVO_KUBECONFIG)

build: longhorn.yaml

longhorn.yaml:
	@curl https://raw.githubusercontent.com/longhorn/longhorn/master/deploy/longhorn.yaml > longhorn.yaml

	# Test final app.yaml for validity
	@echo "Testing validity of longhorn.yaml"
	@kubectl apply -f longhorn.yaml --dry-run=client > /dev/null
	@echo "Clean longhorn.yaml generated"

.PHONY: clean
clean:
	@rm longhorn.yaml

.PHONY: test
test:
	@echo "TODO: Testing Framework"
