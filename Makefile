COMPOSE_CMD = docker-compose
COMPOSE_FILE = srcs/docker-compose.yml

build:
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) build

up:
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) up -d

down:
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) down

restart:
	$(COMPOSE_CMD) -f $(COMPOSE_FILE) restart

# build      Build images
# up         Start containers
# down       Stop/remove containers/networks/images/volumes
# restart    Restart containers
