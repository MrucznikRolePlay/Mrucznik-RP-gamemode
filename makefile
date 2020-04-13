.PHONY: gen build build-alpine clean test help default

BIN_NAME=Mrucznik-RP.amx

VERSION := $(shell grep VERSION gamemodes/VERSION.pwn | sed -E 's/.*"(.+)"$$/\1/')
GIT_COMMIT=$(shell git rev-parse HEAD)
GIT_DIRTY=$(shell test -n "`git status --porcelain`" && echo "+CHANGES" || true)
BUILD_DATE=$(shell date '+%Y-%m-%d-%H:%M:%S')
IMAGE_NAME := "mrucznik/mrucznik-rp"

default: help

help:
	@echo 'Management commands for Mrucznik Role Play gamamode:'
	@echo
	@echo 'Usage:'
	@echo '    make run             Run server with Mrucznik-RP gamemode.'
	@echo '    make build           Compile the project.'
	@echo '    make ensure          Ensure package dependencies.'
	@echo '    make package         Build docker image with gamemode and development server inside'
	@echo '    make tag             Tag image created by package with latest, git commit and version'
	@echo '    make push            Push tagged images to registry'
	@echo '    make gen             Generate files using mrucznikctl.'
	@echo '    make clean           Clean the directory tree.'
	@echo

run:
	@echo "Run Mrucznik-RP gamemode server"
	sampctl server run

ensure:
	@echo "ensuring dependencies"
	sampctl package ensure

build:
	@echo "building ${BIN_NAME} ${VERSION}"
	sampctl package build

package:
	@echo "building server image ${BIN_NAME} ${VERSION} $(GIT_COMMIT)"
	docker build --build-arg VERSION=${VERSION} --build-arg GIT_COMMIT=$(GIT_COMMIT) -t $(IMAGE_NAME):local --no-cache .

tag: 
	@echo "Tagging: latest ${VERSION} $(GIT_COMMIT)"
	docker tag $(IMAGE_NAME):local $(IMAGE_NAME):$(GIT_COMMIT)
	docker tag $(IMAGE_NAME):local $(IMAGE_NAME):${VERSION}
	docker tag $(IMAGE_NAME):local $(IMAGE_NAME):latest

push: tag
	@echo "Pushing docker image to registry: latest ${VERSION} $(GIT_COMMIT)"
	docker push $(IMAGE_NAME):$(GIT_COMMIT)
	docker push $(IMAGE_NAME):${VERSION}
	docker push $(IMAGE_NAME):latest

gen:
	@echo "Generating code..."
	cd gamemodes && mrucznikctl build

clean:
	@echo "cleaning..."
	rm -R dependencies
