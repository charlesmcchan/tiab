.PHONY: clean onos mininet host restasrt_mininet

ALL:
	@echo "\033[32m-------------\033[0m"
	@echo "\033[32mStarting ONOS\033[0m"
	@echo "\033[32m-------------\033[0m"
	docker-compose run --rm start_onos
	@echo "\033[32m----------------\033[0m"
	@echo "\033[32mStarting Mininet\033[0m"
	@echo "\033[32m----------------\033[0m"
	docker-compose up -d mininet

clean:
	docker-compose down --remove-orphan

onos:
	ssh -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null onos@localhost -p 18101

restart_mininet:
	docker-compose rm -sf mininet
	docker-compose up -d --no-recreate mininet

mininet:
	@echo "\033[31m---------------------------------------------------------------\033[0m"
	@echo "\033[31mCaution:\033[0m"
	@echo "\033[31mCtrl-D will terminate mininet. Use Ctrl-P then Ctrl-Q to escape\033[0m"
	@echo "\033[31m---------------------------------------------------------------\033[0m"
	docker attach mininet || true

host:
	docker exec -it mininet /root/m $(HOST)
