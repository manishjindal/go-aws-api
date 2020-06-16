.PHONY: build build.docker

BINARY        ?= go-aws-api
SOURCES        = $(shell find . -name '*.go')
IMAGE         ?= mjindal/$(BINARY)
VERSION       ?= $(shell git describe --tags --always --dirty)


build: build/$(BINARY)

build/$(BINARY): $(SOURCES)
	CGO_ENABLED=0 go build -o build/$(BINARY) .

build.push: build.docker
	docker push "$(IMAGE):$(VERSION)"

build.docker:
	docker build --rm --tag "$(IMAGE):$(VERSION)" --build-arg VERSION="$(VERSION)" .

clean:
	@rm -rf build
