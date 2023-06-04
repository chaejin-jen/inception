NAME = inception

# Check your env_file
# cp /home/chaejkim/inception/.env ./srcs/

all: up

up:
	@echo "Starting ${NAME} ...\n"
	@mkdir -p /home/chaejkim/data/wordpress
	@mkdir -p /home/chaejkim/data/mariadb
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d --build

start:
	@echo "Starting ${NAME} ...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env start

stop:
	@echo "Stopping ${NAME} ...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env stop

down:
	@echo "Shuting Down ${NAME} ...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down

build: down
	echo "ReBuilding ${NAME} ...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d --build

clean: down
	@echo "Cleaning ${name} ...\n"
	@docker volume rm srcs_wp-data srcs_db-data
	@su -c 'rm -rf /home/chaejkim/data'

fclean:
	@echo "Total Cleaning ...\n"
	@docker stop $$(docker ps -aq)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume rm srcs_wp-data srcs_db-data
	@su -c 'rm -rf /home/chaejkim/data'

re: fclean all

.PHONY	: all build down re clean fclean
