.DEFAULT_GOAL := help

container-start: ## start container
	docker-compose up -d

container-build: ## build container
	if ! [ -f .env ];then cp .env.example .env;fi
	docker-compose up -d --build
	docker-compose exec app composer install
	docker-compose exec app php artisan key:generate
	docker-compose exec app php artisan migrate
	docker-compose exec app php artisan db:seed

container-stop: ## stop container
	docker-compose stop

container-remove: ## remove container
	docker-compose down

container-ssh: ## enter container service bash
	docker exec -it laravel-service /bin/bash

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
