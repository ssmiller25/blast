version ?= 20211121-3
release_date ?= $(shell date +%Y-%m-%d)
# Latest on 2021/11/21
upstream_image ?= gitpod/workspace-full@sha256:4713c384ce8be4b0cf1e413b6c860e0d18eb0718a8d9a1f16c302be6f4e697f7
image_name ?= gitpod-k8s
build_repo ?= quay.io/ssmiller25
build_image ?= ${build_repo}/${image_name}

#include $(shell curl -sSL -o Makefile.docker "https://raw.githubusercontent.com/ssmiller25/blast/v0.0.1/docker/include/Makefile.docker"; echo Makefile.docker)
include ../include/Makefile.docker

.PHONY: latest-sha256
latest-sha256:
	@docker pull gitpod/workspace-full:latest
	@docker inspect --format='{{index .RepoDigests 0}}' gitpod/workspace-full:latest