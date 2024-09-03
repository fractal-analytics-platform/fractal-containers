run-demos-v2: clean
	docker compose --file docker-compose-demos.yml up fractal-server fractal-demos-v2 fractal-web

run-demos-v2-github:
	docker compose --file docker-compose-demos.yml up fractal-server fractal-demos-v2 --abort-on-container-exit

run-demos-v1-github:
	docker compose --file docker-compose-demos.yml up fractal-server fractal-demos-v1 --abort-on-container-exit

# Auxiliary targets

build:
	docker compose -f docker-compose-demos.yml build

clean:
	docker compose -f docker-compose-demos.yml down -v --timeout 2

list-share:
	tree | docker volume inspect --format '{{ .Mountpoint }}' fractal_share
