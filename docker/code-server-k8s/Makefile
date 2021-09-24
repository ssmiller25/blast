version ?= 3.11.1-1
release_date ?= $(shell date +%Y-%m-%d)
upstream_image ?= codercom/code-server:3.11.1
image_name ?= k8s-code-server
build_repo ?= quay.io/ssmiller25
build_image ?= ${build_repo}/${image_name}

#include $(shell curl -sSL -o Makefile.docker "https://raw.githubusercontent.com/ssmiller25/blast/v0.0.1/docker/include/Makefile.docker"; echo Makefile.docker)
include ../include/Makefile.docker