SHELL:=/bin/bash
REVISION:=$(shell git rev-parse HEAD)

build:
	docker build -f Dockerfile -t sirene:${REVISION} .

login:
	zsh -c "`aws ecr get-login --no-include-email --region eu-west-3`"

push: login build
	REVISION=$(shell git rev-parse HEAD)
	docker tag sirene:${REVISION} sirene:latest
	docker tag sirene:${REVISION} 771637207041.dkr.ecr.eu-west-3.amazonaws.com/sirene:${REVISION}
	docker push 771637207041.dkr.ecr.eu-west-3.amazonaws.com/sirene:${REVISION}

deploy: push
	docker tag sirene:latest sirene:production
	docker tag sirene:production 771637207041.dkr.ecr.eu-west-3.amazonaws.com/sirene:production
	docker push 771637207041.dkr.ecr.eu-west-3.amazonaws.com/sirene:production

