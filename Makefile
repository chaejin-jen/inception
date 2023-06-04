NAME = inception

all:up

up:
	@echo "Starting ${NAME} ...\n"
	@mkdir -p /home/chaejkim/data/wordpress
	@mkdir -p /home/chaejkim/data/mariadb
	@docker-compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d --build
# sudo echo "127.0.0.1	chaejkim.42.fr" > /etc/hosts
# sudo cat << EOF > /etc/hosts
# "127.0.0.1	chaejkim.42.fr"
# EOF

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
	@sudo rm -rf ~/data

# @docker system prune -a
# @docker volume prune --force

fclean:
	@echo "Total Cleaning ...\n"
	@docker stop $$(docker ps -aq)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume prune --force
	@sudo rm -rf ~/data

re: fclean all

.PHONY	: all build down re clean fclean
