DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_FILE = srcs/docker-compose.yml

build:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) build

up:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d

down:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down

restart:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) restart

# build      Build images
# up         Start containers
# down       Stop/remove containers/networks/images/volumes
# restart    Restart containers
