up:
	docker compose up

build:
	docker compose --progress=plain build

build-no-cache:
	docker compose --progress=plain build --no-cache

down:
	docker compose down -v --timeout 1

down-with-volumes:
	docker compose down --volumes -v --timeout 1


all-from-scratch: down-with-volumes build-no-cache
	docker compose up
