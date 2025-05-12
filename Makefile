META_FILE ?= info.yaml
DOCKERFILE ?= Dockerfile

GET_META_FIELD = $(shell yq e .${1} ${META_FILE})

build: ${DOCKERFILE}
	$(info Building...)
	docker build -t $(call GET_META_FIELD,image):$(call GET_META_FIELD,version) --build-arg "FROM_IMAGE=$(call GET_META_FIELD,from_image)" --build-arg "FROM_VERSION=$(call GET_META_FIELD,from_version)" .

tag: build
ifeq (.git,$(wildcard .git))
	@git tag -m "$(call GET_META_FIELD,version)" "$(call GET_META_FIELD,version)" || ( echo "Error tagging: have you upgraded the version" ; false )
	@echo "Repository successfully tagged as $(call GET_META_FIELD,version)"
endif

push: build
	$(info Pushing image to registry)
	docker push $(call GET_META_FIELD,image):$(call GET_META_FIELD,version)

run: build
	docker run --rm -it $(call GET_META_FIELD,image):$(call GET_META_FIELD,version) ${CMD}

clean:

.PHONY: build tag push run clean
