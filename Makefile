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


MIMIR_DASHBOARD_DIR=https://github.com/grafana/mimir/blob/main/operations/mimir-mixin-compiled
define get_dashboard
	curl -L -o dashboards/$(1) $(MIMIR_DASHBOARD_DIR)/dashboards/$(1)
endef

.PHONY: dashboards
dashboards:
	mkdir -p dashboards
	$(call get_dashboard,mimir-alertmanager.json)
	$(call get_dashboard,mimir-compactor.json)
	$(call get_dashboard,mimir-object-store.json)
	$(call get_dashboard,mimir-overrides.json)
	$(call get_dashboard,mimir-queries.json)
	$(call get_dashboard,mimir-reads.json)
	$(call get_dashboard,mimir-ruler.json)
	$(call get_dashboard,mimir-tenants.json)
	$(call get_dashboard,mimir-top-tenants.json)
	$(call get_dashboard,mimir-writes.json)
