docker_stack_name = mimir

it:
	@echo "make [configs|deploy|destroy]"

.PHONY: configs
configs:
	test -f "configs/mimir.yaml" || cp configs/mimir.default.yaml configs/mimir.yaml

deploy: configs
	docker stack deploy -c docker-compose.yml $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
