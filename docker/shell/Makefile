version ?= 0.0.1
release_date ?= $(shell date +%Y-%m-%d)
upstream_image ?= "alpine:3.13.1"
image_name ?= shell
build_repo ?= quay.io/ssmiller25
build_image ?= ${build_repo}/${image_name}
run_flags ?= -it



include $(shell curl -sSL -o Makefile.docker "https://raw.githubusercontent.com/ssmiller25/blast-oci/v0.1.2/include/Makefile.docker"; echo Makefile.docker)
#include Makefile.docker
