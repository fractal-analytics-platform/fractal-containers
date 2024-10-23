# Auxiliary targets

up:
	docker compose up
build:
	docker compose build --progress=plain

build-no-cache:
	docker compose build --no-cache --progress=plain

clean:
	docker compose down -v --timeout 1

clean-with-volumes:
	docker compose down --volumes -v --timeout 1

list-volumes:
	tree | docker volume inspect --format '{{ .Mountpoint }}' fractal_share
