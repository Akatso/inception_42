DOCKER_CMD = docker
COMPOSE_CMD = docker-compose
COMPOSE_FILE = srcs/docker-compose.yml

build:
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) build
	sudo mkdir -p /home/kali/data/wordpress
	sudo mkdir -p /home/kali/data/mariadb

up:
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) up -d

down:
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) down -v --rmi all
	cd /home/kali && sudo rm -rf data

restart:
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) restart

list:
	$(DOCKER_CMD) ps -a
	$(DOCKER_CMD) volume ls
	$(DOCKER_CMD) image ls
	$(DOCKER_CMD) network ls

# FOR DOCKER-COMPOSE
# build      Build images
# up         Start containers
# down       Stop/remove containers/networks/images/volumes
# restart    Restart containers

# EXEC WITH BASH
# docker exec -it <container_name> bash