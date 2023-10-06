# Single components

server-base:
	docker build --file server/Dockerfile.server.step1 --tag fractal/server-base:1 .

demos-base:
	docker build --file demos/Dockerfile.demos.step1 --tag fractal/demos-base:1 .

server-no-cache: server-base
	docker compose --file docker-compose-demos.yml build server --no-cache

demos-no-cache:	demos-base
	docker compose --file docker-compose-demos.yml build demos --no-cache

web-no-cache:
	docker compose --file docker-compose-demos.yml build web --no-cache

# End-to-end testing

run-demos: server-no-cache demos-no-cache web-no-cache
	docker compose --file docker-compose-demos.yml up

run-demos-github: server-base demos-base
	docker compose --file docker-compose-demos.yml up demos --abort-on-container-exit

# Auxiliary targets

clean:
	docker compose -f docker-compose-demos.yml down -v

list-share:
	tree | docker volume inspect --format '{{ .Mountpoint }}' fractal_share

# Old targets

OLD-run:
	mkdir -p fractal-share/tasks fractal-share/data
	docker compose up --build --force-recreate

OLD-clean-all:
	rm -rf fractal-db-data
	rm -rf fractal-share
