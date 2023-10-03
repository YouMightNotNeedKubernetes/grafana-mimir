docker_stack_name = mimir

it:
	@echo "make [deploy|destroy]"

deploy:
	test -f "configs/mimir.yaml" || cp configs/mimir.base.yaml configs/mimir.yaml
	docker stack deploy -c docker-compose.yml $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
