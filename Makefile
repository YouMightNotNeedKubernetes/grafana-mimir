docker_stack_name = mimir

compose_files := -c docker-compose.yml
ifneq ("$(wildcard docker-compose.override.yml)","")
	compose_files += -c docker-compose.override.yml
endif

it:
	@echo "make [configs|deploy|destroy]"

.PHONY: configs
configs:
	test -f "configs/mimir.yaml" || cp configs/mimir.default.yaml configs/mimir.yaml

deploy: configs
	docker stack deploy $(compose_files) $(docker_stack_name)

destroy:
	docker stack rm $(docker_stack_name)
