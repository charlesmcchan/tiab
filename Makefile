.PHONY: clean onos mininet host

ALL:
	@echo "\033[32m-------------\033[0m"
	@echo "\033[32mStarting ONOS\033[0m"
	@echo "\033[32m-------------\033[0m"
	sudo docker-compose run --rm start_onos
	@echo "\033[32m----------------\033[0m"
	@echo "\033[32mStarting Mininet\033[0m"
	@echo "\033[32m----------------\033[0m"
	sudo -E docker-compose up -d mininet

clean:
	sudo -E docker-compose down --remove-orphan

onos:
	ssh -o GlobalKnownHostsFile=/dev/null -o UserKnownHostsFile=/dev/null onos@localhost -p 18101

mininet:
	@echo "\033[31m---------------------------------------------------------------\033[0m"
	@echo "\033[31mCaution:\033[0m"
	@echo "\033[31mCtrl-D will terminate mininet. Use Ctrl-P then Ctrl-Q to escape\033[0m"
	@echo "\033[31m---------------------------------------------------------------\033[0m"
	sudo -E docker attach mininet || true

host:
	sudo docker exec -it mininet /root/m $(HOST)
