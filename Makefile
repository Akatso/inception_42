YELLOW=\033[1;33m
NC=\033[0m

DOCKER_CMD = docker
COMPOSE_CMD = docker-compose
COMPOSE_FILE = srcs/docker-compose.yml
ENV = srcs/.env

all: secrets build up

build: secrets
	@echo "$(YELLOW)Building containers...$(NC)"
	@sudo mkdir -p /home/slepetit/data/wordpress
	@sudo mkdir -p /home/slepetit/data/mariadb
	@$(COMPOSE_CMD) -f $(COMPOSE_FILE) build
	@echo "$(YELLOW)Done!$(NC)"

up: secrets build
	@echo "$(YELLOW)Run containers...$(NC)"
	@$(COMPOSE_CMD) -f $(COMPOSE_FILE) up -d
	@echo "$(YELLOW)Done!$(NC)"

down:
	@echo "$(YELLOW)Stop containers and delete related images/volumes/network/directories$(NC)"
	@sudo rm -rf secrets
	@sudo rm -rf /home/slepetit/data
	@$(COMPOSE_CMD) -f $(COMPOSE_FILE) down -v --rmi all
	@echo "$(YELLOW)Done!$(NC)"

list:
	@echo "$(YELLOW)List of all containers$(NC)"
	@$(DOCKER_CMD) ps -a
	@echo "$(YELLOW)List of all volumes$(NC)"
	@$(DOCKER_CMD) volume ls
	@echo "$(YELLOW)List of all images$(NC)"
	@$(DOCKER_CMD) image ls
	@echo "$(YELLOW)List of all networks$(NC)"
	@$(DOCKER_CMD) network ls

secrets:
	@echo "$(YELLOW)Create secrets directory...$(NC)"
	@sudo mkdir -p secrets
	@sudo chown -R $(USER):$(USER) secrets
	@grep "SQL_PASS=" $(ENV) > secrets/db_password.txt
	@grep "SQL_ROOT_PASS=" $(ENV) > secrets/db_root_password.txt
	@grep "SQL_DATABASE=" $(ENV) > secrets/credentials.txt
	@grep "SQL_USER=" $(ENV) >> secrets/credentials.txt
	@grep "DB_HOST=" $(ENV) >> secrets/credentials.txt
	@grep "WP_URL=" $(ENV) >> secrets/credentials.txt
	@grep "WP_TITLE=" $(ENV) >> secrets/credentials.txt
	@grep "WP_ADMIN=" $(ENV) >> secrets/credentials.txt
	@grep "WP_ADMIN_EMAIL=" $(ENV) >> secrets/credentials.txt
	@grep "WP_ADMIN_PASS=" $(ENV) >> secrets/credentials.txt
	@grep "WP_USER=" $(ENV) >> secrets/credentials.txt
	@grep "WP_EMAIL=" $(ENV) >> secrets/credentials.txt
	@grep "WP_PASS=" $(ENV) >> secrets/credentials.txt
	@grep "CRT_NGINX=" $(ENV) >> secrets/credentials.txt
	@grep "KEY_NGINX=" $(ENV) >> secrets/credentials.txt
	@grep "SUB_NGINX=" $(ENV) >> secrets/credentials.txt
	@echo "$(YELLOW)Done!$(NC)"
