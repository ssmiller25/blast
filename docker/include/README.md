# Make-Includes

A centralized place for common Makefiles that could be included in various projects.  Overall goals

- Parameters passed by environment variable.  We're applicable, sane defaults if no variables are set
- Sane pre-requisite checking
- Common build, tagging, and local running toolchain.
- Potentially k8s testing from various providers.

## Usage

**Makefile:**
```makefile
version ?= 0.0.1
release_date ?= $(shell date +%Y-%m-%d)
upstream_images ?= $(shell cat .upstream-images)
image_name ?= myimage
build_repo ?= quay.io/ssmiller25
build_image ?= ${build_repo}/${image_name}

include $(shell curl -sSL -o Makefile.docker "https://raw.githubusercontent.com/ssmiller25/blast/v0.0.1/docker/include/Makefile.docker"; echo Makefile.docker)

```

**.upstream-images:**

```text
alpine:1.13.1
```
