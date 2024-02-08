IMAGE_NAME := docker_template
CONTAINER_NAME := $(IMAGE_NAME)

build:
	docker build -t $(IMAGE_NAME) . \
		--build-arg ssh_pub_key="$$(cat ~/.ssh/id_rsa.pub)" \
		--build-arg hostname="$(CONTAINER_NAME)"

run:
	docker run \
		--mount type=bind,source="$(PWD)/app",target=/app \
		--name=$(CONTAINER_NAME) \
		--hostname=$(CONTAINER_NAME) \
		-d \
		-p 2222:22 \
		$(IMAGE_NAME)

ssh:
	ssh -p 2222 ubuntu@localhost

stop:
	docker stop $(CONTAINER_NAME)

rm: stop
	docker rm $(CONTAINER_NAME)

clean: rm
	docker rmi $(IMAGE_NAME)

