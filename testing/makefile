run-demos-v2: clean
	docker compose up fractal-server fractal-demos-v2 fractal-web

run-demos-v2-github:
	docker compose up fractal-server fractal-demos-v2 --abort-on-container-exit

run-demos-v1-github:
	docker compose up fractal-server fractal-demos-v1 --abort-on-container-exit

# Auxiliary targets


build:
	docker compose build

build-afresh:
	docker compose build --pull --no-cache

clean:
	docker compose down -v --timeout 2

clean-with-volumes:
	docker compose down --volumes -v --timeout 2

list-share:
	tree | docker volume inspect --format '{{ .Mountpoint }}' fractal_share
