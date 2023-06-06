NAME = inception

# Check your env_file
# cp /home/chaejkim/inception/.env ./srcs/

all: build

build:
	@echo "Building ${NAME} ...\n"
	@mkdir -p /home/chaejkim/data/wordpress
	@mkdir -p /home/chaejkim/data/mariadb
	@mkdir -p /home/chaejkim/data/mariadb-log
	@docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up --build

up:
	@echo "Starting ${NAME} ...\n"
	@mkdir -p /home/chaejkim/data/wordpress
	@mkdir -p /home/chaejkim/data/mariadb
	@mkdir -p /home/chaejkim/data/mariadb-log
	@docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up

start:
	@echo "Starting ${NAME} ...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env start

stop:
	@echo "Stopping ${NAME} ...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env stop

down:
	@echo "Shuting Down ${NAME} ...\n"
	@docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down

clear:
	@su -c 'rm -rf /home/chaejkim/data'

clean: down clear
	@echo "Cleaning ${name} ...\n"
	@docker volume rm srcs_wp-data srcs_db-data

fclean: clear
	@echo "Total Cleaning ...\n"
	@docker stop $$(docker ps -aq)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume rm srcs_wp-data srcs_db-data

re: fclean all

.PHONY	: all build down re clean fclean
