xxxrun:
	mkdir -p fractal-share/tasks fractal-share/data
	docker compose up --build --force-recreate

run-demos:
	docker build --file server/Dockerfile.base --tag fractal/server-base:1 .
	docker compose --file docker-compose-demos.yml build server --no-cache
	docker compose --file docker-compose-demos.yml up

run-demos-github:
	docker build --file server/Dockerfile.base --tag fractal/server-base:1 .
	# docker compose --file docker-compose-demos.yml build server --no-cache
	# demos is to avoid activating webclient
	docker compose --file docker-compose-demos.yml up demos --abort-on-container-exit

clean:
	docker compose -f docker-compose-demos.yml down -v

clean-all:
	rm -rf fractal-db-data
	rm -rf fractal-share

list-share:
	tree | docker volume inspect --format '{{ .Mountpoint }}' fractal_share
