run-demos: clean
	docker compose --progress plain up fractal-server fractal-demos fractal-web

run-demos-github:
	docker compose up fractal-server fractal-demos --abort-on-container-exit

# Auxiliary targets


build:
	docker compose build

build-no-cache:
	docker compose build --no-cache

clean:
	docker compose down -v --timeout 1

clean-with-volumes:
	docker compose down --volumes -v --timeout 1

list-share:
	tree | docker volume inspect --format '{{ .Mountpoint }}' fractal_share
