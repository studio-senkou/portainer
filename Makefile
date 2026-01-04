.PHONY: help build up down restart logs clean ssl

COMPOSE = docker compose

help:
	@echo "Available commands:"
	@echo "  make ssl      - Generate self-signed SSL certificate"
	@echo "  make build    - Build all containers"
	@echo "  make up       - Start all containers"
	@echo "  make down     - Stop all containers"
	@echo "  make restart  - Restart all containers"
	@echo "  make logs     - View container logs"
	@echo "  make clean    - Remove containers, volumes, and images"

ssl:
	@mkdir -p ssl
	@openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout ssl/key.pem \
		-out ssl/cert.pem \
		-subj "/C=ID/ST=Local/L=Local/O=Dev/CN=$${DOMAIN:-localhost}"
	@chmod 644 ssl/*.pem
	@echo "SSL certificate generated for $${DOMAIN:-localhost}"

build:
	$(COMPOSE) build --no-cache

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

restart:
	$(COMPOSE) restart

logs:
	$(COMPOSE) logs -f

logs-nginx:
	$(COMPOSE) logs -f nginx

logs-portainer:
	$(COMPOSE) logs -f portainer

clean:
	$(COMPOSE) down -v --rmi local
	@rm -rf ssl/*.pem
