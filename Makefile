.DEFAULT_GOAL := help

container-start: ## start container
	docker-compose up -d

container-build: ## build container
	docker-compose up -d --build

container-stop: ## stop container
	docker-compose stop

container-remove: ## remove container
	docker-compose down

container-ssh: ## enter container service bash
	docker exec -it laravel-service /bin/bash

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
