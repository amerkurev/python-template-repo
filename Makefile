ifdef GITHUB_REF
    # CI environment - use provided ref
    GIT_TAG=$(shell echo $(GITHUB_REF) | cut -d'/' -f3)
else
    # Local environment - calculate from git
    GIT_TAG=$(shell git describe --tags --abbrev=0 2>/dev/null || git rev-parse --abbrev-ref HEAD)
endif

ifdef GITHUB_SHA
    # CI environment - use provided sha
    GIT_SHA=$(GITHUB_SHA)
else
    # Local environment - calculate from git
    GIT_SHA=$(shell git rev-parse --short HEAD)
endif

REV=$(GIT_TAG)-$(GIT_SHA)
PWD=$(shell pwd)
PROJECT_NAME=$(shell basename $(PWD))
IMAGE=$(shell basename $(PWD)):master

info:
	- @echo "revision $(REV)"

pip-sync:
	- @pip-compile requirements.in
	- @pip-sync requirements.txt

build:
	- @docker buildx build --load --build-arg GIT_SHA="${GIT_SHA}" --build-arg GIT_TAG="${GIT_TAG}" -t $(IMAGE) --progress=plain .

lint:
	- @ruff check src

fmt: lint
	- @ruff format src

test:
	- @docker run --rm -t -v $(PWD)/src:/usr/src/app $(IMAGE) ./pytest.sh

cov:
	- @docker run --rm -t -v $(PWD)/src:/usr/src/app $(IMAGE) coverage html


dev: build
	- @docker run -it --rm \
	  --name $(PROJECT_NAME) \
  	  --env-file=.env \
	  -v $(PWD)/src:/usr/src/app \
	  -p 8000:8000 \
	  $(IMAGE)

.PHONY: info pip-sync build lint fmt test cov dev
