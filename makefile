server-base:
	docker build --file server/Dockerfile.server.step1 --tag fractal/server-base:1 .

server-no-cache: server-base
	docker compose --file docker-compose-demos.yml build server --no-cache

demos-no-cache:
	docker compose --file docker-compose-demos.yml build demos --no-cache

webclient-no-cache:
	docker compose --file docker-compose-demos.yml build webclient --no-cache

run-demos: server-no-cache demos-no-cache webclient-no-cache
	docker compose --file docker-compose-demos.yml up

run-demos-github: server-base
	docker compose --file docker-compose-demos.yml up demos --abort-on-container-exit

clean:
	docker compose -f docker-compose-demos.yml down -v

list-share:
	tree | docker volume inspect --format '{{ .Mountpoint }}' fractal_share


OLD-run:
	mkdir -p fractal-share/tasks fractal-share/data
	docker compose up --build --force-recreate

OLD-clean-all:
	rm -rf fractal-db-data
	rm -rf fractal-share
