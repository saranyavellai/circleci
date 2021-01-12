
.DEFAULT: all
.PHONY: all

REPOSITORY ?= 183795
NAME := alpine-image
ALPINE_VERSION := 3.12
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
SUFFIX ?= -$(subst /,-,$(BRANCH))


all: build

build: python${PYTHON_VERSION}.Dockerfile
        @./build.sh "$(REPOSITORY)/$(NAME) "${ALPINE_VERSION}"

push:
        # Push docker images
        docker push "$(REPOSITORY)/$(NAME):alpine-${ALPINE_VERSION}

manifest:
        # Manifest for alpine-${ALPINE_VERSION}-pyinstaller-${PYINSTALLER_TAG}
        DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create -a "$(REPOSITORY)/$(NAME):alpine-${ALPINE_VERSION} \
                "$(REPOSITORY)/$(NAME):alpine-${ALPINE_VERSION} 
        DOCKER_CLI_EXPERIMENTAL=enabled docker manifest push "$(REPOSITORY)/$(NAME):alpine-${ALPINE_VERSION}
        # Manifest for $(REPOSITORY)/$(NAME):latest
        DOCKER_CLI_EXPERIMENTAL=enabled docker manifest create -a "$(REPOSITORY)/$(NAME):latest" \
                "$(REPOSITORY)/$(NAME):alpine-${ALPINE_VERSION}
        DOCKER_CLI_EXPERIMENTAL=enabled docker manifest push "$(REPOSITORY)/$(NAME):latest"
