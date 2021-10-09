app.yaml:
	@../../../scripts/bin/helm repo add crossplane-stable https://charts.crossplane.io/stable
	@../../../scripts/bin/helm repo update
	@../../../scripts/bin/helm template crossplane --namespace crossplane-system crossplane-stable/crossplane --version 1.4.1 > app.yaml

.PHONY: list-versions
	@../../../scripts/bin/helm search repo crossplane-stable/crossplane --versions

.PHONY: clean 
clean:
	rm app.yaml
	rm -rf src/