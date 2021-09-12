app.yaml: | src
	 @../../../scripts/bin/helm template code-server src/ci/helm-chart > app.yaml

src:
	git clone --depth=1 https://github.com/cdr/code-server src


.PHONY: clean 
clean:
	rm app.yaml
	rm -rf src/