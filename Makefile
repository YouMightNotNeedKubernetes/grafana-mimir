docker_stack_name = mimir

-include .env.example
-include .env.local

it:
	@echo "make [deploy|destroy]"

deploy:
	test -f "configs/mimir.yaml" || cp configs/configs/mimir.base.yaml configs/mimir.yaml
	docker stack deploy -c docker-compose.yml $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
